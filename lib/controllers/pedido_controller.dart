/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUÍZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../models/detalle_pedido_model.dart';
import '../models/pedido_model.dart';
import '../services/persistence_service.dart';

class PedidoController extends ChangeNotifier {
  final PersistenceService _service = PersistenceService();
 
  final List<DetallePedidoModel> _carrito = [];
  bool _isProcesando = false;

  List<DetallePedidoModel> get carrito => _carrito;
  bool get isProcesando => _isProcesando;
 
  double get totalCarrito {
    return _carrito.fold(0.0, (sum, item) => sum + item.subtotal);
  }
 
  void agregarAlCarrito(ProductoModel producto, int cantidad) { 
    final index = _carrito.indexWhere((d) => d.productoId == producto.id);

    if (index != -1) {
      _carrito[index].cantidad += cantidad;
    } else {
      _carrito.add(DetallePedidoModel(
        productoId: producto.id!,
        cantidad: cantidad,
        precioUnitario: producto.precio,
        precioOferta: producto.esOferta ? producto.precioOferta : null,
      ));
    }
    notifyListeners();
  }
 
  void removerDelCarrito(int index) {
    _carrito.removeAt(index);
    notifyListeners();
  }
 
  void vaciarCarrito() {
    _carrito.clear();
    notifyListeners();
  }
 
  Future<bool> confirmarCompra(int usuarioId, int direccionId) async {
    if (_carrito.isEmpty) return false;

    _isProcesando = true;
    notifyListeners();
 
    final nuevoPedido = PedidoModel(
      usuarioId: usuarioId,
      direccionId: direccionId,
      total: totalCarrito,
      estatus: 'Pendiente',
      fechaCreacion: DateTime.now(),
      detalles: _carrito,
    );
 
    final exito = await _service.crearPedidoCompleto(nuevoPedido);

    if (exito) {
      vaciarCarrito();
    }

    _isProcesando = false;
    notifyListeners();
    
    return exito;
  }
}