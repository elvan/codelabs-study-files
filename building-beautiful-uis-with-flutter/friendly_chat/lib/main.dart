import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    FriendlyChatApp(),
  );
}

final ThemeData kIOSTheme = ThemeData(
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.light,
  primarySwatch: Colors.orange,
);

final ThemeData kDefaultTheme = ThemeData(
  accentColor: Colors.orangeAccent[400],
  primarySwatch: Colors.purple,
);

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      title: 'FriendlyChat',
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  var _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        title: Text('FriendlyChat'),
      ),
      body: Container(
        child: Column(
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
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.green[200]!),
                ),
              )
            : null,
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
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
              ),
            ),
            Container(
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      child: Text('Send'),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    )
                  : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
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

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {
      _isComposing = false;
    });

    var message = ChatMessage(
      animationController: AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      ),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });

    _focusNode.requestFocus();
    message.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  final AnimationController animationController;
  final String text;
  String _name = 'Your Name';

  ChatMessage({required this.text, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 0.0,
      child: Container(
        child: Row(
          children: [
            Container(
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
              margin: EdgeInsets.only(right: 16.0),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(_name, style: Theme.of(context).textTheme.headline4),
                  Container(
                    child: Text(text),
                    margin: EdgeInsets.only(top: 5.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      sizeFactor: CurvedAnimation(
        curve: Curves.easeOut,
        parent: animationController,
      ),
    );
  }
}
