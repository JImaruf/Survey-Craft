import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/presentation/pages/submission_page.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';
import '../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_state.dart';
import '../widgets/form_field_widget.dart';


class FormPage extends StatelessWidget {
  final FormModel form;
  final FormBloc formPageBloc;
   FormPage({super.key, required this.form, required this.formPageBloc});
 // final formPageBloc = FormBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: form.formName!),
      body: BlocBuilder<FormBloc, FormPageState>(
        bloc: formPageBloc,
        builder: (context, state) {
          return Form(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                for (int i = 0; i < form.sections!.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        form.sections![i].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

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

                ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmissionViewPage(data: formPageBloc.currentAnswers,modelWithAnswer: formPageBloc.formModel,),));

                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
