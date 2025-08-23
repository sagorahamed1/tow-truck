import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:towservice/services/api_client.dart';
import 'package:towservice/services/api_constants.dart';

class UploadNidController extends GetxController {


  RxBool nidUploading = false.obs;
  uploadNID({String? nid, font, back, endPoint}) async {
    nidUploading(true);
    var body = {"nidNo": "$nid", "nidFront": "$font", "nidBack": "$back"};

    var response = await ApiClient.patch("${ApiConstants.nidUpload}${endPoint??""}", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      nidUploading(false);
    }else{
      nidUploading(false);
    }
  }



  RxBool getNIDLoading = false.obs;
   TextEditingController idController = TextEditingController();
  RxString? front = ''.obs;
  RxString? back = ''.obs;

  getNID({String? endPoint}) async {
    getNIDLoading(true);
    var response = await ApiClient.getData("${ApiConstants.nidUpload}${endPoint??""}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      idController.text = response.body["data"]["nidNo"];
      back?.value = response.body["data"]["nidBack"];
      front?.value = response.body["data"]["nidFront"];

      update();
      getNIDLoading(false);
    } else {
      getNIDLoading(false);
    }
  }


}



