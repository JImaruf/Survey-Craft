

import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../data/models/form_model.dart';

abstract class FormPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormInitial extends FormPageState {}

class FormLoading extends FormPageState {}

class FormLoaded extends FormPageState {
  final List<FormModel> forms;
  FormLoaded(this.forms);
  @override
  List<Object?> get props => [forms];
}

class FormAnswerUpdated extends FormPageState {
  final Map<String, dynamic> answers;
  final File? image;
  FormAnswerUpdated(this.answers, this.image);
  @override
  List<Object?> get props => [answers];
}
class ImageUpdate extends FormPageState {
 final File image;
  ImageUpdate(this.image);
  @override
  List<Object?> get props => [image];
}

class FormSubmitted extends FormPageState {
  final Map<String, dynamic> answers;
  FormSubmitted(this.answers);
  @override
  List<Object?> get props => [answers];
}

class FormError extends FormPageState {
  final String message;
  FormError(this.message);
  @override
  List<Object?> get props => [message];
}
