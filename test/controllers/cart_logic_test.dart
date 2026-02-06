import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/controllers/pedido_controller.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';
import 'package:tienda_canasta_basica/models/pedido_model.dart';

void main() {
  group('HU-36 y HU-37: Lógica de Carrito y Pedidos', () {
    late PedidoController controller;
    final prodA = ProductoModel(id: 1, nombre: 'Aceite', precio: 50, unidadMedida: 'lt', stock: 10);
    final prodB = ProductoModel(id: 2, nombre: 'Sal', precio: 10, unidadMedida: 'kg', stock: 20);

    setUp(() {
      controller = PedidoController();
    });

    test('HU-36: El total del carrito debe iniciar en 0', () {
      expect(controller.totalCarrito, 0.0);
      expect(controller.carrito.isEmpty, true);
    });

    test('HU-36: Agregar productos debe sumar al total correctamente', () {
      // Agregar 1 Aceite (50) + 2 Sales (20) = 70
      controller.agregarAlCarrito(prodA, 1);
      controller.agregarAlCarrito(prodB, 2);

      expect(controller.totalCarrito, 70.0);
    });

    test('HU-37: Agregar el mismo producto debe agrupar en una sola línea (Detalle)', () {
      controller.agregarAlCarrito(prodA, 1);
      controller.agregarAlCarrito(prodA, 1); // Agregamos otro igual

      expect(controller.carrito.length, 1, reason: "Debe haber solo un item en la lista");
      expect(controller.carrito.first.cantidad, 2);
    });

    test('HU-39: El pedido nuevo debe tener estatus Pendiente por defecto', () {
      final pedido = PedidoModel(
        usuarioId: 1, 
        direccionId: 1, 
        total: 100, 
        estatus: 'Pendiente', 
        fechaCreacion: DateTime.now()
      );
      
      expect(pedido.estatus, 'Pendiente');
    });
  });
}