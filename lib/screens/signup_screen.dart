import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_fiap/utils/mask_enum_util.dart';
import 'package:crud_flutter_fiap/widgets/rounded_button_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final profilePictureController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final String profileImagePicker;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source, {BuildContext? context, }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 100,
      );

      File file = File(pickedFile!.path);

      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      setState(() {
        profilePictureController.text = base64Image;
        // _setImageFileListFromFile(pickedFile);
      });
      // print(base64Image);
      Navigator.of(context!).pop();
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
  }



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
                        "assets/SuasSkillsBlack.png",
                        height: 90,
                        width: 90,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, top: 5),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        "Suas Skills (Nova Conta)",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                )
              ),
            ),
            RoundedTextField(
              hint: 'Nome completo',
              textController: nameController,
              icon: const Icon(
                Icons.person,
                color: Color(0xff2e2e2e),
              ),
              obscureText: false,
              maskType: MaskCustomType.none,
            ),
            RoundedTextField(
              hint: 'Telefone',
              textController: phoneController,
              icon: const Icon(
                Icons.phone,
                color: Color(0xff2e2e2e),
              ),
              obscureText: false,
              maskType: MaskCustomType.phone,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RoundedTextField(
                    hint: 'Imagem do perfil',
                    textController: profilePictureController,
                    icon: const Icon(
                      Icons.image,
                      color: Color(0xff2e2e2e),
                    ),
                    obscureText: false,
                    maskType: MaskCustomType.none,
                  )
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return _showModalBottomSheet();
                        }
                      );
                    },
                    child: const RoundedButtonIcon(
                      color: Color(0xffee4c83),
                      icon: Icon(
                        Icons.photo_camera,
                        color: Color(0xffEEEEEE),
                      )
                    ),
                  ),
                )
              ],
            ),
            RoundedTextField(
              hint: 'Email',
              textController: emailController,
              icon: const Icon(
                Icons.email,
                color: Color(0xff2e2e2e),
              ),
              obscureText: false,
              maskType: MaskCustomType.none,
            ),
            RoundedTextField(
              hint: 'Senha',
              textController: passwordController,
              icon: const Icon(
                Icons.vpn_key,
                color: Color(0xff2e2e2e),
              ),
              obscureText: true,
              maskType: MaskCustomType.none,
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
          ])
        )
      );
  }

  doSignup(BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      var db = FirebaseFirestore.instance;

      final user = <String, String?>{
        "name": nameController.text,
        "phone": phoneController.text,
        "profilePicture": profileImagePicker,
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

  _showModalBottomSheet() {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.folder, color: Color(0xffee4c83)),
              title: const Text('Do dispositivo'),
              onTap: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Color(0xffee4c83)),
              title: const Text('Camera'),
              onTap: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Color(0xffee4c83)),
              title: const Text('Fechar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}