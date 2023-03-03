import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';

class LogoutService extends ChangeNotifier {
  LogoutService(BuildContext context) {
    _doLogout(context);
  }

  _doLogout(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.push(MaterialPageRoute(
      builder: (context) => const AuthScreen(),
    ));
  }
}
