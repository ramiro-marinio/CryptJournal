import 'package:cryptjournal/widgets/centered_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              width: double.infinity,
              child: CenteredText(
                'Welcome to CryptJournal.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Image.asset('assets/images/writing.png')
          ],
        ),
      ),
    );
  }
}
