import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:portal_muni/features/ejecucion/models/ejecucion_model.dart';

class EjecucionRepository {
  final String apiUrl = 'https://muniupala.go.cr/portal/api/ejecucion.php';

  Future<List<EjecucionModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => EjecucionModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los ejecuciones');
    }
  }

  Future<void> post(File file, EjecucionModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['es_historico'] = model.esHistorico;
    request.fields['tipo'] = model.tipo;
    request.fields['fecha'] = model.fecha;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar ejecucion');
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
      throw Exception('Error al eliminar informacion de la ejecucion');
    }
  }
}
