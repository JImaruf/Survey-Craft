



import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_event.dart';

import '../../../data/models/form_model.dart';
import 'form_page_state.dart';

class FormBloc extends Bloc<FormEvent, FormPageState> {
  Map<String, dynamic> currentAnswers = {};

  FormBloc() : super(FormInitial()) {
    // on<LoadForms>(_onLoadForms);
    on<SubmitForm>(_onSubmitForm);
    on<SaveAnswer>(_onSaveAnswer);
  }

  // Future<void> _onLoadForms(LoadForms event, Emitter<FormState> emit) async {
  //   emit(FormLoading());
  //   try {
  //     final List<String> assets = [
  //       'assets/forms/form_1.json',
  //       'assets/forms/form_2.json',
  //       'assets/forms/form_3.json',
  //     ];
  //
  //     final List<FormModel> forms = [];
  //     for (final path in assets) {
  //       final data = await rootBundle.loadString(path);
  //       final jsonData = json.decode(data);
  //       forms.add(FormModel.fromJson(jsonData));
  //     }
  //     loadedForms = forms;
  //     emit(FormLoaded(forms));
  //   } catch (e) {
  //     emit(FormError("Failed to load forms"));
  //   }
  // }

  void _onSaveAnswer(SaveAnswer event, Emitter<FormPageState> emit) {
    currentAnswers[event.key] = event.value;
    emit(FormAnswerUpdated(Map.from(currentAnswers)));
  }

  void _onSubmitForm(SubmitForm event, Emitter<FormPageState> emit) {
    emit(FormSubmitted(event.answers));
  }
}
