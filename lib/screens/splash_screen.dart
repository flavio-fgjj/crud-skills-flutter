import 'dart:async';

import 'package:crud_flutter_fiap/utils/security.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'home/home_screen.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthScreen()));
      } else {
        setPreferences(user.uid.toString());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  Future<void> setPreferences(String userId) async {
    SecurityPreferences pref = SecurityPreferences();
    String aux = await pref.getUserId();
    if (aux.isEmpty) {
      await pref.initializePreference(userId);
    }
  }


  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffee4c83),
                gradient: RadialGradient(
                  colors: [Color(0xffee4c83), Color(0xff2e2e2e)],
                  center: Alignment.center,
                  radius: 0.8,
                )),
          ),
          Center(
            child: Image.asset("assets/MBA.png"),
          )
        ],
      ),
    );
  }
}
