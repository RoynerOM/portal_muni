import 'dart:convert';

List<PlanInstitucionalModel> planInstitucionalModelFromJson(String str) =>
    List<PlanInstitucionalModel>.from(
        json.decode(str).map((x) => PlanInstitucionalModel.fromJson(x)));

class PlanInstitucionalModel {
  final String id;
  final String fecha;
  final String? url;
  final String nombre;
  final String year;
  final String tipo;

  PlanInstitucionalModel({
    required this.id,
    required this.fecha,
    this.url,
    required this.nombre,
    required this.year,
    required this.tipo,
  });

  factory PlanInstitucionalModel.fromJson(Map<String, dynamic> map) {
    return PlanInstitucionalModel(
      id: map['id'],
      fecha: map['fecha'],
      url: map['url'],
      nombre: map['nombre'],
      year: map['year'],
      tipo: map['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fecha': fecha,
      'url': url,
      'nombre': nombre,
      'year': year,
      'tipo': tipo,
    };
  }
}
