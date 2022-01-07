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

// Retrieve Data From Azure
class AzureDataRetrieveEvent extends CheckListScreenEvent {
  bool isDataBeingUpdated;
  AzureDataRetrieveEvent({this.isDataBeingUpdated = false});
}

// Delete Card
class DeleteCard extends CheckListScreenEvent {
  String title;
  DeleteCard({required this.title});
}

// CheckBox pressed
class CheckBoxPressed extends CheckListScreenEvent {
  int index;
  int cardIndex;
  CheckBoxPressed({this.index = -1, this.cardIndex = -1});
}

class AddFieldsEvent extends CheckListScreenEvent {
  var fieldTitle;
  AddFieldsEvent({this.fieldTitle});
}
