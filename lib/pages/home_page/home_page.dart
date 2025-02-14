import 'package:cryptjournal/constants/bg_decoration.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/image_background.dart';
import 'package:cryptjournal/pages/home_page/widgets/image_button.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/my_diaries.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo/CryptJournal.png',
            height: 70,
          ),
        ),
        body: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: MyDiaries(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
