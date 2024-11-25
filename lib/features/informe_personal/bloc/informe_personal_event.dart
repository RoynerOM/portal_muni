part of 'informe_personal_bloc.dart';

abstract class InformePersonalEvent {}

class LoadInformePersonalEvt extends InformePersonalEvent {}

class CreateInformePersonalEvt extends InformePersonalEvent {
  final File file;
  final InformePersonalModel model;
  CreateInformePersonalEvt({required this.file, required this.model});
}

class DeleteInformePersonalEvt extends InformePersonalEvent {
  final String id;
  DeleteInformePersonalEvt(this.id);
}

class FiltrosEvt extends InformePersonalEvent {
  final String nombre;
  final String year;
  final String tipo;
  FiltrosEvt(this.nombre, this.year, this.tipo);
}
