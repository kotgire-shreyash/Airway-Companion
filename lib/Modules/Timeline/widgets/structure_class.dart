class StepInfo {
  const StepInfo({
    required this.date,
    required this.stages,
    required this.name,
  });
  final String name;
  final DateTime date;
  final List<Stage> stages;
}

class Stage {
  const Stage({
    this.title = 'Done',
    this.subStages = const [],
  });

  final String title;
  final List<SubStage> subStages;

  bool get isCompleted => title == 'Done';
}

class SubStage {
  const SubStage(this.createdAt, this.tasks);

  final String createdAt; // final DateTime createdAt;
  final String tasks;

  @override
  String toString() {
    return '$createdAt $tasks';
  }
}
