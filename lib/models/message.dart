import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sender;
  final Timestamp timestamp;
  final String message;
  Message({required this.sender, required this.timestamp, required this.message});
}
