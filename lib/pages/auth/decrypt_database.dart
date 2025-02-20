import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptjournal/pages/home_page/widgets/decoration/image_background.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/standard_button.dart';
import 'package:cryptjournal/providers/functionality_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecryptDatabase extends StatefulWidget {
  const DecryptDatabase({super.key});

  @override
  State<DecryptDatabase> createState() => _DecryptDatabaseState();
}

class _DecryptDatabaseState extends State<DecryptDatabase> {
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FunctionalityProvider functionalityProvider =
        context.watch<FunctionalityProvider>();
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
                    'Your database is encrypted;\n Please insert your password.',
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
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              StandardButton(
                child: Text('Set Password'),
                onPressed: () async {
                  final bytes = utf8.encode(password.text);
                  final hash = sha256.convert(bytes).bytes;
                  functionalityProvider.password = Uint8List.fromList(hash);
                  await functionalityProvider.decryptDatabase();
                  functionalityProvider.changeAuthStatus(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
