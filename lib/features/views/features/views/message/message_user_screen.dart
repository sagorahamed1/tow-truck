// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../../global/custom_assets/assets.gen.dart';
// import '../../../../../routes/app_routes.dart';
// import '../../../../../widgets/custom_app_bar.dart';
// import '../../../../../widgets/custom_network_image.dart';
// import '../../../../../widgets/custom_text.dart';
// import '../../../../../widgets/custom_text_field.dart';
//
//
// class MessageUserScreen extends StatelessWidget {
//   MessageUserScreen({super.key});
//
//   final TextEditingController searchCtrl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: CustomText(text: "Inbox", fontSize: 17.h, fontWeight: FontWeight.w500)),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           children: [
//             CustomTextField(
//                 controller: searchCtrl,
//                 hintextColor: Colors.black87,
//                 hintText: "Search",
//                 borderColor: Colors.grey,
//                 validator: (value) {},
//                 suffixIcon: Padding(
//                   padding:  EdgeInsets.all(8.r),
//                   child: Assets.icons.searhIcon.svg(height: 24.h, width: 24.w),
//                 )),
//
//
//
//
//             Expanded(
//               child: ListView.builder(
//                   itemCount: 20,
//                   itemBuilder: (context, index) {
//                    return GestureDetector(
//                      onTap: () {
//                        Get.toNamed(AppRoutes.chatScreen);
//                      },
//                      child: Container(
//                         margin: EdgeInsets.all(3.r),
//                         padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
//                         decoration: BoxDecoration(
//                           border: Border(bottom: BorderSide(color: Colors.grey))
//
//                         ),
//                         child: Row(
//                           children: [
//                             CustomNetworkImage(
//                               border:
//                                   Border.all(color: Color(0xff592B00), width: 0.002),
//                               imageUrl: "https://i.pravatar.cc/150?img=3",
//                               height: 58.h,
//                               width: 58.w,
//                               boxShape: BoxShape.circle,
//                             ),
//                             SizedBox(width: 10.w),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                     text: "Sagor Ahamed",
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                     bottom: 6.h),
//                                 CustomText(
//                                     text: "hello how are you", fontSize: 12.h),
//                               ],
//                             ),
//                             Spacer(),
//                             CustomText(
//                                 text: "4:15 PM"),
//                             SizedBox(width: 8.w)
//                           ],
//                         ),
//                       ),
//                    );
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../controller/chat_controller.dart';
import '../../../../../helpers/time_format.dart';
import '../../../../../services/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text_field.dart';



class MessageUserScreen extends StatefulWidget {
  MessageUserScreen({super.key});

  @override
  State<MessageUserScreen> createState() => _MessageUserScreenState();
}

class _MessageUserScreenState extends State<MessageUserScreen> {
  ChatController chatController = Get.find<ChatController>();
  TextEditingController searchCtrl = TextEditingController();

  Timer? debounce;

  @override
  void initState() {
    chatController.fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chatController.fetchUser();
    return Scaffold(
      appBar: const CustomAppBar(title: "Message"),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CustomTextField(
                controller: searchCtrl,
                hintText: "Write Name Here",
                onChanged: (value) {
                  if (debounce?.isActive ?? false) {
                    debounce?.cancel();
                  }
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    chatController.chatUsers.clear();
                    chatController.fetchUser(name: searchCtrl.text);
                  });
                },
                suffixIcon: const Icon(Icons.search)),
            Expanded(
              child: Obx(
                    () => chatController.fetchUserLoading.value
                    ? const ChatShimmerList()
                    : chatController.chatUsers.isEmpty
                    ? const CustomText(text: "No Data found!")
                    : ListView.builder(
                    itemCount: chatController.chatUsers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var user = chatController.chatUsers[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: GestureDetector(
                          onTap: () {
                            // context.pushNamed(AppRoutes.messageChatScreen, extra: {
                            //   "receiverId" : "${user.receiver?.id}",
                            //   "name" : "${user.receiver?.name}",
                            //   "threadId" : "${user.id}"
                            // }).then((_){
                            //   chatController.chatUsers.clear();
                            //   chatController.fetchUser();
                            // });
                            Get.toNamed(AppRoutes.chatScreen, arguments: {
                              "receiverId" : "${user.receiver?.id}",
                              "name" : "${user.receiver?.name}",
                              "threadId" : "${user.id}",
                              "image" : "${user.receiver?.profileImage}"
                            })?.then((_){
                                chatController.chatUsers.clear();
                                chatController.fetchUser();
                            });
                          },
                          child: _userCard(
                              name: '${user.receiver?.name ?? "N/A"}',
                              isOnline: user.receiver?.isOnline ?? false,
                              image: "${ApiConstants.imageBaseUrl}/${user.receiver?.profileImage}",
                              message: user.lastMessage?.content == "" ? "File" : "${user.lastMessage?.content ?? ""}",
                              time: "${TimeFormatHelper.timeWithAMPM(DateTime.parse("${user.lastMessage?.createdAt ?? DateTime.now()}"))}" ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCard(
      {required String name, message, time, image, required bool isOnline}) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            CustomNetworkImage(
                border: Border.all(color: AppColors.paymentCardColor, width: 0.2),
                imageUrl: "$image",
                height: 48.h,
                width: 48.w,
                boxShape: BoxShape.circle),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: name.toString(), fontSize: 16.h, color: Colors.black),
                  CustomText(
                    textAlign: TextAlign.start,
                      text: message.toString(),
                      fontSize: 12.h,
                      color: Colors.black87),
                ],
              ),
            ),
            const Spacer(),
            CustomText(text: time.toString(), right: 12.w),
            Container(
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: isOnline ? Colors.green : Colors.grey,
                  shape: BoxShape.circle),
            )
          ],
        ),
      ),
    );
  }

}



class ChatShimmerList extends StatelessWidget {
  const ChatShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                // Circle avatar placeholder
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                // Name and message column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 12.h,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 100.w,
                        height: 13.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // Time and status dot
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 13.h,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6.h),
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
