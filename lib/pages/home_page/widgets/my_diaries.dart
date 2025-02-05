import 'package:flutter/material.dart';

class MyDiaries extends StatefulWidget {
  const MyDiaries({super.key});

  @override
  State<MyDiaries> createState() => _MyDiariesState();
}

class _MyDiariesState extends State<MyDiaries> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            'My Diaries',
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
