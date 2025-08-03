import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/config/constants/text_styles.dart';
import 'package:survey_craft/presentation/pages/submission_page.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';
import 'package:survey_craft/presentation/widgets/custom_button.dart';
import '../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_state.dart';
import '../widgets/form_field_widget.dart';


class FormPage extends StatelessWidget {
  final FormModel form;
  final FormBloc formPageBloc;
    FormPage({super.key, required this.form, required this.formPageBloc});
 // final formPageBloc = FormBloc();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: form.formName!),
      body: BlocBuilder<FormBloc, FormPageState>(
        bloc: formPageBloc,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                for (int i = 0; i < form.sections!.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        form.sections![i].name,
                        style: AppTextStyles.section,

                      ),
                      SizedBox(height: 16,),

                      for (int j = 0; j < form.sections![i].fields.length; j++)
                        DynamicFormField(
                          field: form.sections![i].fields[j],
                          bloc: formPageBloc,
                          fieldIndex: j,
                          sectionIndex: i,
                        ),

                      SizedBox(height: 20),
                    ],
                  ),
                Center(
                  child: CustomButton(text: "Submit",onPressed:() {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmissionViewPage(data: formPageBloc.currentAnswers,modelWithAnswer: formPageBloc.formModel,),));

                      //Get.to(() => SubmissionViewPage(data: answers));
                    }

                  } ,),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
