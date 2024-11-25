import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:portal_muni/features/informe_personal/models/informe_personal_model.dart';

class InformePersonalRepo {
  final String apiUrl =
      'https://muniupala.go.cr/portal/api/informe_personal.php';

  Future<List<InformePersonalModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => InformePersonalModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los planes');
    }
  }

  Future<void> post(File file, InformePersonalModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['tipo'] = model.tipo;
    request.fields['fecha'] = model.fecha;
    request.fields['year'] = model.year;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar plan');
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
      throw Exception('Error al eliminar informacion del informe');
    }
  }
}