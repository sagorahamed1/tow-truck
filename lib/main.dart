import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/dependency/dependency_Injection.dart';
import 'package:towservice/services/socket_services.dart';
import 'package:towservice/themes/theme.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // DependencyInjection di = DependencyInjection();
  // di.dependencies();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
  //   const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
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
