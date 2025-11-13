class ContactoModel {
  final int? id;
  final String nombre;
  final String departamento;
  final String telefono;
  final String? extension;
  final String email;
  final String? puesto;

  ContactoModel({
    this.id,
    required this.nombre,
    required this.departamento,
    required this.telefono,
    this.extension,
    required this.email,
    this.puesto,
  });

  factory ContactoModel.fromJson(Map<String, dynamic> json) {
    return ContactoModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      nombre: json['nombre'] ?? '',
      departamento: json['departamento'] ?? '',
      telefono: json['telefono'] ?? '',
      extension: json['extension'],
      email: json['email'],
      puesto: json['puesto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'departamento': departamento,
      'telefono': telefono,
      'extension': extension,
      'email': email,
      'puesto': puesto,
    };
  }

  ContactoModel copyWith({
    int? id,
    String? nombre,
    String? departamento,
    String? telefono,
    String? extension,
    String? email,
    String? puesto,
  }) {
    return ContactoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      departamento: departamento ?? this.departamento,
      telefono: telefono ?? this.telefono,
      extension: extension ?? this.extension,
      email: email ?? this.email,
      puesto: puesto ?? this.puesto,
    );
  }
}
