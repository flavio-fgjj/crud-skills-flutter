import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';
import '../widgets/rounded_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "/signup_screen";
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) => initWidget();

  String name = '';
  String phone = '';
  String profilePicture = '';
  String email = '';
  String password = '';

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final profilePictureController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
            color: Color(0xff2e2e2e),
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
                margin: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/MBA.png",
                  height: 90,
                  width: 90,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 5),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "Nova Conta",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        RoundedTextField(
          hint: 'Nome completo',
          textController: nameController,
          icon: const Icon(
            Icons.person,
            color: Color(0xff2e2e2e),
          ),
          obscureText: false,
        ),
        RoundedTextField(
          hint: 'Telefone',
          textController: phoneController,
          icon: const Icon(
            Icons.phone,
            color: Color(0xff2e2e2e),
          ),
          obscureText: false,
        ),
        RoundedTextField(
          hint: 'Url profile (imagem)',
          textController: profilePictureController,
          icon: const Icon(
            Icons.image,
            color: Color(0xff2e2e2e),
          ),
          obscureText: false,
        ),
        RoundedTextField(
          hint: 'Email',
          textController: emailController,
          icon: const Icon(
            Icons.email,
            color: Color(0xff2e2e2e),
          ),
          obscureText: false,
        ),
        RoundedTextField(
          hint: 'Senha',
          textController: passwordController,
          icon: const Icon(
            Icons.vpn_key,
            color: Color(0xff2e2e2e),
          ),
          obscureText: true,
        ),
        GestureDetector(
          onTap: () {
            // Write Click Listener Code Here.
            doSignup(context);
          },
          child: const RoundedButton(color: Color(0xff2e2e2e), text: "CRIAR CONTA"),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Já tem conta?  "),
              GestureDetector(
                child: const Text(
                  "Fazer Login",
                  style: TextStyle(color: Color(0xffee4c83)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
          ],
        )
      )
    );
  }

  doSignup(BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var db = FirebaseFirestore.instance;

      final user = <String, String?>{
        "name": nameController.text,
        "phone": phoneController.text,
        "profilePicture": profilePictureController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "userId": credential.user?.uid,
      };

      db
        .collection("Users")
        .doc(credential.user?.uid)
        .set(user)
        .onError((e, _) => debugPrint("Error writing document: $e"));

      navigator.pop();
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = "A senha fornecida é muito fraca!";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Para esse e-mail, a conta já existe!";
      }

      var snackBar = SnackBar(
        content: Text(errorMessage),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
