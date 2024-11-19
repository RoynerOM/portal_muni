part of 'plan_institucional_bloc.dart';

class PlanInstitucionalState<T> {
  final PlanInsReact? react;
  final List<PlanInstitucionalModel> list;
  final List<PlanInstitucionalModel> filterList;

  PlanInstitucionalState({
    this.react,
    this.list = const [],
    this.filterList = const [],
  });

  PlanInstitucionalState<T> copyWith(
    PlanInstitucionalState state, {
    PlanInsReact? react,
    List<PlanInstitucionalModel>? list,
    List<PlanInstitucionalModel>? filterList,
  }) =>
      PlanInstitucionalState<T>(
        react: react ?? state.react,
        list: list ?? state.list,
        filterList: filterList ?? state.filterList,
      );
}

enum PlanInsReact {
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
