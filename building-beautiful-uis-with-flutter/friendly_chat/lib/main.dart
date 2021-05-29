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
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) => _messages[index],
              itemCount: _messages.length,
              padding: EdgeInsets.all(8.0),
              reverse: true,
            ),
          ),
          Divider(height: 1.0),
          Container(
            child: _buildTextComposer(),
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
          ),
        ],
      ),
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
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
                focusNode: _focusNode,
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

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(text: text);

    setState(() {
      _messages.insert(0, message);
    });

    _focusNode.requestFocus();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text});

  final String text;
  String _name = 'Your Name';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: CircleAvatar(
              child: Text(_name[0]),
            ),
            margin: EdgeInsets.only(right: 16.0),
          ),
          Column(
            children: [
              Text(_name, style: Theme.of(context).textTheme.headline4),
              Container(
                child: Text(text),
                margin: EdgeInsets.only(top: 5.0),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
