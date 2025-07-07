import 'package:flutter/material.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/widgets/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Assets.images.splashImage.image(
              fit: BoxFit.cover,
            ),
          ),

          // Centered Icon (SVG)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Splash Icon
                Assets.icons.splashIcon.svg(height: 120, width: 120),

                const SizedBox(height: 20),

                // Title
                const CustomText(
                  text: 'Tow Services',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                const SizedBox(height: 8),

                // Subtitle or secondary text
                const CustomText(
                  text: 'We care for your journey',
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
