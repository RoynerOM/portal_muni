import 'dart:convert';

List<PresupuestoModel> presupuestoModelFromJson(String str) =>
    List<PresupuestoModel>.from(
        json.decode(str).map((x) => PresupuestoModel.fromJson(x)));

class PresupuestoModel {
  String id;
  String year;
  String tipo;
  String fecha;
  String url;
  String nombre;

  PresupuestoModel({
    required this.id,
    required this.year,
    required this.tipo,
    required this.fecha,
    required this.url,
    required this.nombre,
  });

  factory PresupuestoModel.fromJson(Map<String, dynamic> json) =>
      PresupuestoModel(
        id: json["id"] ?? '',
        year: json["year"] ?? '',
        tipo: json["tipo"] ?? '',
        fecha: json["fecha"] ?? '',
        url: json["url"] ?? '',
        nombre: json["nombre"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "tipo": tipo,
        "fecha": fecha,
        "url": url,
        "nombre": nombre,
      };
}
