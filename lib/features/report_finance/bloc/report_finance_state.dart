part of 'report_finance_bloc.dart';

class ReportFinanceState {
  final ReportReact? react;
  final List<ReportFinanceModel> list;
  final List<ReportFinanceModel> filterList;

  ReportFinanceState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  ReportFinanceState copyWith(
    ReportFinanceState state, {
    ReportReact? react,
    List<ReportFinanceModel>? list,
    List<ReportFinanceModel>? filterList,
  }) =>
      ReportFinanceState(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum ReportReact {
  initial,
  getLoading,
  getSuccess,
  getError,

  postLoading,
  postSuccess,
  postError,

  deleteLoading,
  deleteSuccess,
  deleteError,
}
