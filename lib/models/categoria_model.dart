/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALES ERICK DANIEL
 * FECHA>: 06-02-2026
 */



class CategoriaModel {
  int? id;
  String nombre;

  CategoriaModel({
    this.id,
    required this.nombre,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}