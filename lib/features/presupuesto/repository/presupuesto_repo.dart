import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:portal_muni/features/presupuesto/models/presupuesto_model.dart';

class PresupuestoRepository {
  final String apiUrl = 'https://muniupala.go.cr/portal/api/presupuesto.php';

  Future<List<PresupuestoModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => PresupuestoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los presupuestos');
    }
  }

  Future<void> post(File file, PresupuestoModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.fields['year'] = model.year;
    request.fields['tipo'] = model.tipo;
    request.fields['fecha'] = model.fecha;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar presupuesto');
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'id': id},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar informacion de presupuesto');
    }
  }
}
