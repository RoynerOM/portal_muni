import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal, // Cambia el color según tu paleta
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Sección de enlaces
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Navegación',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Inicio', style: TextStyle(color: Colors.white)),
                  Text('Servicios', style: TextStyle(color: Colors.white)),
                  Text('Experiencias', style: TextStyle(color: Colors.white)),
                ],
              ),
              // Sección de contacto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contacto',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Teléfono: +506 2470 0157',
                      style: TextStyle(color: Colors.white)),
                  Text('Correo: info@muniupala.com',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              // Sección de redes sociales
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Síguenos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.facebook, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),
          // Derechos de autor
          Text(
            '© ${DateTime.now().year} Muncipalidad de Upala. Todos los derechos reservados.',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
