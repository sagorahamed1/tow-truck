import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/toast_message_helper.dart';
import '../../routes/app_routes.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class UserJobPostController extends GetxController{



  ///===============fillProfile================<>
  RxBool jobPostLoading = false.obs;

  jobPost({required String car, required String issue, note, distance, required List coodinates, destCoodinate }) async {
    jobPostLoading(true);
    var body =
    {
      "vehicle": "${car.toLowerCase()}",
      "issue": "${issue.toLowerCase()}",
      "note": "$note",
      "coordinates": [90.4125, 23.8103],
      "destCoordinates": [90.3842, 23.7980],
      "distance": 5.2
    };

    var response = await ApiClient.postData(ApiConstants.postJob, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.toNamed(AppRoutes.userMapScreen);
      ToastMessageHelper.showToastMessage('${response.body["message"]}');

      print("======>>> successful");
      jobPostLoading(false);
    } else {
      jobPostLoading(false);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
    }
  }


}