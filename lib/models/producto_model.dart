/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALES ERICK DANIEL
 * FECHA>: 06-02-2026
 */



class ProductoModel {
  int? id;
  int? categoriaId;
  String nombre;
  String? descripcion;
  double precio;
  String unidadMedida;
  int _stock;
  String? imagenUrl;
  bool esOferta;
  double? precioOferta;

  ProductoModel({
    this.id,
    this.categoriaId,
    required this.nombre,
    this.descripcion,
    required this.precio,
    required this.unidadMedida,
    required int stock,
    this.imagenUrl,
    this.esOferta = false,
    this.precioOferta,
  }) : _stock = stock; 


  int get stock => _stock;
 
  set stock(int value) {
    if (value < 0) { 
      _stock = 0;
    } else {
      _stock = value;
    }
  }
 
  double get precioActual {
    if (esOferta && precioOferta != null) {
      return precioOferta!;
    }
    return precio;
  }

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      categoriaId: json['categoria_id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'], 
      precio: (json['precio'] is int) ? (json['precio'] as int).toDouble() : json['precio'],
      unidadMedida: json['unidad_medida'],
      stock: json['stock'],
      imagenUrl: json['imagen_url'],
      esOferta: json['es_oferta'] == 1 || json['es_oferta'] == true,
      precioOferta: json['precio_oferta'] != null 
          ? ((json['precio_oferta'] is int) ? (json['precio_oferta'] as int).toDouble() : json['precio_oferta']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoria_id': categoriaId,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'unidad_medida': unidadMedida,
      'stock': _stock,
      'imagen_url': imagenUrl,
      'es_oferta': esOferta,
      'precio_oferta': precioOferta,
    };
  }
}