import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/ejecucion/pages/ejecuciones.dart';
import 'package:portal_muni/features/informe_personal/pages/informes_personal.dart';
import 'package:portal_muni/features/inicio/models/menu_model.dart';
import 'package:portal_muni/features/presupuesto/pages/presupuesto.dart';
import 'package:portal_muni/features/report_finance/pages/reporte_financiero.dart';

class FinanceroPage extends StatelessWidget {
  const FinanceroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> accesos = [
      MenuItem(
        name: 'Presupuestos',
        description: 'Accede a funciones administrativas',
        icon: Icons.account_balance,
        requiredRole: 'financiero',
        targetPage: const PresupuestoPage(),
      ),
      MenuItem(
        name: 'Ejecución del presupuesto',
        description:
            'Evalúa la disponibilidad de informes de ejecución presupuestaria.',
        icon: Icons.bar_chart,
        requiredRole: 'financiero',
        targetPage: const EjecucionesPage(),
      ),
      MenuItem(
        name: 'Reporte anual financiero',
        description:
            'Evalúa la disponibilidad del reporte anual financiero de la institución.',
        icon: Icons.receipt_long,
        requiredRole: 'financiero',
        targetPage: const ReporteFinancieroPage(),
      ),
      MenuItem(
        name: 'Informes de viajes',
        description:
            'Está disponible toda la siguiente información: motivo del viaje, resultados obtenidos, todos los funcionarios que asistieron, y viáticos percibidos de la institución o de otras organizaciones',
        icon: Icons.flight_takeoff,
        requiredRole: 'financiero',
        targetPage: const InformesDePersonal(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Financiero'),
      ),
      body: CenterScroll(
        child: Column(
          children: [
            for (var x in accesos)
              ListTile(
                leading: Icon(x.icon),
                title: Text(
                  x.name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  x.description,
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => x.targetPage,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
