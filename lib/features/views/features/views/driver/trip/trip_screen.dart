import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/helpers/time_format.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/widgets.dart';
import '../../../../../../controller/profile_controller.dart';
import '../../../../../../controller/tow_truck/tow_trcuk_job_controller.dart';
import '../../../../../../services/api_constants.dart';
import '../../../../../../widgets/custom_text.dart';

class TripScreen extends StatefulWidget {
  TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  TowTruckJobController towTruckJobController = Get.put(TowTruckJobController());
  ProfileController profileController = Get.find<ProfileController>();

  int selectedBtnIndex = 0;
  var selectedNegotiateIndex = (-1).obs;
  var counter = 0.obs; // per negotiation counter


  @override
  void initState() {
    super.initState();
  }

  getApiData(){
    if(selectedBtnIndex == 0){
      towTruckJobController.userRequest.value = [];
      towTruckJobController.getUserRequest();
    }else if(selectedBtnIndex == 1){
      towTruckJobController.jobOngoing.value = [];
      towTruckJobController.getOngoingJob();
    }

  }

  @override
  Widget build(BuildContext context) {
    print("=======================role : ${profileController.role}");
    getApiData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            // Tab Bar
            Row(
              children: [


                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                    boderColor: AppColors.primaryColor,
                    color: selectedBtnIndex != 0
                        ? Colors.transparent
                        : AppColors.primaryColor,
                    titlecolor: selectedBtnIndex != 0
                        ? AppColors.primaryColor
                        : Colors.white,
                    height: 40.h,
                    borderRadius: 4.r,
                    loaderIgnore: true,
                    loading: false,
                    title: "Request",
                    onpress: () {
                      setState(() {
                        selectedBtnIndex = 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12.w),





                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                    boderColor: AppColors.primaryColor,
                    color: selectedBtnIndex != 1
                        ? Colors.transparent
                        : AppColors.primaryColor,
                    titlecolor: selectedBtnIndex != 1
                        ? AppColors.primaryColor
                        : Colors.white,
                    height: 40.h,
                    borderRadius: 4.r,
                    loaderIgnore: true,
                    loading: false,
                    title: "Ongoing",
                    onpress: () {
                      setState(() {
                        selectedBtnIndex = 1;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                    boderColor: AppColors.primaryColor,
                    color: selectedBtnIndex != 2
                        ? Colors.transparent
                        : AppColors.primaryColor,
                    titlecolor: selectedBtnIndex != 2
                        ? AppColors.primaryColor
                        : Colors.white,
                    height: 40.h,
                    borderRadius: 4.r,
                    title: "Completed",
                    loaderIgnore: true,
                    loading: false,
                    onpress: () {
                      print("==================");
                      setState(() {
                        selectedBtnIndex = 2;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: AppColors.primaryColor, height: 1.5.h),
            SizedBox(height: 10.h),

            // List
            selectedBtnIndex == 0 ?
            Expanded(
              child: Obx(
                    () => towTruckJobController.userRequestLoading.value
                    ? CustomLoader()
                    : towTruckJobController.userRequest.isEmpty
                    ? CustomText(text: "No Data Found!")
                    : ListView.builder(
                      padding: EdgeInsets.zero,
                  itemCount: towTruckJobController.userRequest.length,
                  itemBuilder: (context, index) {
                    var userJob =
                    towTruckJobController.userRequest[index];
                    counter.value = userJob.amount?.toInt() ?? 0;
                    return Container(
                      margin: EdgeInsets.all(5.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 4.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),


                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffF7F3EC),
                                  borderRadius:
                                  BorderRadius.circular(12.r)),
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5),
                                      height: 41.h,
                                      width: 41.w,
                                      boxShape: BoxShape.circle,
                                      imageUrl:
                                      "${ApiConstants.imageBaseUrl}/${userJob.userProfile}",
                                    ),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                            "${userJob.userName}"),
                                        Row(
                                          children: [
                                            CustomText(
                                                text: "★★★★★",
                                                color: Color(
                                                    0xffFFCE31)),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                                text: "5(2)"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                            "\$ ${userJob.amount}",
                                            fontWeight:
                                            FontWeight.w600),
                                        CustomText(
                                            text:
                                            "${userJob.distance}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Assets.icons.pickUpIcon.svg(),
                                CustomText(
                                    text: " Pick Up",
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            CustomText(
                                text: "${userJob.fromAddress}",
                                fontSize: 11.h),

                            Row(
                              children: [
                                Icon(Icons.location_on, size: 12.h),
                                CustomText(
                                    text: " Drop off",
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            CustomText(
                                text: "${userJob.toAddress}",
                                fontSize: 11.h),

                            SizedBox(height: 6.h),
                            Divider(height: 4.h),


                            Row(
                              children: [
                                Row(children: [
                                  CustomText(
                                      text: "Car Type: ",
                                      fontWeight: FontWeight.w500),
                                  Row(
                                    children: [
                                      Assets.icons.carIcon.svg(),
                                      CustomText(
                                          text:
                                          "  ${userJob.vehicle}",
                                          fontSize: 11.h,
                                          fontWeight:
                                          FontWeight.w300)
                                    ],
                                  )
                                ]),
                                Spacer(),
                                Row(
                                  children: [
                                    CustomText(
                                        text: "Vehicle Issue: ",
                                        fontWeight:
                                        FontWeight.w500),
                                    CustomText(
                                        text: "${userJob.issue}",
                                        fontWeight:
                                        FontWeight.w300),
                                  ],
                                ),
                              ],
                            ),

                            Divider(height: 4.h),


                            CustomText(
                                text: "Passengers Note:",
                                fontWeight: FontWeight.w500),
                            CustomText(
                                maxline: 4,
                                textAlign: TextAlign.start,
                                text: "${userJob.note}",
                                fontWeight: FontWeight.w500),




                            Divider(),
                            SizedBox(height: 10.h),





                             Column(
                               children: [




                                 Obx(() => selectedNegotiateIndex.value ==  index?

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     // Counter Box


                                     Container(
                                       padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(30),
                                         border: Border.all(color: Colors.grey.shade400, width: 1),
                                       ),
                                       child: Row(
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           // Minus Button
                                           SizedBox(width: 10.w),
                                           InkWell(
                                             onTap: () {
                                               if (counter.value > 0) counter.value--;
                                             },
                                             child: CircleAvatar(
                                               radius: 14,
                                               backgroundColor: AppColors.primaryColor,
                                               child:  Icon(Icons.remove, size: 16.h, color: Colors.white),
                                             ),
                                           ),
                                            SizedBox(width: 24.w),

                                           // Counter Text

                                           CustomText(text: "${counter.value}"),
                                            SizedBox(width: 24.w),

                                           // Plus Button
                                           Obx(() {
                                             counter.value;
                                             return InkWell(
                                               onTap: () {
                                                 counter.value++;

                                               } ,
                                               child: CircleAvatar(
                                                 radius: 14,
                                                 backgroundColor: AppColors.primaryColor,
                                                 child:  Icon(Icons.add, size: 16.h, color: Colors.white),
                                               ),
                                             );
                                           }
                                           ),


                                           SizedBox(width: 10.w),
                                         ],
                                       ),
                                     ),





                                     CustomButtonTwo(
                                       height: 40.h,
                                         width: 130.w,
                                         loaderIgnore: true,
                                         title: "Send", onpress: (){
                                         towTruckJobController.negotiateJob(jobId: userJob.jobId.toString(), price: counter.value);

                                     })



                                   ],
                                 )

                                     :


                                 (userJob.negBy == "${profileController.role}" ?
                                 Container(
                                     height: 40.h,
                                     width: double.infinity,
                                     decoration: BoxDecoration(
                                       color: AppColors.primaryColor,
                                       borderRadius: BorderRadius.circular(12.r),
                                     ),
                                     child: Center(child: CustomText(text: "You already request to ${profileController.role == "user"? "Provider" : "User"}", color: Colors.white))
                                 )
                                     :
                                 Row(
                                   children: [
                                     CustomButtonTwo(
                                         height: 40.h,
                                         color: Color(0xff7B6846),
                                         boderColor: Color(0xff7B6846),
                                         loaderIgnore: true,
                                         width: 140.w,
                                         title: "Negotiate",
                                         onpress: () {
                                           counter.value = userJob.amount ?? 0;
                                           selectedNegotiateIndex.value = index;

                                         }),

                                     Spacer(),

                                     Obx(() =>
                                         CustomButtonTwo(
                                             loading: towTruckJobController.acceptJobLoading.value,
                                             height: 40.h,
                                             loaderIgnore: true,
                                             width: 140.w,
                                             title: "Accept",
                                             onpress: () {
                                               towTruckJobController.acceptJob(jobId: userJob.jobId.toString(), providerId: userJob.userId, trxId: userJob.trId, context: context);
                                             }),
                                     )
                                   ],
                                 )),


                                 ),


                               ],
                             ),
                             // selectedNegotiateIndex.value == index  ?



                            SizedBox(height: 10.h),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
                :
            Expanded(
              child: Obx(() =>towTruckJobController.ongoingLoading.value
                  ? CustomLoader()
                  : towTruckJobController.jobOngoing.isEmpty
                  ? CustomText(text: "No Data Found!")
                  :
                 ListView.builder(
                  itemCount:towTruckJobController.jobOngoing.length,
                  padding: EdgeInsets.only(top: 8.h),
                  itemBuilder: (context, index) {
                    var job = towTruckJobController.jobOngoing[index];
                    return GestureDetector(child: CompletedCard(
                      image: "${job.profileImage}",
                      dateTime: job.date,
                      fromAddress: job.fromAddress,
                      toAddress: job.toAddress,
                      onTap: () {
                        // selectedBtnIndex == 1
                        //     ? Get.toNamed(AppRoutes.tripDetailsScreen)
                        //     :
                        print("===================kkk ${job.coordinate?[0]}");
                        Get.toNamed(AppRoutes.tripHistoryScreen, arguments: {
                          "name" : job.name,
                          "dateTime" : job.date,
                          "fromAddress" : job.fromAddress,
                          "toAddress" : job.toAddress,
                          "distance" : "null",
                          "promo" : "null",
                          "email" : "null",
                          "phone" : "null",
                          "status" : job.status,
                          "fromLat" : job.coordinate?[0],
                          "fromLng" : job.coordinate?[1],
                          "toLat" : job.destCoordinate?[0],
                          "toLng" : job.destCoordinate?[1]
                        });
                      },
                    ));
                  },
                ),
              ),
            )







          ],
        ),
      ),
    );
  }
}

class CompletedCard extends StatelessWidget {
  final DateTime? dateTime;
  final String? fromAddress;
  final String? toAddress;
  final String? image;
  final VoidCallback? onTap;

  const CompletedCard({super.key, this.onTap, this.dateTime, this.fromAddress, this.toAddress, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 2.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(1, 1),
                blurRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date + Profile Image
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: "${TimeFormatHelper.formatDate(dateTime?? DateTime.now())}, ${TimeFormatHelper.timeWithAMPM(dateTime ?? DateTime.now())}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomNetworkImage(
                  imageUrl: "${ApiConstants.imageBaseUrl}/${image}",
                  boxShape: BoxShape.circle,
                  height: 40.h,
                  width: 40.w)
            ],
          ),
          SizedBox(height: 8.h),

          // Pickup location
          Row(
            children: [
              Assets.icons.pickUpIcon.svg(),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  text: "  ${fromAddress}",
                  fontSize: 13.sp,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Destination location
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 18.sp, color: AppColors.darkColor),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  text: "${toAddress}",
                  fontSize: 13.sp,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          CustomButtonTwo(
              height: 36.h,
              color: Colors.transparent,
              titlecolor: Colors.black,
              title: "View Details",
              onpress: onTap ?? () {})
        ],
      ),
    );
  }
}
