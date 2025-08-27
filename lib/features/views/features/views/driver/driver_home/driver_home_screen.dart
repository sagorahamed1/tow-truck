import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../../controller/profile_controller.dart';
import '../../../../../../controller/tow_truck/tow_trcuk_job_controller.dart';
import '../../../../../../widgets/customTripCard.dart';
import '../../../../../../widgets/custom_loader.dart';
import '../../../../../../widgets/custom_toggle_swicher.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool isOnline = false;
  ProfileController profileController = Get.find<ProfileController>();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(23.8103, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableListSheet();
        },
      );
    });
    profileController.getUserLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Assets.icons.appLogo.svg(),
        ),
        title: CustomToggleSwitch(
          isOnline: isOnline,
          onChanged: (value) {
            setState(() {
              isOnline = value;
            });

            if (isOnline) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return DraggableListSheet();
                },
              );
            }
          },
        ),
        actions: [
          Stack(
            children: [
              Obx(() =>
                 CustomNetworkImage(
                    height: 41.h,
                    width: 41.w,
                    boxShape: BoxShape.circle,
                    imageUrl: "${ApiConstants.imageBaseUrl}/${profileController.image}"),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:
                    Assets.icons.verifyBedgeIcon.svg(height: 16.h, width: 16.w),
              )
            ],
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: Stack(
        children: [
          // The Map section
          SizedBox(
            height: Get.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),

          Positioned(
            bottom: 60.h,
            right: 20.w,
            left: 20.w,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white, width: 3.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text:
                          "You’re offline now.\nGo online to get trip and earn",
                      fontSize: 16.h,
                      left: 16.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.white, width: 3.r)),
                    child: Padding(
                      padding: EdgeInsets.all(15.r),
                      child: CustomText(
                          text: "Go\nOnline",
                          color: Colors.white,
                          fontSize: 16.h),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DraggableListSheet extends StatefulWidget {
  const DraggableListSheet({super.key});

  @override
  State<DraggableListSheet> createState() => _DraggableListSheetState();
}

class _DraggableListSheetState extends State<DraggableListSheet> {
  late DraggableScrollableController _draggableController;
  bool isExpanded = false;

  TowTruckJobController towTruckJobController =
      Get.put(TowTruckJobController());

  @override
  void initState() {
    super.initState();
    towTruckJobController.getUser();
    _draggableController = DraggableScrollableController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_draggableController.isAttached) {
        _draggableController.jumpTo(0.35); // initial state
      }
    });
  }

  void toggleSheet() {
    if (!_draggableController.isAttached) {
      debugPrint("Controller not attached yet");
      return;
    }

    if (isExpanded) {
      _draggableController.animateTo(
        0.35,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _draggableController.animateTo(
        1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableController,
      initialChildSize: 0.35,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (_, controller) {
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: toggleSheet,
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 28.h,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  CustomText(
                    text: "Tow Trucks",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Obx(
                  () => towTruckJobController.getJobsFromUserLoading.value
                      ? CustomLoader()
                      : towTruckJobController.users.isEmpty
                          ? CustomText(text: "No Data Found!")
                          : ListView.builder(
                              controller: controller,
                              itemCount: towTruckJobController.users.length,
                              itemBuilder: (context, index) {
                                var userJob =
                                towTruckJobController.users[index];
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



                                        userJob.negBy == "provider" ?
                                            Container(
                                              height: 40.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius: BorderRadius.circular(12.r),
                                              ),
                                              child: Center(child: CustomText(text: "You already request to user", color: Colors.white))
                                            ) :
                                        Row(
                                          children: [
                                            CustomButtonTwo(
                                              height: 40.h,
                                              color: Color(0xff7B6846),
                                              boderColor: Color(0xff7B6846),
                                              loaderIgnore: true,
                                              width: 160.w,
                                                title: "Negotiate",
                                                onpress: () {}),

                                            Spacer(),

                                            Obx(() =>
                                              CustomButtonTwo(
                                                loading: towTruckJobController.acceptJobLoading.value,
                                                height: 40.h,
                                                  loaderIgnore: true,
                                                  width: 160.w,
                                                  title: "Accept",
                                                  onpress: () {

                                                    towTruckJobController.acceptJob(jobId: userJob.jobId.toString(), providerId: userJob.userId, trxId: userJob.trId);


                                                }),
                                            )
                                          ],
                                        ),


                                        SizedBox(height: 10.h),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
