import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informes_cumplimientos.dart';
import 'package:portal_muni/features/inicio/models/menu_model.dart';
import 'package:portal_muni/features/plan_institucional/pages/planes_institucionales.dart';

class PlanificacionPage extends StatelessWidget {
  const PlanificacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> accesos = [
      MenuItem(
        name: 'Planes institucionales',
        description:
            'Evalúa la disponibilidad de planes estratégicos, planes operativos, de desarrollo y otros.',
        icon: Icons.admin_panel_settings,
        requiredRole: 'planificación',
        targetPage: const PlanesInstitucionales(),
      ),
      MenuItem(
        name: 'Cumplimiento de planes institucionales',
        description:
            'Evalúa la disponibilidad de informes de cumplimiento de los planes institucionales.',
        icon: Icons.person,
        requiredRole: 'planificación',
        targetPage: const InformesCumplimientos(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Planificación'),
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
