import 'dart:convert';

List<AcuerdoModel> acuerdoToList(String str) => List<AcuerdoModel>.from(
    json.decode(str).map((x) => AcuerdoModel.fromJson(x)));

AcuerdoModel acuerdoModelFromJson(String str) =>
    AcuerdoModel.fromJson(json.decode(str));

String acuerdoModelToJson(AcuerdoModel data) => json.encode(data.toJson());

class AcuerdoModel {
  String id;
  String actaId;
  String fecha;
  String year;
  String url;
  String nombre;

  AcuerdoModel({
    required this.id,
    required this.actaId,
    required this.fecha,
    required this.year,
    required this.url,
    required this.nombre,
  });

  factory AcuerdoModel.fromJson(Map<String, dynamic> json) => AcuerdoModel(
        id: json["id"],
        actaId: json["actaId"],
        fecha: json["fecha"],
        year: json["year"],
        url: json["url"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actaId": actaId,
        "fecha": fecha,
        "year": year,
        "url": url,
        "nombre": nombre,
      };
}
