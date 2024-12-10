import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/informe_cumplimiento/models/informe_cumplimiento_model.dart';
import 'package:portal_muni/features/informe_cumplimiento/repository/informe_cumplimiento_repo.dart';

part 'informe_cumplimiento_event.dart';
part 'informe_cumplimiento_state.dart';

typedef React = InformeCmplReact;
typedef Emit = Emitter<InformeCumplimientoState>;

class InformeCumplimientoBloc
    extends Bloc<InformeCumplimientoEvent, InformeCumplimientoState> {
  final InformeCumplimientoRepo repository;
  InformeCumplimientoBloc(this.repository)
      : super(InformeCumplimientoState(react: React.initial)) {
    on<LoadInformeCumplimientoEvt>((event, emit) async {
      emit(InformeCumplimientoState().copyWith(state, react: React.getLoading));
      await cargarInformes(event, emit);
    });
    on<LoadInformeAuditoriaEvt>((event, emit) async {
      emit(InformeCumplimientoState().copyWith(state, react: React.getLoading));
      await cargarInformeAuditoria(event, emit);
    });

    on<LoadInformeRRHHEvt>((event, emit) async {
      emit(InformeCumplimientoState().copyWith(state, react: React.getLoading));
      await cargarInformeRRHH(event, emit);
    });
    on<CreateInformeCumplimientoEvt>((event, emit) async {
      emit(
          InformeCumplimientoState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(InformeCumplimientoState()
            .copyWith(state, react: React.postSuccess));
        add(LoadInformeCumplimientoEvt());
      } catch (e) {
        emit(
            InformeCumplimientoState().copyWith(state, react: React.postError));
      }
    });
    on<DeleteInformeCumplimientoEvt>((event, emit) async {
      emit(InformeCumplimientoState()
          .copyWith(state, react: React.deleteLoading));
      await eliminarInforme(event, emit);
    });
    on<FiltrosEvt>((event, emit) async {
      emit(InformeCumplimientoState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarInformes(LoadInformeCumplimientoEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where((x) =>
              x.tipo != 'Informe final de gestión' ||
              x.tipo != 'Informes de seguimiento a las recomendaciones')
          .toList();

      emit(
        InformeCumplimientoState(
          react: React.getSuccess,
          list: filter,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeCumplimientoState(react: React.getError));
    }
  }

  Future<void> cargarInformeAuditoria(
      LoadInformeAuditoriaEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where((x) =>
              x.tipo.contains('Informes de seguimiento a las recomendaciones'))
          .toList();

      emit(
        InformeCumplimientoState(
          react: React.getSuccess,
          list: filter,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeCumplimientoState(react: React.getError));
    }
  }

  Future<void> cargarInformeRRHH(LoadInformeRRHHEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where((x) => x.tipo.contains('Informe final de gestión'))
          .toList();

      emit(
        InformeCumplimientoState(
          react: React.getSuccess,
          list: filter,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeCumplimientoState(react: React.getError));
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
        InformeCumplimientoState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(InformeCumplimientoState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarInforme(
      DeleteInformeCumplimientoEvt evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(InformeCumplimientoState()
          .copyWith(state, react: React.deleteSuccess));
      add(LoadInformeCumplimientoEvt());
    } catch (e) {
      emit(InformeCumplimientoState(react: React.getError));
    }
  }
}
