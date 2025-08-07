
import 'package:get/get.dart';
import 'package:towservice/services/api_client.dart';
import 'package:towservice/services/api_constants.dart';

class CustomerSupportController extends GetxController{

  RxString phone = "".obs;
  RxString email = "".obs;
  RxBool supportLoading = false.obs;

  getSupportEmailPhone()async{
    supportLoading(true);

    var response = await ApiClient.getData(ApiConstants.support);

    if(response.statusCode == 200 || response.statusCode == 201){
      phone.value = response.body["data"]["value"]["phone"];
      email.value = response.body["data"]["value"]["email"];
      supportLoading(false);
    }else{
      supportLoading(false);
    }

  }
}