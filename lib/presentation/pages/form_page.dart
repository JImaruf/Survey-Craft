import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';
import '../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_state.dart';
import '../widgets/form_field_widget.dart';


class FormPage extends StatelessWidget {
  final FormModel form;
  const FormPage({super.key, required this.form});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: form.formName),
      body: BlocBuilder<FormBloc, FormPageState>(
        builder: (context, state) {
          return Form(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                for (var section in form.sections)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        section.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      for (var field in section.fields)
                        DynamicFormField(field: field),
                      SizedBox(height: 20),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () {},
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
