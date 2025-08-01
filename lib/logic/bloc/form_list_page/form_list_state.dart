import 'package:equatable/equatable.dart';

import '../../../data/models/form_model.dart';

abstract class FormListState extends Equatable {}
class FormInitialState extends FormListState{


  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FormLoadedState extends FormListState{
  final List<FormModel> formsList;

  FormLoadedState(this.formsList);


  @override
  // TODO: implement props
  List<Object?> get props => [formsList];
}