part of 'informe_cumplimiento_bloc.dart';

class InformeCumplimientoState<T> {
  final InformeCmplReact? react;
  final List<InformeCumplimientoModel> list;
  final List<InformeCumplimientoModel> filterList;

  InformeCumplimientoState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  InformeCumplimientoState<T> copyWith(
    InformeCumplimientoState state, {
    InformeCmplReact? react,
    List<InformeCumplimientoModel>? list,
    List<InformeCumplimientoModel>? filterList,
  }) =>
      InformeCumplimientoState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum InformeCmplReact {
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
