import 'package:airwaycompanion/Modules/Timeline/widgets/inner_timeline.dart';
import 'package:airwaycompanion/Modules/Timeline/widgets/structure_class.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TimeLineCardHeader extends StatelessWidget {
  const TimeLineCardHeader({
    Key? key,
    required this.stepObject,
  }) : super(key: key);

  final StepInfo stepObject;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.transit_enterexit,
          color: Colors.green,
        ),
        Text(
          stepObject.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          '${stepObject.date.day}/${stepObject.date.month}/${stepObject.date.year}',
          style: TextStyle(
            color: Color(0xffb6b2b2),
          ),
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.checklist_rounded,
              color: Colors.lightBlue,
            ))
      ],
    );
  }
}

class TimeLineCardBody extends StatelessWidget {
  const TimeLineCardBody({Key? key, required this.stages}) : super(key: key);

  final List<Stage> stages;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: stages.length,
            contentsBuilder: (_, index) {
              if (stages[index].isCompleted) return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      stages[index].title,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    InnerTimeline(subStages: stages[index].subStages),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (stages[index].isCompleted) {
                return DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: stages[index].isCompleted ? Color(0xff66c97f) : null,
            ),
          ),
        ),
      ),
    );
  }
}

class TimeLineCardFooter extends StatelessWidget {
  const TimeLineCardFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('On-time!'),
              ),
            );
          },
          elevation: 0,
          shape: StadiumBorder(),
          color: Color(0xff66c97f),
          textColor: Colors.white,
          child: Text('On-time'),
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.gps_fixed_outlined,
              color: Colors.teal,
            ))
      ],
    );
  }
}
