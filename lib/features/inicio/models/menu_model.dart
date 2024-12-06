import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final String description;
  final IconData icon;
  final String requiredRole; // Puede ser 'financiero', 'alcaldia', etc.
  final Widget targetPage; // Página a la que se dirige

  MenuItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.requiredRole,
    required this.targetPage,
  });
}
