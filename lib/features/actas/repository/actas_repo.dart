import 'package:portal_muni/features/actas/models/acta_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ActasRepo {
  final String apiUrl = 'https://muniupala.go.cr/portal/api/actas.php';

  Future<List<ActaModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => ActaModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las actas');
    }
  }

  Future<void> post(File file, ActaModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['tipo'] = model.tipo;
    request.fields['fecha'] = model.fecha;
    request.fields['year'] = model.year;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar acta');
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
      throw Exception('Error al eliminar acta');
    }
  }
}
