import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final List messages;
  const Message({super.key, required this.messages});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
