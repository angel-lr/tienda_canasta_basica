class ProductoModel {
  int? id;
  int? categoriaId;
  String nombre;
  String? descripcion;
  double precio;
  String unidadMedida;
  int _stock; // Propiedad privada para encapsular validación
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
  }) : _stock = stock; // Inicializador

  // Getter para obtener el stock
  int get stock => _stock;

  // Setter con validación de integridad (HU-30)
  set stock(int value) {
    if (value < 0) {
      // Opción A: Lanzar error
      // throw Exception("El stock no puede ser negativo");
      // Opción B: Ajustar a 0 (Defensivo)
      _stock = 0;
    } else {
      _stock = value;
    }
  }

  // Lógica de Negocio: Calcular precio real
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
      // Manejo seguro de tipos numéricos (int a double)
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