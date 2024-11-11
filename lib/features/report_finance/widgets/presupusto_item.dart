import 'package:flutter/material.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';

class ReporteItem extends StatelessWidget {
  final String nombre;
  final String year;
  final VoidCallback onDelete;

  const ReporteItem({
    super.key,
    required this.nombre,
    required this.year,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 2,
          color: HexColor('E7E9F4'),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        leading: const Icon(
          Icons.pie_chart_rounded,
          size: 36,
        ),
        title: Text(
          nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          year,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          tooltip: 'Eliminar',
          icon: Icon(
            Icons.delete_outline,
            color: HexColor('9D9CA2'),
            size: 28,
          ),
          onPressed: () => _showDeleteDialog(context, nombre),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String nombre) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            nombre,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            '¿Estás seguro de que quieres eliminar este Reporte?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}