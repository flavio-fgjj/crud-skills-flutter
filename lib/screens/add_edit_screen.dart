import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/screens/auth_screen.dart';
import 'package:crud_flutter_fiap/utils/security.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  static const String id = "/addedit_screen";
  const AddEditScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<AddEditScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  final skillController = TextEditingController();
  final levelController = TextEditingController();
  final timeExperienceController = TextEditingController();
  String id = "";
  String userId = '';
  String profileImg =
      "https://avatars.githubusercontent.com/u/9452793?s=96&v=4";

  @override
  void initState() {
    super.initState();
    getUserId();
    getSkill();
  }

  //#region Futures
  Future<void> getUserId() async {
    SecurityPreferences pref = SecurityPreferences();
    String uId = await pref.getUserId();
    setState(() {
      userId = uId;
    });
  }

  getSkill() async {
    try {
      var document = await FirebaseFirestore.instance
          .collection('Skills')
          .doc('BCdzmmEgl4MeIsfbgEu4')
          .get();

      if (document.exists) {
        skillController.text = document.data()?['skill'];
        levelController.text = document.data()?['level'];
        timeExperienceController.text = document.data()?['timeExperience'];
      }
    } catch (e) {
      return null;
    }
  }

  doLogout(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.push(MaterialPageRoute(
      builder: (context) => const AuthScreen(),
    ));
  }

  initWidget() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
            children: [
              Text(
                id != '' ? "Editar" : "Adicionar",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(profileImg),
            ),
            const SizedBox(height: 24),
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
                controller: skillController,
                cursorColor: const Color(0xff2e2e2e),
                decoration: const InputDecoration(
                  focusColor: Color(0xff2e2e2e),
                  hintText: "Skill",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
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
                controller: levelController,
                cursorColor: const Color(0xff2e2e2e),
                decoration: const InputDecoration(
                  focusColor: Color(0xff2e2e2e),
                  hintText: "Level",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
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
                controller: timeExperienceController,
                cursorColor: const Color(0xff2e2e2e),
                decoration: const InputDecoration(
                  focusColor: Color(0xff2e2e2e),
                  hintText: "Tempo de experiencia",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                save(context);
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
                child: Text(
                  id != '' ? "Editar" : "Salvar",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )));
  }

  void save(BuildContext context) {
    try {
      final navigator = Navigator.of(context);

      final skillToSave = <String, String?>{
        "skill": skillController.text,
        "level": levelController.text,
        "timeExperience": timeExperienceController.text,
        "userId": userId,
      };

      if (id != '') {
        FirebaseFirestore.instance
            .collection("Skills")
            .doc(id)
            .update(skillToSave);
      } else {
        FirebaseFirestore.instance.collection("Skills").add(skillToSave);
      }

      navigator.pop();
    } on FirebaseAuthException catch (_) {
      var snackBar = const SnackBar(
        content: Text("Problemas ao salvar! Tente novamente!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
