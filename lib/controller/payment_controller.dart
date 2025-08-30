import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../global/custom_assets/assets.gen.dart';
import '../helpers/prefs_helper.dart';
import '../model/payment_history_model.dart';
import '../services/api_client.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../services/api_constants.dart';
import '../services/vibration_service.dart';
import '../utils/app_constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_buttonTwo.dart';

import '../../../widgets/custom_text.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  requestToAddBalance(
      {required String price, required BuildContext context}) async {
    Map<String, dynamic> body = {
      "amount": int.parse(price.toString()),
    };

    final apiResponse =
    await ApiClient.postData(ApiConstants.addBalance, jsonEncode(body));

    if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
      var url = apiResponse.body["data"];
      // context.pushNamed(AppRoutes.paymentWebView, extra: url);
      Get.toNamed(AppRoutes.paymentWebView,
          arguments: {"paymentUrl": url["authorizationUrl"]});

      if (kDebugMode) {
        debugPrint("Payment successfully created: ${apiResponse.body}");
      }
    }
  }

  // /// ===================================> Withdraw Request ==============================>
  //
  // RxBool withDrawLoading = false.obs;
  // withdrawRequestBalance({required String price,required BuildContext context})async{
  //   withDrawLoading(true);
  //   Map<String, dynamic> body = {
  //     "amount": int.parse(price.toString()),
  //   };
  //
  //
  //   final apiResponse = await ApiClient.postData(ApiConstants.withdrawRequest, jsonEncode(body));
  //
  //   if (apiResponse.statusCode==200|| apiResponse.statusCode==201) {
  //
  //     var url = apiResponse.body["data"]["url"];
  //     context.pushNamed(AppRoutes.paymentWebView, extra: url);
  //
  //     if (kDebugMode) {
  //       debugPrint("=============================================Payment successfully created: ${apiResponse.body}");
  //     }
  //     withDrawLoading(false);
  //   }else{
  //     withDrawLoading(false);
  //   }
  // }

  /// ================================> Payment History  ==============================>

  RxBool paymentHistoryLoading = false.obs;
  RxString? balance = ''.obs;
  RxList<PaymentHistoryModel> paymentHistory = <PaymentHistoryModel>[].obs;

  getPaymentHistory() async {
    paymentHistoryLoading(true);
    var response = await ApiClient.getData(ApiConstants.history);
    if (response.statusCode == 200 || response.statusCode == 201) {
      paymentHistory.value = List<PaymentHistoryModel>.from(response
          .body["data"]["history"]
          .map((x) => PaymentHistoryModel.fromJson(x)));
      balance?.value = response.body["data"]["wallet"].toString();

      update();
      paymentHistoryLoading(false);
    } else {
      paymentHistoryLoading(false);
    }
  }

  final isLoading = false.obs;

  /// Handles the final payment result
  Future<void> paymentResults(
      {required String finishUrl, required BuildContext context}) async {
    try {
      isLoading(true);

      var accessToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(finishUrl), headers: headers);
      var res = jsonDecode(response.body);

      print("================================================== ${response.body}");

      if (response.statusCode == 200 && res["message"] == "Payment successful.") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close),
                    ),
                    Center(
                        child: Column(
                          children: [
                            Assets.icons.confirmationIcon.svg(
                              height: 124.h,
                              width: 124.w,
                            ),
                            CustomText(
                              text: 'Payment Success',
                              fontSize: 22.sp,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomText(
                              text: 'Your payment has been processed successfully',
                              fontSize: 13.sp,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomButton(
                              onPressed: () {
                                Get.back();
                                Get.back();
                              },
                              label: 'Go To Wallet',
                            ),
                          ],
                        ))
                  ],
                ),
              );
            });

        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessScreen(title: "Payment Success", message: "Payment was successful!")));
      } else {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessScreen(title: "Payment Fail", message: "Payment was Fail! Please Try again")));

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close),
                    ),
                    Center(
                        child: Column(
                          children: [
                            Assets.icons.confirmationIcon.svg(
                              height: 124.h,
                              width: 124.w,
                            ),
                            CustomText(
                              text: 'Payment was Fail!',
                              fontSize: 22.sp,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomText(
                              text: 'Please try again or contact customer support.',
                              fontSize: 13.sp,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomButton(
                              onPressed: () {
                                Get.back();
                                Get.back();
                              },
                              label: 'Go To Wallet',
                            ),
                          ],
                        ))
                  ],
                ),
              );
            });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final PaymentController _paymentController = Get.put(PaymentController());

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // Handle loading progress if needed
          },
          onPageStarted: (url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (url) {
            debugPrint('Page finished loaded: $url');
            _paymentController.paymentResults(finishUrl: url, context: context);
          },
          onHttpError: (error) {
            debugPrint('HTTP error: ${error.request}');
          },
          onWebResourceError: (error) {
            debugPrint('Web resource error: ${error.description}');
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent; // Block YouTube links
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Get.arguments["paymentUrl"].toString()))
          .then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: CustomText(
          text: "Payment",
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
