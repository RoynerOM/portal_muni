import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/enums/screens.dart';
import 'package:portal_muni/features/access/models/access_manager.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final AccesoManager manager;
  AccessBloc(this.manager) : super(AccessState(permisos: {})) {
    on<LoadAccess>(_onLoad);
    on<ChangeAccess>(_onChange);
  }

  Future<void> _onLoad(LoadAccess event, Emitter<AccessState> emit) async {
    emit(state.copyWith(loading: true));

    final permisos = manager.todos;

    emit(AccessState(permisos: permisos, loading: false));
  }

  Future<void> _onChange(ChangeAccess event, Emitter<AccessState> emit) async {
    await manager.setAcceso(event.screen, event.value);

    final updated = Map<AppScreens, bool>.from(state.permisos);
    updated[event.screen] = event.value;

    emit(state.copyWith(permisos: updated));
  }
}
