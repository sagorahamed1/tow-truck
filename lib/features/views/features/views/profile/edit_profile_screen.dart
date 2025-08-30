import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:towservice/controller/auth_controller.dart';
import 'package:towservice/controller/profile_controller.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_loader.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../controller/upload_app_file.dart';
import '../../../../../model/tow_truck_model.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../fill_profile/fill_profile_screen.dart';


class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  ProfileController profileController = Get.find<ProfileController>();
  AuthController authController = Get.find<AuthController>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController companyCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController typeOfTowTruckCtrl = TextEditingController();
  TextEditingController towTypeIdCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController image = TextEditingController();

  List genderList = ['male', 'female'];
  List dropDownList = ['male', 'female'];

  RxBool isDropDownGender = false.obs;



  @override
  void initState() {
    Map? data = Get.arguments;
    nameCtrl.text = data?["name"]?.toString() ?? "";
    emailCtrl.text = data?["email"]?.toString() ?? "";
    addressCtrl.text = data?["address"]?.toString() ?? "";
    phoneCtrl.text = data?["phone"]?.toString() ?? "";
    role.text = data?["role"]?.toString() ?? "";
    dateCtrl.text = data?["dateOfBirth"]?.toString() ?? "";
    image.text = data?["image"]?.toString() ?? "";
    profileImagePath = data?["image"]?.toString() ?? "";
    authController.getTowType();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

                    _image != null ?
                    CircleAvatar(
                        radius: 50.r,
                        backgroundImage: MemoryImage(_image!)) :
                    CustomNetworkImage(
                      imageUrl: "${ApiConstants.imageBaseUrl}${image.text}",
                      height: 100.h,
                      width: 100.w,
                      boxShape: BoxShape.circle,
                    ),


                    Positioned(
                        bottom: 0.h,
                        right: 0.w,
                        child: GestureDetector(
                          onTap: () {
                            showImagePickerOption(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.black)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(5.r),
                                child: Icon(Icons.edit),
                              )),
                        )

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



              if(role.text != "user")
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
                keyboardType: TextInputType.number,
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),





              if(role.text != "user")
              CustomTextField(
                readOnly: true,
                onTap: () {
                  openVehicleIssueOptions(context);
                },
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
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateCtrl.text = formattedDate;
                    });
                  }

                },
              ),




              if(role.text != "user")
              // ///=====================Gender ======================>
                CustomTextField(
                    borderColor: AppColors.primaryColor,
                    onTap: () {
                      if (isDropDownGender.value == true) {
                        isDropDownGender(false);
                      }
                      isDropDownGender(true);
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

              Obx(() => isDropDownGender.value
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
                        isDropDownGender(false);
                        genderCtrl.text = dropDownItems;
                      },
                    );
                  },
                ),
              )
                  : const SizedBox()),




              if(role.text != "user")
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(text: "Documents", fontSize: 16.h, bottom: 10.h, top: 4.h)),
              if(role.text != "user")
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




              if(role.text != "user")
              CustomTextField(
                controller: descriptionCtrl,
                hintText: "Description",
                labelText: "Description",
                borderColor: AppColors.primaryColor,
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),




              SizedBox(height: 40.h),

              Obx(() =>
                 CustomButtonTwo(
                    loading: profileController.updateProfileLoading.value,
                    title: "Update Profile", onpress: (){
                  if(role.text == "user"){
                    profileController.updateUserProfile(
                        dateOfBirth: dateCtrl.text,
                        address: addressCtrl.text,
                        name: nameCtrl.text,
                        phone: phoneCtrl.text,
                        profileImage: "${profileImagePath}"
                    );
                  }else{

                  }

                }),
              ),

              SizedBox(height: 100.h)


            ],
          ),
        ),
      ),
    );
  }



  void openVehicleIssueOptions(BuildContext context) async {
    final result = await showModalBottomSheet<Map>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          List<TowTruckModel> trucks = authController.towTypes.value
              .map((type) => TowTruckModel(
            id: type.id,    // map the fields properly
            name: type.name,
            // add other fields if needed
          )).toList();
          return HelpOptionsSheet2(
              options: trucks
          );
        });
      },
    );

    if (result != null) {
      typeOfTowTruckCtrl.text = result["name"];
      towTypeIdCtrl.text = result["id"];

      setState(() {});
      print("Selected option: ============================================= ${result["name"]}");
    }
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
  Uint8List? _image;
  File? selectedIMage;
  RxBool isDropDown = false.obs;

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    selectedIMage = File(returnImage.path);
    _image = File(returnImage.path).readAsBytesSync();
    profileImagePath = await UploadAppFile.uploadFile(file: selectedIMage!);
    setState(() {
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;

    Get.back();
    selectedIMage = File(returnImage.path);
    _image = File(returnImage.path).readAsBytesSync();
    profileImagePath =await UploadAppFile.uploadFile(file: selectedIMage!);
    setState(() {});

  }

}
