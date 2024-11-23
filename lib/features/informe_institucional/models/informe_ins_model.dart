import 'dart:convert';

List<InformeInstModel> informeInstModelFromJson(String str) =>
    List<InformeInstModel>.from(
        json.decode(str).map((x) => InformeInstModel.fromJson(x)));

class InformeInstModel {
  final String id;
  final String fecha;
  final String? url;
  final String nombre;
  final String year;
  final String tipo;

  InformeInstModel({
    required this.id,
    required this.fecha,
    this.url,
    required this.nombre,
    required this.year,
    required this.tipo,
  });

  factory InformeInstModel.fromJson(Map<String, dynamic> map) {
    return InformeInstModel(
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
