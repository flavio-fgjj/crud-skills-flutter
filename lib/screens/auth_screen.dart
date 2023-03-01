import 'dart:io';

import 'package:crud_flutter_fiap/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  String email = '';
  String password = '';

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
            color: Color(0xffee4c83),
            gradient: RadialGradient(
              colors: [Color(0xffee4c83), Color(0xff2e2e2e)],
              center: Alignment.center,
              radius: 0.8,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  "assets/MBA.png",
                  height: 90,
                  width: 90,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            cursorColor: const Color(0xff2e2e2e),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.email,
                color: Color(0xff2e2e2e),
              ),
              hintText: "Digite seu Email",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                email = text;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xffEEEEEE),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            cursorColor: const Color(0xff2e2e2e),
            decoration: const InputDecoration(
              focusColor: Color(0xff2e2e2e),
              icon: Icon(
                Icons.vpn_key,
                color: Color(0xff2e2e2e),
              ),
              hintText: "Digite sua Senha",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                password = text;
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            // Write Click Listener Code Here.
            // ignore: avoid_print
            doLogin(context);
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xff2e2e2e),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: const Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ainda não tem conta?  "),
              GestureDetector(
                child: const Text(
                  "Criar Conta",
                  style: TextStyle(color: Color(0xfff1709c)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                },
              )
            ],
          ),
        )
      ],
    )));
  }

  doSharedPref() async {
    String? u = FirebaseAuth.instance.currentUser?.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', u.toString());
  }

  doLogin(BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      doSharedPref();

      navigator.push(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = "Usuário ou senha invalidos!";
      }

      var snackBar = SnackBar(
        content: Text(errorMessage),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
