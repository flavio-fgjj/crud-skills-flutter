import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/screens/add_edit_screen.dart';
import 'package:crud_flutter_fiap/screens/home/model/skill.model.dart';
import 'package:crud_flutter_fiap/utils/security_util.dart';
import 'package:flutter/material.dart';

import '../../services/logout_service.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home_screen";
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  List<SkillModel> skillsData = [];
  String userId = '';

  String profileImg = "";
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //#region Futures
  Future<void> getUserId() async {
    SecurityPreferences pref = SecurityPreferences();
    String uId = await pref.getUserId();
    setState(() {
      userId = uId;
    });
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
        userName = data['name'];
        userEmail = data['email'];
      });

      await getSkills();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> getSkills() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Skills')
          .where('userId', isEqualTo: userId)
          .get();

      setState(() {
        skillsData = [];
      });

      for (var doc in querySnapshot.docs) {
        // Getting data from map
        Map<String, dynamic> data = doc.data();
        SkillModel m = SkillModel(
            id: doc.id,
            skill: data['skill'],
            level: data['level'],
            timeExperience: data['timeExperience'],
            userId: data['userId']
        );

        setState(() {
          skillsData.add(m);
        });
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _onDeleteItemPressed(String id) async {
    await FirebaseFirestore.instance
      .collection('Skills').doc(id).delete();

    await getSkills();
  }
  //#endregion

  initWidget() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [Color(0xffee4c83), Color(0xff2e2e2e)]),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(profileImg),
          ),
        ), // 1
        title: Column(
          children: [
            Text(
              userName,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              userEmail,
              style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ), // 2
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              LogoutService(context);
              //_doLogout(context);
            }, // omitting onPressed makes the button disabled
          )
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemBuilder: (_, index) {
              final skill = skillsData[index];
              return Dismissible(
                key: Key(skill.id),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffee4c83),
                    child: Text((index + 1).toString()),
                  ),
                  title: Text('${skill.skill} | ${skill.level} level'),
                  subtitle: Text(
                      '${skill.timeExperience.toString().replaceAll(" years", "")} ano(s) de experiëncia'),
                  //trailing: const Icon(Icons.delete, color: Color(0xff2e2e2e)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 20.0,
                          color: Colors.indigo,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditScreen(idCollection: skill.id, level: skill.level, timeExperience: skill.timeExperience, skill: skill.skill,),
                              ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _onDeleteItemPressed(skill.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: skillsData.length),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditScreen(idCollection: "_", level: '', timeExperience: '', skill: ''),
              ));
        },
        backgroundColor: const Color(0xff2e2e2e),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
