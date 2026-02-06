class UsuarioModel {
  int? id;
  String nombre;
  String email;
  String password; // Recuerda hashear esto en producción
  String? telefono;
  String rol; // 'admin' o 'cliente'

  UsuarioModel({
    this.id,
    required this.nombre,
    required this.email,
    required this.password,
    this.telefono,
    required this.rol,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      password: json['password'],
      telefono: json['telefono'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'telefono': telefono,
      'rol': rol,
    };
  }
}