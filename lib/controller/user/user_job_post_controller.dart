import 'dart:convert';

import 'package:get/get.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/model/tow_truck_model.dart';
import 'package:towservice/utils/app_constant.dart';

import '../../helpers/toast_message_helper.dart';
import '../../model/job_details_model.dart';
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

      PrefsHelper.setString(AppConstants.jobId, response.body["data"]["_id"]);

      Get.toNamed(AppRoutes.userMapScreen);
      ToastMessageHelper.showToastMessage('${response.body["message"]}');

      print("======>>> successful");
      jobPostLoading(false);
    } else {
      jobPostLoading(false);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
    }
  }



  RxList<TowTruckModel> towTrucks = <TowTruckModel>[].obs;
  RxList towTruckProviderList = [].obs;

  RxBool towTruckLoading = false.obs;
  getTowTruck()async{
    towTruckLoading(true);
    var response = await ApiClient.getData("${ApiConstants.towTruck}");

    if(response.statusCode == 200){

      towTrucks.value = List<TowTruckModel>.from(response.body["data"]["providers"].map((x) => TowTruckModel.fromJson(x)));
      towTruckProviderList.value = towTrucks.map((e) => e.id).toList();
      towTruckLoading(false);
    }else{
      towTruckLoading(false);
    }
  }




  RxString providerId = "".obs;
  Rx<JobDetailsModel> jobDetails = JobDetailsModel().obs;
  RxBool jobDetailsLoading = false.obs;
  getJobDetails()async{
    var jobId = await PrefsHelper.getString(AppConstants.jobId);
    jobDetailsLoading(true);
    var response = await ApiClient.getData("${ApiConstants.jobDetails}/${jobId}/${providerId.value}");

    if(response.statusCode == 200){
      jobDetails.value = JobDetailsModel.fromJson(response.body["data"]);
      jobDetailsLoading(false);
    }else{
      jobDetailsLoading(false);
    }
  }



  RxBool requestProviderLoading = false.obs;

  requestJobPost({required List providerList}) async {
    requestProviderLoading(true);
    String jobId = await PrefsHelper.getString(AppConstants.jobId);
    var body = {
      "providerIds": providerList.toList()
    };

    var response = await ApiClient.postData("${ApiConstants.requestJob}/$jobId", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();

      requestProviderLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      requestProviderLoading(false);
    }
  }




}