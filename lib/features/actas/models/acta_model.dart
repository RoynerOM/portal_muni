import 'dart:convert';

List<ActaModel> actaToList(String str) =>
    List<ActaModel>.from(json.decode(str).map((x) => ActaModel.fromJson(x)));

ActaModel actaModelFromJson(String str) => ActaModel.fromJson(json.decode(str));

String actaModelToJson(ActaModel data) => json.encode(data.toJson());

class ActaModel {
  String id;
  String tipo;
  String fecha;
  String year;
  String url;
  String nombre;

  ActaModel({
    required this.id,
    required this.tipo,
    required this.fecha,
    required this.year,
    required this.url,
    required this.nombre,
  });

  factory ActaModel.fromJson(Map<String, dynamic> json) => ActaModel(
        id: json["id"],
        tipo: json["tipo"],
        fecha: json['fecha'],
        year: json["year"],
        url: json["url"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "fecha": fecha,
        "year": year,
        "url": url,
        "nombre": nombre,
      };
}
