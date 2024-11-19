part of 'plan_institucional_bloc.dart';

abstract class PlanInstitucionalEvent {}

class LoadPlanInstitucionalEvt extends PlanInstitucionalEvent {}

class CreatePlanInstitucionalEvt extends PlanInstitucionalEvent {
  final File file;
  final PlanInstitucionalModel model;
  CreatePlanInstitucionalEvt({required this.file, required this.model});
}

class DeletePlanInstitucionalEvt extends PlanInstitucionalEvent {
  final String id;
  DeletePlanInstitucionalEvt(this.id);
}

class FiltrosEvt extends PlanInstitucionalEvent {
  final String nombre;
  final String year;
  final String tipo;
  FiltrosEvt(this.nombre, this.year, this.tipo);
}
