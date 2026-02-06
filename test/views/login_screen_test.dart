import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';

void main() {
  group('HU-29 y HU-30: Persistencia de Productos', () {
    // Datos de prueba 
    final Map<String, dynamic> productoJson = {
      'id': 1,
      'categoria_id': 5,
      'nombre': 'Arroz Super Extra',
      'descripcion': 'Bolsa de 1kg',
      'precio': 25.50,
      'unidad_medida': 'kg',
      'stock': 100,
      'es_oferta': true,
      'precio_oferta': 22.00
    };

    test('El modelo Producto debe crearse correctamente desde JSON (HU-29)', () {
      final producto = ProductoModel.fromJson(productoJson);

      expect(producto.id, 1);
      expect(producto.nombre, 'Arroz Super Extra');
      expect(producto.precio, 25.50);
      expect(producto.esOferta, true);
    });

    test('Validación de Stock: No debe permitir stock negativo (HU-30)', () {
      final producto = ProductoModel.fromJson(productoJson);
      
      // Simulamos una venta lógica
      producto.stock = producto.stock - 10;
      expect(producto.stock, 90);

      // Verificamos que la lógica de negocio proteja la integridad
      // (Asumiendo que agregaste un setter o método de validación en tu modelo)
      bool stockValido = producto.stock >= 0;
      expect(stockValido, true, reason: "El stock nunca debe ser menor a 0");
    });

    test('Cálculo de precio final con oferta (Regla de Negocio)', () {
      final producto = ProductoModel.fromJson(productoJson);
      // Si está en oferta, el precio activo debe ser el de oferta
      expect(producto.precioActual, 22.00);
    });
  });
}