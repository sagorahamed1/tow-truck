import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';

import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_field.dart';



class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageCtrl = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      "text" : "Hi Sagor, How are you? ",
      "isSender" : false
    }
  ];

  void sendMessage() {
    if (messageCtrl.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'text': messageCtrl.text.trim(),
        'isSender': true, // change to false if simulating receiver message
      });
      messageCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(0, 0)
                )
              ],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding:  EdgeInsets.all(4.r),
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
              imageUrl: "https://randomuser.me/api/portraits/men/10.jpg",
              border: Border.all(color: Colors.grey, width: 0.02),
            ),

            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Hub Names", fontSize: 15.h),
                CustomText(text: "Active 2 hours ago", fontSize: 12.h),
              ]
            )
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
              PopupMenuItem<String>(
                value: 'Block',
                child: Text('Block'),
              ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return BubbleSpecialOne(
                  text: message['text'],
                  isSender: message['isSender'],
                  seen: true,
                  color: message['isSender']
                      ? Color(0xffEADDC6)
                      : const Color(0xFFE8E8EE),
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      color: message['isSender'] ? Colors.black : Colors.black
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(width: 10.w),
                Expanded(
                  flex: 15,
                  child: CustomTextField(
                    borderColor: Colors.grey,
                    controller: messageCtrl,
                    hintText: "Type your message",
                    validator: (value) {},
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: sendMessage,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10.h),
                    child: Assets.icons.messageSendIcon.svg(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
