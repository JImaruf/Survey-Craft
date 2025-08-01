import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/config/constants/forms_path.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_event.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_state.dart';

import '../../../data/models/form_model.dart';

class FormListBloc extends Bloc<FormListEvent,FormListState>{
  FormListBloc() : super(FormInitialState()){

    LoadFormAssetsEvent();

    on<LoadFormAssetsEvent>((event, emit)  async {
      List <FormModel> formList = await loadForms();
      if(formList.isNotEmpty)
        {
          emit(FormLoadedState(formList));
        }

    });
  }

  Future<List<FormModel>> loadForms() async {
    final List<String> formAssets = [
      FormsPath.form1,
      FormsPath.form2,
      FormsPath.form3,
    ];

    final List<FormModel> forms = [];
    for (final path in formAssets) {
      final data = await rootBundle.loadString(path);
      final jsonData = json.decode(data);
      forms.add(FormModel.fromJson(jsonData));
    }
    return forms;
  }
}