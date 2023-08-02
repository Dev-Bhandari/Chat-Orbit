import 'package:mobi_chat/screens/authenticate/register.dart';
import 'package:mobi_chat/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
