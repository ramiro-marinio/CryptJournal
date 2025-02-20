import 'package:cryptjournal/pages/auth/decrypt_database.dart';
import 'package:cryptjournal/pages/auth/set_password.dart';
import 'package:cryptjournal/pages/home_page/home_page.dart';
import 'package:cryptjournal/providers/functionality_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppWithChangeNotifierProvider());
}

class AppWithChangeNotifierProvider extends StatelessWidget {
  const AppWithChangeNotifierProvider({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FunctionalityProvider(),
      child: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late FunctionalityProvider functionalityProvider;
  @override
  void initState() {
    super.initState();
    functionalityProvider = context.read<FunctionalityProvider>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ([
      AppLifecycleState.inactive,
      AppLifecycleState.paused,
      AppLifecycleState.detached
    ].contains(state)) {
      if (AppLifecycleState.detached != state &&
          functionalityProvider.authStatus == 2) {
        functionalityProvider.changeAuthStatus(0);
      }
      functionalityProvider.encryptDatabase();
    } else if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    final FunctionalityProvider functionalityProvider =
        context.watch<FunctionalityProvider>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'CryptJournal',
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.white,
        brightness: Brightness.dark,
        fontFamily: 'LiberationSerif',
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (BuildContext context) => Icon(
            PhosphorIcons.caretLeft(),
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'LiberationSerif',
          ),
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
          bodyMedium: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 12.0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
        ),
      ),
      home: Builder(builder: (context) {
        if (!functionalityProvider.initialized) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (functionalityProvider.authStatus == 0) {
          return SetPassword();
        }
        if (functionalityProvider.authStatus == 1) {
          return DecryptDatabase();
        }
        return Column(
          children: [
            Expanded(
              child: HomePage(),
            ),
          ],
        );
      }),
    );
  }
}
