// import 'package:flutter/material.dart';

// class ToDoTile extends StatefulWidget {
//   ToDoTile({required this.title});
//   final title;

//   @override
//   _ToDoTileState createState() => _ToDoTileState();
// }

// class _ToDoTileState extends State<ToDoTile> {
//   bool _ischecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       value: _ischecked,
//       activeColor: Colors.red,
//       onChanged: (value) {
//         setState(() {
//           _ischecked = !_ischecked;
//         });
//       },
//       title: Text(widget.title),
//       controlAffinity: ListTileControlAffinity.leading,
//     );
//   }
// }
