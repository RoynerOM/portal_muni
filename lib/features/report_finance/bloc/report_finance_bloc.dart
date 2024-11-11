import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/report_finance/models/report_finance_model.dart';
import 'package:portal_muni/features/report_finance/repository/report_finance_repo.dart';

part 'report_finance_event.dart';
part 'report_finance_state.dart';

typedef React = ReportReact;
typedef Emit = Emitter<ReportFinanceState>;

class ReportFinanceBloc extends Bloc<ReportFinanceEvent, ReportFinanceState> {
  final ReportFinanceRepo repository;
  ReportFinanceBloc(this.repository)
      : super(ReportFinanceState(react: React.initial)) {
    on<CreateReportFinanceEvt>((event, emit) async {
      emit(ReportFinanceState().copyWith(state, react: React.postLoading));
      try {
        await repository.post(event.file, event.model);
        emit(ReportFinanceState().copyWith(state, react: React.postSuccess));
        add(LoadReportFinanceEvt());
      } catch (e) {
        emit(ReportFinanceState().copyWith(state, react: React.postError));
      }
    });
    on<LoadReportFinanceEvt>((event, emit) async {
      emit(ReportFinanceState().copyWith(state, react: React.getLoading));
      await cargarPresupuestos(event, emit);
    });
    on<DeleteReportFinanceEvt>((event, emit) async {
      emit(ReportFinanceState().copyWith(state, react: React.deleteLoading));
      await eliminarPresupuesto(event, emit);
    });

    on<FiltrosEvent>((event, emit) async {
      emit(ReportFinanceState().copyWith(state, react: React.getLoading));
      await filtros(event, emit);
    });
  }

  Future<void> cargarPresupuestos(LoadReportFinanceEvt evt, Emit emit) async {
    try {
      final list = await repository.getAll();

      emit(
        ReportFinanceState(
          react: React.getSuccess,
          list: list,
          filterList: list,
        ),
      );
    } catch (e) {
      emit(ReportFinanceState(react: React.getError));
    }
  }

  Future<void> filtros(FiltrosEvent evt, Emit emit) async {
    final nombreFiltro = evt.nombre.toLowerCase();

    try {
      final filter = state.list.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(nombreFiltro);
        return coincideNombre;
      }).toList();

      emit(
        ReportFinanceState().copyWith(
          state,
          react: React.getSuccess,
          list: state.list,
          filterList: filter,
        ),
      );
    } catch (e) {
      emit(ReportFinanceState(react: React.getError).copyWith(state));
    }
  }

  Future<void> eliminarPresupuesto(
      DeleteReportFinanceEvt evt, Emit emit) async {
    try {
      await repository.delete(evt.id);
      emit(ReportFinanceState().copyWith(state, react: React.deleteSuccess));
      add(LoadReportFinanceEvt());
    } catch (e) {
      emit(ReportFinanceState(react: React.getError));
    }
  }
}
