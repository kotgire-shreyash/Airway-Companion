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
      appBar: AppBar(title: Text('timeline'), centerTitle: true),
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










// class ProcessTimelinePage extends StatefulWidget {
//   @override
//   _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
// }

// class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
//   int _processIndex = 2;

//   Color getColor(int index) {
//     if (index == _processIndex) {
//       return inProgressColor;
//     } else if (index < _processIndex) {
//       return completeColor;
//     } else {
//       return todoColor;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: TitleAppBar('Process Timeline'),
//       appBar: AppBar(
//         title: Text('processes'),
//       ),
//       body: Container(
//         child: Timeline.tileBuilder(
//           theme: TimelineThemestepObject(
//             direction: Axis.vertical,
//             nodePosition: 0.25,
//             indicatorPosition: 0.5,
//             connectorTheme: ConnectorThemestepObject(
//               space: 30.0,
//               thickness: 5.0,
//             ),
//           ),
//           builder: TimelineTileBuilder.connected(
//             connectionDirection: ConnectionDirection.before,
//             itemExtentBuilder: (_, __) =>
//                 MediaQuery.of(context).size.width / _processes.length,
//             oppositeContentsBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.only(right: 15.0),
//                   child: Text(TimeOfDay.now().format(context)));
//             },
//             contentsBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Text(
//                   _processes[index],
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: getColor(index),
//                   ),
//                 ),
//               );
//             },
//             indicatorBuilder: (_, index) {
//               var color;
//               var child;

//               if (index == _processIndex) {
//                 color = inProgressColor;
//                 child = Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircularProgressIndicator(
//                     strokeWidth: 3.0,
//                     valueColor: AlwaysStoppedAnimation(Colors.white),
//                   ),
//                 );
//               } else if (index < _processIndex) {
//                 color = completeColor;
//                 child = Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 15.0,
//                 );
//               } else {
//                 color = todoColor;
//               }

//               if (index <= _processIndex) {
//                 return Stack(
//                   children: [
//                     DotIndicator(
//                       size: 30.0,
//                       color: color,
//                       child: child,
//                     ),
//                   ],
//                 );
//               } else {
//                 return Stack(
//                   children: [
//                     OutlinedDotIndicator(
//                       borderWidth: 4.0,
//                       color: color,
//                     ),
//                   ],
//                 );
//               }
//             },
//             connectorBuilder: (_, index, type) {
//               if (index > 0) {
//                 if (index == _processIndex) {
//                   final prevColor = getColor(index - 1);
//                   final color = getColor(index);
//                   List<Color> gradientColors;
//                   if (type == ConnectorType.start) {
//                     gradientColors = [
//                       Color.lerp(prevColor, color, 0.5)!,
//                       color
//                     ];
//                   } else {
//                     gradientColors = [
//                       prevColor,
//                       Color.lerp(prevColor, color, 0.5)!
//                     ];
//                   }
//                   return DecoratedLineConnector(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: gradientColors,
//                       ),
//                     ),
//                   );
//                 } else {
//                   return SolidLineConnector(
//                     color: getColor(index),
//                   );
//                 }
//               } else {
//                 return null;
//               }
//             },
//             itemCount: _processes.length,
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.chevron_right_rounded),
//         onPressed: () {
//           setState(() {
//             _processIndex = (_processIndex + 1) % _processes.length;
//           });
//         },
//         backgroundColor: inProgressColor,
//       ),
//     );
//   }
// }

// final _processes = [
//   'Check in',
//   'Luggage Drop',
//   'Boarding pass',
//   'Security Check',
//   'Flight Boarding',
// ];
