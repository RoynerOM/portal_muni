import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/storage/storage.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/actas/bloc/actas_bloc.dart';
import 'package:portal_muni/features/ejecucion/bloc/ejecucion_bloc.dart';
import 'package:portal_muni/features/informe_cumplimiento/bloc/informe_cumplimiento_bloc.dart';
import 'package:portal_muni/features/informe_institucional/bloc/informe_institucional_bloc.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_institucionales.dart';
import 'package:portal_muni/features/informe_personal/bloc/informe_personal_bloc.dart';
import 'package:portal_muni/features/inicio/bloc/acceso_bloc.dart';
import 'package:portal_muni/features/inicio/pages/auditoria_page.dart';
import 'package:portal_muni/features/inicio/pages/planificacion_page.dart';
import 'package:portal_muni/features/plan_institucional/bloc/plan_institucional_bloc.dart';
import 'package:portal_muni/features/presupuesto/bloc/presupuesto_bloc.dart';
import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';
import 'package:portal_muni/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    injection(),
    Storage().init(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccesoBloc>(
          create: (context) => sl()..add(CargarAccesosEvent()),
        ),
        BlocProvider<PresupuestoBloc>(
          create: (context) => sl()..add(LoadPresupuestoEvent()),
        ),
        BlocProvider<EjecucionBloc>(
          create: (context) => sl()..add(LoadEjeucionesEvent()),
        ),
        BlocProvider<ReportFinanceBloc>(
          create: (context) => sl()..add(LoadReportFinanceEvt()),
        ),
        BlocProvider<PlanInstitucionalBloc>(
          create: (context) => sl()..add(LoadPlanInstitucionalEvt()),
        ),
        BlocProvider<InformeCumplimientoBloc>(
          create: (context) => sl()..add(LoadInformeCumplimientoEvt()),
        ),
        BlocProvider<InformeInstitucionalBloc>(
          create: (context) => sl()..add(LoadInformeInstitucionalEvt()),
        ),
        BlocProvider<InformePersonalBloc>(
          create: (context) => sl()..add(LoadInformePersonalEvt()),
        ),
        BlocProvider<ActasBloc>(
          create: (context) => sl()..add(LoadActasEvt()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        supportedLocales: const [
          Locale('es', 'ES'), // Español (España)
          Locale('es', 'AR'), // Español (Argentina)
          Locale('es', 'BO'), // Español (Bolivia)
          Locale('es', 'CL'), // Español (Chile)
          Locale('es', 'CO'), // Español (Colombia)
          Locale('es', 'CR'), // Español (Costa Rica)
          Locale('es', 'DO'), // Español (República Dominicana)
          Locale('es', 'EC'), // Español (Ecuador)
          Locale('es', 'SV'), // Español (El Salvador)
          Locale('es', 'GT'), // Español (Guatemala)
          Locale('es', 'HN'), // Español (Honduras)
          Locale('es', 'MX'), // Español (México)
          Locale('es', 'NI'), // Español (Nicaragua)
          Locale('es', 'PA'), // Español (Panamá)
          Locale('es', 'PY'), // Español (Paraguay)
          Locale('es', 'PE'), // Español (Perú)
          Locale('es', 'PR'), // Español (Puerto Rico)
          Locale('es', 'UY'), // Español (Uruguay)
          Locale('es', 'VE'), // Español (Venezuela)
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: HexColor('1E3A5F'),
            foregroundColor: Colors.white,
          ),
        ),
        //home: const FinanceroPage(),
        // home: const MenuScreen(),
        //home: const PlanificacionPage(),
        home: const InformesInstitucionales(),
      ),
    );
  }
}
