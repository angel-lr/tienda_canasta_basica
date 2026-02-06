class DireccionModel {
  int? id;
  int usuarioId;
  String nombre; // Alias: "Casa", "Oficina"
  String calle;
  String numeroExterior;
  String? numeroInterior;
  String colonia;
  String codigoPostal;
  String? referencias;

  DireccionModel({
    this.id,
    required this.usuarioId,
    required this.nombre,
    required this.calle,
    required this.numeroExterior,
    this.numeroInterior,
    required this.colonia,
    required this.codigoPostal,
    this.referencias,
  });

  factory DireccionModel.fromJson(Map<String, dynamic> json) {
    return DireccionModel(
      id: json['id'],
      usuarioId: json['usuario_id'],
      nombre: json['nombre'],
      calle: json['calle'],
      numeroExterior: json['numero_exterior'],
      numeroInterior: json['numero_interior'],
      colonia: json['colonia'],
      codigoPostal: json['codigo_postal'],
      referencias: json['referencias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'nombre': nombre,
      'calle': calle,
      'numero_exterior': numeroExterior,
      'numero_interior': numeroInterior,
      'colonia': colonia,
      'codigo_postal': codigoPostal,
      'referencias': referencias,
    };
  }
}