import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/screens/home/home_screen.dart';
import 'package:crud_flutter_fiap/utils/security_util.dart';
import 'package:crud_flutter_fiap/widgets/rounded_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';
import '../widgets/rounded_dropdown.dart';

class AddEditScreen extends StatefulWidget {
  static const String id = "/addedit_screen";

  AddEditScreen({
    super.key,
    required this.idCollection,
    required this.level,
    required this.timeExperience,
    required this.skill
  });

  final String idCollection;
  String? level;
  String? timeExperience;
  String skill;

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<AddEditScreen> {
  final skillController = TextEditingController();

  String id = "";
  String userId = '';
  String profileImg = "";

  final List<String> _levelValues = [
    "High",
    "Medium",
    "Low"
  ];

  final List<String> _timeExperienceValues = [
    "1",
    "2",
    "3",
    "4",
    "5+"
  ];

  @override
  void initState() {
    getUserId();
    getUserData();
    if (widget.idCollection != '_') {
      skillController.text = widget.skill;
    } else {
      widget.level = _levelValues[0];
      widget.timeExperience = _timeExperienceValues[0];
      widget.skill = "";
    }
    super.initState();
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
        final document = await FirebaseFirestore.instance
            .collection('Skills')
            .doc(widget.idCollection)
            .get();

        if (document.exists) {
          widget.skill = document.data()?['skill'];
          widget.level = document.data()?['level'];
          widget.timeExperience = document.data()?['timeExperience'];
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getUserData() async {
    try {
      await getUserId();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: userId)
          .get();

      Map<String, dynamic> data = querySnapshot.docs[0].data();
      setState(() {
        profileImg = data['profilePicture'].toString();
      });

      await getSkill();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

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
            RoundedTextField(
              hint: 'Skill',
              textController: skillController,
              icon: const Icon(
                Icons.military_tech,
                color: Color(0xff2e2e2e),
              ),
              obscureText: false,
              maskType: 'none',
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(6),
                  isExpanded: true,
                  value: widget.level,
                  items: _levelValues.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text("Level"),
                  onChanged: (String? value) {
                    setState(() {
                      widget.level = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(6),
                  isExpanded: true,
                  value: widget.timeExperience,
                  items: _timeExperienceValues.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text("Tempo de experiência"),
                  onChanged: (String? value) {
                    setState(() {
                      widget.timeExperience = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16, width: double.infinity),
            GestureDetector(
              onTap: () {
                onSave(context);
              },
              child: RoundedButton(color: const Color(0xff2e2e2e), text: widget.idCollection != '_' ? "Editar" : "Salvar"),
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
              child: const RoundedButton(color: Color(0xffee4c83), text: "Cancelar"),
            ),
          ],
        )));
  }

  bool validateFields() {
    if (skillController.text.isEmpty || widget.level == null || widget.timeExperience == null) {
      return false;
    }

    return true;
  }
  void onSave(BuildContext context) {
    if (validateFields()) {
      save();
      final navigator = Navigator.of(context);
      navigator.pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } else {
      var snackBar = const SnackBar(
        content: Text("Todos os campos devem ser preenchidos"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> save() async {
    try {
      final skillToSave = <String, String?>{
        "skill": skillController.text,
        "level": widget.level,
        "timeExperience": widget.timeExperience,
        "userId": userId,
      };

      if (widget.idCollection != '_') {
        await FirebaseFirestore.instance
            .collection("Skills")
            .doc(widget.idCollection)
            .update(skillToSave);
      } else {
        await FirebaseFirestore.instance.collection("Skills").add(skillToSave);
      }
    } on FirebaseAuthException catch (_) {
      var snackBar = const SnackBar(
        content: Text("Problemas ao salvar! Tente novamente!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
