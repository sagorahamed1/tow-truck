import 'dart:math';
import 'package:flutter/material.dart';

class SplashLoading extends StatefulWidget {
  const SplashLoading({super.key});

  @override
  State<SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: CustomPaint(
            painter: SemiCirclePainter(),
            size: const Size(70, 70), // Adjust size as needed
          ),
        );
      },
    );
  }
}


class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 2 * pi,
        colors: [
          Color(0xff772C16),
          Color(0xffB18B44),
        ],
      ).createShader(rect);

    // Draw arc - adjust angles for "open gap"
    canvas.drawArc(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      pi * 0.05, // start angle
      pi * 1.8, // sweep angle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
