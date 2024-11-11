part of 'acceso_bloc.dart';

class AccesoState {
  final List<AppScreens> accesos;

  AccesoState({
    this.accesos = const [],
  });

  AccesoState copyWith(
    AccesoState state, {
    List<AppScreens>? accesos,
  }) =>
      AccesoState(
        accesos: accesos ?? state.accesos,
      );
}
