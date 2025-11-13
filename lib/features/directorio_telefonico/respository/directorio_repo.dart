import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_muni/features/directorio_telefonico/models/contacto_model.dart';

class DirectorioRepo {
  final String apiUrl =
      'https://muniupala.go.cr/portal/api/directorio_telefonico.php';

  Future<List<ContactoModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => ContactoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los directorios telefonicos');
    }
  }

  Future<void> post(ContactoModel model) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": model.nombre,
        "departamento": model.departamento,
        "telefono": model.telefono,
        "extension": model.extension,
        "email": model.email,
        "puesto": model.puesto
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al guardar directorio telefonico');
    }
  }

  Future<void> put(ContactoModel model) async {
    var response = await http.put(
      Uri.parse("$apiUrl?id=${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": model.id,
        "nombre": model.nombre,
        "departamento": model.departamento,
        "telefono": model.telefono,
        "extension": model.extension,
        "email": model.email,
        "puesto": model.puesto
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el directorio telefonico');
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$apiUrl?id=$id"));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar directorio');
    }
  }
}
