import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../models/detalle_pedido_model.dart';
import '../models/pedido_model.dart';
import '../services/persistence_service.dart';

class PedidoController extends ChangeNotifier {
  final PersistenceService _service = PersistenceService();

  // Estado del Carrito (Lista temporal en memoria)
  final List<DetallePedidoModel> _carrito = [];
  bool _isProcesando = false;

  List<DetallePedidoModel> get carrito => _carrito;
  bool get isProcesando => _isProcesando;

  // Calcular total al vuelo
  double get totalCarrito {
    return _carrito.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  /// Agrega un producto al carrito
  void agregarAlCarrito(ProductoModel producto, int cantidad) {
    // Verificar si ya existe para sumar cantidad
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

  /// Elimina un item del carrito
  void removerDelCarrito(int index) {
    _carrito.removeAt(index);
    notifyListeners();
  }

  /// Limpia todo
  void vaciarCarrito() {
    _carrito.clear();
    notifyListeners();
  }

  /// Finaliza la compra y guarda en Base de Datos
  Future<bool> confirmarCompra(int usuarioId, int direccionId) async {
    if (_carrito.isEmpty) return false;

    _isProcesando = true;
    notifyListeners();

    // 1. Armar el objeto Pedido completo
    final nuevoPedido = PedidoModel(
      usuarioId: usuarioId,
      direccionId: direccionId,
      total: totalCarrito,
      estatus: 'Pendiente', // Estatus inicial
      fechaCreacion: DateTime.now(),
      detalles: _carrito,
    );

    // 2. Enviar al servicio de persistencia
    final exito = await _service.crearPedidoCompleto(nuevoPedido);

    if (exito) {
      vaciarCarrito(); // Limpiar si se vendió
    }

    _isProcesando = false;
    notifyListeners();
    
    return exito;
  }
}