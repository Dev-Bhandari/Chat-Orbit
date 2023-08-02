import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/message.dart';

class Messages extends StatelessWidget {
  const Messages({super.key, required this.id2, required this.name});
  final String id2;
  final String name;
  @override
  Widget build(BuildContext context) {
    final messageList = Provider.of<List<Message>>(context);
    return messageList.isEmpty
        ? Center(
            child: Text(
            'Say hello to $name',
            style: const TextStyle(fontSize: 20),
          ))
        : ListView.builder(
            reverse: true,
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              return Align(
                alignment:
                    messageList[messageList.length - index - 1].sender == id2
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: messageList[messageList.length - index - 1]
                                    .sender ==
                                id2
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      child: Text(
                        messageList[messageList.length - index - 1].message,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              );
            },
          );
  }
}
