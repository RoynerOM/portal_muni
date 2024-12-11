import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/informe_rrhh.dart';
import 'package:portal_muni/features/informe_institucional/pages/informes_institucionales.dart';
import 'package:portal_muni/features/inicio/models/menu_model.dart';

class RrhhPage extends StatelessWidget {
  const RrhhPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> accesos = [
      MenuItem(
        name: 'Informe final de gestión',
        description:
            'Están disponibles los informes finales de gestión de los jerarcas y titulares subordinados',
        icon: Icons.assignment_turned_in,
        requiredRole: 'rrhh',
        targetPage: const InformeRrhh(),
      ),
      MenuItem(
        name: 'Informes de calificación del personal',
        description:
            'Está disponible la evaluación del desempeño del personal en general (no individual)',
        icon: Icons.library_books,
        requiredRole: 'rrhh',
        targetPage: const InformesInstitucionales(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal RRHH'),
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
