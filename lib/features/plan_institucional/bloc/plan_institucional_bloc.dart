import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/plan_institucional/models/plan_institucional_model.dart';
import 'package:portal_muni/features/plan_institucional/repository/plan_institucional_repo.dart';

part 'plan_institucional_event.dart';
part 'plan_institucional_state.dart';

typedef React = PlanInsReact;
typedef Emit = Emitter<PlanInstitucionalState>;

class PlanInstitucionalBloc
    extends Bloc<PlanInstitucionalEvent, PlanInstitucionalState> {
  final PlanInstitucionalRepo repository;
  PlanInstitucionalBloc(this.repository)
      : super(PlanInstitucionalState(react: React.initial)) {
    on<CreatePlanInstitucionalEvt>((event, emit) async {
      emit(PlanInstitucionalState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(
            PlanInstitucionalState().copyWith(state, react: React.postSuccess));
        add(LoadPlanInstitucionalEvt());
      } catch (e) {
        emit(PlanInstitucionalState().copyWith(state, react: React.postError));
      }
    });
    on<LoadPlanInstitucionalEvt>((event, emit) async {
      emit(PlanInstitucionalState().copyWith(state, react: React.getLoading));
      await cargarEjecuciones(event, emit);
    });
    on<DeletePlanInstitucionalEvt>((event, emit) async {
      emit(
          PlanInstitucionalState().copyWith(state, react: React.deleteLoading));
      await eliminarEjecucion(event, emit);
    });

    on<FiltrosEvt>((event, emit) async {
      emit(PlanInstitucionalState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarEjecuciones(
      LoadPlanInstitucionalEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        PlanInstitucionalState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(PlanInstitucionalState(react: React.getError));
    }
  }

  Future<void> filtros(FiltrosEvt evt, Emit emit) async {
    final nombreFiltro = evt.nombre.toLowerCase();
    final tipoFilter = evt.tipo.toLowerCase();
    final yearFilter = evt.year.toLowerCase();
    try {
      final filter = state.list.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(nombreFiltro);
        final coincideTipo = x.tipo.toLowerCase() == (tipoFilter);
        final coincideYear = x.year.toLowerCase() == (yearFilter);
        return coincideNombre && coincideTipo && coincideYear;
      }).toList();

      emit(
        PlanInstitucionalState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(PlanInstitucionalState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarEjecucion(
      DeletePlanInstitucionalEvt evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(
          PlanInstitucionalState().copyWith(state, react: React.deleteSuccess));
      add(LoadPlanInstitucionalEvt());
    } catch (e) {
      emit(PlanInstitucionalState(react: React.getError));
    }
  }
}
