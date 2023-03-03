// ignore_for_file: depend_on_referenced_packages

import 'package:crud_flutter_fiap/screens/add_edit_screen.dart';
import 'package:crud_flutter_fiap/screens/auth_screen.dart';
import 'package:crud_flutter_fiap/screens/home/home_screen.dart';
import 'package:crud_flutter_fiap/screens/signup_screen.dart';
import 'package:crud_flutter_fiap/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skills',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        AuthScreen.id: (context) => const AuthScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        AddEditScreen.id: (context) => const AddEditScreen(),
        SplashScreen.id: (context) => const SplashScreen()
      },
    );
  }
}
