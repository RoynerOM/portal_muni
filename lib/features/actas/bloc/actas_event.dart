part of 'actas_bloc.dart';

abstract class ActasEvent {}

class LoadActasEvt extends ActasEvent {}

class CreateActaEvt extends ActasEvent {
  final File file;
  final ActaModel model;
  CreateActaEvt({required this.file, required this.model});
}

class CreateAcuerdoEvt extends ActasEvent {
  final File file;
  final AcuerdoModel model;
  CreateAcuerdoEvt({required this.file, required this.model});
}

class DeleteActaEvt extends ActasEvent {
  final String id;
  DeleteActaEvt(this.id);
}

class DeleteAcuerdoEvt extends ActasEvent {
  final String id;
  DeleteAcuerdoEvt(this.id);
}

class FiltrosActasEvt extends ActasEvent {
  final String nombre;
  final String year;
  final String tipo;
  FiltrosActasEvt(this.nombre, this.year, this.tipo);
}

class FiltrosAcuerdosEvt extends ActasEvent {
  final String nombre;
  final String year;
  final String actaId;
  FiltrosAcuerdosEvt(this.nombre, this.year, this.actaId);
}
