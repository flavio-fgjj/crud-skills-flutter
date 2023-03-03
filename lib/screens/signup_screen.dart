import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 35,
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
                Icons.person,
                color: Color(0xff2e2e2e),
              ),
              hintText: "Nome Completo",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                name = text;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                Icons.phone,
                color: Color(0xff2e2e2e),
              ),
              hintText: "Telefone",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                phone = text;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                Icons.person,
                color: Color(0xff2e2e2e),
              ),
              hintText: "Url do Profile (imagem)",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                profilePicture = text;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
              hintText: "Email",
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
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
              hintText: "Senha",
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
            doSignup(context);
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
              "CRIAR CONTA",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
    )));
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
        "name": name,
        "phone": phone,
        "profilePicture": profilePicture,
        "email": email,
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
