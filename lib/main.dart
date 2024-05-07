import 'package:chat_site/Authentication/Login/login.dart';
import 'package:chat_site/Chat/chat.dart';
import 'package:chat_site/GetEmail/getEmail.dart';
import 'package:chat_site/Resources/theme.dart';
import 'package:chat_site/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.theme,
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/login': ((context) => const Login()),
      },
    );
  }
}
