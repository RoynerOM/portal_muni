part of 'informe_institucional_bloc.dart';

abstract class InformeInstitucionalEvent {}

class LoadInformeInstitucionalEvt extends InformeInstitucionalEvent {}

class CreateInformeInstitucionalEvt extends InformeInstitucionalEvent {
  final File file;
  final InformeInstModel model;
  CreateInformeInstitucionalEvt({required this.file, required this.model});
}

class DeleteInformeInstitucionalEvt extends InformeInstitucionalEvent {
  final String id;
  DeleteInformeInstitucionalEvt(this.id);
}

class FiltrosEvt extends InformeInstitucionalEvent {
  final String nombre;
  final String year;
  final String tipo;
  FiltrosEvt(this.nombre, this.year, this.tipo);
}
