import 'package:portal_muni/features/actas/models/acuerdo_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AcuerdoRepo {
  final String apiUrl = 'https://muniupala.go.cr/portal/api/acuerdos.php';

  Future<List<AcuerdoModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((json) => AcuerdoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los acuerdos');
    }
  }

  Future<void> post(File file, AcuerdoModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['actaId'] = model.actaId;
    request.fields['fecha'] = model.fecha;
    request.fields['year'] = model.year;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar acuerdo');
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
      throw Exception('Error al eliminar acuerdo');
    }
  }
}
