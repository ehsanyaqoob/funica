import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:funica/config/theme/theme-cont.dart';
import 'package:funica/constants/export.dart';

class FunicaLoader extends StatefulWidget {
  static const int dotCount = 5;
  static const double size = 26;
  static const double dotSize = 6;

  final Color? color;

  const FunicaLoader({super.key, this.color});

  @override
  State<FunicaLoader> createState() => _FunicaLoaderState();
}

class _FunicaLoaderState extends State<FunicaLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        final Color loaderColor =
            widget.color ?? (isDarkMode ? kWhite : kBlack);

        return SizedBox(
          width: FunicaLoader.size,
          height: FunicaLoader.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => CustomPaint(
              painter: _DotsPainter(
                progress: _controller.value,
                color: loaderColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color color;

  _DotsPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.5;

    final int headIndex =
        ((progress * FunicaLoader.dotCount) % FunicaLoader.dotCount).floor();

    for (int i = 0; i < FunicaLoader.dotCount; i++) {
      final double angleStep = 2 * pi / FunicaLoader.dotCount;
      final double angle =
          (progress * 2 * pi) + (i * angleStep); // clockwise only

      int distance = (i - headIndex) % FunicaLoader.dotCount;
      double opacity = 1 - (distance / FunicaLoader.dotCount);

      final dotPaint = Paint()
        ..color = color.withOpacity(opacity.clamp(0.2, 1.0));

      final offset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(offset, FunicaLoader.dotSize / 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
