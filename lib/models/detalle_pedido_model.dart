/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALES ERICK DANIEL
 * FECHA>: 06-02-2026
 */



class DetallePedidoModel {
  int? id;
  int? pedidoId;
  int productoId;
  int cantidad;
  double precioUnitario;
  double? precioOferta;

  DetallePedidoModel({
    this.id,
    this.pedidoId,
    required this.productoId,
    required this.cantidad,
    required this.precioUnitario,
    this.precioOferta,
  });
 
  double get subtotal => cantidad * (precioOferta ?? precioUnitario);

  factory DetallePedidoModel.fromJson(Map<String, dynamic> json) {
    return DetallePedidoModel(
      id: json['id'],
      pedidoId: json['pedido_id'],
      productoId: json['producto_id'],
      cantidad: json['cantidad'],
      precioUnitario: (json['precio_unitario'] as num).toDouble(),
      precioOferta: json['precio_oferta'] != null 
          ? (json['precio_oferta'] as num).toDouble() 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pedido_id': pedidoId,
      'producto_id': productoId,
      'cantidad': cantidad,
      'precio_unitario': precioUnitario,
      'precio_oferta': precioOferta,
    };
  }
}