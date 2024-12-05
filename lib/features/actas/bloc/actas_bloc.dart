import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/actas/models/acta_model.dart';
import 'package:portal_muni/features/actas/models/acuerdo_model.dart';
import 'package:portal_muni/features/actas/repository/actas_repo.dart';
import 'package:portal_muni/features/actas/repository/acuerdo_repo.dart';

part 'actas_event.dart';
part 'actas_state.dart';

typedef Emit = Emitter<ActasState>;

class ActasBloc extends Bloc<ActasEvent, ActasState> {
  final ActasRepo actaRepo;
  final AcuerdoRepo acuerdoRepo;
  ActasBloc(this.actaRepo, this.acuerdoRepo)
      : super(ActasState(react: ActasReact.initial)) {
    on<LoadActasEvt>((event, emit) async {
      emit(ActasState().copyWith(state, react: ActasReact.getLoading));
      await cargarActas(event, emit);
    });
    on<CreateActaEvt>((event, emit) async {
      emit(ActasState().copyWith(state, react: ActasReact.postLoading));
      try {
        await actaRepo.post(event.file, event.model);
        emit(ActasState().copyWith(state, react: ActasReact.postSuccess));
        add(LoadActasEvt());
      } catch (e) {
        emit(ActasState().copyWith(state, react: ActasReact.postError));
      }
    });
    on<DeleteActaEvt>((event, emit) async {
      emit(ActasState().copyWith(state, react: ActasReact.deleteLoading));
      await eliminarInforme(event, emit);
    });
    on<FiltrosActasEvt>((event, emit) async {
      emit(ActasState().copyWith(state, react: ActasReact.getLoading));
      await filtrosActas(event, emit);
    });
  }

  Future<void> cargarActas(LoadActasEvt evt, Emit emit) async {
    try {
      final list = await actaRepo.getAll();

      emit(
        ActasState(
          react: ActasReact.getSuccess,
          listActas: list,
          filterListActas: list,
        ),
      );
    } catch (e) {
      emit(ActasState(react: ActasReact.getError));
    }
  }

  Future<void> filtrosActas(FiltrosActasEvt evt, Emit emit) async {
    final nombreFiltro = evt.nombre.toLowerCase();
    final tipoFilter = evt.tipo.toLowerCase();
    final yearFilter = evt.year.toLowerCase();
    try {
      final filter = state.listActas.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(nombreFiltro);
        final coincideTipo = x.tipo.toLowerCase() == (tipoFilter);
        final coincideYear = x.year.toLowerCase() == (yearFilter);
        return coincideNombre && coincideTipo && coincideYear;
      }).toList();

      emit(
        ActasState().copyWith(
          state,
          react: ActasReact.getSuccess,
          list: state.listActas,
          filterListActas: filter,
        ),
      );
    } catch (e) {
      emit(ActasState(react: ActasReact.getError).copyWith(state));
    }
  }

  Future<void> eliminarInforme(DeleteActaEvt evt, Emit emit) async {
    try {
      await actaRepo.delete(evt.id);
      emit(ActasState().copyWith(state, react: ActasReact.deleteSuccess));
      add(LoadActasEvt());
    } catch (e) {
      emit(ActasState(react: ActasReact.getError));
    }
  }
}
