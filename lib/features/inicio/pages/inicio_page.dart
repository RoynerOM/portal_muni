import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/enums/screens.dart';
import 'package:portal_muni/features/ejecucion/pages/ejecuciones.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informes_cumplimientos.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_institucionales.dart';
import 'package:portal_muni/features/inicio/bloc/acceso_bloc.dart';
import 'package:portal_muni/features/plan_institucional/pages/planes_institucionales.dart';
import 'package:portal_muni/features/presupuesto/pages/presupuesto.dart';

import '../../report_finance/pages/reporte_financiero.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<AppScreens> accesos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú Principal"),
        elevation: 0,
      ),
      body: BlocListener<AccesoBloc, AccesoState>(
        listener: (context, state) {
          if (state.accesos.isNotEmpty) {
            accesos = state.accesos;
            setState(() {});
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (validarAcceso(AppScreens.finanzasPublicas, accesos))
                      CenterChildList(
                        child: _crearModulo(
                          'Finanzas Públicas',
                          Icons.account_balance_wallet,
                          context,
                          Colors.blueAccent,
                          [
                            if (validarAcceso(
                                AppScreens.presupuestoProyectadoAprobado,
                                accesos))
                              _Submodulo('Presupuesto'),
                            if (validarAcceso(
                                AppScreens.ejecucionPresupuesto, accesos))
                              _Submodulo('Ejecución del presupuesto'),
                            if (validarAcceso(
                                AppScreens.reporteFinanciero, accesos))
                              _Submodulo('Reporte anual financiero'),
                          ],
                        ),
                      ),
                    if (validarAcceso(AppScreens.planesCumplimiento, accesos))
                      CenterChildList(
                        child: _crearModulo(
                          'Planes y cumplimiento',
                          Icons.account_balance_wallet,
                          context,
                          Colors.blueAccent,
                          [
                            if (validarAcceso(
                                AppScreens.planesInstitucionales, accesos))
                              _Submodulo('Planes Institucionales'),
                            if (validarAcceso(
                                AppScreens.cumplimientoPlanesInstitucionales,
                                accesos))
                              _Submodulo(
                                  'Cumplimiento de planes institucionales'),
                          ],
                        ),
                      ),
                    if (validarAcceso(
                        AppScreens.informesInstitucionalesPersonal, accesos))
                      CenterChildList(
                        child: _crearModulo(
                          'Informes institucionales y de personal',
                          Icons.account_balance_wallet,
                          context,
                          Colors.blueAccent,
                          [
                            if (validarAcceso(
                                AppScreens.informesInstitucionales, accesos))
                              _Submodulo('Informes Institucionales'),
                            if (validarAcceso(
                                AppScreens.informesPersonalInstitucional,
                                accesos))
                              _Submodulo('Informes de personal institucional'),
                          ],
                        ),
                      ), /*
                    if (validarAcceso(AppScreens.finanzasPublicas, accesos))
                      CenterChildList(
                        child: _crearModulo(
                          'Informes institucionales y de personal',
                          Icons.account_balance_wallet,
                          context,
                          Colors.blueAccent,
                          [
                            if (validarAcceso(
                                AppScreens.finanzasPublicas, accesos))
                              _Submodulo('Informes Institucionales'),
                            if (validarAcceso(
                                AppScreens.finanzasPublicas, accesos))
                              _Submodulo('Informes de personal institucional'),
                          ],
                        ),
                      ),
                    if (validarAcceso(AppScreens.finanzasPublicas, accesos))
                      CenterChildList(
                        child: _crearModulo(
                          'Toma de decisiones',
                          Icons.account_balance_wallet,
                          context,
                          Colors.blueAccent,
                          [
                            if (validarAcceso(
                                AppScreens.finanzasPublicas, accesos))
                              _Submodulo('Temas y acuerdos'),
                          ],
                        ),
                      ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearModulo(String moduloNombre, IconData icono, BuildContext context,
      Color color, List<_Submodulo> submodulos) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.black87,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icono,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      moduloNombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: const Text(
                "Variables",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: submodulos.map((submodulo) {
                return ListTile(
                  title: Text(
                    submodulo.nombre,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PantallaView(moduloNombre: submodulo.nombre),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaView extends StatelessWidget {
  final String moduloNombre;

  const PantallaView({super.key, required this.moduloNombre});

  @override
  Widget build(BuildContext context) {
    if (AppScreens.presupuestoProyectadoAprobado.name == moduloNombre) {
      return const PresupuestoPage();
    }

    if (AppScreens.ejecucionPresupuesto.name == moduloNombre) {
      return const EjecucionesPage();
    }

    if (AppScreens.reporteFinanciero.name == moduloNombre) {
      return const ReporteFinancieroPage();
    }

    if (AppScreens.planesInstitucionales.name == moduloNombre) {
      return const PlanesInstitucionales();
    }

    if (AppScreens.cumplimientoPlanesInstitucionales.name == moduloNombre) {
      return const InformesCumplimientos();
    }

    if (AppScreens.informesInstitucionales.name == moduloNombre) {
      return const InformesInstitucionales();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(moduloNombre),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'No tienes acceso a esta vista',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Submodulo {
  final String nombre;
  _Submodulo(this.nombre);
}
