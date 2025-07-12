import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_field.dart';


class MessageUserScreen extends StatelessWidget {
  MessageUserScreen({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: CustomText(text: "Inbox", fontSize: 17.h, fontWeight: FontWeight.w500)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
                controller: searchCtrl,
                hintextColor: Colors.black87,
                hintText: "Search",
                borderColor: Colors.grey,
                validator: (value) {},
                suffixIcon: Padding(
                  padding:  EdgeInsets.all(8.r),
                  child: Assets.icons.searhIcon.svg(height: 24.h, width: 24.w),
                )),




            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: () {
                       Get.toNamed(AppRoutes.chatScreen);
                     },
                     child: Container(
                        margin: EdgeInsets.all(3.r),
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey))

                        ),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              border:
                                  Border.all(color: Color(0xff592B00), width: 0.002),
                              imageUrl: "https://i.pravatar.cc/150?img=3",
                              height: 58.h,
                              width: 58.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "Sagor Ahamed",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    bottom: 6.h),
                                CustomText(
                                    text: "hello how are you", fontSize: 12.h),
                              ],
                            ),
                            Spacer(),
                            CustomText(
                                text: "4:15 PM"),
                            SizedBox(width: 8.w)
                          ],
                        ),
                      ),
                   );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
