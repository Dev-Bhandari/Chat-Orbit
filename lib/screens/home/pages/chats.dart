import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/open_chat.dart';
import '../components/private_chat.dart';

class Chats extends StatelessWidget {
  final String id1;
  const Chats({super.key, required this.id1});

  @override
  Widget build(BuildContext context) {
    final openChatList = Provider.of<List<OpenChat>>(context);

    return openChatList.isEmpty
        ? const Center(
            child: Text(
              'Add new friends',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            itemCount: openChatList.length,
            itemBuilder: (context, index) {
              var id2 = openChatList[index].id;
              var name = openChatList[index].name;
              var privateChatid = openChatList[index].privateChatId;
              return Container(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  leading: const Icon(Icons.account_circle, size: 45),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivateChat(
                              id1: id1,
                              id2: id2,
                              privateChatId: privateChatid,
                              name: name),
                        ));
                  },
                ),
              );
            },
          );
  }
}
