import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/glass_morphism.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/modify_diary/modify_diary.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const StandardButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: GlassMorphism(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                child: child,
              ),
              GestureDetector(
                onTap: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
