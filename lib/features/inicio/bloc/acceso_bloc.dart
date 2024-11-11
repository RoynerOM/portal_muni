import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/enums/screens.dart';

part 'acceso_event.dart';
part 'acceso_state.dart';

class AccesoBloc extends Bloc<AccesoEvent, AccesoState> {
  AccesoBloc() : super(AccesoState()) {
    on<CargarAccesosEvent>((event, emit) async {
      final list = await cargarAccesos();
      emit(AccesoState().copyWith(state, accesos: list));
    });
  }

  Future<List<AppScreens>> cargarAccesos() async {
    try {
      final file = File('C:/config.json');
      if (!await file.exists()) {
        if (kDebugMode) {
          print("El archivo no existe en la ruta especificada.");
        }
        return [];
      }
      final contenido = await file.readAsString();

      final jsonData = json.decode(contenido);

      List<AppScreens> accesos = [];
      for (var acceso in jsonData['accesos']) {
        accesos.add(AppScreens.values.firstWhere((x) => x.name == acceso));
      }
      return accesos;
    } catch (e) {
      return [];
    }
  }
}
