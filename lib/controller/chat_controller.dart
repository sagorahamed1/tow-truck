import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../model/chat_model.dart';
import '../model/chat_user_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../services/socket_services.dart';
import '../utils/app_constant.dart';

class ChatController extends GetxController {

  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);



  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      fetchChat();
      update();
    }
  }



  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxBool chatLoading = false.obs;

  RxString tempReceiverId = "".obs;
  fetchChat({String? receiverId}) async {
    if(page.value == 1){
      clearChats();
      tempReceiverId.value = receiverId ?? "";
      chatLoading(true);
      update();
    }

    var response = await ApiClient.getData(ApiConstants.message("$tempReceiverId?page=${page.value}&limit=18"));

    if (response.statusCode == 200) {

      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      currectPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
      totalResult = jsonDecode(response.body['pagination']['totalCount'].toString()) ?? 0;

      var data = List<ChatModel>.from(response.body["data"].map((x) => ChatModel.fromJson(x)));
      chats.addAll(data);
      chats.refresh();
      update();
      chatLoading(false);
    }
    chatLoading(false);
  }
  clearChats(){
    chats.clear();
    page.value = 1;
    totalPage = -1;
    currectPage = -1;
    totalResult = -1;
    tempReceiverId.value = "";
    update();
  }

  RxList<ChatUserModel> chatUsers = <ChatUserModel>[].obs;
  RxBool fetchUserLoading = false.obs;

  fetchUser({String name = ""}) async {
    fetchUserLoading(true);
    var response = await ApiClient.getData("${ApiConstants.chatUser}${name== "" ? "all?limit=80"  : "search?keyword=${name}"}");

    if (response.statusCode == 200) {
      chatUsers.value = List<ChatUserModel>.from(
          response.body["data"].map((x) => ChatUserModel.fromJson(x)));

      fetchUserLoading(false);
    }
    fetchUserLoading(false);
  }



  uploadFile({required List<File> images, String? receiveId, threadId}) async {
    List<MultipartBody> photoList = images.map((file) => MultipartBody("files", file)).toList();

    var response = await ApiClient.postMultipartData(
      "/upload/multiple",
      {},
      multipartBody: photoList,
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      List<String> filenames = List<String>.from(response.body["data"]);
      sendMessage(threadId: "$threadId",content: "",receiveId: "$receiveId", filePath: filenames);
    } else {
      ToastMessageHelper.showToastMessage("Failed to upload files");
    }
  }

  ///=======================Socket ====================>>>>

  SocketServices socketServices = SocketServices();

  void listenMessage() async {

    socketServices.socket?.on("message-receive", (data) {
      if (data != null) {


        ChatModel demoData = ChatModel.fromJson(data);

        chats.insert(0, demoData);

        update();

        print('Message added to chatMessages list');
      } else {
        print("No message data found in the response");
      }
    });
  }

  void offListenMessage(){
    socketServices.socket?.off("message-receive");
  }

  createChat({String? content, receiveId}) async {
    var myId = await PrefsHelper.getString(AppConstants.userId);

    var body = {
      "senderId": "$myId",
      "content": "",
      "participants": ["$myId", "$receiveId"]
    };

    socketServices.emit("message-send", body);
  }

  sendMessage({String? content, receiveId, threadId, filePath}) async {
    var myId = await PrefsHelper.getString(AppConstants.userId);

    var body = filePath == null || filePath == ""
        ? {
      "senderId": "$myId",
      "threadId": "$threadId",
      "content": "$content",
    }
        : {
      "senderId": "$myId",
      "threadId": "$threadId",
      "content": "$content",
      "attachments": filePath
    };

    socketServices.emit("message-send", body);
  }
}
