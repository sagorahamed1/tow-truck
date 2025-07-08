import 'package:get/get.dart';
import 'package:towservice/helpers/privacy_and_terms_helper.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(PrivacyController());
  }

}