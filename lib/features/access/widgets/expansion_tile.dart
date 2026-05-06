import 'package:flutter/material.dart';
import 'package:portal_muni/core/enums/screens.dart';
import 'package:portal_muni/core/utils/helpers.dart';

class ExpansionTileUI extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final List<AppScreens> vistas;
  const ExpansionTileUI({
    super.key,
    required this.icon,
    required this.titulo,
    required this.vistas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(25, 109, 133, 1)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: ExpansionTile(
        backgroundColor: const Color.fromRGBO(25, 109, 133, 1),
        iconColor: Colors.white,
        collapsedIconColor: Colors.indigo,
        textColor: Colors.white,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.only(bottom: 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: Icon(icon),
        children: vistas.map((screen) {
          return ListTile(
            tileColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              screen.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            leading: const Icon(
              Icons.circle,
              color: Color.fromRGBO(25, 109, 133, 1),
              size: 16,
            ),
            onTap: () => abrirPantalla(context, screen),
          );
        }).toList(),
      ),
    );
  }
}
