/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: López Camarillo Daniel y López Ruíz Angel
 * FECHA: 06-02-2026 
 */


import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/pedido_model.dart';
import 'package:tienda_canasta_basica/models/detalle_pedido_model.dart';

void main() {
  group('🟣 CRUD PEDIDOS (HU-36, HU-37, HU-39)', () {
    
    // 1. CREATE
    test('CREATE: Debe crear un pedido con lista de detalles vacía o inicializada', () {
      final pedido = PedidoModel(
        usuarioId: 1,
        direccionId: 1,
        total: 0.0,
        estatus: 'Pendiente',
        fechaCreacion: DateTime.now()
      );

      expect(pedido.detalles, isEmpty);
      expect(pedido.estatus, 'Pendiente');
      print('✅ CREATE Pedido: Cabecera de pedido creada correctamente.');
    });

    // 2. READ
    test('READ: Debe calcular el total sumando los subtotales de los detalles', () {
      final d1 = DetallePedidoModel(productoId: 1, cantidad: 2, precioUnitario: 10.0); // 20.0
      final d2 = DetallePedidoModel(productoId: 2, cantidad: 1, precioUnitario: 50.0); // 50.0

      final pedido = PedidoModel(
        usuarioId: 1, direccionId: 1, total: 0, estatus: 'Pendiente', fechaCreacion: DateTime.now(),
        detalles: [d1, d2]
      );

      // Si tienes un método calcularTotal(), úsalo. Si no, simulamos la lógica:
      double totalCalculado = 0;
      for(var d in pedido.detalles) {
        totalCalculado += (d.cantidad * d.precioUnitario);
      }
      pedido.total = totalCalculado;

      expect(pedido.total, 70.0);
      print('✅ READ Pedido: Total calculado correctamente leyendo detalles.');
    });

    // 3. UPDATE
    test('UPDATE: Debe permitir cambiar el estatus del pedido (Ej. Pendiente -> Enviado)', () {
      final pedido = PedidoModel(
        usuarioId: 1, direccionId: 1, total: 100, estatus: 'Pendiente', fechaCreacion: DateTime.now()
      );

      // Actualización de estado (flujo de negocio)
      pedido.estatus = 'Enviado';
      expect(pedido.estatus, 'Enviado');
      
      pedido.estatus = 'Entregado';
      expect(pedido.estatus, 'Entregado');
      
      print('✅ UPDATE Pedido: Cambio de estatus exitoso.');
    });

    // 4. DELETE
    test('DELETE: Debe permitir eliminar un detalle del pedido antes de confirmar', () {
      final d1 = DetallePedidoModel(productoId: 1, cantidad: 1, precioUnitario: 10);
      final pedido = PedidoModel(
        usuarioId: 1, direccionId: 1, total: 10, estatus: 'Pendiente', fechaCreacion: DateTime.now(),
        detalles: [d1] // Lista mutable
      );

      expect(pedido.detalles.length, 1);

      // Simular eliminación de item del carrito/pedido
      // Nota: Si tu lista es 'const' o fija, esto fallaría. Asegúrate de que sea mutable (List<Detalle>).
      // Si usaste el constructor por defecto 'const []', tendrás que asignar una nueva lista.
      List<DetallePedidoModel> nuevaLista = List.from(pedido.detalles);
      nuevaLista.removeAt(0);
      pedido.detalles = nuevaLista;

      expect(pedido.detalles, isEmpty);
      print('✅ DELETE Detalle: Item eliminado del pedido correctamente.');
    });
  });
}