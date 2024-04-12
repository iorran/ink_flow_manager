import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ink_flow_manager/pages/authentication/auth_page.dart';
import 'package:ink_flow_manager/pages/home_page.dart';
import 'package:ink_flow_manager/pages/sign_term_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/consent': (context) => const SignTermPage(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
