import 'package:mobi_chat/models/local_user.dart';
import 'package:mobi_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<LocalUser>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(children: [
        const Spacer(
          flex: 1,
        ),
        const Icon(Icons.account_circle, size: 80),
        const SizedBox(
          height: 32,
        ),
        ListTile(
            iconColor: Colors.blue,
            leading: const Icon(Icons.person, size: 30),
            title: Text(
              user.name,
              style: const TextStyle(fontSize: 18),
            )),
        const SizedBox(
          height: 18,
        ),
        ListTile(
          iconColor: Colors.blue,
          leading: const Icon(
            Icons.email,
            size: 30,
          ),
          title: Text(
            user.email,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.logout,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () async {
            await _authService.signout();
          },
          label: const Text(
            'Logout',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Spacer(
          flex: 4,
        )
      ]),
    );
  }
}
