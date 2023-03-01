import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/screens/auth_screen.dart';
import 'package:crud_flutter_fiap/utils/security.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  List<Map<String, dynamic>> skillsData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSkills();
  }

  Future<dynamic> getSkills() async {
    SecurityPreferences pref = SecurityPreferences();
    String userId = await pref.getUserId();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Skills')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> skillsData1 = [];
      for (var doc in querySnapshot.docs) {
        // Getting data from map
        Map<String, dynamic> data = doc.data();
        skillsData1.add(data);
      }

      setState(() {
        skillsData = skillsData1;
      });
    } catch (e) {
      return null;
    }
  }

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
                  ),
                ],
              )),
            ),
            GestureDetector(
              onTap: () async {
                // Write Click Listener Code Here.
                // ignore: avoid_print
                doLogout(context);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
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
                  "LOGOUT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:    FloatingActionButtonLocation.endFloat,
    );
  }

  doLogout(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.push(MaterialPageRoute(
      builder: (context) => const AuthScreen(),
    ));
  }
}
