import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_chat/models/local_user.dart';
import 'package:mobi_chat/models/message.dart';
import 'package:mobi_chat/models/open_chat.dart';
import 'package:mobi_chat/models/users.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});
 
  final CollectionReference userDB =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference mesaageDB =
      FirebaseFirestore.instance.collection('messages');

  Future registerUser(String name, String email) async {
    return await userDB
        .doc(uid)
        .set({'name': name, 'email': email, 'openchats': []});
  }

  Stream<LocalUser> get localUser {
    return userDB.doc(uid).snapshots().map(
      (documentSnapshot) {
        return LocalUser(
            id: uid,
            name: documentSnapshot.get('name'),
            email: documentSnapshot.get('email'));
      },
    );
  }

  List<Users> _userListFromSnapshot(QuerySnapshot querySnapshot) {
    List<Users> users = [];
    for (var doc in querySnapshot.docs) {
      if (doc.id != uid) {
        users.add(Users(id: doc.id, name: doc.get('name')));
      }
    }
    return users;
  }

  Stream<List<Users>> get users {
    return userDB.snapshots().map(_userListFromSnapshot);
  }

  List<OpenChat> _openChatListFormSnapshot(DocumentSnapshot documentSnapshot) {
    List<OpenChat> openChatList = [];
    documentSnapshot.get('openchats');
    for (var openChat in documentSnapshot.get('openchats')) {
      openChatList.add(OpenChat(
          id: openChat['id'],
          privateChatId: openChat['privatechatid'],
          name: openChat['name']));
    }
    return openChatList;
  }

  Stream<List<OpenChat>> get openChat {
    return userDB.doc(uid).snapshots().map(_openChatListFormSnapshot);
  }

  List<Message> _messageListFromSnapshot(DocumentSnapshot documentSnapshot) {
    List<Message> messagesList = [];
    for (var message in documentSnapshot.get('messages')) {
      messagesList.add(Message(
          sender: message['id'],
          timestamp: message['timestamp'],
          message: message['message']));
    }
    return messagesList;
  }

  Stream<List<Message>> getmessages(String privateChatId) {
    return mesaageDB
        .doc(privateChatId)
        .snapshots()
        .map(_messageListFromSnapshot);
  }

  void addFriend(String id2, String name1, String name2) async {
    String privateChatId = privateChatIdGenerator(uid, id2);
    userDB.doc(id2).update({
      'openchats': FieldValue.arrayUnion([
        {'id': uid, 'privatechatid': privateChatId, 'name': name1}
      ])
    });
    userDB.doc(uid).update({
      'openchats': FieldValue.arrayUnion([
        {'id': id2, 'privatechatid': privateChatId, 'name': name2}
      ])
    });

    await mesaageDB.doc(privateChatId).set(
      {'messages': []},
    );
  }

  bool isPrivateChatIdExistChecker(List<OpenChat> openChatList, String id) {
    bool isPrivateChatIdExist = false;
    for (var openChat in openChatList) {
      isPrivateChatIdExist = openChat.id == id;
      if (isPrivateChatIdExist) {
        return isPrivateChatIdExist;
      }
    }
    return isPrivateChatIdExist;
  }

  String privateChatIdGenerator(String id1, id2) => id1 + id2;

  Future sendMessage(String privateChatId, String message) async {
    return await mesaageDB.doc(privateChatId).update(
      {
        'messages': FieldValue.arrayUnion([
          {'id': uid, 'timestamp': Timestamp.now(), 'message': message}
        ])
      },
    );
  }
}
