import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/helpers/time_format.dart';
import 'package:towservice/main.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_container.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../controller/current_location_controller.dart';
import '../../../../../../../controller/live_location_change_controller.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../controller/tow_truck/tow_trcuk_job_controller.dart';

class TripHistoryScreen extends StatefulWidget {
  TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  TowTruckJobController towTruckJobController =
  Get.put(TowTruckJobController());
  TextEditingController supportNoteCtrl = TextEditingController();
  late GoogleMapController mapController;
  LiveLocationChangeController liveLocationChangeController =
  Get.find<LiveLocationChangeController>();
  CurrentLocationController currentLocationController =
  Get.find<CurrentLocationController>();

  var routeData = Get.arguments;

  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  LatLng userLatLng = const LatLng(23.7805733, 90.2792399);
  LatLng mechanicLatLng = const LatLng(23.7855733, 90.2852399);

  BitmapDescriptor carIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    loadRouteData();
    super.initState();
  }

  void loadRouteData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (routeData["fromLat"] != null) {
        if (currentLocationController.latitude.value != null) {
          userLatLng = LatLng(
            currentLocationController.latitude.value,
            currentLocationController.longitude.value,
          );
        }

        mechanicLatLng = LatLng(
          routeData["toLat"] ?? 23.78,
          routeData["toLng"] ?? 90.28,
        );

        getRoutePolyline(userLatLng, mechanicLatLng);
      } else {
        // 🔁 Retry after 500 milliseconds
        Future.delayed(const Duration(milliseconds: 500), () {
          loadRouteData();
        });
      }
    });
  }

  Future<void> getRoutePolyline(LatLng origin, LatLng destination) async {
    String apiKey = "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0";
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin
        .latitude},${origin.longitude}&destination=${destination
        .latitude},${destination.longitude}&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final points = data["routes"][0]["overview_polyline"]["points"];

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> result = polylinePoints.decodePolyline(points);

      polylineCoordinates.clear();
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        polylines = {
          Polyline(
            polylineId: PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: polylineCoordinates,
          )
        };
      });
    } else {
      print("Failed to load directions: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "${routeData["type"]}"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                // paddingHorizontal: 24.r,
                height: 180.h,
                radiusAll: 12.r,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 4,
                      spreadRadius: 0)
                ],
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: GetBuilder<CurrentLocationController>(
                      builder: (controller) {
                        if (controller.isLoading.value ||
                            controller.initialCameraPosition == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return GoogleMap(
                          myLocationEnabled: true,
                          initialCameraPosition:
                          controller.initialCameraPosition!,
                          markers: {
                            Marker(
                                markerId: const MarkerId("provider"),
                                position: mechanicLatLng,
                                infoWindow:
                                InfoWindow(title: "${routeData["name"]}"),
                                icon: carIcon),
                            Marker(
                              markerId: const MarkerId("user"),
                              position: userLatLng,
                              infoWindow:
                              const InfoWindow(title: "Your Location"),
                            ),
                          },
                          polylines: polylines,
                          onMapCreated: (GoogleMapController mapCtrl) {
                            controller.mapController = mapCtrl;
                          },
                        );
                      },
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(2, 4))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 22.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "${routeData["name"]}", fontSize: 16.h),
                          CustomText(
                              text: "${routeData["status"].toString()}",
                              fontSize: 13.h,
                              color: AppColors.primaryColor),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                              "${TimeFormatHelper.formatDate(
                                  DateTime.parse("${routeData["dateTime"]}"))}",
                              fontSize: 16.h),
                          CustomText(
                              text:
                              "${TimeFormatHelper.timeWithAMPM(
                                  DateTime.parse("${routeData["dateTime"]}"))}",
                              fontSize: 11.h),
                        ],
                      ),
                      SizedBox(width: 16.w)
                    ],
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.symmetric(vertical: 8.h),
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(2, 4))
                    ]),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Your Trip", fontWeight: FontWeight.w600),
                      Row(
                        children: [
                          Assets.icons.pickUpIcon.svg(),
                          CustomText(
                              text: " ${routeData["fromAddress"]}",
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      Container(height: 20.h, width: 1.5.w, color: Colors.grey),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12.h),
                          CustomText(
                              text: " ${routeData["toAddress"]}",
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Distance :"),
                          CustomText(
                              text:
                              "${(double.parse(routeData["distance"]))
                                  .toStringAsFixed(2)} km",
                              right: 20.w),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomContainer(
                paddingAll: 16.r,
                // height: 36.h,
                radiusAll: 16.r,
                width: double.infinity,
                color: AppColors.paymentCardColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // spacing: 8,
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 16.sp,
                          color: AppColors.primaryColor,
                        ),
                        CustomText(
                          text: 'Payment',
                          fontSize: 12.sp,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16.sp,
                        )
                      ],
                    ),
                    CustomText(
                      text: '${routeData["amount"]} ₦',
                      fontSize: 11.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              CustomContainer(
                width: double.infinity,
                paddingAll: 8.r,
                radiusAll: 16.r,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 4),
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 2)
                ],
                child: Row(
                  children: [
                    CustomNetworkImage(
                        height: 53.h,
                        boxShape: BoxShape.circle,
                        width: 53.w,
                        imageUrl:
                        "${ApiConstants.imageBaseUrl}/${routeData["image"]}"),
                    SizedBox(width: 10.w),
                    CustomText(text: "${routeData["name"]}"),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE4E4E4),
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final Uri url =
                                Uri.parse('tel:${routeData["email"]}');
                                if (await launchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  debugPrint('Could not launch phone dialer');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Assets.icons.messageIcon
                                      .svg(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                            SizedBox(width: 30.w),
                            GestureDetector(
                              onTap: () async {
                                final Uri url =
                                Uri.parse('tel:${routeData["phone"]}');
                                if (await launchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  debugPrint('Could not launch phone dialer');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Assets.icons.callIcon.svg(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              routeData["type"] == "Trip Details" && routeData["role"] == "user"
                  ? Obx(
                    () =>
                    CustomButtonTwo(
                        loading: towTruckJobController
                            .acceptCompletedLoading.value,
                        title: "Completed",
                        onpress: () async {
                          var response = await towTruckJobController
                              .completedRequest(jobId: routeData["jobId"]);

                          if (response == true) {
                            showPaymentRatingSheet(context, routeData["providerId"]);
                          }
                        }),
              )
                  : SizedBox(),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentRatingBottomSheet extends StatefulWidget {
  final String? providerId;

  const PaymentRatingBottomSheet({super.key, this.providerId});
  @override
  _PaymentRatingBottomSheetState createState() =>
      _PaymentRatingBottomSheetState();
}

class _PaymentRatingBottomSheetState extends State<PaymentRatingBottomSheet> {
  int selectedStars = 4; // default 4 stars
  List<String> comments = [
    "Driver was very polite",
    "Riding was smooth and comfortable",
    "Reached destination on time",
    "Drive safely",
    "Car was clean and well-maintained",
    "Very friendly driver",
    "Helped with luggage",
    "Professional driving skills",
    "Great communication",
    "Overall excellent service"
  ];

  List<String> selectedComments = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            "Your payment has been made.",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            "Now, Give Stars to Driver.",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 10.h),

          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    selectedStars = index + 1;
                  });
                },
                icon: Icon(
                  index < selectedStars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30.sp,
                ),
              );
            }),
          ),
          SizedBox(height: 10.h),

          // Leave a comment
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Leave Us A Comment",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10.h),

          // Comment buttons
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: comments.map((comment) {
              final isSelected = selectedComments.contains(comment);
              return ChoiceChip(
                label: Text(comment),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedComments.add(comment);
                    } else {
                      selectedComments.remove(comment);
                    }
                  });
                },
                selectedColor: Colors.blueAccent.withOpacity(0.2),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),

          CustomButtonTwo(title: "Thank You", onpress: () {
            towTruckJobController.reviewSubmit(rating: selectedStars.toString(),
                comment: selectedComments.toString(),
                providerId: widget.providerId.toString());
          }),

          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

// Usage:
void showPaymentRatingSheet(BuildContext context, String providerId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => PaymentRatingBottomSheet(),
  );
}
