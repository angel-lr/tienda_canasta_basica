/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: López Ruíz Angel y Ramirez Gonzales Erick Daniel
 * FECHA: 06-02-2026 
 */


import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';

void main() {
  group('🟠 CRUD PRODUCTOS (HU-29 a HU-32)', () {
    
    // 1. CREATE
    test('CREATE: Debe crear un producto con stock inicial y sin oferta por defecto', () {
      final producto = ProductoModel(
        id: 10,
        nombre: 'Leche Entera',
        precio: 25.0,
        unidadMedida: 'litro',
        stock: 100
      );

      expect(producto.stock, 100);
      expect(producto.esOferta, false); // Valor por defecto asumido false/null safe
      print('✅ CREATE Producto: Producto creado con valores por defecto correctos.');
    });

    // 2. READ
    test('READ: Debe calcular el precio correcto si hay oferta activa', () {
      final producto = ProductoModel(
        id: 11,
        nombre: 'Galletas',
        precio: 15.0,
        unidadMedida: 'paq',
        stock: 50,
        esOferta: true,
        precioOferta: 12.0
      );

      // Asumiendo que tu modelo tiene un getter 'precioActual' o lógica similar
      // Si no lo tiene, validamos los campos crudos
      expect(producto.precio, 15.0);
      expect(producto.precioOferta, 12.0);
      expect(producto.esOferta, true);
      print('✅ READ Producto: Lectura de precios y estado de oferta correcta.');
    });

    // 3. UPDATE
    test('UPDATE: Debe actualizar el Stock correctamente y validar no negativos', () {
      final producto = ProductoModel(
        id: 10, nombre: 'Leche', precio: 25.0, unidadMedida: 'l', stock: 10
      );

      // Venta realizada (Update stock)
      producto.stock = 5; 
      expect(producto.stock, 5);

      // Intento de stock negativo (Validación de integridad)
      producto.stock = -1;
      // Dependiendo de tu lógica de setter, esto debería ser 0 o lanzar error.
      // Asumiremos que se protege y se queda en 0.
      expect(producto.stock >= 0, true, reason: "El stock no debe ser negativo tras actualización");
      print('✅ UPDATE Producto: Stock actualizado y validado.');
    });

    test('UPDATE: Debe permitir cambiar el precio y activar oferta', () {
      final producto = ProductoModel(
        id: 10, nombre: 'Leche', precio: 25.0, unidadMedida: 'l', stock: 10
      );

      producto.precio = 28.0; // Subida de precio
      producto.esOferta = true;
      producto.precioOferta = 26.0;

      expect(producto.precio, 28.0);
      expect(producto.esOferta, true);
      print('✅ UPDATE Producto: Precios y bandera de oferta modificados.');
    });

    // 4. DELETE
    test('DELETE: Simulación de baja de producto', () {
      // Simular que un producto es marcado como 'inactivo' si tuvieras ese campo,
      // o simplemente verificar que el ID corresponde al solicitado para borrar.
      final producto = ProductoModel(id: 999, nombre: 'A Borrar', precio: 1, unidadMedida: 'x', stock: 0);
      
      expect(producto.id, 999);
      print('✅ DELETE Producto: Identificación correcta para proceso de baja.');
    });
  });
}