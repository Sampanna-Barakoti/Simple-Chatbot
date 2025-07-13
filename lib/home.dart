import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/messages_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DialogFlowtter? dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeDialogFlow();
  }

  _initializeDialogFlow() async {
    try {
      dialogFlowtter = await DialogFlowtter.fromFile();
    } catch (e) {
      // DialogFlow initialization failed - will use fallback responses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          "PIE-BOT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: MessagesScreen(messages: messages, scrollController: _scrollController),
          ),
          if (_isLoading)
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('Bot is typing...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          sendMessage(text);
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _isLoading ? null : () {
                      if (_controller.text.isNotEmpty) {
                        sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'text': text,
        'isUserMessage': true,
      });
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      if (dialogFlowtter != null) {
        DetectIntentResponse response = await dialogFlowtter!.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );

        String botResponse = 'Sorry, I didn\'t understand that.';
        if (response.message != null && response.message!.text != null) {
          botResponse = response.message!.text!.text!.isNotEmpty 
              ? response.message!.text!.text![0] 
              : botResponse;
        }

        setState(() {
          messages.add({
            'text': botResponse,
            'isUserMessage': false,
          });
        });
      } else {
        // Fallback response when DialogFlow is not initialized
        setState(() {
          messages.add({
            'text': 'Hello! I\'m PIE-BOT. DialogFlow is not configured yet, but I\'m here to chat!',
            'isUserMessage': false,
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({
          'text': 'Sorry, I encountered an error. Please try again.',
          'isUserMessage': false,
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
