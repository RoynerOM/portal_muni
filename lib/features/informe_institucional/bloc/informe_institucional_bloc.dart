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

        if (event.model.tipo == "Especial") {
          add(LoadInformeEspecialAuditoriaEvt());
        }

        if (event.model.tipo == "Anual") {
          add(LoadInformeAnualAuditoriaEvt());
        }
      } catch (e) {
        emit(InformeInstitucionalState()
            .copyWith(state, react: React.postError));
      }
    });
    on<LoadInformeHistoricoEvt>((event, emit) async {
      emit(
          InformeInstitucionalState().copyWith(state, react: React.getLoading));
      await cargarInformesHistoricos(event, emit);
    });

    on<LoadInformeEspecialAuditoriaEvt>((event, emit) async {
      emit(
          InformeInstitucionalState().copyWith(state, react: React.getLoading));
      await cargarInformesEspecialAuditoria(event, emit);
    });

    on<LoadInformeAnualAuditoriaEvt>((event, emit) async {
      emit(
          InformeInstitucionalState().copyWith(state, react: React.getLoading));
      await cargarInformesAnualAuditoria(event, emit);
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

  Future<void> cargarInformesHistoricos(
      LoadInformeHistoricoEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      final filter = list
          .where((x) => x.tipo.contains('Especial') || x.tipo.contains('Anual'))
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

//AUDITORIA

  Future<void> cargarInformesEspecialAuditoria(
      LoadInformeEspecialAuditoriaEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list.where((x) => x.tipo.contains('Especial')).toList();

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

  Future<void> cargarInformesAnualAuditoria(
      LoadInformeAnualAuditoriaEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list.where((x) => x.tipo.contains('Anual')).toList();

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

// Cambiar a Arhivo o Calificación de personal
  Future<void> cargarInformesRRHH(
      LoadInformeHistoricoEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();
      final filter = list
          .where(
            (x) => x.tipo.contains('Calificación de personal'),
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
        final coincideTipo = tipoFilter.toLowerCase() == 'todos'
            ? ['especial', 'anual'].contains(x.tipo.toLowerCase())
            : x.tipo.toLowerCase() == (tipoFilter);
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
      if (evt.type == "Especial") {
        add(LoadInformeEspecialAuditoriaEvt());
      }

      if (evt.type == "Anual") {
        add(LoadInformeAnualAuditoriaEvt());
      }
    } catch (e) {
      emit(InformeInstitucionalState(react: React.getError));
    }
  }
}
