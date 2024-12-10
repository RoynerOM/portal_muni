import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/ejecucion/pages/ejecuciones.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informe_auditoria.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_institucionales.dart';
import 'package:portal_muni/features/inicio/models/menu_model.dart';

class AuditoriaPage extends StatelessWidget {
  const AuditoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> accesos = [
      MenuItem(
        name: 'Informes de seguimiento a las recomendaciones',
        description:
            'Están disponibles los informes de seguimiento realizados a las recomendaciones de las evaluaciones internas.',
        icon: Icons.assignment_turned_in,
        requiredRole: 'auditoria',
        targetPage: const InformeAuditoria(),
      ),
      MenuItem(
        name: 'Informes institucionales',
        description: 'Evalúa la disponibilidad de informes de auditoría',
        icon: Icons.library_books,
        requiredRole: 'auditoria',
        targetPage: const InformesInstitucionales(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Auditoría'),
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
