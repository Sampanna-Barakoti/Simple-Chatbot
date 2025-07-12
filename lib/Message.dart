import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final List messages;
  const MessageScreen({super.key, required this.messages});

  @override
  State<MessageScreen> createState() => _MessagesState();
}

class _MessagesState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
