import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ink_flow_manager/pages/artists_page.dart';
import 'package:ink_flow_manager/pages/edit_artist_page.dart';
import 'package:ink_flow_manager/pages/home_page.dart';
import 'package:ink_flow_manager/pages/sign_term_page2.dart';
import 'package:ink_flow_manager/providers/artist_provider.dart';
import 'package:ink_flow_manager/providers/responsibility_form_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ArtistProvider>(
        create: (_) => ArtistProvider(),
      ),
      ChangeNotifierProvider<ResponsibilityFormProvider>(
        create: (_) => ResponsibilityFormProvider(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //versao 1
      // home: const AuthPage(),
      // routes: {
      //   '/home': (context) => HomePage(),
      //   '/consent': (context) => const SignTermPage(),
      // },
      //versao 2
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/artists': (context) => const ArtistsPage(),
        '/edit-artist': (context) => const EditArtistPage(),
        '/consent': (context) => const SignTermPage2(),
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
