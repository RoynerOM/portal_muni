import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/presupuesto/models/presupuesto_model.dart';
import 'package:portal_muni/features/presupuesto/repository/presupuesto_repo.dart';

part 'presupuesto_event.dart';
part 'presupuesto_state.dart';

typedef React = AttractionsReact;
typedef Emit = Emitter<PresupuestoState>;

class PresupuestoBloc extends Bloc<PresupuestoEvent, PresupuestoState> {
  final PresupuestoRepository repository;
  PresupuestoBloc(this.repository)
      : super(PresupuestoState(react: React.initial)) {
    on<CreatePresupuestoEvent>((event, emit) async {
      emit(PresupuestoState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(PresupuestoState().copyWith(state, react: React.postSuccess));
        add(LoadPresupuestoEvent());
      } catch (e) {
        emit(PresupuestoState().copyWith(state, react: React.postError));
      }
    });
    on<LoadPresupuestoEvent>((event, emit) async {
      emit(PresupuestoState().copyWith(state, react: React.getLoading));
      await cargarPresupuestos(event, emit);
    });
    on<DeletePresupuestoEvent>((event, emit) async {
      emit(PresupuestoState().copyWith(state, react: React.deleteLoading));
      await eliminarPresupuesto(event, emit);
    });

    on<FiltrosEvent>((event, emit) async {
      emit(PresupuestoState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarPresupuestos(LoadPresupuestoEvent evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        PresupuestoState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(PresupuestoState(react: React.getError));
    }
  }

  Future<void> filtros(FiltrosEvent evt, Emit emit) async {
    final nombreFiltro = evt.nombre.toLowerCase();
    final tipoFiltro = evt.tipo.toLowerCase();

    try {
      final filter = state.list.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(nombreFiltro);
        final coincideTipo = x.categoria.toLowerCase() == (tipoFiltro);

        if (tipoFiltro == 'todos') {
          return coincideNombre || coincideTipo;
        } else {
          final coincideTipo = x.categoria.toLowerCase() == (tipoFiltro);
          return coincideNombre && coincideTipo;
        }
      }).toList();

      emit(
        PresupuestoState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(PresupuestoState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarPresupuesto(
      DeletePresupuestoEvent evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(PresupuestoState().copyWith(state, react: React.deleteSuccess));
      add(LoadPresupuestoEvent());
    } catch (e) {
      emit(PresupuestoState(react: React.getError));
    }
  }
}
