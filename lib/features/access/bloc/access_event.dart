part of 'access_bloc.dart';

abstract class AccessEvent {}

class LoadAccess extends AccessEvent {}

class ChangeAccess extends AccessEvent {
  final AppScreens screen;
  final bool value;

  ChangeAccess(this.screen, this.value);
}
