import 'package:cryptjournal/constants/colors.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String imagePath;
  const ImageButton(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: AppColors.accent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: widget.onPressed,
        child: SizedBox(
          width: 300,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    Colors.transparent
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(150, 0, 0, 0), BlendMode.darken),
                child: Image.asset(
                  'assets/images/writing.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
