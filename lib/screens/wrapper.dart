import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobi_chat/screens/authenticate/authenticate.dart';
import 'package:mobi_chat/screens/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    return user == null
        ? const Authenticate()
        : Home(
            uid: user.uid,
          );
  }
}
