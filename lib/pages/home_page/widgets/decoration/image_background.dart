import 'package:cryptjournal/constants/bg_decoration.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: child,
    );
  }
}
