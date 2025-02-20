import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptjournal/pages/home_page/home_page.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/image_background.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/standard_button.dart';
import 'package:cryptjournal/providers/functionality_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController repeatPassword = TextEditingController();
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
                    'Your database is being configured;\n Please define a password.',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: repeatPassword,
                  decoration: InputDecoration(
                    hintText: 'Repeat Password',
                  ),
                ),
              ),
              StandardButton(
                child: Text('Set Password'),
                onPressed: () {
                  if (password.text == repeatPassword.text) {
                    final bytes = utf8.encode(password.text);
                    final hash = sha256.convert(bytes).bytes;
                    functionalityProvider.password = Uint8List.fromList(hash);
                  }
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
