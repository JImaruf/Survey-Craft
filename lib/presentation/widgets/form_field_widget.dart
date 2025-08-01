import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_state.dart';
import '../../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_event.dart';

class DynamicFormField extends StatelessWidget {
  final FieldModel field;
  File? image;
  final ImagePicker _picker = ImagePicker();

  DynamicFormField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final props = field.properties;
    final label = props['label'] ?? '';

    switch (field.id) {
      case 1: // Text field
        return TextFormField(
          decoration: InputDecoration(labelText: label),
          initialValue: props['defaultValue'],
          onChanged: (value) =>
              context.read<FormBloc>().add(SaveAnswer(field.key, value)),
          validator: (value) {
            if (props['minLength'] != null &&
                value!.length < props['minLength']) {
              return 'Minimum ${props['minLength']} characters required';
            }
            return null;
          },
        );

      case 2: // Dropdown or Multi-select
        final items = json.decode(props['listItems']) as List;
        if (props['multiSelect'] == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              ...items.map((item) => BlocBuilder<FormBloc, FormPageState>(
                builder: (context, state) {
                  final value = (state is FormAnswerUpdated)
                      ? state.answers['${field.key}_${item['value']}'] ?? false
                      : false;
                  return CheckboxListTile(
                    title: Text(item['name']),
                    value: value,
                    onChanged: (val) => context.read<FormBloc>().add(
                        SaveAnswer('${field.key}_${item['value']}', val)),
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
                context.read<FormBloc>().add(SaveAnswer(field.key, val)),
          );
        }

      case 3: // Yes/No/NA
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            BlocBuilder<FormBloc, FormPageState>(
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
                    onSelected: (_) => context
                        .read<FormBloc>()
                        .add(SaveAnswer(field.key, opt)),
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
            //context.read<FormBloc>().add(SaveAnswer(field.key, 'Image Picked'));
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
