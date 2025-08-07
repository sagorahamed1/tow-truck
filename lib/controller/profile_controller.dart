import 'dart:convert';

import 'package:get/get.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/services/api_client.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_constant.dart';

class ProfileController extends GetxController{
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString image = ''.obs;
  RxString role = ''.obs;
  RxString rating = '0'.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString dateOfBirth = ''.obs;



  getUserLocalData()async{
    name.value = await PrefsHelper.getString(AppConstants.name);
    email.value = await PrefsHelper.getString(AppConstants.email);
    image.value = await PrefsHelper.getString(AppConstants.image);
    role.value = await PrefsHelper.getString(AppConstants.role);
    phone.value = await PrefsHelper.getString(AppConstants.number);
    address.value = await PrefsHelper.getString(AppConstants.address);
    dateOfBirth.value = await PrefsHelper.getString(AppConstants.dateOfBirth);
    rating.value = await PrefsHelper.getString(AppConstants.rating);
  }


  RxBool updateProfileLoading = false.obs;
  updateUserProfile({String? name, String? phone, String? dateOfBirth, String? address, String? profileImage})async{
    updateProfileLoading(true);
    var body = {
      "name": "$name",
      "phone": "$phone",
      "dateOfBirth": "$dateOfBirth",
      "address": "$address",
      "profileImage": "$profileImage"
    };
    var response = await ApiClient.patch(ApiConstants.updateProfile, jsonEncode(body));

    if(response.statusCode == 201 || response.statusCode == 200){
      PrefsHelper.setString(AppConstants.name, name);
      PrefsHelper.setString(AppConstants.number, phone);
      PrefsHelper.setString(AppConstants.dateOfBirth, dateOfBirth);
      PrefsHelper.setString(AppConstants.address, address);
      PrefsHelper.setString(AppConstants.image, profileImage);

      Get.back();
      updateProfileLoading(false);


    }else{

      updateProfileLoading(false);
    }

  }

}