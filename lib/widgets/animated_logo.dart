import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:griot_urban_app/constants/colors.dart';

class AnimatedLogo extends StatelessWidget {
  final double size;

  const AnimatedLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.1),
      duration: const Duration(seconds: 2),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: size,
            height: size,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
