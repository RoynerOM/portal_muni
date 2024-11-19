import 'dart:convert';

List<InformeCumplimientoModel> informeCumpliminetoModelFromJson(String str) =>
    List<InformeCumplimientoModel>.from(
        json.decode(str).map((x) => InformeCumplimientoModel.fromJson(x)));

class InformeCumplimientoModel {
  final String id;
  final String fecha;
  final String? url;
  final String nombre;
  final String year;
  final String tipo;

  InformeCumplimientoModel({
    required this.id,
    required this.fecha,
    this.url,
    required this.nombre,
    required this.year,
    required this.tipo,
  });

  factory InformeCumplimientoModel.fromJson(Map<String, dynamic> map) {
    return InformeCumplimientoModel(
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
