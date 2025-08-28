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



  //
  // RxString providerId = "".obs;
  // Rx<JobDetailsModel> jobDetails = JobDetailsModel().obs;
  // RxBool jobDetailsLoading = false.obs;
  // getJobDetails()async{
  //   var jobId = await PrefsHelper.getString(AppConstants.jobId);
  //   jobDetailsLoading(true);
  //   var response = await ApiClient.getData("${ApiConstants.jobDetails}/${jobId}/${providerId.value}");
  //
  //   if(response.statusCode == 200){
  //     jobDetails.value = JobDetailsModel.fromJson(response.body["data"]);
  //     jobDetailsLoading(false);
  //   }else{
  //     jobDetailsLoading(false);
  //   }
  // }
  //
  //

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
      "negAmount" : 745
    };

    var response = await ApiClient.postData("${ApiConstants.negotiate}/${jobId}", jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      Get.back();
      negotiateLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      negotiateLoading(false);
    }
  }



}