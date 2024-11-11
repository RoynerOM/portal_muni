import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

void go(BuildContext context, {required Widget to}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => to),
  );
}

void back(BuildContext context) {
  Navigator.pop(context);
}

void console(input) {
  if (kDebugMode) {
    print(input);
  }
}

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).flatMap(mapper);
  };
}

TimeOfDay durationToTimeOfDay(Duration duration) {
  int minutosTotales = duration.inMinutes;
  int horas = minutosTotales ~/ 60;
  int minutos = minutosTotales % 60;

  return TimeOfDay(hour: horas, minute: minutos);
}

List<String> textToList(String text) {
  List<String> elementos =
      text.replaceAll('[', '').replaceAll(']', '').split(',');

  List<String> listaResultante = elementos.map((elemento) {
    return elemento.trim();
  }).toList();

  return listaResultante;
}
