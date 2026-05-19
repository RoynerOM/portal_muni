import 'package:flutter/material.dart';
import 'package:portal_muni/app/buttons/default_button.dart';
import 'package:portal_muni/app/text_field/text_field_ui.dart';
import 'package:portal_muni/features/access/pages/admin_config.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final controller = TextEditingController();
  final String password = "1234";

  void validar() {
    if (controller.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminConfigPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contraseña incorrecta")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Input(
              labelText: '',
              controller: controller,
              hintText: 'Contraseña',
              obscureText: true,
              onFieldSubmitted: (value) {
                validar();
              },
              validator: (value) {
                //Validar el formato de normalizar
                if (value!.isEmpty) {
                  return 'Campo no puede estar en blanco';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DefaultButton(
              label: 'Ingresar',
              onTap: validar,
            ),
          ],
        ),
      ),
    );
  }
}
