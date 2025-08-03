import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_craft/config/constants/text_styles.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_state.dart';
import 'package:survey_craft/presentation/widgets/custom_button.dart';
import '../../../data/models/form_model.dart';
import '../../logic/bloc/form_page/form_page_bloc.dart';
import '../../logic/bloc/form_page/form_page_event.dart';

class DynamicFormField extends StatelessWidget {
  final int sectionIndex;
  final int fieldIndex;
  final Field field;
  final bloc;
  File? image;
  String? selectedValue;


  final ImagePicker _picker = ImagePicker();
  String checkList="";

  DynamicFormField({super.key, required this.field, required this.bloc, required this.sectionIndex, required this.fieldIndex});

  @override
  Widget build(BuildContext context) {

    final props = field.properties;
    final label = props.label ?? '';

    switch (field.id) {
      case 1: // Text field
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              hintText: field.properties.hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
            ),
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
          ),
        );

      case 2: // Dropdown or Multi-select
        final items = json.decode(props.listItems!) as List;
        if (props.multiSelect == true) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,style: AppTextStyles.title2,),
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
                      title: Text(item['name'],style: AppTextStyles.body2,),
                      value: value,
                      onChanged: (val) => bloc.add(SaveAnswer('${field.key}_${item['value']}',isMultiSelect:false,answer: checkList, val,fieldIndex: fieldIndex,sectionIndex: sectionIndex)),
                    );
                  },
                ))
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: selectedValue, // You can manage this in your state
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                // filled: true,
                // fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color:Colors.black12, width: 1.5),
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item['name'],
                  child: Text(
                    item['name'],
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }).toList(),
              onChanged: (val) => bloc.add(
                SaveAnswer(
                  field.key,
                  isMultiSelect: false,
                  val,
                  answer: val.toString(),
                  sectionIndex: sectionIndex,
                  fieldIndex: fieldIndex,
                ),
              ),
            )

          );
        }

      case 3: // Yes/No/NA
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,style: AppTextStyles.title2,),
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
        return  BlocBuilder<FormBloc, FormPageState>(
          bloc: bloc,
          builder: (context, state) {
            log(state.toString(),name: "alkds");
            if (state is ImageUpdate) {
              return InkWell(
                onTap:() async {
                  await pickImageFromGallery();
                  if (image != null) {
                    bloc.add(SaveAnswer(field.key, isMultiSelect: false,
                        answer: image!.absolute.path.toString(),
                        "value",
                        sectionIndex: sectionIndex,
                        fieldIndex: fieldIndex));
                    bloc.add(SaveCheckImageToModel(image: image!));

                  }
                },
                  child: Image.file(state.image));
            }
            return CustomButton(
                icon: Icons.image,
                text: label,
                onPressed: () async {
                  await pickImageFromGallery();
                  if (image != null) {
                    bloc.add(SaveAnswer(field.key, isMultiSelect: false,
                        answer: image!.absolute.path.toString(),
                        "value",
                        sectionIndex: sectionIndex,
                        fieldIndex: fieldIndex));
                    bloc.add(SaveCheckImageToModel(image: image!));
                    
                  }
                  //bloc.add(SaveAnswer(field.key, 'Image Picked'));
                }
            );
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
