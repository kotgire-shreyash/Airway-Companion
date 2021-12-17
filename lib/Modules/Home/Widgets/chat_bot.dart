import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.redAccent.shade200,
          shape: BoxShape.circle,
        ),
        child: CustomPopupMenu(
          verticalMargin: 0,
          arrowColor: Colors.redAccent.shade200,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.redAccent.shade200, shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                CupertinoIcons.chat_bubble_2_fill,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          menuBuilder: () {
            return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              elevation: 5,
              child: Container(
                height: 450,
                width: 280,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            );
          },
          pressType: PressType.singleClick,
        ),
      ),
    );

    /*
    DropDown<Container>(
      isExpanded: false,
      dropDownType: DropDownType.Button,
      showUnderline: false,
      icon: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.redAccent.shade200, shape: BoxShape.circle),
        child: const Center(
          child: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      items: [
        Container(),
      ],
      customWidgets: [
        Container(
          height: MediaQuery.of(context).size.height - 200,
          width: 250,
          color: Colors.blue,
          child: Column(children: [
            Container(
              child: Center(
                child: Text("ChatBot"),
              ),
            ),
          ]),
        ),
      ],
    );

    */

    // Container(
    //   height: 60,
    //   width: 60,
    //   decoration: BoxDecoration(
    //     color: Colors.redAccent.shade200,
    //     shape: BoxShape.circle,
    //   ),
    //   child: Center(

    //   ),
    // );

    /*

    DropdownButtonHideUnderline(
            child: DropdownButton<FloatingActionButtonLocation>(
              icon: Icon(
                CupertinoIcons.chat_bubble_2_fill,
                size: 30,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                    child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.blue,
                ))
              ],
            ),
          ),


     DropDown(
        dropDownType: DropDownType.Button,
        showUnderline: false,
        icon: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.redAccent.shade200, shape: BoxShape.circle),
          child: const Center(
            child: Icon(
              CupertinoIcons.chat_bubble_2_fill,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        items: const [
          "",
        ],
      ),
     */

    // FloatingActionButton(
    //   // isExtended: true,
    //   materialTapTargetSize: MaterialTapTargetSize.padded,
    //   elevation: 8,
    //   backgroundColor: Colors.redAccent.shade200,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(50))),
    //   child: Center(
    //     child: Icon(CupertinoIcons.chat_bubble_2_fill),
    //   ),
    //   onPressed: () {},
    // );
  }
}
