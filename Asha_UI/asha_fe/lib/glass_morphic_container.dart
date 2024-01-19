import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double sigmaX;
  final double sigmaY;
  const GlassmorphicContainer(
      {super.key,
      required this.child,
      required this.borderRadius,
      this.sigmaX = 3,
      this.sigmaY = 3});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.6),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
