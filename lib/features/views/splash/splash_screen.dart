import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/features/views/splash/widgets/splash_loading.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_scaffold.dart';
import 'package:towservice/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _goNextScreen();
    super.initState();
  }



  Future<void> _goNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.roleScreen);
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Assets.images.splashImage.image(
              fit: BoxFit.cover,
            ),
          ),

          /// Centered Icon & Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 54.h),
              Assets.icons.splashIcon.svg(height: 380.h,width: 380.w),
               SizedBox(height: 20.h),
               CustomText(
                text: 'Tow Services',
                fontSize: 30.sp,
                color: Colors.white,
              ),
               CustomText(
                text: 'Where Drivers and Tow Services Meet',
                fontSize: 13.sp,
                color: Colors.white70,
              ),
            ],
          ),

          /// Bottom Loading
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: SplashLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
