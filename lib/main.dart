import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/dependency/dependency_Injection.dart';
import 'package:towservice/services/socket_services.dart';
import 'package:towservice/themes/theme.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'controller/tow_truck/tow_trcuk_job_controller.dart';
import 'routes/app_routes.dart';



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.grey, // status bar background
      statusBarIconBrightness: Brightness.light, // light = white icons
      statusBarBrightness: Brightness.light, // iOS text color
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light
    ),
  );


  // DependencyInjection di = DependencyInjection();
  // di.dependencies();

  runApp(
    MyApp(),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          initialBinding: DependencyInjection(),
          debugShowCheckedModeBanner: false,
          title: 'Service App',
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes.routes,
          theme: light(),
          themeMode: ThemeMode.light,
        );
      },
      designSize: const Size(393, 852),
    );
  }
}


TowTruckJobController towTruckJobController = Get.put(TowTruckJobController());
RxBool isNeg = false.obs;
var counter = 0.obs;

void showGlobalAlert(dynamic data) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) {
    print("❌ No context available to show dialog");
    return;
  }

  final payload = Map<String, dynamic>.from(data);
  counter.value = payload["negAmount"];

  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: CustomText(text: "Negotiate Amount", fontSize: 22.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          customTextInfo(key: "👤 User: ", value: "${payload['uName'] ?? ''}"),
          customTextInfo(key: "🚗 Car: ", value: "${payload['carType'] ?? ''}"),
          customTextInfo(key: "⚠️ Issue: ", value: "${payload['issue'] ?? ''}"),
          customTextInfo(key: "📍 Pickup: ", value: "${payload['pickUp'] ?? ''}"),
          customTextInfo(key: "🏁 DropOff: ", value: "${payload['dropOff'] ?? ''}"),
          customTextInfo(key: " Distance: ", value: "${payload['distance'] ?? ''}km"),
          customTextInfo(key: "📝 Note: ", value: "${payload['note'] ?? ''}"),
          customTextInfo(key: "💰 Amount: ", value: "${payload['minAmount']} - ${payload['negAmount']}"),


        ],
      ),
      actions: [




            Obx(() =>  isNeg.value ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Counter Box


                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Minus Button
                      SizedBox(width: 6.w),
                      InkWell(
                        onTap: () {
                          if (counter.value > 0) counter.value--;
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primaryColor,
                          child:  Icon(Icons.remove, size: 16.h, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 14.w),

                      // Counter Text

                      CustomText(text: "${counter.value}"),
                      SizedBox(width: 14.w),

                      // Plus Button
                      Obx(() {
                        counter.value;
                        return InkWell(
                          onTap: () {
                            counter.value++;

                          } ,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primaryColor,
                            child:  Icon(Icons.add, size: 16.h, color: Colors.white),
                          ),
                        );
                      }
                      ),


                      SizedBox(width: 6.w),
                    ],
                  ),
                ),





                CustomButtonTwo(
                    height: 40.h,
                    width: 110.w,
                    loaderIgnore: true,
                    title: "Send", onpress: (){
                  towTruckJobController.negotiateJob(jobId: "${payload["jobId"]}", price: counter.value);
                  isNeg(false);

                })



              ],
            )
                    :
                Row(
                children: [
                CustomButtonTwo(
                height: 40.h,
                color: Color(0xff7B6846),
                boderColor: Color(0xff7B6846),
                loaderIgnore: true,
                width: 120.w,
                fontSize: 12.h,
                title: "Negotiate",
                onpress: () {

                  isNeg(true);

                }),

        Spacer(),

        Obx(() =>
            CustomButtonTwo(
                loading: towTruckJobController.acceptJobLoading.value,
                height: 40.h,
                loaderIgnore: true,
                width: 120.w,
                fontSize: 12.h,
                title: "Accept",
                onpress: () {
                  towTruckJobController.acceptJob(jobId: "${payload["jobId"]}", providerId: "${payload["uId"]}", trxId: "${payload["trId"]}", context: ctx);

                }),
        )
      ],
    )),





      ],
    ),
  );


}



customTextInfo({String? key, value}){
  return Padding(
    padding:  EdgeInsets.only(top: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "$key", fontSize: 12.h),
        Expanded(child: CustomText(text: "$value", fontSize: 12.h, textAlign: TextAlign.start,)),
      ],
    ),
  );
}