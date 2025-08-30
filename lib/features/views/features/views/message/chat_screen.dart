// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:towservice/routes/app_routes.dart';
//
// import '../../../../../global/custom_assets/assets.gen.dart';
// import '../../../../../utils/app_colors.dart';
// import '../../../../../widgets/custom_network_image.dart';
// import '../../../../../widgets/custom_text.dart';
// import '../../../../../widgets/custom_text_field.dart';
//
//
//
// class ChatScreen extends StatefulWidget {
//   ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController messageCtrl = TextEditingController();
//   List<Map<String, dynamic>> messages = [
//     {
//       "text" : "Hi Sagor, How are you? ",
//       "isSender" : false
//     }
//   ];
//
//   void sendMessage() {
//     if (messageCtrl.text.trim().isEmpty) return;
//
//     setState(() {
//       messages.add({
//         'text': messageCtrl.text.trim(),
//         'isSender': true, // change to false if simulating receiver message
//       });
//       messageCtrl.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Container(
//             margin: EdgeInsets.only(left: 20.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey,
//                   blurRadius: 1,
//                   offset: Offset(0, 0)
//                 )
//               ],
//               shape: BoxShape.circle,
//             ),
//             child: Padding(
//               padding:  EdgeInsets.all(4.r),
//               child: Icon(Icons.arrow_back_ios_new),
//             ),
//           ),
//         ),
//         title: Row(
//
//           children: [
//             CustomNetworkImage(
//               height: 36.h,
//               width: 36.w,
//               boxShape: BoxShape.circle,
//               imageUrl: "https://randomuser.me/api/portraits/men/10.jpg",
//               border: Border.all(color: Colors.grey, width: 0.02),
//             ),
//
//             SizedBox(width: 8.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(text: "Hub Names", fontSize: 15.h),
//                 CustomText(text: "Active 2 hours ago", fontSize: 12.h),
//               ]
//             )
//           ],
//         ),
//
//
//         actions: [
//           PopupMenuButton<String>(
//             icon: Icon(Icons.more_vert),
//             onSelected: (String value) {
//               // Handle menu selection
//               if (value == 'Report') {
//                 Get.toNamed(AppRoutes.reportScreen);
//               } else if (value == 'delete') {
//                 // Confirm delete
//               }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               PopupMenuItem<String>(
//                 value: 'Report',
//                 child: Text('Report'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'Block',
//                 child: Text('Block'),
//               ),
//             ],
//           ),
//           SizedBox(width: 10.w),
//         ],
//
//
//         // actions: [
//         //   IconButton(onPressed: () {
//         //
//         //   }, icon: Icon(Icons.more_vert)),
//         //
//         //   SizedBox(width: 10.w)
//         // ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return BubbleSpecialOne(
//                   text: message['text'],
//                   isSender: message['isSender'],
//                   seen: true,
//                   color: message['isSender']
//                       ? Color(0xffEADDC6)
//                       : const Color(0xFFE8E8EE),
//                   textStyle: TextStyle(
//                       fontSize: 14.sp,
//                       color: message['isSender'] ? Colors.black : Colors.black
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 SizedBox(width: 10.w),
//                 Expanded(
//                   flex: 15,
//                   child: CustomTextField(
//                     borderColor: Colors.grey,
//                     controller: messageCtrl,
//                     hintText: "Type your message",
//                     validator: (value) {},
//                   ),
//                 ),
//                 SizedBox(width: 10.w),
//                 GestureDetector(
//                   onTap: sendMessage,
//                   child: Padding(
//                     padding:  EdgeInsets.only(top: 10.h),
//                     child: Assets.icons.messageSendIcon.svg(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 30.h),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:towservice/widgets/custom_text.dart';
import '../../../../../controller/chat_controller.dart';
import '../../../../../helpers/time_format.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../services/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_loader.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  ChatController chatController = Get.find<ChatController>();
  final ScrollController _scrollController = ScrollController();
  String threadId = "";

  @override
  void initState() {
    chatController.listenMessage();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          chatController.loadMore();
          print("====> scroll bottom");
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    chatController.clearChats();
    chatController.offListenMessage();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map routeData = Get.arguments;
    chatController.fetchChat(receiverId: routeData["receiverId"]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 1, offset: Offset(0, 0))
              ],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        title: Row(
          children: [
            CustomNetworkImage(
              height: 36.h,
              width: 36.w,
              boxShape: BoxShape.circle,
              imageUrl: "${ApiConstants.imageBaseUrl}/${routeData["image"]}",
              border: Border.all(color: Colors.grey, width: 0.02),
            ),
            SizedBox(width: 8.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(text: "${routeData["name"]}", fontSize: 15.h),
              CustomText(text: "${TimeFormatHelper.timeWithAMPM(DateTime.parse("${routeData["lastActive"] ?? DateTime.now()}"))}", fontSize: 12.h),
            ])
          ],
        ),

        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              // Handle menu selection
              if (value == 'Report') {
                Get.toNamed(AppRoutes.reportScreen);
              } else if (value == 'delete') {
                // Confirm delete
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Report',
                child: Text('Report'),
              ),
              // PopupMenuItem<String>(
              //   value: 'Block',
              //   child: Text('Block'),
              // ),
            ],
          ),
          SizedBox(width: 10.w),
        ],

        // actions: [
        //   IconButton(onPressed: () {
        //
        //   }, icon: Icon(Icons.more_vert)),
        //
        //   SizedBox(width: 10.w)
        // ],
      ),
      // appBar: CustomAppBar(title: "${routeData["name"]}"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => chatController.chatLoading.value
                    ? const SizedBox()
                    : chatController.chats.isEmpty
                        ? const CustomText(text: "No Data Found!")
                        : ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            itemCount: chatController.chats.length,
                            itemBuilder: (context, index) {
                              if (index < chatController.chats.length) {
                                final message = chatController.chats[index];
                                final isSender =
                                    routeData["receiverId"] != message.senderId;

                                threadId = message.threadId.toString();

                                return Column(
                                  crossAxisAlignment: isSender
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    message.content == ""
                                        ? BubbleNormalImage(
                                            id: 'image_${message.id}',
                                            image: CustomNetworkImage(
                                              imageUrl:
                                                  "${ApiConstants.imageBaseUrl}/${message.attachments?.first}",
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: 16.r,
                                            ),
                                            isSender: isSender,
                                            color: Colors.transparent)
                                        : BubbleNormal(
                                            text: "${message.content}",
                                            isSender: isSender,
                                            color: !isSender
                                                ? Color(0xffCDE1E1)
                                                : Color(0xffFDFDF7),
                                            // seen: isSender,
                                            textStyle: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16.sp),
                                          ),
                                    SizedBox(height: 10.h),
                                  ],
                                );
                              } else if (index >= chatController.totalResult) {
                                return null;
                              } else {
                                return const CustomLoader();
                              }
                            },
                          ),
              ),
            ),
            if (pickedFiles.isNotEmpty)
              Container(
                height: 100.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pickedFiles.length,
                  itemBuilder: (context, index) {
                    final file = pickedFiles[index];
                    final isImage = ['jpg', 'jpeg', 'png']
                        .contains(file.path.split('.').last.toLowerCase());

                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.w),
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: isImage
                              ? Image.file(file, fit: BoxFit.cover)
                              : Center(
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 40.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pickedFiles.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: pickAnyFile,
                    child: const Icon(Icons.attachment_outlined),
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: CustomTextField(
                      validator: (value) {},
                      controller: _messageController,
                      hintText: "Message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            chatController.sendMessage(
                              receiveId: routeData["receiverId"],
                              content: _messageController.text,
                              threadId: routeData["threadId"] ?? threadId,
                            );
                            _messageController.clear();
                          } else {
                            chatController.uploadFile(
                                images: pickedFiles,
                                receiveId: routeData["receiverId"],
                                threadId: routeData["threadId"] ?? threadId);
                            pickedFiles.clear();
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<File> pickedFiles = [];

  Future<void> pickAnyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      setState(() {
        pickedFiles.addAll(files);
      });
    }
  }
}
