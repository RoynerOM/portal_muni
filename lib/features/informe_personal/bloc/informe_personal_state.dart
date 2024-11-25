part of 'informe_personal_bloc.dart';

class InformePersonalState<T> {
  final InformePersonalReact? react;
  final List<InformePersonalModel> list;
  final List<InformePersonalModel> filterList;

  InformePersonalState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  InformePersonalState<T> copyWith(
    InformePersonalState state, {
    InformePersonalReact? react,
    List<InformePersonalModel>? list,
    List<InformePersonalModel>? filterList,
  }) =>
      InformePersonalState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum InformePersonalReact {
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
