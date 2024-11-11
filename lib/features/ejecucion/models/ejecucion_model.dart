import 'dart:convert';

List<EjecucionModel> ejecucionModelFromJson(String str) =>
    List<EjecucionModel>.from(
        json.decode(str).map((x) => EjecucionModel.fromJson(x)));

class EjecucionModel {
  String id;

  String tipo;
  String fecha;
  String url;
  String nombre;
  String esHistorico;
  EjecucionModel({
    required this.id,
    required this.tipo,
    required this.fecha,
    required this.url,
    required this.nombre,
    required this.esHistorico,
  });

  factory EjecucionModel.fromJson(Map<String, dynamic> json) => EjecucionModel(
        id: json["id"] ?? '',
        tipo: json["tipo"] ?? '',
        fecha: json["fecha"] ?? '',
        url: json["url"] ?? '',
        nombre: json["nombre"] ?? '',
        esHistorico: json["es_historico"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "fecha": fecha,
        "url": url,
        "nombre": nombre,
        "es_historico": esHistorico,
      };
}
