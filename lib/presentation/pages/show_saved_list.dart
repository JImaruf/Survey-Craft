

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:survey_craft/core/utils/hive_constants.dart';
import 'package:survey_craft/data/models/form_model.dart';
import 'package:survey_craft/presentation/pages/submission_page.dart';
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
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmissionViewPage(data: jsonDecode(data),isFromFormPage: false, modelWithAnswer: formModel),));
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF27AD61),
                radius: 24.r,
                child: Icon(Icons.description, color: Colors.white, size: 20.sp),
              ),
              title: Text(
                formModel.formName!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(formModel.dateTime!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),

            ),
          ),
        );


      },),
    );
  }
}
