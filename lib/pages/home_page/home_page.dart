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
            'assets/CryptJournal.png',
            height: 70,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: ImageButton(
                  onPressed: () {},
                  imagePath: 'assets/images/writing.png',
                  label: 'Create New Entry',
                  width: 200,
                  aspectRatio: AspectRatio(aspectRatio: 2 / 3),
                ),
              ),
              Expanded(
                child: MyDiaries(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
