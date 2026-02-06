/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: JOSÉ ANGEL VIRGEN ESLAVA
 * FECHA>: 06-02-2026
 */

import 'detalle_pedido_model.dart';

class PedidoModel {
  int? id;
  int usuarioId;
  int direccionId;
  double total;
  String estatus;
  DateTime fechaCreacion;
  List<DetallePedidoModel> detalles;

  PedidoModel({
    this.id,
    required this.usuarioId,
    required this.direccionId,
    this.total = 0.0,
    required this.estatus,
    required this.fechaCreacion,
    this.detalles = const [],
  });
 
  void calcularTotal() {
    double tempTotal = 0;
    for (var item in detalles) {
      tempTotal += item.subtotal;
    }
    total = tempTotal;
  }

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    var list = json['detalles'] as List? ?? [];
    List<DetallePedidoModel> detallesList = list.map((i) => DetallePedidoModel.fromJson(i)).toList();

    return PedidoModel(
      id: json['id'],
      usuarioId: json['usuario_id'],
      direccionId: json['direccion_id'],
      total: (json['total'] as num).toDouble(),
      estatus: json['estatus'],
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
      detalles: detallesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'direccion_id': direccionId,
      'total': total,
      'estatus': estatus,
      'fecha_creacion': fechaCreacion.toIso8601String(),
      'detalles': detalles.map((e) => e.toJson()).toList(),
    };
  }
}