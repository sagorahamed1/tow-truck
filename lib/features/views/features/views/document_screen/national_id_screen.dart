import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:towservice/widgets/custom_text_field.dart';

class NationalIDScreen extends StatefulWidget {
  const NationalIDScreen({super.key});

  @override
  State<NationalIDScreen> createState() => _NationalIDScreenState();
}

class _NationalIDScreenState extends State<NationalIDScreen> {
  final TextEditingController _idController = TextEditingController();
  File? _frontImage;
  File? _backImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }





  Widget _buildUploadBox({
    required String label,
    required File? image,
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
                    ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                    : null,
              ),
              child: image == null
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${Get.arguments["appBarTitle"]}",),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Get.arguments["textEditCtrlTitle"] == "N/A" ? SizedBox() :
            CustomTextField(controller: _idController, hintText: "${Get.arguments["textEditCtrlTitle"]}", labelText: "${Get.arguments["textEditCtrlTitle"]}"),



            SizedBox(height: 20.h),

            // Upload front
            _buildUploadBox(
              label:  "${Get.arguments["image1"]}",
              image: _frontImage,
              onTap: () => _pickImage(true),
            ),

            // Upload back
            _buildUploadBox(
              label:  "${Get.arguments["image2"]}",
              image: _backImage,
              onTap: () => _pickImage(false),
            ),




            SizedBox(height: 40.h),

            CustomButtonTwo(title: "Save", onpress: () {
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}
