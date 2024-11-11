part of 'ejecucion_bloc.dart';

class EjecucionState<T> {
  final EjecucionesReact? react;
  final List<EjecucionModel> list;
  final List<EjecucionModel> filterList;

  EjecucionState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  EjecucionState<T> copyWith(
    EjecucionState state, {
    EjecucionesReact? react,
    List<EjecucionModel>? list,
    List<EjecucionModel>? filterList,
  }) =>
      EjecucionState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum EjecucionesReact {
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
