import 'package:cryptjournal/constants/colors.dart';
import 'package:cryptjournal/widgets/centered_text.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imagePath;
  final String label;
  final double width;
  final double height;
  final AspectRatio? aspectRatio;
  const ImageButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    required this.label,
    this.aspectRatio,
    this.width = 300,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: AppColors.accent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onPressed,
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: width,
                height: aspectRatio != null
                    ? width * aspectRatio!.aspectRatio
                    : height,
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
                        const Color.fromARGB(150, 0, 0, 0),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        'assets/images/writing.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                width: width,
                height: aspectRatio != null
                    ? width * aspectRatio!.aspectRatio
                    : height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CenteredText(
                        label.toUpperCase(),
                        style: TextStyle(
                          fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .fontSize! *
                              (width / 250),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
