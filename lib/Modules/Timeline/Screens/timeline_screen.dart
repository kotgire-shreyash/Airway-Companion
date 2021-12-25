// ignore_for_file: prefer_const_constructors

import 'package:airwaycompanion/Modules/Timeline/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:airwaycompanion/Modules/Timeline/widgets/structure_class.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timeline'), centerTitle: true),
      body: ListView.builder(
        itemCount: stepObjects.length,
        itemBuilder: (context, index) {
          final stepObject = stepObjects[index];
          return Center(
            child: Container(
              width: 360.0,
              child: Card(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TimeLineCardHeader(stepObject: stepObject),
                    ),
                    const Divider(height: 1.0),
                    TimeLineCardBody(stages: stepObject.stages),
                    const Divider(height: 1.0),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TimeLineCardFooter(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final stepObjects = <StepInfo>[
  StepInfo(
    name: 'CHECK IN',
    date: DateTime.now(),
    stages: [
      Stage(
        title: 'Check IN',
        subStages: [
          SubStage('8:15am', 'Traveler arrived for check In'),
          SubStage('8:25am', 'Verification of E ticket'),
          SubStage('8:30am', 'Vaccination and RTPCR report'),
          SubStage('8:35am', 'Checked In Successfully'),
          SubStage('8:40am', 'Issue of Boarding Pass'),
        ],
      ),
      Stage(),
    ],
  )
];
