import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_bloc.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_event.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_state.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_bloc.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_event.dart';
import 'package:survey_craft/presentation/pages/form_page.dart';
import 'package:survey_craft/presentation/pages/show_saved_list.dart';
import 'package:survey_craft/presentation/widgets/custom_app_bar.dart';
import 'package:survey_craft/presentation/widgets/custom_button.dart';

import '../../config/constants/app_colors.dart';
import '../widgets/form_list_card.dart';

class FormList extends StatelessWidget {
  const FormList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FormListBloc>().add(LoadFormAssetsEvent());
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Form List",
          showBackButton: false,
        ),
        body: Center(child: BlocBuilder<FormListBloc, FormListState>(
          builder: (context, state) {
            log(state.toString(), name: "current form list state");
            if (state is FormInitialState) {
              return CircularProgressIndicator();
            } else if (state is FormLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: state.formsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FormCard(
                          icon: Icon(
                            Icons.assignment,
                            color: AppColors.white,
                          ),
                          onTap: () {
                            FormBloc formBloc = FormBloc();
                            formBloc.add(FetchCurrentFormDataEvent(
                                state.formsList[index]));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormPage(
                                    form: state.formsList[index],
                                    formPageBloc: formBloc,
                                  ),
                                ));
                          },
                          title: state.formsList[index].formName.toString(),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      text: "Saved Survey List",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavedList(),
                            ));
                      },
                    ),
                  )
                ],
              );
            } else {
              return Text("NO Data Currently Available");
            }
          },
        )));
  }
}
