import 'package:mobi_chat/models/local_user.dart';
import 'package:mobi_chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/open_chat.dart';
import '../../../models/users.dart';

class FindPeople extends StatefulWidget {
  final String uid;
  const FindPeople({super.key, required this.uid});
  @override
  State<FindPeople> createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUser?>(context);
    final users = Provider.of<List<Users>>(context);
    final openChatList = Provider.of<List<OpenChat>>(context);
    final DatabaseService databaseService = DatabaseService(uid: widget.uid);
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final String id2 = users[index].id;
        final String name2 = users[index].name;

        bool isPrivateChatIdExist =
            databaseService.isPrivateChatIdExistChecker(openChatList, id2);
        return Container(
            padding: const EdgeInsets.all(8),
            child: ListTile(
                title: Text(
                  name2,
                  style: const TextStyle(fontSize: 20),
                ),
                leading: const Icon(Icons.account_circle, size: 45),
                trailing: IconButton(
                  onPressed: () {
                    databaseService.addFriend(id2, localUser!.name, name2);
                  },
                  icon: isPrivateChatIdExist
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        )
                      : const Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 30,
                        ),
                )));
      },
    );
  }
}
