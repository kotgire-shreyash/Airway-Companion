import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:azstore/azstore.dart';
import 'package:flutter/material.dart';

class CheckListScreenState {
  List<dynamic> taskWidgets;
  var azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=airwaycompanionblob;AccountKey=z8NIVphTTdxv7ja06UvpU7Gyhyms4UWdVozkV/5kxvL61wxlEIE0VyVq2Fr8p3CPRwHLG/lX5/i3TLTrG0/+0A==;EndpointSuffix=core.windows.net");

  bool isChecked;

  CheckListScreenState({
    this.taskWidgets = const [],
    this.isChecked = false,
  });

  CheckListScreenState copyWith({var taskWidgets, var isChecked}) {
    return CheckListScreenState(
      taskWidgets: taskWidgets ?? this.taskWidgets,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Future<void> uploadCheckListCardData(Map<String, dynamic> dataMap) async {
    try {
      print("TRYING...");
      var _rowKey = "checklistrow123";
      var _partitionKey = "checklistpartition123";
      await azureStorage.upsertTableRow(
        tableName: "ChecklistTable",
        partitionKey: _partitionKey,
        rowKey: _rowKey,
        bodyMap: dataMap,
      );
      print("DONE...");
    } catch (e) {
      print(e);
    }
  }

  getAzureCardTable() async {
    var tableData = await azureStorage.getTableRow(
      tableName: "ChecklistTable",
      partitionKey: "checklistpartition123",
      rowKey: "checklistrow123",
      // fields: ["cardIndex", "title", "isChecked", "a", "b"],
    );

    return tableData;
  }
}
