
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:survey_craft/logic/bloc/form_page/form_page_event.dart';

import '../../../data/models/form_model.dart';
import 'form_page_state.dart';

class FormBloc extends Bloc<FormEvent, FormPageState> {
  Map<String, dynamic> currentAnswers = {};
   FormModel formModel = FormModel();
   File? image;

  FormBloc() : super(FormInitial()) {
    on<SubmitForm>(_onSubmitForm);
    on<SaveAnswer>(_onSaveAnswer);
    on<FetchCurrentFormDataEvent>(_loadCurrentForm);
    on<SaveCheckListToModel>((event, emit) {
      log(event.checkList,name: "check list in bloc");
           formModel.sections![event.sectionIndex].fields[event.fieldIndex].properties.answer = event.checkList;

    },);
  }



  void _onSaveAnswer(SaveAnswer event, Emitter<FormPageState> emit) {
    currentAnswers[event.key] = event.value;

    if(!event.isMultiSelect)
      {
        formModel.sections![event.sectionIndex].fields[event.fieldIndex].properties.answer = event.answer.toString();

      }
    log(formModel.toJson().toString(),name: "form model data");
    emit(FormAnswerUpdated(Map.from(currentAnswers),image));
  }
  void _loadCurrentForm(FetchCurrentFormDataEvent event, Emitter<FormPageState> emit) {
    formModel = event.form;
  }

  void _onSubmitForm(SubmitForm event, Emitter<FormPageState> emit) {
    emit(FormSubmitted(event.answers));
  }
}
