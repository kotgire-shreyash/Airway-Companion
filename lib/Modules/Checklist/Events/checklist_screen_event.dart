import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';

abstract class CheckListScreenEvent {}

// Dismiss Card
class DismissCard extends CheckListScreenEvent {
  bool isCardDismissed;
  DismissCard({this.isCardDismissed = false});
}

// Add Card
class AddCard extends CheckListScreenEvent {
  TaskCard newTaskCard;
  AddCard({required this.newTaskCard});
}
