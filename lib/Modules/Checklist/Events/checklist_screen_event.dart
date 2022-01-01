import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';

abstract class CheckListScreenEvent {}

class AzureTableCardAddition extends CheckListScreenEvent {
  var checkListCardMap;
  AzureTableCardAddition({this.checkListCardMap});
}

// Dismiss Card
class DismissCard extends CheckListScreenEvent {
  bool isCardDismissed;
  DismissCard({this.isCardDismissed = false});
}

// Add Card
class AddCard extends CheckListScreenEvent {
  var newTaskCard;
  AddCard({required this.newTaskCard});
}

// Delete Card
class DeleteCard extends CheckListScreenEvent {
  // int cardIndex;
  // DeleteCard({required this.cardIndex});
  var uniqueKey;
  DeleteCard({required this.uniqueKey});
}

// CheckBox pressed
class CheckBoxPressed extends CheckListScreenEvent {
  bool isCheckBoxPressed;
  int index;
  int cardIndex;
  CheckBoxPressed(
      {this.isCheckBoxPressed = false, this.index = -1, this.cardIndex = -1});
}
