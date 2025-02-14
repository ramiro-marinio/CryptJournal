import 'dart:ui';

import 'package:cryptjournal/constants/standard_radius.dart';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  const GlassMorphism({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: standardRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
          ),
          child: child,
        ),
      ),
    );
  }
}
