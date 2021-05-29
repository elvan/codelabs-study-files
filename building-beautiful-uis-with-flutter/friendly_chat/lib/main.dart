import 'package:flutter/material.dart';

void main() {
  runApp(
    FriendlyChatApp(),
  );
}

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      title: 'FriendlyChat',
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
      ),
      body: _buildTextComposer(),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      child: Container(
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                onSubmitted: _handleSubmitted,
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
            )
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      data: IconThemeData(color: Theme.of(context).accentColor),
    );
  }

  void _handleSubmitted(String value) {
    _textController.clear();
  }
}
