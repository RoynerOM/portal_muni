import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/ejecucion/models/ejecucion_model.dart';
import 'package:portal_muni/features/ejecucion/repository/ejecucion_repository.dart';

part 'ejecucion_event.dart';
part 'ejecucion_state.dart';

typedef React = EjecucionesReact;
typedef Emit = Emitter<EjecucionState>;

class EjecucionBloc extends Bloc<EjecucionEvent, EjecucionState> {
  final EjecucionRepository repository;
  EjecucionBloc(this.repository) : super(EjecucionState(react: React.initial)) {
    on<CreateEjecucionEvent>((event, emit) async {
      emit(EjecucionState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(EjecucionState().copyWith(state, react: React.postSuccess));
        add(LoadEjeucionesEvent());
      } catch (e) {
        emit(EjecucionState().copyWith(state, react: React.postError));
      }
    });
    on<LoadEjeucionesEvent>((event, emit) async {
      emit(EjecucionState().copyWith(state, react: React.getLoading));
      await cargarEjecuciones(event, emit);
    });
    on<DeleteEjecucionEvent>((event, emit) async {
      emit(EjecucionState().copyWith(state, react: React.deleteLoading));
      await eliminarEjecucion(event, emit);
    });

    on<FiltrosEvent>((event, emit) async {
      emit(EjecucionState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarEjecuciones(LoadEjeucionesEvent evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        EjecucionState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(EjecucionState(react: React.getError));
    }
  }

  Future<void> filtros(FiltrosEvent evt, Emit emit) async {
    final nombreFiltro = evt.nombre.toLowerCase();
    final tipoFiltro = getTipo(evt.tipo);
    try {
      final filter = state.list.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(nombreFiltro);
        final coincideTipo = x.tipo.toLowerCase() == (tipoFiltro);

        if (tipoFiltro == 'todos') {
          return coincideNombre || coincideTipo;
        } else if (tipoFiltro == 'HA') {
          final coincideTipo = x.esHistorico.toLowerCase().contains('1');
          return coincideNombre && coincideTipo;
        } else if (tipoFiltro == 'auditorías') {
          final coincideTipo = x.tipo.toLowerCase().contains(tipoFiltro);
          final coincideH = x.esHistorico.toLowerCase().contains('0');
          return coincideNombre && coincideTipo && coincideH;
        } else {
          final coincideTipo = x.tipo.toLowerCase().contains(tipoFiltro);
          return coincideNombre && coincideTipo;
        }
      }).toList();

      emit(
        EjecucionState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(EjecucionState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarEjecucion(DeleteEjecucionEvent evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(EjecucionState().copyWith(state, react: React.deleteSuccess));
      add(LoadEjeucionesEvent());
    } catch (e) {
      emit(EjecucionState(react: React.getError));
    }
  }

  String getTipo(String value) {
    if (value == 'Informes parciales de ejecución') {
      return 'parcial';
    } else if (value == 'Informe de fin de año') {
      return 'final';
    } else if (value == 'Histórico de presupuesto aprobado y ejecutado') {
      return 'histórico';
    } else if (value == 'Auditorías del gasto público') {
      return 'auditorías';
    } else if (value == 'Todos') {
      return 'todos';
    } else {
      return 'HA';
    }
  }
}
