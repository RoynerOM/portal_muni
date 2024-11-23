part of 'informe_institucional_bloc.dart';

class InformeInstitucionalState<T> {
  final InformeInsReact? react;
  final List<InformeInstModel> list;
  final List<InformeInstModel> filterList;

  InformeInstitucionalState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  InformeInstitucionalState<T> copyWith(
    InformeInstitucionalState state, {
    InformeInsReact? react,
    List<InformeInstModel>? list,
    List<InformeInstModel>? filterList,
  }) =>
      InformeInstitucionalState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum InformeInsReact {
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
