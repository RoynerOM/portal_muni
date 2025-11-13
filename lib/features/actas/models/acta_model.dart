import 'dart:convert';

List<ActaModel> actaToList(String str) =>
    List<ActaModel>.from(json.decode(str).map((x) => ActaModel.fromJson(x)));

ActaModel actaModelFromJson(String str) => ActaModel.fromJson(json.decode(str));

String actaModelToJson(ActaModel data) => json.encode(data.toJson());

class ActaModel {
  String id;
  String tipo;
  DateTime? fecha;
  String year;
  String url;
  String nombre;
  DateTime? fechaPublicacion;
  String esOrdinario;

  ActaModel({
    required this.id,
    required this.tipo,
    required this.fecha,
    required this.year,
    required this.url,
    required this.nombre,
    required this.fechaPublicacion,
    required this.esOrdinario,
  });

  factory ActaModel.fromJson(Map<String, dynamic> json) => ActaModel(
        id: json["id"],
        tipo: json["tipo"],
        fecha: json['fecha'] == null
            ? null
            : parseIsoDate(json["fecha"]).toLocal(),
        year: json["year"],
        url: json["url"],
        nombre: json["nombre"],
        fechaPublicacion: json["fecha_publicacion"] == null
            ? null
            : parseIsoDate(json["fecha_publicacion"]).toLocal(),
        esOrdinario: json["es_ordinario"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "fecha": fecha?.toIso8601String(),
        "year": year,
        "url": url,
        "nombre": nombre,
        "fecha_publicacion": fechaPublicacion?.toIso8601String(),
        "es_ordinario": esOrdinario
      };
}

DateTime parseIsoDate(String input) {
  if (RegExp(r'^\d{4}-\d{2}-\d{2}Z$').hasMatch(input)) {
    input = input.replaceFirst('Z', 'T00:00:00Z');
  }

  return DateTime.parse(input);
}
