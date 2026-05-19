part of 'informe_institucional_bloc.dart';

abstract class InformeInstitucionalEvent {}

class LoadInformeHistoricoEvt extends InformeInstitucionalEvent {}

class LoadInformeEspecialAuditoriaEvt extends InformeInstitucionalEvent {}

class LoadInformeAnualAuditoriaEvt extends InformeInstitucionalEvent {}

class CreateInformeInstitucionalEvt extends InformeInstitucionalEvent {
  final File file;
  final InformeInstModel model;
  CreateInformeInstitucionalEvt({required this.file, required this.model});
}

class DeleteInformeInstitucionalEvt extends InformeInstitucionalEvent {
  final String id;
  final String type;
  DeleteInformeInstitucionalEvt(this.id, this.type);
}

class FiltrosEvt extends InformeInstitucionalEvent {
  final String nombre;
  final String year;
  final String tipo;
  FiltrosEvt(this.nombre, this.year, this.tipo);
}
