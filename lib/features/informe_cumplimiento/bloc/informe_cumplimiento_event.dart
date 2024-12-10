part of 'informe_cumplimiento_bloc.dart';

abstract class InformeCumplimientoEvent {}

class LoadInformeCumplimientoEvt extends InformeCumplimientoEvent {}

class CreateInformeCumplimientoEvt extends InformeCumplimientoEvent {
  final File file;
  final InformeCumplimientoModel model;
  CreateInformeCumplimientoEvt({required this.file, required this.model});
}

class DeleteInformeCumplimientoEvt extends InformeCumplimientoEvent {
  final String id;
  DeleteInformeCumplimientoEvt(this.id);
}

class FiltrosEvt extends InformeCumplimientoEvent {
  final String nombre;
  final String year;
  final String tipo;
  final bool isPlan;
  FiltrosEvt(this.nombre, this.year, this.tipo, this.isPlan);
}
