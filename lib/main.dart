import 'package:cryptjournal/pages/home_page/home_page.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DbProvider(),
      child: MaterialApp(
        title: 'CryptJournal',
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.white,
          brightness: Brightness.dark,
          fontFamily: 'LiberationSerif',
          appBarTheme: AppBarTheme(
            toolbarHeight: 100,
            backgroundColor: const Color.fromARGB(255, 31, 31, 31),
            titleTextStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            shape: Border(
              bottom: BorderSide(
                color: Colors.white.withAlpha(30), // Faint white color
                width: 1.0,
              ),
            ),
          ),
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 28.0),
            headlineMedium: TextStyle(fontSize: 24.0),
            headlineSmall: TextStyle(fontSize: 20),
            bodyMedium: TextStyle(fontSize: 12.0),
            bodySmall: TextStyle(fontSize: 10.0),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
