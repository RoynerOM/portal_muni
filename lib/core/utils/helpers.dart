import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/core/enums/screens.dart';
import 'package:portal_muni/features/access/models/access_manager.dart';
import 'package:portal_muni/features/actas/pages/actas.dart';
import 'package:portal_muni/features/actas/pages/acuerdos.dart';
import 'package:portal_muni/features/directorio_telefonico/pages/lista_directorio.dart';
import 'package:portal_muni/features/ejecucion/pages/ejecuciones.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informe_auditoria.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informes_cumplimientos.dart';
import 'package:portal_muni/features/informe_institucional/pages/informe_historico.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_anuales.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_especiales.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_institucionales.dart';
import 'package:portal_muni/features/informe_personal/pages/informes_personal.dart';
import 'package:portal_muni/features/inicio/pages/gestion_financiero.dart';
import 'package:portal_muni/features/plan_institucional/pages/planes_institucionales.dart';
import 'package:portal_muni/features/presupuesto/pages/presupuesto.dart';
import 'package:portal_muni/features/report_finance/pages/registro_reporte.dart';
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

void showAlertError(BuildContext context, String title, String message) {
  Alert.error(context, title: title, message: message);
}

void showAlertSuccess(BuildContext context, String title, String message) {
  Alert.success(context, title: title, message: message, pop: true);
}

String formatFechaCorta(DateTime date) {
  // Formato corto: "Lun, 10 ago 2024"
  return 'Publicado el ${DateFormat('EEE, d MMM yyyy', 'es_ES').format(date)}';
}

int extraerNumero(String texto) {
  final match = RegExp(r'\d+').firstMatch(texto);
  return match != null ? int.parse(match.group(0)!) : 0;
}

final Map<AppScreens, WidgetBuilder> appRoutes = {
  AppScreens.finanzasPublicas: (_) => const FinanceroPage(),
  AppScreens.presupuestoProyectadoAprobado: (_) => const PresupuestoPage(),
  AppScreens.ejecucionPresupuesto: (_) => const EjecucionesPage(),
  AppScreens.reporteFinanciero: (_) => const RegistroReportePage(),
  //
  //AppScreens.planesCumplimiento: (_) => const InformesCumplimientos(),
  AppScreens.planesInstitucionales: (_) => const PlanesInstitucionales(),
  // AppScreens.planesEstrategicoMunicipal: (_) => const InformesCumplimientos(),
//  AppScreens.planesAnualOperativo: (_) => const InformesCumplimientos(),
//  AppScreens.planesSectoriales: (_) => const InformesCumplimientos(),
  // AppScreens.informesCumplimiento: (_) => const InformesCumplimientos(),
  // AppScreens.informeAnualGestion: (_) => const InformesCumplimientos(),
  // informesSeguimientoRecomendaciones
  AppScreens.cumplimientoPlanesInstitucionales: (_) =>
      const InformesCumplimientos(),
  AppScreens.informesSeguimientoRecomendaciones: (_) =>
      const InformeAuditoria(),
  //
  AppScreens.informesInstitucionales: (_) => const InformesInstitucionales(
        title: 'Informes Institucionales',
        type: 0,
      ),
  AppScreens.informesInstitucionalesEspecialesAuditoria: (_) =>
      const InformesEspecialesAuditoria(),
  AppScreens.informesAnualesAuditoria: (_) => const InformesAnualesAuditoria(),
  AppScreens.historicoInformesAuditoria: (_) =>
      const InformeHistoricoAuditoria(),
  AppScreens.informeArchivo: (_) => const ListaDirectorio(),
  AppScreens.informeCalificacionPersonal: (_) => const ListaDirectorio(),
  AppScreens.informesPersonalInstitucional: (_) => const InformesDePersonal(),
  //AppScreens.actividadesJerarcas: (_) => const InformesDePersonal(),
  //AppScreens.informesViajes: (_) => const InformesDePersonal(),
  AppScreens.directorioTelefonico: (_) => const ListaDirectorio(),
  //
  AppScreens.actas: (_) => const Actas(),
  AppScreens.acuerdos: (_) => const Acuerdos(),
};

void abrirPantalla(
  BuildContext context,
  AppScreens screen,
) {
  final acceso = AccesoManager();

  if (!acceso.puedeAcceder(screen)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Acceso no permitido")),
    );
    return;
  }

  final builder = appRoutes[screen];

  if (builder == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pantalla no configurada")),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(builder: builder),
  );
}
