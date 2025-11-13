import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/features/directorio_telefonico/models/contacto_model.dart';
import 'package:portal_muni/features/directorio_telefonico/respository/directorio_repo.dart';

part 'directorio_event.dart';
part 'directorio_state.dart';

typedef Emit = Emitter<DirectorioState>;

class DirectorioBloc extends Bloc<DirectorioEvent, DirectorioState> {
  final DirectorioRepo repo;
  DirectorioBloc(this.repo)
      : super(DirectorioState(react: DirectorioReact.initial)) {
    on<LoadDirectoriosEvt>((event, emit) async {
      emit(
          DirectorioState().copyWith(state, react: DirectorioReact.getLoading));
      await cargarDirectorios(event, emit);
    });
    on<FiltrarDirectorioEvt>((event, emit) async {
      emit(
          DirectorioState().copyWith(state, react: DirectorioReact.getLoading));
      await filtrosDirectorio(event, emit);
    });

    on<CreateDirectorioEvt>((event, emit) async {
      emit(
        DirectorioState().copyWith(state, react: DirectorioReact.postLoading),
      );
      await onPostDirectorio(event, emit);
    });

    on<DeleteDirectorioEvt>((event, emit) async {
      emit(
        DirectorioState().copyWith(state, react: DirectorioReact.deleteLoading),
      );
      await onDeleteDirectorio(event, emit);
    });

    on<UpdateDirectorioEvt>((event, emit) async {
      emit(
        DirectorioState().copyWith(state, react: DirectorioReact.updateLoading),
      );
      await onPutDirectorio(event, emit);
    });
  }

  // Registrar un directorio

  Future<void> onPostDirectorio(CreateDirectorioEvt evt, Emit emit) async {
    try {
      await repo.post(evt.model);
      emit(DirectorioState()
          .copyWith(state, react: DirectorioReact.postSuccess));
      add(LoadDirectoriosEvt());
    } catch (e) {
      emit(DirectorioState(react: DirectorioReact.postError));
    }
  }

  // Eliminar un directorio

  Future<void> onDeleteDirectorio(DeleteDirectorioEvt evt, Emit emit) async {
    try {
      await repo.delete(evt.id);
      emit(DirectorioState()
          .copyWith(state, react: DirectorioReact.deleteSuccess));
      add(LoadDirectoriosEvt());
    } catch (e) {
      emit(DirectorioState(react: DirectorioReact.deleteError));
    }
  }

// Listar todos los directorios
  Future<void> cargarDirectorios(LoadDirectoriosEvt evt, Emit emit) async {
    try {
      final list = await repo.getAll();

      emit(
        DirectorioState(
          react: DirectorioReact.getSuccess,
          listDirectorio: list,
          filterListDirectorio: list,
        ),
      );
    } catch (e) {
      emit(DirectorioState(react: DirectorioReact.getError));
    }
  }

// Modificar un directorio
  Future<void> onPutDirectorio(UpdateDirectorioEvt evt, Emit emit) async {
    try {
      await repo.put(evt.model);
      emit(DirectorioState()
          .copyWith(state, react: DirectorioReact.updateSuccess));
      add(LoadDirectoriosEvt());
    } catch (e) {
      emit(DirectorioState(react: DirectorioReact.updateError));
    }
  }

  Future<void> filtrosDirectorio(FiltrarDirectorioEvt evt, Emit emit) async {
    final valor = evt.valor.toLowerCase();

    try {
      final filter = state.listDirectorio.where((x) {
        final coincideNombre = x.nombre.toLowerCase().contains(valor);
        final coincideTipo = x.departamento.toLowerCase().contains(valor);
        final coincideYear = x.email.toLowerCase().contains(valor);
        return coincideNombre || coincideTipo || coincideYear;
      }).toList();

      emit(
        DirectorioState().copyWith(
          state,
          react: DirectorioReact.getSuccess,
          listDirectorio: state.listDirectorio,
          filterListDirectorio: filter,
        ),
      );
    } catch (e) {
      emit(DirectorioState(react: DirectorioReact.getError).copyWith(state));
    }
  }
}
