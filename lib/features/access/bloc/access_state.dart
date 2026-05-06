part of 'access_bloc.dart';

class AccessState {
  final Map<AppScreens, bool> permisos;
  final bool loading;

  AccessState({
    required this.permisos,
    this.loading = false,
  });

  AccessState copyWith({
    Map<AppScreens, bool>? permisos,
    bool? loading,
  }) {
    return AccessState(
      permisos: permisos ?? this.permisos,
      loading: loading ?? this.loading,
    );
  }
}
