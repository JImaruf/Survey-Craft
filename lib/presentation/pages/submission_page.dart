import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:survey_craft/data/data_sources/local/local_data_source.dart';
import 'package:survey_craft/data/models/form_model.dart';
import 'package:survey_craft/presentation/pages/form_list.dart';

class SubmissionViewPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final FormModel modelWithAnswer;
  const SubmissionViewPage({super.key, required this.data, required this.modelWithAnswer});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submission Summary")),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          for (int i = 0; i < modelWithAnswer.sections!.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelWithAnswer.sections![i].name,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                ),

                for (int j = 0; j < modelWithAnswer.sections![i].fields.length; j++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${modelWithAnswer.sections![i].fields[j].properties.label} :",),

                      Text(modelWithAnswer.sections![i].fields[j].properties.answer!=""?modelWithAnswer.sections![i].fields[j].properties.answer.toString():"not given"),
                    ],
                  ),

                SizedBox(height: 20),
              ],
            ),


        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: SizedBox(
          height: 50.h,
          child: ElevatedButton.icon(
            onPressed: () async {
              modelWithAnswer.dateTime = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
              log(modelWithAnswer.dateTime!,name: "time");
             await HiveOperation().addData(jsonEncode(modelWithAnswer.toJson()), "${modelWithAnswer.formName}${DateTime.now().toString()}");
             // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FormList(),), (route) => false,);
            },
            icon: Icon(Icons.save_alt),
            label: Text('Save to Storage', style: TextStyle(fontSize: 16.sp)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
        ),
      ),
    );
  }
}
