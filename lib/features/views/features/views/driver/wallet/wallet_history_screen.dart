import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/widgets/custom_app_bar.dart';

import '../../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../widgets/custom_text.dart';

class WalletHistoryScreen extends StatelessWidget {
   const WalletHistoryScreen({super.key});

  final int trans = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: "Transactions"),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [


            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: trans,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F3EC),
                      border: Border.all(color: Color(0xffE7DBC5)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(12.r),
                      child: Row(
                        children: [

                          index.isOdd ? Assets.icons.rightTopIcon.svg() : Assets.icons.leftBottomIcon.svg(),


                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomText(text: "Welton"),
                              CustomText(text: "today at 09:20 AM", color: AppColors.primaryColor )

                            ],
                          ),



                          Spacer(),

                          CustomText(text: "-₦570.00", color: index.isOdd ? Colors.red : Colors.black)

                        ],
                      ),
                    ),
                  );
                },
              ),
            )



          ],
        ),
      ),
    );
  }
}
