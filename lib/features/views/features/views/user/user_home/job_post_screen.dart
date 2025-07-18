import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location_picker_text_field/open_street_location_picker.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';

import '../../../../../../controller/current_location_controller.dart';
import '../../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_field.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  CurrentLocationController controller = Get.put(CurrentLocationController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var address = "";

  @override
  void initState() {
    priviuseScreenData();
    super.initState();
  }

  priviuseScreenData(){
    address = "${Get.arguments["address"] ?? ""}";
    setState(() {

    });
  }

  TextEditingController carCtrl = TextEditingController();
  TextEditingController vehicleIssueCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  TextEditingController carSelectIdCtrl = TextEditingController();
  TextEditingController locationName = TextEditingController();

  double distance = 0;
  double lat = 0;
  double log = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: "Tow Service Booking"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 4),
                                blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(17.r),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        border: Border.all(
                                            color: AppColors.primaryShade600),
                                        color: const Color(0xffE6E6FF)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8.w),
                                          Icon(Icons.location_on,
                                              color: AppColors.primaryShade600),
                                          Expanded(
                                            child: CustomText(
                                                textAlign: TextAlign.start,
                                                text:
                                                    "$address",
                                                color:
                                                    AppColors.primaryShade600,
                                                left: 8.w),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_downward),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: const Color(0xffE6E6FF)),
                                    child: LocationPicker(
                                      label: "",
                                      controller: locationName,
                                      onSelect: (data) {
                                        locationName.text = data.displayname;
                                        distance =
                                            controller.calculateDistanceInMiles(
                                                data.latitude, data.longitude);
                                        log = data.longitude;
                                        lat = data.latitude;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.primaryColor),
                      child: Padding(
                        padding: EdgeInsets.all(18.r),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: CustomText(
                                      maxline: 2,
                                      textAlign: TextAlign.start,
                                      text: "$address",
                                      color: Colors.white,
                                      left: 7.w),
                                )
                              ],
                            ),
                            Icon(Icons.arrow_downward_rounded,
                                color: Colors.white),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: locationName.text.isEmpty
                                          ? "You've not selected a location yet."
                                          : "${locationName.text}",
                                      color: Colors.white,
                                      maxline: 2,
                                      left: 7.w),
                                )
                              ],
                            ),
                            CustomText(
                                text:
                                    "Total Distance: ${distance.toStringAsFixed(2)} KM",
                                color: Colors.white,
                                fontSize: 16.h,
                                top: 20.h)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                    onTap: () {
                      openCarOptions(context);
                    },
                    readOnly: true,
                    controller: carCtrl,
                    labelText: "Car Type",
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    hintText: "Select Car"),
                CustomTextField(
                    onTap: () {
                      openVehicleIssueOptions(context);
                    },
                    readOnly: true,
                    controller: vehicleIssueCtrl,
                    labelText: "Vehicle Issue",
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    hintText: "Select your car problem"),
                CustomTextField(
                    controller: noteCtrl,
                    minLines: 4,
                    labelText: "Note",
                    hintText: "Write note"),
                SizedBox(height: 16.h),
                CustomButtonTwo(title: "Request Tow", onpress: () {

                  Get.toNamed(AppRoutes.userMapScreen);

                }),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }


  final List<String> carOptions = [
    'Stuck / Emergency',
    'Jump Start',
    'Flat Tire',
    'Out of Fuel',
    'Recovery (mud/snow)',
    'Lockout Out',
    'Other',
  ];

  void openCarOptions(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return HelpOptionsSheet(
          options: carOptions
        );
      },
    );

    if (result != null) {
      carCtrl.text = result;
      setState(() {});
      print("Selected option: $result");
    }
  }




  final List<String> vehicleIssueOption = [
    'Motor Bike',
    'Car',
    'Jeep',
    'Car',
    'Close Truck',
    'Open Truck',
    'Other',
  ];

  void openVehicleIssueOptions(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return HelpOptionsSheet(
            options: vehicleIssueOption
        );
      },
    );

    if (result != null) {
      vehicleIssueCtrl.text = result;
      setState(() {});
      print("Selected option: $result");
    }
  }

}



class HelpOptionsSheet extends StatefulWidget {
  final List<String> options;

  const HelpOptionsSheet({super.key, required this.options});

  @override
  State<HelpOptionsSheet> createState() => _HelpOptionsSheetState();
}

class _HelpOptionsSheetState extends State<HelpOptionsSheet> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.options.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // Close and return selected value
              Future.delayed(Duration(milliseconds: 200), () {
                Navigator.pop(context, widget.options[index]);
              });
            },
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: selectedIndex == index
                      ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  )
                      : null,
                ),
                Text(
                  widget.options[index],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
