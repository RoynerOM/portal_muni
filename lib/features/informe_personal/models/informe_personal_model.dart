import 'dart:convert';

List<InformePersonalModel> informePersonalModelFromJson(String str) =>
    List<InformePersonalModel>.from(
        json.decode(str).map((x) => InformePersonalModel.fromJson(x)));

class InformePersonalModel {
  final String id;
  final String fecha;
  final String? url;
  final String nombre;
  final String year;
  final String tipo;

  InformePersonalModel({
    required this.id,
    required this.fecha,
    this.url,
    required this.nombre,
    required this.year,
    required this.tipo,
  });

  factory InformePersonalModel.fromJson(Map<String, dynamic> map) {
    return InformePersonalModel(
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
