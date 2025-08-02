

import 'package:equatable/equatable.dart';
import 'package:survey_craft/data/models/form_model.dart';

abstract class FormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadForms extends FormEvent {}

class SubmitForm extends FormEvent {
  final Map<String, dynamic> answers;
  SubmitForm(this.answers);
  @override
  List<Object?> get props => [answers];
}
class FetchCurrentFormDataEvent extends FormEvent {
 final FormModel form;
 FetchCurrentFormDataEvent(this.form);
  @override
  List<Object?> get props => [form];
}


class SaveAnswer extends FormEvent {
  final bool isMultiSelect;
  final String key;
  final dynamic value;
  final int sectionIndex;
  final int fieldIndex;
  final String answer;
  SaveAnswer(this.key, this.value,  {required this.isMultiSelect,required this.sectionIndex, required this.fieldIndex,required this.answer,});
  @override
  List<Object?> get props => [key, value,sectionIndex,fieldIndex];
}
class SaveCheckListToModel extends FormEvent {
  final int sectionIndex;
  final int fieldIndex;
  final String checkList;
  SaveCheckListToModel({required this.sectionIndex, required this.fieldIndex,required this.checkList,});
  @override
  List<Object?> get props => [sectionIndex,fieldIndex,checkList];
}
