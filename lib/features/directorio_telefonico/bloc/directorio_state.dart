part of 'directorio_bloc.dart';

class DirectorioState<T> {
  final DirectorioReact? react;
  final List<ContactoModel> listDirectorio;
  final List<ContactoModel> filterListDirectorio;

  DirectorioState({
    this.react,
    this.listDirectorio = const [],
    this.filterListDirectorio = const [],
  });

  DirectorioState<T> copyWith(
    DirectorioState state, {
    DirectorioReact? react,
    List<ContactoModel>? listDirectorio,
    List<ContactoModel>? filterListDirectorio,
  }) =>
      DirectorioState<T>(
        react: react ?? state.react,
        listDirectorio: listDirectorio ?? state.listDirectorio,
        filterListDirectorio:
            filterListDirectorio ?? state.filterListDirectorio,
      );
}

enum DirectorioReact {
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

  updateLoading,
  updateSuccess,
  updateError,
}
