import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';

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


  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return Padding(
  //           padding: EdgeInsets.all(16.0),
  //           child: SizedBox(
  //             height: 700.h,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //
  //                 Expanded(
  //                   child: ListView.builder(
  //                       itemCount: 10,
  //                       itemBuilder: (context, index) {
  //                         return Container(
  //                           width: double.infinity,
  //                           decoration: BoxDecoration(
  //                             border: Border.all(color: Color(0xffB78D39), width: 1.5),
  //                             borderRadius: BorderRadius.circular(16.r),
  //                           ),
  //                           padding: EdgeInsets.all(12.r),
  //                           margin: EdgeInsets.only(top: 12.h),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               CustomText(text: "Driver Name: abcd"),
  //                               SizedBox(height: 8.h),
  //                               CustomText(
  //                                   text: "Flatbed Tow Truck (Rollback)", bottom: 12.h),
  //                               Row(
  //                                 children: [
  //                                   Icon(Icons.location_on),
  //                                   CustomText(text: "800m (5mins away)"),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 12.h),
  //                               Row(
  //                                 children: [
  //                                   Icon(Icons.star, color: Colors.yellow),
  //                                   CustomText(
  //                                       text: "4.65     |   24545 Trips   |",
  //                                       fontSize: 11.h),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 16.h),
  //
  //                               Container(
  //                                 width: double.infinity,
  //                                 decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(16.r),
  //                                     gradient: LinearGradient(
  //                                       begin: Alignment.topCenter,
  //                                       end: Alignment.bottomCenter,
  //                                       colors: [
  //                                         Color(0xffAA8F5D),
  //                                         Color(0xff5D5036),
  //                                       ],
  //                                     )
  //                                 ),
  //                                 child: CustomText(
  //                                     top: 9.h,
  //                                     bottom: 9.h,
  //                                     text: "View Details", color: Colors.white),
  //                               )
  //                             ],
  //                           ),
  //                         );
  //
  //                   }),
  //                 ),
  //
  //
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

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
                border: Border.all(color: Colors.grey, width: .15.r)
              ),
              child: Padding(
                padding:  EdgeInsets.all(8.r),
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

  @override
  void initState() {
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
                      isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                      size: 28.h,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  CustomText(
                    text: "Select Tow Truck",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffB78D39), width: 1.5),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(12.r),
                        margin: EdgeInsets.only(top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Driver Name: abcd"),
                            SizedBox(height: 8.h),
                            CustomText(
                                text: "Flatbed Tow Truck (Rollback)", bottom: 12.h),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 15.h),
                                CustomText(text: "800m (5mins away)"),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow, size: 15.h),
                                CustomText(
                                    text: "4.65     |   24545 Trips   |",
                                    fontSize: 11.h),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            GestureDetector(
                              onTap: () {
                                // toggleSheet();
                                Get.toNamed(AppRoutes.jobDetailsScreen);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
