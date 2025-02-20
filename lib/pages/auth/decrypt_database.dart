import 'package:cryptjournal/pages/home_page/home_page.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/image_background.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/standard_button.dart';
import 'package:flutter/material.dart';

class DecryptDatabase extends StatefulWidget {
  const DecryptDatabase({super.key});

  @override
  State<DecryptDatabase> createState() => _DecryptDatabaseState();
}

class _DecryptDatabaseState extends State<DecryptDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'Database is encrypted;\n Please insert your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium?.fontSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              StandardButton(
                child: Text('Decrypt Database'),
                onPressed: () {
                  //Add guard logic
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
