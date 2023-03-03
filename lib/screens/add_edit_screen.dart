import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/screens/home/home_screen.dart';
import 'package:crud_flutter_fiap/utils/security_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  static const String id = "/addedit_screen";

  const AddEditScreen({
    super.key,
    required this.idCollection
  });

  final String idCollection;

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

  var document;

  @override
  void initState() {
    super.initState();
    getUserId();
    getSkill();
  }

  //#regionFutures
  Future<void> getUserId() async {
    SecurityPreferences pref = SecurityPreferences();
    String uId = await pref.getUserId();
    setState(() {
      userId = uId;
    });
  }

  Future<dynamic> getSkill() async {
    try {
      if (widget.idCollection != "_") {
        document = await FirebaseFirestore.instance
            .collection('Skills')
            .doc(widget.idCollection)
            .get();

        if (document.exists) {
          skillController.text = document.data()?['skill'];
          levelController.text = document.data()?['level'];
          timeExperienceController.text = document.data()?['timeExperience'];
        }
      }
    } catch (e) {
      return null;
    }
  }
  //#endregion

  initWidget() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
            children: [
              Text(
                widget.idCollection != '_' ? "Editar" : "Adicionar",
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
              radius: 60.0,
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
                  widget.idCollection != '_' ? "Editar" : "Salvar",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffee4c83),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: const Text(
                  "Cancelar",
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

      if (widget.idCollection != '_' && document != null) {
        FirebaseFirestore.instance
            .collection("Skills")
            .doc(widget.idCollection)
            .update(skillToSave);
      } else {
        FirebaseFirestore.instance.collection("Skills").add(skillToSave);
      }

      navigator.pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } on FirebaseAuthException catch (_) {
      var snackBar = const SnackBar(
        content: Text("Problemas ao salvar! Tente novamente!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
