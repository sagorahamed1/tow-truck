import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/features/views/features/views/user/user_home/job_details_screen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_loader.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../../controller/user/user_job_post_controller.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(23.8103, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return TowTruckDraggableSheet();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(top: 40.h, left: 20.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: .15.r)),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Icon(Icons.arrow_back),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TowTruckDraggableSheet extends StatefulWidget {
  @override
  State<TowTruckDraggableSheet> createState() => _TowTruckDraggableSheetState();
}

class _TowTruckDraggableSheetState extends State<TowTruckDraggableSheet> {
  late DraggableScrollableController _draggableController;
  bool isExpanded = false;
  UserJobPostController userJobPostController = Get.put(UserJobPostController());


  @override
  void initState() {
    userJobPostController.getTowTruck();
    super.initState();
    _draggableController = DraggableScrollableController();
  }

  void toggleSheet() {
    if (isExpanded) {
      _draggableController.animateTo(
        0.35,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _draggableController.animateTo(
        1.0,
        duration: Duration(milliseconds: 300),
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

                  Spacer(),

                  Obx(()=>
                     CustomButtonTwo(
                       loading: userJobPostController.requestProviderLoading.value,
                        fontSize: 11.h,
                        loaderIgnore: true,
                        height: 32.h,
                        title: "Request All",
                        onpress: () {
                          userJobPostController.requestJobPost(providerList: userJobPostController.towTruckProviderList.value);
                        },
                        width: 120.w),
                  )

                  // CustomText(
                  //   text: "Request All",
                  //   fontSize: 18.sp,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Obx(
                  () => userJobPostController.towTruckLoading.value
                      ? CustomLoader()
                      : userJobPostController.towTrucks.isEmpty
                          ? CustomText(text: "No Data Found!")
                          : ListView.builder(
                              controller: controller,
                              itemCount: userJobPostController.towTrucks.length,
                              itemBuilder: (context, index) {
                                var towTruck = userJobPostController.towTrucks[index];
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xffB78D39), width: 1.5),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  padding: EdgeInsets.all(12.r),
                                  margin: EdgeInsets.only(top: 12.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text:
                                                        "Driver Name: ${towTruck.name}"),
                                                SizedBox(height: 8.h),
                                                CustomText(
                                                    text:
                                                        "Company: ${towTruck.companyName}",
                                                    bottom: 12.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        size: 15.h),
                                                    CustomText(
                                                        text:
                                                            "${towTruck.distance}"),
                                                  ],
                                                ),
                                                SizedBox(height: 12.h),
                                                CustomText(text: "${towTruck.id}"),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.yellow,
                                                        size: 15.h),
                                                    CustomText(
                                                        text:
                                                            "${towTruck.rating}   |  ${towTruck.trips} Trips  |   ${towTruck.amount}₦",
                                                        fontSize: 11.h),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: CustomNetworkImage(
                                                height: 95.h,
                                                  borderRadius: 12.r,
                                                  width: double.infinity,
                                                  imageUrl:
                                                      "${ApiConstants.imageBaseUrl}${towTruck.carImage}"))
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      GestureDetector(
                                        onTap: () {
                                           userJobPostController.providerId.value = towTruck.id.toString();
                                          // Get.toNamed(AppRoutes.jobDetailsScreen);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsScreen()));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffAA8F5D),
                                                Color(0xff5D5036),
                                              ],
                                            ),
                                          ),
                                          child: CustomText(
                                              top: 9.h,
                                              bottom: 9.h,
                                              text: "View Details",
                                              color: Colors.white,
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
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
