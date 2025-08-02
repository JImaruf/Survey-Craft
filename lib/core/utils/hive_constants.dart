

import 'package:hive_flutter/adapters.dart';

class HiveBoxesName {
  //********** Box Name *********** */
  static const String surveyListBox = 'BasicBox';

}

//********** open Box *********** */

class OpenBoxes {
  openBox() async {
    await Hive.openBox(HiveBoxesName.surveyListBox);

  }
}

class HiveBoxes {
  static Box get surveyListBox => Hive.box(HiveBoxesName.surveyListBox);

}


