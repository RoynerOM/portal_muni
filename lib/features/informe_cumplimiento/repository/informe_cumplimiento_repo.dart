import 'package:portal_muni/features/informe_cumplimiento/models/informe_cumplimiento_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class InformeCumplimientoRepo {
  final String apiUrl =
      'https://muniupala.go.cr/portal/api/informe_cumplimiento.php';

  Future<List<InformeCumplimientoModel>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body
          .map((json) => InformeCumplimientoModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener los informes');
    }
  }

  Future<void> post(File file, InformeCumplimientoModel model) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['tipo'] = model.tipo;
    request.fields['fecha'] = model.fecha;
    request.fields['year'] = model.year;
    request.fields['nombre'] = model.nombre;
    request.files.add(await http.MultipartFile.fromPath('url', file.path));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al guardar informe');
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
      throw Exception('Error al eliminar informacion del informes');
    }
  }
}
