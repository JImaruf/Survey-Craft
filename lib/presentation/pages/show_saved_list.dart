

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:survey_craft/core/utils/hive_constants.dart';
import 'package:survey_craft/data/models/form_model.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';

class SavedList extends StatelessWidget {

  const SavedList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "Saved List"),
      body: ListView.builder(
        itemCount: HiveBoxes.surveyListBox.length,
        itemBuilder: (context, index)
      {
        var data = HiveBoxes.surveyListBox.get(HiveBoxes.surveyListBox.keyAt(index));
        FormModel formModel = FormModel.fromJson(jsonDecode(data));
        log(data.toString(),name: "timeee");
        return ListTile(title:Text(formModel.formName.toString(),

        ),
        subtitle: Text(formModel.dateTime.toString()),);

      },),
    );
  }
}
