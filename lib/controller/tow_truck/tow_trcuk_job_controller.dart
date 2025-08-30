import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/model/tow_truck_model.dart';
import 'package:towservice/utils/app_constant.dart';

import '../../helpers/quick_aler_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../model/job_details_model.dart';
import '../../model/job_ongoing_model.dart';
import '../../model/user_job_request_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../services/vibration_service.dart';

class TowTruckJobController extends GetxController{



  // RxBool jobPostLoading = false.obs;
  //
  // jobPost({required String car, required String issue, note, distance, required List coodinates, destCoodinate }) async {
  //   jobPostLoading(true);
  //   var body =
  //   {
  //     "vehicle": "${car.toLowerCase()}",
  //     "issue": "${issue.toLowerCase()}",
  //     "note": "$note",
  //     "coordinates": [90.4125, 23.8103],
  //     "destCoordinates": [90.3842, 23.7980],
  //     "distance": 5.2
  //   };
  //
  //   var response = await ApiClient.postData(ApiConstants.postJob, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //
  //     PrefsHelper.setString(AppConstants.jobId, response.body["data"]["_id"]);
  //
  //     Get.toNamed(AppRoutes.userMapScreen);
  //     ToastMessageHelper.showToastMessage('${response.body["message"]}');
  //
  //     print("======>>> successful");
  //     jobPostLoading(false);
  //   } else {
  //     jobPostLoading(false);
  //     ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //   }
  // }



  RxList<UserJobRequestModel> users = <UserJobRequestModel>[].obs;
  RxBool getJobsFromUserLoading = false.obs;
  getUser()async{
    getJobsFromUserLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getJobFromUser}");

    if(response.statusCode == 200){

      users.value = List<UserJobRequestModel>.from(response.body["data"].map((x) => UserJobRequestModel.fromJson(x)));
      getJobsFromUserLoading(false);
    }else{
      getJobsFromUserLoading(false);
    }
  }




  RxList<UserJobRequestModel> userRequest = <UserJobRequestModel>[].obs;
  RxBool userRequestLoading = false.obs;
  getUserRequest()async{
    String role = await PrefsHelper.getString(AppConstants.role);
    userRequestLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getUserRequest(role)}");

    if(response.statusCode == 200){

      userRequest.value = List<UserJobRequestModel>.from(response.body["data"].map((x) => UserJobRequestModel.fromJson(x)));
      userRequestLoading(false);
    }else{
      userRequestLoading(false);
    }
  }





  RxList<JobOngoingModel> jobOngoing = <JobOngoingModel>[].obs;
  RxBool ongoingLoading = false.obs;
  getOngoingJob()async{
    String role = await PrefsHelper.getString(AppConstants.role);
    ongoingLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getJobOngoing(role)}");

    if(response.statusCode == 200){

      jobOngoing.value = List<JobOngoingModel>.from(response.body["data"].map((x) => JobOngoingModel.fromJson(x)));
      ongoingLoading(false);
    }else{
      ongoingLoading(false);
    }
  }



  RxList<JobOngoingModel> jobCompleted = <JobOngoingModel>[].obs;
  RxBool completedLoading = false.obs;
  getCompletedJob()async{
    String role = await PrefsHelper.getString(AppConstants.role);
    completedLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getJobCompleted(role)}");

    if(response.statusCode == 200){

      jobCompleted.value = List<JobOngoingModel>.from(response.body["data"].map((x) => JobOngoingModel.fromJson(x)));
      completedLoading(false);
    }else{
      completedLoading(false);
    }
  }



  RxBool acceptJobLoading = false.obs;

  acceptJob({required String jobId, String? providerId, trxId, BuildContext? context}) async {
    String role = await PrefsHelper.getString(AppConstants.role);
    acceptJobLoading(true);

    var body = role == "user" ? {
      "providerId": "$providerId",
      "transactionId": "$trxId"
    } : {};

    var response = await ApiClient.postData("${ApiConstants.acceptJob("$role")}/$jobId", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      if(role == "user"){

        Get.back();
        VibrationService.vibrateForDuration(2500);
        QuickAlertHelper.showSuccessAlert(context!, "Your has been successfully processed.");


        var data = {
          "jobId": "$jobId",
          "promoCode": ""
        };
        await ApiClient.postData("${ApiConstants.paymentSend}", jsonEncode(data));


      }else{
        // Get.back();
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
      }


      acceptJobLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      acceptJobLoading(false);
    }
  }




  RxBool negotiateLoading = false.obs;

  negotiateJob({required String jobId, price}) async {
    negotiateLoading(true);
    var body = {
      "negAmount" : int.parse("$price")
    };

    var response = await ApiClient.postData("${ApiConstants.negotiate}/${jobId}", jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      negotiateLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      negotiateLoading(false);
    }
  }





  RxBool cancelLoading = false.obs;

  cancelJobs({required String jobId}) async {
    cancelLoading(true);

    var response = await ApiClient.postData("${ApiConstants.cancelJob}/${jobId}", jsonEncode({}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      userRequest.removeWhere((x) => x.jobId == jobId);
      update();
      Get.back();
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      cancelLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      cancelLoading(false);
    }
  }




  RxBool acceptCompletedLoading = false.obs;

 Future<bool?> completedRequest({required String jobId}) async {
    acceptCompletedLoading(true);

    var response = await ApiClient.postData("${ApiConstants.completed}/${jobId}", jsonEncode({}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      jobOngoing.removeWhere((x) => x.jobId == jobId);
      update();
      // Get.back();
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      acceptCompletedLoading(false);
      return true;
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      acceptCompletedLoading(false);
      return false;
    }

  }






  RxBool reviewLoading = false.obs;

  Future<bool?> reviewSubmit({required String rating, comment, providerId}) async {
    reviewLoading(true);

    var body = {
      "rating": int.parse(rating),
      "comment": "$comment"
    };

    var response = await ApiClient.postData("${ApiConstants.review}/${providerId}", jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.back();
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      reviewLoading(false);

    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      reviewLoading(false);

    }

  }




}