

import 'package:equatable/equatable.dart';

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

class SaveAnswer extends FormEvent {
  final String key;
  final dynamic value;
  SaveAnswer(this.key, this.value);
  @override
  List<Object?> get props => [key, value];
}
