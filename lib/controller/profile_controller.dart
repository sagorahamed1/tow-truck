import 'package:get/get.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/utils/app_constant.dart';

class ProfileController extends GetxController{
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString image = ''.obs;
  RxString role = ''.obs;
  RxString rating = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;


  getUserLocalData()async{
    name.value = await PrefsHelper.getString(AppConstants.name);
    email.value = await PrefsHelper.getString(AppConstants.email);
    image.value = await PrefsHelper.getString(AppConstants.image);
    role.value = await PrefsHelper.getString(AppConstants.role);
    phone.value = await PrefsHelper.getString(AppConstants.number);
    address.value = await PrefsHelper.getString(AppConstants.address);
  }

}