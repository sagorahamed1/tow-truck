import 'dart:convert';
import 'package:get/get.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../model/notification_model.dart';

class NotificationsController extends GetxController{


  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);

  void loadMore() {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getGetNotifications();
      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }


  RxBool notificationLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  getGetNotifications()async{
    if(page.value == 1){
      notificationLoading(true);
    }
    var response = await ApiClient.getData('${ApiConstants.notification}/?page=${page.value ?? ""}');
    if(response.statusCode == 200){
      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString()) ?? 0;
      totalResult = jsonDecode(response.body['pagination']['totalCount'].toString()) ?? 0;
     var data  = List<NotificationModel>.from(response.body["data"].map((x)=> NotificationModel.fromJson(x)));
      notifications.addAll(data);
      update();
      notificationLoading(false);
    }else{
      notificationLoading(false);
    }
  }

}