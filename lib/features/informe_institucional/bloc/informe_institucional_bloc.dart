import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/informe_institucional/models/informe_ins_model.dart';
import 'package:portal_muni/features/informe_institucional/repository/informe_inst_repo.dart';

part 'informe_institucional_event.dart';
part 'informe_institucional_state.dart';

typedef React = InformeInsReact;
typedef Emit = Emitter<InformeInstitucionalState>;

class InformeInstitucionalBloc
    extends Bloc<InformeInstitucionalEvent, InformeInstitucionalState> {
  final InformeInstRepo repository;
  InformeInstitucionalBloc(this.repository)
      : super(InformeInstitucionalState()) {
    on<CreateInformeInstitucionalEvt>((event, emit) async {
      emit(InformeInstitucionalState()
          .copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(InformeInstitucionalState()
            .copyWith(state, react: React.postSuccess));
        add(LoadInformeInstitucionalEvt());
      } catch (e) {
        emit(InformeInstitucionalState()
            .copyWith(state, react: React.postError));
      }
    });
    on<LoadInformeInstitucionalEvt>((event, emit) async {
      emit(
          InformeInstitucionalState().copyWith(state, react: React.getLoading));
      await cargarInformes(event, emit);
    });
    on<DeleteInformeInstitucionalEvt>((event, emit) async {
      emit(InformeInstitucionalState()
          .copyWith(state, react: React.deleteLoading));
      await eliminarInforme(event, emit);
    });

    on<FiltrosEvt>((event, emit) async {
      emit(
          InformeInstitucionalState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }
/*
  Future<void> cargarInformes(
      LoadInformeInstitucionalEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        InformeInstitucionalState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError));
    }
  }
*/

//AUDITORIA
/*
  Future<void> cargarInformes(
      LoadInformeInstitucionalEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where(
            (x) => x.tipo.contains('Especial') || x.tipo.contains('Anual'),
          )
          .toList();

      emit(
        InformeInstitucionalState(
          react: React.getSuccess,
          list: filter,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError));
    }
  }
*/
//ARCHIVO
  Future<void> cargarInformes(
      LoadInformeInstitucionalEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where(
            (x) => x.tipo.contains('Archivo'),
          )
          .toList();

      emit(
        InformeInstitucionalState(
          react: React.getSuccess,
          list: filter,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError));
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
        InformeInstitucionalState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarInforme(
      DeleteInformeInstitucionalEvt evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(InformeInstitucionalState()
          .copyWith(state, react: React.deleteSuccess));
      add(LoadInformeInstitucionalEvt());
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError));
    }
  }
}
