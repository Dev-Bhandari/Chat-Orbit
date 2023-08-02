import 'package:mobi_chat/models/message.dart';
import 'package:mobi_chat/screens/home/components/messages.dart';
import 'package:mobi_chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivateChat extends StatelessWidget {
  final String id1;
  final String id2;
  final String name;
  final String privateChatId;
  final TextEditingController _message = TextEditingController();

  PrivateChat(
      {super.key,
      required this.id1,
      required this.id2,
      required this.name,
      required this.privateChatId});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService(uid: id1);
    return StreamProvider<List<Message>>.value(
      initialData: const [],
      value: databaseService.getmessages(privateChatId),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: Theme.of(context).shadowColor,
            title: Row(children: [
              const Icon(Icons.account_circle, size: 42),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(name),
              )
            ]),
          ),
          body: Column(children: [
            Expanded(
                child: Messages(
              id2: id2,
              name: name,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _message,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Message',
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 18),
                            contentPadding: EdgeInsets.only(left: 16)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (_message.text.trim().isNotEmpty) {
                            databaseService.sendMessage(
                                privateChatId, _message.text);
                            _message.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
