enum AppScreens {
  // Presupuesto Proyectado y Aprobado
  finanzasPublicas('Finanzas Públicas'),
  presupuestoProyectadoAprobado('Presupuesto'),
  nuevoPresupuestoProyectado('Proyecto de presupuesto'),
  nuevoPresupuestoAprobado('Presupuesto aprobado'),
  eliminarPresupuestoProyectadoAprobado('Eliminar Presupuesto'),

  // Ejecución de Presupuesto
  ejecucionPresupuesto('Ejecución del presupuesto'),
  nuevoInformeParcial('Informes parciales de ejecución'),
  nuevoInformeFinAno('Informe de fin de año'),
  nuevoHistoricoAprobadoEjecutado(
      'Histórico de presupuesto aprobado y ejecutado'),
  nuevaAuditoriaGastoPublico('Auditorías del gasto público'),
  eliminarEjecucionPresupuesto('Eliminar Ejecución del presupuesto'),

  // Reporte Financiero
  reporteFinanciero('Reporte anual financiero'),
  nuevoReporteAnualFinanciero('Nuevo Reporte anual financiero'),
  eliminarReporteFinanciero('Eliminar Reporte Financiero'),

  // Planes y cumplimiento
  planesCumplimiento('Planes y cumplimiento'),
  planesInstitucionales('Planes Institucionales'),
  planesEstrategicoMunicipal('Plan estratégico municipal'),
  planesAnualOperativo('Plan anual operativo'),
  planesSectoriales('Otros planes específicos o sectoriales'),
  //
  cumplimientoPlanesInstitucionales('Cumplimiento de planes institucionales'),
  // Informes institucionales
  informesInstitucionalesPersonal('Informes institucionales y de personal'),
  informesInstitucionales('Informes Institucionales'),
  informesInstitucionalesEspecialesAuditoria(
      'Informes Especiales de Auditoría'),
  informesAnualesAuditoria('Informes anuales de auditoría'),
  historicoInformesAuditoria('Histórico de informes de auditoría'),
  informeArchivo('Informe del archivo institucional'),
  informeCalificacionPersonal('Informes de calificación del personal'),
//
  informesPersonalInstitucional('Informes de personal institucional');
  //

  final String name;
  const AppScreens(this.name);
}

bool validarAcceso(AppScreens pantalla, List<AppScreens> accesos) {
  return accesos.any((x) => x == pantalla);
}
