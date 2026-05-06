import 'package:flutter/material.dart';
import 'package:portal_muni/features/access/pages/admin_config.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final controller = TextEditingController();
  final String password = "1234"; // ⚠️ simple

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
            TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validar,
              child: const Text("Ingresar"),
            )
          ],
        ),
      ),
    );
  }
}
