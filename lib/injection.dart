import 'package:get_it/get_it.dart';
import 'package:portal_muni/features/ejecucion/bloc/ejecucion_bloc.dart';
import 'package:portal_muni/features/ejecucion/repository/ejecucion_repository.dart';
import 'package:portal_muni/features/informe_cumplimiento/bloc/informe_cumplimiento_bloc.dart';
import 'package:portal_muni/features/informe_cumplimiento/repository/informe_cumplimiento_repo.dart';
import 'package:portal_muni/features/inicio/bloc/acceso_bloc.dart';
import 'package:portal_muni/features/plan_institucional/bloc/plan_institucional_bloc.dart';
import 'package:portal_muni/features/plan_institucional/repository/plan_institucional_repo.dart';
import 'package:portal_muni/features/presupuesto/bloc/presupuesto_bloc.dart';
import 'package:portal_muni/features/presupuesto/repository/presupuesto_repo.dart';
import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';
import 'package:portal_muni/features/report_finance/repository/report_finance_repo.dart';

final sl = GetIt.instance;

Future<void> injection() async {
  sl.registerSingleton<PresupuestoRepository>(PresupuestoRepository());
  sl.registerFactory<PresupuestoBloc>(() => PresupuestoBloc(sl()));
  //
  sl.registerSingleton<EjecucionRepository>(EjecucionRepository());
  sl.registerFactory<EjecucionBloc>(() => EjecucionBloc(sl()));
  //
  sl.registerSingleton<ReportFinanceRepo>(ReportFinanceRepo());
  sl.registerFactory<ReportFinanceBloc>(() => ReportFinanceBloc(sl()));
  //
  sl.registerFactory<AccesoBloc>(() => AccesoBloc());
  //
  sl.registerSingleton<PlanInstitucionalRepo>(PlanInstitucionalRepo());
  sl.registerFactory<PlanInstitucionalBloc>(() => PlanInstitucionalBloc(sl()));
  //
  sl.registerSingleton<InformeCumplimientoRepo>(InformeCumplimientoRepo());
  sl.registerFactory<InformeCumplimientoBloc>(
      () => InformeCumplimientoBloc(sl()));
  //
}
