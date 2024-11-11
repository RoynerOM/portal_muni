import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/storage/storage.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/ejecucion/bloc/ejecucion_bloc.dart';
import 'package:portal_muni/features/inicio/bloc/acceso_bloc.dart';
import 'package:portal_muni/features/inicio/pages/inicio_page.dart';
import 'package:portal_muni/features/presupuesto/bloc/presupuesto_bloc.dart';
import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';
import 'package:portal_muni/injection.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: HexColor('1E3A5F'),
            foregroundColor: Colors.white,
          ),
        ),
        home: const MenuScreen(),
      ),
    );
  }
}