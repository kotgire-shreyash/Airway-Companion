import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // isExtended: true,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      elevation: 8,
      backgroundColor: Colors.redAccent.shade200,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: Icon(CupertinoIcons.chat_bubble_2_fill),
      ),
      onPressed: () {},
    );
  }
}
