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
          color: Colors.yellow.shade700,
        ),
        Text(
          stepObject.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '${stepObject.date.day}/${stepObject.date.month}/${stepObject.date.year}',
          style: const TextStyle(
            color: Color(0xffb6b2b2),
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(
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
      style: const TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: const Color(0xff989898),
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: stages.length,
            contentsBuilder: (_, index) {
              if (stages[index].isCompleted) return null;

              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
                  color: Colors.yellow.shade700,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return const OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: stages[index].isCompleted ? Colors.yellow.shade700 : null,
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
              const SnackBar(
                content: Text('On-time!'),
              ),
            );
          },
          elevation: 0,
          shape: const StadiumBorder(),
          color: Colors.yellow.shade700,
          textColor: Colors.white,
          child: const Text('On-time'),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.gps_fixed_outlined,
              color: Colors.blue.shade900,
            ))
      ],
    );
  }
}
