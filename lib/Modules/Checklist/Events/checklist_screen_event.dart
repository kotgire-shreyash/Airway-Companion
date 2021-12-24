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

// CheckBox pressed
class CheckBoxPressed extends CheckListScreenEvent {
  bool isCheckBoxPressed;
  int index;
  int cardIndex;
  CheckBoxPressed(
      {this.isCheckBoxPressed = false, this.index = -1, this.cardIndex = -1});
}
