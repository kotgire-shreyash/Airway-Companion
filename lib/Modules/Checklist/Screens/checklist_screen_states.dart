import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:azstore/azstore.dart';
import 'package:flutter/material.dart';

class CheckListScreenState {
  List<dynamic> taskWidgets;
  var azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=airwaycompanionblob;AccountKey=Br8NyBihgsdUJ+iQfqUDUPbY4jutmNwBoYSdT40fmLUo/ZsV9f86pelutmew8aEZOfinjk9tsK8L0FrEx/8P8A==;EndpointSuffix=core.windows.net");

  List<Widget> fieldsList;
  List<String> fieldsNameList;
  bool isChecked;
  bool isDataBeingUpdated;

  CheckListScreenState({
    this.taskWidgets = const [],
    this.isChecked = false,
    this.fieldsList = const [],
    this.fieldsNameList = const [],
    this.isDataBeingUpdated = false,
  });

  CheckListScreenState copyWith({
    var taskWidgets,
    var isChecked,
    var fieldsList,
    var fieldsNameList,
    var isDataBeingUpdated,
  }) {
    return CheckListScreenState(
      taskWidgets: taskWidgets ?? this.taskWidgets,
      isChecked: isChecked ?? this.isChecked,
      fieldsList: fieldsList ?? this.fieldsList,
      fieldsNameList: fieldsNameList ?? this.fieldsNameList,
      isDataBeingUpdated: isDataBeingUpdated ?? this.isDataBeingUpdated,
    );
  }

  Future<void> uploadCheckListCardData(Map<String, dynamic> dataMap) async {
    try {
      print(dataMap["title"]);
      await azureStorage.createTable(dataMap["title"]);
      var _rowKey = "${dataMap["title"]}row123";
      var _partitionKey = "${dataMap["title"]}partition123";
      await azureStorage.putTableRow(
        tableName: dataMap["title"],
        partitionKey: _partitionKey,
        rowKey: _rowKey,
        bodyMap: dataMap,
      );
    } catch (e) {
      return null;
    }
  }

  getAzureCardTable(String tableName) async {
    var tableData = await azureStorage.getTableRow(
      tableName: tableName,
      partitionKey: "${tableName}partition123",
      rowKey: "${tableName}row123",
    );

    return tableData;
  }
}
