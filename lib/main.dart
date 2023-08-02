import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobi_chat/screens/wrapper.dart';
import 'package:mobi_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthService().authUser,
      child: MaterialApp(
        color: Colors.white,
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}
