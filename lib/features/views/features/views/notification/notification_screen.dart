import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/features/views/features/views/message/message_user_screen.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import '../../../../../controller/notifications_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsController notificationsController =
      Get.put(NotificationsController());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    notificationsController.getGetNotifications();
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notificationsController.loadMore();
        print("load more true");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notifications"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => notificationsController.notificationLoading.value
                  ? const ChatShimmerList()
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          notificationsController.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index < notificationsController.notifications.length){
                          var notification = notificationsController.notifications[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: Assets.icons.notificationIcon
                                          .svg(color: Colors.white),
                                    )),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                text: "${notification.title}",
                                                fontSize: 16.h),
                                            CustomText(
                                                textAlign: TextAlign.start,
                                                maxline: 3,
                                                text:
                                                "${notification.message}",
                                                fontSize: 11.h),
                                          ],
                                        ),
                                      ),




                                      CustomText(
                                        top: 2.h,
                                        text: TimeAgo.format(notification.createdAt ?? DateTime.now()),
                                        fontSize: 12.h,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(
                                          0xFF8C8C8C,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }else if (index >= notificationsController.totalResult) {
                          return null;
                        } else {
                          return const CustomLoader();
                        }

                      },
                    ),
            ))
          ],
        ),
      ),
    );
  }
}
