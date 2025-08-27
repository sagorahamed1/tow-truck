import 'package:get/get.dart';
import 'package:towservice/helpers/privacy_and_terms_helper.dart';

import '../controller/auth_controller.dart';
import '../controller/chat_controller.dart';
import '../controller/profile_controller.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(PrivacyController());
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
  }

}