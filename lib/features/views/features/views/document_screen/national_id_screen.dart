import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towservice/controller/tow_truck/upload_nid_controller.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:towservice/widgets/custom_text_field.dart';

import '../../../../../controller/upload_app_file.dart';

class NationalIDScreen extends StatefulWidget {
  const NationalIDScreen({super.key});

  @override
  State<NationalIDScreen> createState() => _NationalIDScreenState();
}

class _NationalIDScreenState extends State<NationalIDScreen> {

  UploadNidController uploadNidController = Get.put(UploadNidController());
  File? _frontImage;
  File? _backImage;


  String? frontPath;
  String? backPath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (isFront) {
      _frontImage = File(pickedFile!.path);
      frontPath = await UploadAppFile.uploadFile(file: _frontImage!);
    } else {
      _backImage = File(pickedFile!.path);
      backPath = await UploadAppFile.uploadFile(file: _backImage!);
    }

    setState(() {});
  }




  @override
  void initState() {

    uploadNidController.getNID(
      endPoint:  "${Get.arguments["appBarTitle"]}" ==
          "National ID" ? "nid" : "${Get
          .arguments["appBarTitle"]}" == "Driving License"
          ? "license"
          : "${Get.arguments["appBarTitle"]}" ==
          "Car Registration" ? "reg" : "img",
    );

    Future.delayed(Duration(seconds: 3));
    fetchDate();

    super.initState();
  }

  fetchDate(){

    backPath = uploadNidController.back?.value ?? "";
    frontPath = uploadNidController.front?.value ?? "";
    setState(() {});
  }



  @override
  void dispose() {
    uploadNidController.back?.value = "";
    uploadNidController.front?.value = "";
    uploadNidController.idController.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    fetchDate();
    return Scaffold(
      appBar: CustomAppBar(
        title: "${Get.arguments["appBarTitle"]}",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Get.arguments["textEditCtrlTitle"] == "N/A"
                ? SizedBox()
                : CustomTextField(
                keyboardType: TextInputType.number,
                controller: uploadNidController.idController,
                hintText: "${Get.arguments["textEditCtrlTitle"]}",
                labelText: "${Get.arguments["textEditCtrlTitle"]}"),

            SizedBox(height: 20.h),

            // Upload front
            Obx(() =>
               _buildUploadBox(
                label: "${Get.arguments["image1"]}",
                image: uploadNidController.front?.value ?? frontPath,
                onTap: () => _pickImage(true),
              ),
            ),

            // Upload back
            Obx(() =>
               _buildUploadBox(
                label: "${Get.arguments["image2"]}",
                image: uploadNidController.back?.value ?? backPath,
                onTap: () => _pickImage(false),
              ),
            ),

            SizedBox(height: 40.h),

            Obx(() =>
                CustomButtonTwo(
                    loading: uploadNidController.nidUploading.value,
                    title: "Save",
                    onpress: () {
                      uploadNidController.uploadNID(
                          endPoint: "${Get.arguments["appBarTitle"]}" ==
                              "National ID" ? "nid" : "${Get
                              .arguments["appBarTitle"]}" == "Driving License"
                              ? "license"
                              : "${Get.arguments["appBarTitle"]}" ==
                              "Car Registration" ? "reg" : "img",
                          nid: uploadNidController.idController.text,
                          back: backPath?.toString() ?? uploadNidController.back?.value,
                          font: frontPath?.toString()) ?? uploadNidController.front?.value;
                    }),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildUploadBox({
    required String label,
    required String? image,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          left: 4.w,
          bottom: 8.h,
        ),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 1,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(12.r),
            child: Container(
              width: double.infinity,
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: image != null
                    ?
                DecorationImage(
                    image: NetworkImage(ApiConstants.imageBaseUrl+image), fit: BoxFit.cover)
                    : null,
              ),
              child: image == ""
                  ? Center(
                child: Assets.icons.uploadIcon.svg(height: 45.h),
              )
                  : null,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

}
