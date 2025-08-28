import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/dependency/dependency_Injection.dart';
import 'package:towservice/services/socket_services.dart';
import 'package:towservice/themes/theme.dart';
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



void showGlobalAlert(dynamic data) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) {
    print("❌ No context available to show dialog");
    return;
  }

  final payload = Map<String, dynamic>.from(data);

  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text("🚨 New Job Alert"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("👤 User: ${payload['uName'] ?? ''}"),
          Text("🚗 Car: ${payload['carType'] ?? ''}"),
          Text("⚠️ Issue: ${payload['issue'] ?? ''}"),
          Text("📍 Pickup: ${payload['pickUp'] ?? ''}"),
          Text("🏁 DropOff: ${payload['dropOff'] ?? ''}"),
          Text("📏 Distance: ${payload['distance'] ?? ''} km"),
          Text("📝 Note: ${payload['note'] ?? ''}"),
          Text("💰 Amount: ${payload['minAmount']} - ${payload['negAmount']}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text("Reject"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(ctx);
            // example emit accept
            SocketServices().emit("job-accepted", {
              "jobId": payload["jobId"],
              "uId": payload["uId"],
            });
          },
          child: const Text("Accept"),
        ),
      ],
    ),
  );
}



