import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:survey_craft/config/constants/text_styles.dart';
import 'package:survey_craft/data/data_sources/local/local_data_source.dart';
import 'package:survey_craft/data/models/form_model.dart';
import 'package:survey_craft/presentation/pages/form_list.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';
import 'package:survey_craft/presentation/widgets/custom_button.dart';

class SubmissionViewPage extends StatelessWidget {
  final bool isFromFormPage;
  final Map<String, dynamic> data;
  final FormModel modelWithAnswer;
  const SubmissionViewPage({super.key,this.isFromFormPage=true, required this.data, required this.modelWithAnswer});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: isFromFormPage?"Submission Summary":modelWithAnswer.formName!),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          for (int i = 0; i < modelWithAnswer.sections!.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelWithAnswer.sections![i].name,
                  style: AppTextStyles.section2
                ),

                for (int j = 0; j < modelWithAnswer.sections![i].fields.length; j++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${modelWithAnswer.sections![i].fields[j].properties.label} :",style: AppTextStyles.section3,),


                      modelWithAnswer.sections![i].fields[j].properties.type=="imageView"?Image.file(File(modelWithAnswer.sections![i].fields[j].properties.answer.toString())):Text(modelWithAnswer.sections![i].fields[j].properties.answer!=""?modelWithAnswer.sections![i].fields[j].properties.answer.toString():"not given",style: AppTextStyles.answer,),
                    ],
                  ),

                SizedBox(height: 20),
              ],
            ),


        ],
      ),
      bottomNavigationBar: isFromFormPage?Padding(
        padding: EdgeInsets.all(16.w),
        child: SizedBox(
          height: 60.h,
          width: 60.w,
          child: CustomButton(

            icon: Icons.download,
            text: "Save to Storage",
            onPressed: () async {
              modelWithAnswer.dateTime = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
              log(modelWithAnswer.dateTime!,name: "time");
             await HiveOperation().addData(jsonEncode(modelWithAnswer.toJson()), "${modelWithAnswer.formName}${DateTime.now().toString()}");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FormList(),), (route) => false,);
            },
          ),
        ),
      ):SizedBox.shrink(),
    );
  }
}
