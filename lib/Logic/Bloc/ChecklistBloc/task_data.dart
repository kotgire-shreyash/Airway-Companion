import 'package:airwaycompanion/Modules/Checklist/widgets/task_class.dart';
import 'package:flutter/material.dart';

// Initial data of task card for widget list
final List<taskClass> taskList = [
  taskClass(
    title: 'Documents',
    todolist: [
      'aadhar',
      'pancard',
      'passport',
      'gate pass',
      'vaccination Certificate',
    ],
    iconData: Icons.document_scanner,
  ),
  taskClass(
    title: 'Utilities',
    todolist: [
      'Charger',
      'Powerbank',
      'Headphones',
    ],
    iconData: Icons.cable_sharp,
  ),
  taskClass(
    title: 'Covid Necessary',
    todolist: [
      'Mask',
      'Hand Sanitizer',
      'RTPCR Report',
    ],
    iconData: Icons.coronavirus_outlined,
  ),
];
