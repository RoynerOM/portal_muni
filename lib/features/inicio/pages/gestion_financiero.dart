import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/ejecucion/pages/ejecuciones.dart';
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
        icon: Icons.admin_panel_settings,
        requiredRole: 'financiero',
        targetPage: const PresupuestoPage(),
      ),
      MenuItem(
        name: 'Informes',
        description: 'Accede a funciones básicas',
        icon: Icons.person,
        requiredRole: 'financiero',
        targetPage: const EjecucionesPage(),
      ),
      MenuItem(
        name: 'Reportes',
        description: 'Accede a funciones básicas',
        icon: Icons.person,
        requiredRole: 'financiero',
        targetPage: const ReporteFinancieroPage(),
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
