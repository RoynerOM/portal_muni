part of 'presupuesto_bloc.dart';

class PresupuestoState<T> {
  final AttractionsReact? react;
  final List<PresupuestoModel> list;
  final List<PresupuestoModel> filterList;

  PresupuestoState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  PresupuestoState<T> copyWith(
    PresupuestoState state, {
    AttractionsReact? react,
    List<PresupuestoModel>? list,
    List<PresupuestoModel>? filterList,
  }) =>
      PresupuestoState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum AttractionsReact {
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
