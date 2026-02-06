/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LOPEZ CAMARILLO DANIEL
 * FECHA>: 06-02-2026
 */


class UsuarioModel {
  int? id;
  String nombre;
  String email;
  String password;
  String? telefono;
  String rol; 

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