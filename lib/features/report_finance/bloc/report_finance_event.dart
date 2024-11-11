part of 'report_finance_bloc.dart';

abstract class ReportFinanceEvent {}

class LoadReportFinanceEvt extends ReportFinanceEvent {}

class CreateReportFinanceEvt extends ReportFinanceEvent {
  final File file;
  final ReportFinanceModel model;
  CreateReportFinanceEvt({required this.file, required this.model});
}

class DeleteReportFinanceEvt extends ReportFinanceEvent {
  final String id;
  DeleteReportFinanceEvt(this.id);
}

class FiltrosEvent extends ReportFinanceEvent {
  final String nombre;
  final String tipo;
  FiltrosEvent(this.nombre, this.tipo);
}
