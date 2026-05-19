import 'package:flutter/material.dart';
import 'package:portal_muni/core/enums/screens.dart';

class AppModule {
  final String titulo;
  final IconData icono;
  final List<AppScreens> screens;

  const AppModule({
    required this.titulo,
    required this.icono,
    required this.screens,
  });
}

const appModules = [
  AppModule(
    titulo: "Información institucional",
    icono: Icons.business,
    screens: [],
  ),
  AppModule(
    titulo: "Información del personal institucional",
    icono: Icons.groups,
    screens: [
      AppScreens.directorioTelefonico,
    ],
  ),
  AppModule(
    titulo: "Procesos de contratación",
    icono: Icons.assignment,
    screens: [],
  ),
  AppModule(
    titulo: "Servicios y procesos institucionales",
    icono: Icons.settings_suggest,
    screens: [],
  ),

  /* */
  AppModule(
    titulo: "Finanzas Públicas",
    icono: Icons.account_balance,
    screens: [
      // AppScreens.finanzasPublicas,
      AppScreens.presupuestoProyectadoAprobado,
      AppScreens.ejecucionPresupuesto,
      AppScreens.reporteFinanciero,
    ],
  ),
  AppModule(
    titulo: "Planes y Cumplimiento",
    icono: Icons.fact_check,
    screens: [
      AppScreens.planesInstitucionales,
      //AppScreens.planesCumplimiento,
      //AppScreens.planesEstrategicoMunicipal,
      //AppScreens.planesAnualOperativo,
      // AppScreens.planesSectoriales,
      //
      //AppScreens.informesCumplimiento,
      // AppScreens.informeAnualGestion,
      AppScreens.cumplimientoPlanesInstitucionales,
      AppScreens.informesSeguimientoRecomendaciones
    ],
  ),
  AppModule(
    titulo: "Informes institucionales y de personal",
    icono: Icons.description,
    screens: [
      AppScreens.informesInstitucionales,
      AppScreens.informesInstitucionalesEspecialesAuditoria,
      AppScreens.informesAnualesAuditoria,
      AppScreens.historicoInformesAuditoria,
      AppScreens.informeArchivo,
      AppScreens.informeCalificacionPersonal,
      AppScreens.informesPersonalInstitucional,
    ],
  ),
  AppModule(
    titulo: "Toma de decisiones",
    icono: Icons.insights,
    screens: [AppScreens.actas, AppScreens.acuerdos],
  ),
];
