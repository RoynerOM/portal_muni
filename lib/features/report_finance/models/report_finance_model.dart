import 'dart:convert';

List<ReportFinanceModel> reportFinanceModelFromJson(String str) =>
    List<ReportFinanceModel>.from(
        json.decode(str).map((x) => ReportFinanceModel.fromJson(x)));

class ReportFinanceModel {
  String id;
  String year;

  String fecha;
  String url;
  String nombre;

  ReportFinanceModel({
    required this.id,
    required this.year,
    required this.fecha,
    required this.url,
    required this.nombre,
  });

  factory ReportFinanceModel.fromJson(Map<String, dynamic> json) =>
      ReportFinanceModel(
        id: json["id"] ?? '',
        year: json["year"] ?? '',
        fecha: json["fecha"] ?? '',
        url: json["url"] ?? '',
        nombre: json["nombre"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "fecha": fecha,
        "url": url,
        "nombre": nombre,
      };
}
