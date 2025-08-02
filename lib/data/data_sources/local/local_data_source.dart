import 'dart:developer';

import '../../../core/utils/hive_constants.dart';



class HiveOperation {
  Future<void> addData(dynamic data, String key) async {
    await HiveBoxes.surveyListBox.put(key, data);
  }

  getData(String key) {
    return HiveBoxes.surveyListBox.get(key) ?? {};
  }




}
