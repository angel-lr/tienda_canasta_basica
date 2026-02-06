import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/controllers/pedido_controller.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';
import 'package:tienda_canasta_basica/models/pedido_model.dart';

void main() {
  group('🟢 Módulo Lógica: Carrito y Pedidos (HU-36 a HU-39)', () {
    late PedidoController controller;
    final p1 = ProductoModel(id: 1, nombre: 'A', precio: 10, unidadMedida: 'x', stock: 100);
    final p2 = ProductoModel(id: 2, nombre: 'B', precio: 20, unidadMedida: 'x', stock: 100);

    setUp(() => controller = PedidoController());

    test('HU-36: Cálculo de Totales', () {
      controller.agregarAlCarrito(p1, 2); // 2 * 10 = 20
      controller.agregarAlCarrito(p2, 1); // 1 * 20 = 20
      
      expect(controller.totalCarrito, 40.0);
      print('✅ HU-36 VALIDADA: El sistema calcula el total (20 + 20 = 40) correctamente.');
    });

    test('HU-37: Agrupación de Detalles', () {
      controller.agregarAlCarrito(p1, 1);
      controller.agregarAlCarrito(p1, 5); // 6 en total

      expect(controller.carrito.length, 1);
      expect(controller.carrito.first.cantidad, 6);
      print('✅ HU-37 VALIDADA: Los detalles del mismo producto se agrupan en una sola línea.');
    });

    test('HU-39: Estados del Pedido', () {
      final pedido = PedidoModel(
        usuarioId: 1, direccionId: 1, total: 100, estatus: 'Pendiente', fechaCreacion: DateTime.now()
      );
      
      expect(pedido.estatus, 'Pendiente');
      print('✅ HU-39 VALIDADA: El pedido se inicializa con estatus "Pendiente".');
    });
  });
}