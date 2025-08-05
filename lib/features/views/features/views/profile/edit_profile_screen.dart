import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text_field.dart';


class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController companyCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController typeOfTowTruckCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();


  @override
  void initState() {
    Map? data = Get.arguments;
    nameCtrl.text = data?["name"]?.toString() ?? "";
    emailCtrl.text = data?["email"]?.toString() ?? "";
    addressCtrl.text = data?["address"]?.toString() ?? "";
    phoneCtrl.text = data?["phone"]?.toString() ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: "Edit Profile"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),

              SizedBox(
                height: 100.h,
                child: Stack(
                  children: [

                    CustomNetworkImage(
                      imageUrl: "https://i.pravatar.cc/140?img=3",
                      height: 100.h,
                      width: 100.w,
                      boxShape: BoxShape.circle,
                    ),


                    Positioned(
                        bottom: 0.h,
                        right: 0.w,
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(5.r),
                              child: Icon(Icons.edit),
                            ))

                    )
                  ],
                ),
              ),


              SizedBox(height: 16.h),


              CustomTextField(
                controller: nameCtrl,
                hintText: "victor",
                labelText: "Full Name",
                contentPaddingVertical: 10.h,
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
              ),



              CustomTextField(
                controller: companyCtrl,
                hintText: "company name",
                labelText: "Company Name",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),



              CustomTextField(
                controller: addressCtrl,
                hintText: "address",
                labelText: "Address",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),




              CustomTextField(
                controller: phoneCtrl,
                hintText: "",
                labelText: "Phone",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),





              CustomTextField(
                controller: typeOfTowTruckCtrl,
                hintText: "Type of tow truck",
                labelText: "Type of tow truck",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),




              CustomTextField(
                controller: dateCtrl,
                hintText: "Select birth date",
                labelText: "Date of Birth",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
                readOnly: true,
                onTap: () async{


                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateCtrl.text = formattedDate;
                    });
                  }

                },
              ),




              CustomTextField(
                controller: genderCtrl,
                hintText: "Gender",
                labelText: "Gender",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),




              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(text: "Documents", fontSize: 16.h, bottom: 10.h, top: 4.h)),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.documentScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 42.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [

                      Icon(Icons.file_copy_outlined, color: AppColors.primaryColor),

                      CustomText(text: "My Documents", left: 8.w),


                      Spacer(),

                      Assets.icons.rightArrow.svg(),


                    ],
                  ),
                ),
              ),


              SizedBox(height: 16.h),




              CustomTextField(
                controller: descriptionCtrl,
                hintText: "Description",
                labelText: "Description",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),




              SizedBox(height: 40.h),

              CustomButtonTwo(title: "Update Profile", onpress: (){
                Get.back();
              }),

              SizedBox(height: 100.h)


            ],
          ),
        ),
      ),
    );
  }
}
