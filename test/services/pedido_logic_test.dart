import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/pedido_model.dart'; 
import 'package:tienda_canasta_basica/models/detalle_pedido_model.dart';

void main() {
  group('HU-36 y HU-37: Lógica de Pedidos', () {
    test('El total del pedido debe ser la suma de los detalles (HU-36)', () {
      // 1. Crear detalles de prueba (Productos en el carrito)
      final detalle1 = DetallePedidoModel(
        productoId: 1, 
        cantidad: 2, 
        precioUnitario: 10.00 // Total línea: 20.00
      );
      
      final detalle2 = DetallePedidoModel(
        productoId: 2, 
        cantidad: 1, 
        precioUnitario: 50.00 // Total línea: 50.00
      );

      // 2. Crear el pedido
      final pedido = PedidoModel(
        usuarioId: 1,
        direccionId: 1,
        detalles: [detalle1, detalle2],
        estatus: 'Pendiente',
        fechaCreacion: DateTime.now()
      );

      // 3. Calcular total (Lógica que debe estar en tu modelo o controlador)
      pedido.calcularTotal(); // Llamamos al método que creamos

      // 4. Verificación
      expect(pedido.total, 70.00, reason: "El total debe ser 20 + 50 = 70");
      expect(pedido.estatus, 'Pendiente');
    });
  });
}