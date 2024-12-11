import 'package:flutter/material.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/features/actas/pages/actas.dart';
import 'package:portal_muni/features/actas/pages/acuerdos.dart';
import 'package:portal_muni/features/inicio/models/menu_model.dart';

class TemasPage extends StatelessWidget {
  const TemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> accesos = [
      MenuItem(
        name: 'Temas a tratar',
        description:
            'Están disponibles con antelación las agenda/órdenes del día con los principales temas a tratar en las sesiones de los órganos directivos.',
        icon: Icons.assignment_turned_in,
        requiredRole: 'concejo',
        targetPage: const Actas(),
      ),
      MenuItem(
        name: 'Acuerdos',
        description:
            'Están disponibles las resoluciones, directrices, dictámenes, actas y circulares internas de la institución del presente año',
        icon: Icons.library_books,
        requiredRole: 'concejo',
        targetPage: const Acuerdos(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas y acuerdos'),
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
