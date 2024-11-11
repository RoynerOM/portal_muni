part of 'presupuesto_bloc.dart';

abstract class PresupuestoEvent {}

class LoadPresupuestoEvent extends PresupuestoEvent {}

class CreatePresupuestoEvent extends PresupuestoEvent {
  final File file;
  final PresupuestoModel model;
  CreatePresupuestoEvent({required this.file, required this.model});
}

class DeletePresupuestoEvent extends PresupuestoEvent {
  final String id;
  DeletePresupuestoEvent(this.id);
}

class FiltrosEvent extends PresupuestoEvent {
  final String nombre;
  final String tipo;
  FiltrosEvent(this.nombre, this.tipo);
}
