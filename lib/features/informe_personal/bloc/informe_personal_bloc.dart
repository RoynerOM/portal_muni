import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/informe_personal/models/informe_personal_model.dart';
import 'package:portal_muni/features/informe_personal/repository/informe_personal_repo.dart';

part 'informe_personal_event.dart';
part 'informe_personal_state.dart';

typedef React = InformePersonalReact;
typedef Emit = Emitter<InformePersonalState>;

class InformePersonalBloc
    extends Bloc<InformePersonalEvent, InformePersonalState> {
  final InformePersonalRepo repository;
  InformePersonalBloc(this.repository) : super(InformePersonalState()) {
    on<CreateInformePersonalEvt>((event, emit) async {
      emit(InformePersonalState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(InformePersonalState().copyWith(state, react: React.postSuccess));
        add(LoadInformePersonalEvt());
      } catch (e) {
        emit(InformePersonalState().copyWith(state, react: React.postError));
      }
    });
    on<LoadInformePersonalEvt>((event, emit) async {
      emit(InformePersonalState().copyWith(state, react: React.getLoading));
      await cargarInformes(event, emit);
    });
    on<DeleteInformePersonalEvt>((event, emit) async {
      emit(InformePersonalState().copyWith(state, react: React.deleteLoading));
      await eliminarInforme(event, emit);
    });

    on<FiltrosEvt>((event, emit) async {
      print(event.nombre);
      print(event.year);
      print(event.tipo);
      emit(InformePersonalState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarInformes(LoadInformePersonalEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        InformePersonalState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(InformePersonalState(react: React.getError));
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
        InformePersonalState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformePersonalState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarInforme(DeleteInformePersonalEvt evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(InformePersonalState().copyWith(state, react: React.deleteSuccess));
      add(LoadInformePersonalEvt());
    } catch (e) {
      emit(InformePersonalState(react: React.getError));
    }
  }
}
