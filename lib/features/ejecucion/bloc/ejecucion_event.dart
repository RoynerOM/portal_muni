part of 'ejecucion_bloc.dart';

abstract class EjecucionEvent {}

class LoadEjeucionesEvent extends EjecucionEvent {}

class CreateEjecucionEvent extends EjecucionEvent {
  final File file;
  final EjecucionModel model;
  CreateEjecucionEvent({required this.file, required this.model});
}

class DeleteEjecucionEvent extends EjecucionEvent {
  final String id;
  DeleteEjecucionEvent(this.id);
}

class FiltrosEvent extends EjecucionEvent {
  final String nombre;
  final String tipo;
  FiltrosEvent(this.nombre, this.tipo);
}
