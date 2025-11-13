part of 'directorio_bloc.dart';

abstract class DirectorioEvent {}

class LoadDirectoriosEvt extends DirectorioEvent {}

class FiltrarDirectorioEvt extends DirectorioEvent {
  final String valor;
  FiltrarDirectorioEvt(this.valor);
}

class CreateDirectorioEvt extends DirectorioEvent {
  final ContactoModel model;
  CreateDirectorioEvt(this.model);
}

class DeleteDirectorioEvt extends DirectorioEvent {
  final String id;
  DeleteDirectorioEvt(this.id);
}

class GetByIdDirectorio extends DirectorioEvent {
  final String id;
  GetByIdDirectorio(this.id);
}

class UpdateDirectorioEvt extends DirectorioEvent {
  final ContactoModel model;
  UpdateDirectorioEvt(this.model);
}
