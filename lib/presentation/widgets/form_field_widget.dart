import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_state.dart';
import '../../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_event.dart';

class DynamicFormField extends StatelessWidget {
  final int sectionIndex;
  final int fieldIndex;
  final Field field;
  final bloc;
  File? image;


  final ImagePicker _picker = ImagePicker();
  String checkList="";
  DynamicFormField({super.key, required this.field, required this.bloc, required this.sectionIndex, required this.fieldIndex});

  @override
  Widget build(BuildContext context) {

    final props = field.properties;
    final label = props.label ?? '';

    switch (field.id) {
      case 1: // Text field
        return TextFormField(
          decoration: InputDecoration(labelText: label),
          initialValue: props.defaultValue,
          onChanged: (value) =>
              bloc.add(SaveAnswer(field.key,isMultiSelect:false,answer: value, value,sectionIndex: sectionIndex,fieldIndex: fieldIndex)),
          validator: (value) {
            if (props.minLength != null &&
                value!.length < props.minLength!) {
              return 'Minimum ${props.minLength} characters required';
            }
            return null;
          },
        );

      case 2: // Dropdown or Multi-select
        final items = json.decode(props.listItems!) as List;
        if (props.multiSelect == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              ...items.map((item) => BlocBuilder<FormBloc, FormPageState>(

                bloc: bloc,
                builder: (context, state) {
                   bool value =false;
                  if(state is FormAnswerUpdated)
                    {
                     value = state.answers['${field.key}_${item['value']}'] ?? false;
                     if(value)
                     {
                       checkList+="${item["name"].toString()},";
                       log(checkList,name: "now check list");
                       bloc.add(SaveCheckListToModel(sectionIndex: sectionIndex, fieldIndex: fieldIndex, checkList: checkList));
                     }
                    }

                  return CheckboxListTile(
                    title: Text(item['name']),
                    value: value,
                    onChanged: (val) => bloc.add(SaveAnswer('${field.key}_${item['value']}',isMultiSelect:false,answer: checkList, val,fieldIndex: fieldIndex,sectionIndex: sectionIndex)),
                  );
                },
              ))
            ],
          );
        } else {
          return DropdownButtonFormField(
            decoration: InputDecoration(labelText: label),
            items: items
                .map((item) => DropdownMenuItem(
              value: item['name'],
              child: Text(item['name']),
            ))
                .toList(),
            onChanged: (val) =>
                bloc.add(SaveAnswer(field.key,isMultiSelect:false, val,answer:val.toString(),sectionIndex: sectionIndex,fieldIndex: fieldIndex)),
          );
        }

      case 3: // Yes/No/NA
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            BlocBuilder<FormBloc, FormPageState>(
              bloc: bloc,
              builder: (context, state) {
                final current = (state is FormAnswerUpdated)
                    ? state.answers[field.key]
                    : null;
                return Wrap(
                  spacing: 10,
                  children: ['Yes', 'No', 'NA']
                      .map((opt) => ChoiceChip(
                    label: Text(opt),
                    selected: current == opt,
                    onSelected: (_) => bloc.add(SaveAnswer(field.key,isMultiSelect:false,answer: opt.toString(), opt,fieldIndex: fieldIndex,sectionIndex: sectionIndex)),
                  ))
                      .toList(),
                );
              },
            )
          ],
        );

      case 4: // Image picker
        return ElevatedButton(
          child: Text(label),
          onPressed: () {
            pickImageFromGallery();
            //bloc.add(SaveAnswer(field.key, 'Image Picked'));
          }
        );

      default:
        return SizedBox.shrink();
    }
  }
  // Function to pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

}
