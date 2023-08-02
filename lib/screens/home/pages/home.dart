import 'package:mobi_chat/models/local_user.dart';
import 'package:mobi_chat/models/open_chat.dart';
import 'package:mobi_chat/screens/home/pages/chats.dart';
import 'package:mobi_chat/screens/home/pages/find_people.dart';
import 'package:mobi_chat/screens/home/pages/profile.dart';
import 'package:mobi_chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../models/users.dart';

class Home extends StatefulWidget {
  final String uid;
  const Home({super.key, required this.uid});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> page = [
      Chats(id1: widget.uid),
      FindPeople(uid: widget.uid),
      Profile(),
    ];

    final List<String> title = ['Chats', 'Make New Friends', 'Profile'];
    DatabaseService databaseService = DatabaseService(uid: widget.uid);

    return MultiProvider(
      providers: [
        StreamProvider<LocalUser>.value(
          initialData: LocalUser(id: '', name: '', email: ''),
          value: databaseService.localUser,
        ),
        StreamProvider<List<Users>>.value(
          initialData: const [],
          value: databaseService.users,
        ),
        StreamProvider<List<OpenChat>>.value(
            value: databaseService.openChat, initialData: const [])
      ],
      child: Scaffold(
        body: page[_selectedIndex],
        appBar: AppBar(
          title: Text(title[_selectedIndex]),
          backgroundColor: Colors.blue,
          elevation: 4,
          foregroundColor: Colors.white,
          shadowColor: Theme.of(context).shadowColor,
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: GNav(
              haptic: true,
              padding: const EdgeInsets.all(12),
              backgroundColor: Colors.blue,
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: Colors.lightBlue,
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() => _selectedIndex = index);
              },
              tabs: const [
                GButton(icon: Icons.chat, text: 'Chats'),
                GButton(
                  icon: Icons.person_add,
                  text: 'Find people',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile',
                )
              ]),
        ),
      ),
    );
  }
}
