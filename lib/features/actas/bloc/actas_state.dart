part of 'actas_bloc.dart';

class ActasState<T> {
  final ActasReact? react;
  final List<ActaModel> listActas;
  final List<ActaModel> filterListActas;
  final List<AcuerdoModel> listAcuerdos;
  final List<AcuerdoModel> filterListAcuerdos;

  ActasState({
    this.react,
    this.listActas = const [],
    this.filterListActas = const [],
    this.listAcuerdos = const [],
    this.filterListAcuerdos = const [],
  });

  ActasState<T> copyWith(
    ActasState state, {
    ActasReact? react,
    List<ActaModel>? list,
    List<ActaModel>? filterListActas,
    List<AcuerdoModel>? listAcuerdos,
    List<AcuerdoModel>? filterListAcuerdos,
  }) =>
      ActasState<T>(
        react: react ?? state.react,
        listActas: list ?? state.listActas,
        filterListActas: filterListActas ?? state.filterListActas,
        listAcuerdos: listAcuerdos ?? state.listAcuerdos,
        filterListAcuerdos: filterListAcuerdos ?? state.filterListAcuerdos,
      );
}

enum ActasReact {
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
