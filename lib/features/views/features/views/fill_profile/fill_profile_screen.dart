import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towservice/controller/upload_app_file.dart';
import 'package:towservice/helpers/toast_message_helper.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text_field.dart';

import '../../../../../controller/auth_controller.dart';
import '../../../../../helpers/time_format.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';

class FillProfileScreen extends StatefulWidget {
  FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List genderList = ['male', 'female'];
  List dropDownList = ['male', 'female'];

  // File? image;
  DateTime selectedDate = DateTime.now();
  Uint8List? _image;
  File? selectedIMage;
  RxBool isDropDown = false.obs;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController typeOfTowTruckCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(
          text: "Complete Your Profile.",
          fontSize: 22.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        text: "Fill the informaion", top: 8.h, bottom: 24.h),
                  ),

                  Center(
                    child: Container(
                      height: 105.h,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 0.5),
                            ),
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 60.r,
                                    backgroundImage: MemoryImage(_image!))
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 100.h,
                                    width: 100.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.edit, size: 80.h)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                                onTap: () {
                                  showImagePickerOption(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 0.50)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.camera_alt),
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),

                  CustomTextField(
                      borderColor: AppColors.primaryColor,
                      controller: nameCtrl,
                      labelText: "Company Name",
                      hintText: "Enter name",
                      prefixIcon:
                          Icon(Icons.person, color: AppColors.primaryColor)),

                  CustomTextField(
                      borderColor: AppColors.primaryColor,
                      controller: addressCtrl,
                      labelText: "Address",
                      hintText: "Enter address",
                      prefixIcon: Icon(Icons.location_on,
                          color: AppColors.primaryColor)),

                  CustomTextField(
                      borderColor: AppColors.primaryColor,
                      controller: typeOfTowTruckCtrl,
                      labelText: "Type of tow truck",
                      hintText: "Enter type of tow truck"),

                  ///=====================Date of birth ======================>
                  CustomTextField(
                    borderColor: AppColors.primaryColor,
                    labelText: "Date of birth",
                    readOnly: true,
                    onTap: () {
                      selectDate(context);
                    },
                    controller: dateOfBirthCtrl,
                    hintText: "Select date of birth",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select date of birth";
                      }
                      return null;
                    },
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: SvgPicture.asset(AppIcons.carerIcon)),
                  ),

                  // ///=====================Gender ======================>
                  CustomTextField(
                      borderColor: AppColors.primaryColor,
                      onTap: () {
                        if (isDropDown.value == true) {
                          isDropDown(false);
                        }
                        isDropDown(true);
                      },
                      readOnly: true,
                      controller: genderCtrl,
                      hintText: "Select gender",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your gender";
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Icon(Icons.keyboard_arrow_down_rounded),
                      )),

                  isDropDown.value
                      ? Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          height: 120.h,
                          child: ListView.builder(
                            itemCount: dropDownList.length,
                            itemBuilder: (context, index) {
                              var dropDownItems = dropDownList[index];
                              return ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20.w),
                                title: CustomText(
                                    text: dropDownItems,
                                    textAlign: TextAlign.start),
                                onTap: () {
                                  isDropDown(false);
                                  genderCtrl.text = dropDownItems;
                                },
                              );
                            },
                          ),
                        )
                      : const SizedBox(),

                  ///===================== description ======================>
                  CustomTextField(
                    borderColor: AppColors.primaryColor,
                    hintText: "Enter description",
                    labelText: "Description",
                    controller: descriptionCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter description";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 48.h),

                  Obx(
                    () => CustomButtonTwo(
                        loading: _authController.fillProfileLoading.value,
                        onpress: () {
                          if (_formKey.currentState!.validate()) {

                            if(_image == null){
                              ToastMessageHelper.showToastMessage("Please select your profile image");
                            }else{
                              _authController.fillProfile(
                                  name: nameCtrl.text,
                                  description: descriptionCtrl.text,
                                  address: addressCtrl.text,
                                  dateOfBirth: dateOfBirthCtrl.text,
                                  gender: genderCtrl.text,
                                  typeOfTowTruck: typeOfTowTruckCtrl.text,
                                  image: profileImagePath
                              );
                            }


                          }
                        },
                        title: "Next"),
                  ),

                  SizedBox(height: 200.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //==================================> ShowImagePickerOption Function <===============================

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                            ),
                            CustomText(text: 'Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                            ),
                            CustomText(text: 'Camera')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String profileImagePath = "";

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    _image = File(returnImage.path).readAsBytesSync();
    profileImagePath = await UploadAppFile.uploadFile(file: selectedIMage!);
    setState(() {});
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    _image = File(returnImage.path).readAsBytesSync();
    profileImagePath = await UploadAppFile.uploadFile(file: selectedIMage!);
    setState(() {});
    // Get.back();
  }

  //==================================> Calender <==================================
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      dateOfBirthCtrl.text = TimeFormatHelper.formatDateWithHifen(selectedDate);
      print('Selected date: ${dateOfBirthCtrl.text}');
    }
  }
}

