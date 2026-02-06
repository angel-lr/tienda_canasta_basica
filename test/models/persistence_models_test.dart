/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LOPEZ CAMARILLO DANIEL
 * FECHA>: 06-02-2026
 */


import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';
import 'package:tienda_canasta_basica/models/usuario_model.dart';
import 'package:tienda_canasta_basica/models/direccion_model.dart';
import 'package:tienda_canasta_basica/models/categoria_model.dart';
import 'package:tienda_canasta_basica/models/detalle_pedido_model.dart';

void main() {
  group('Pruebas de Persistencia - Modelos de Datos', () {
    
    //  Gestión de Productos
    test('HU-29: ProductoModel debe mapear correctamente desde JSON (BD)', () {
      final json = {
        'id': 1,
        'categoria_id': 5,
        'nombre': 'Frijol Negro',
        'descripcion': 'Bolsa 1kg',
        'precio': 35.50,
        'unidad_medida': 'kg',
        'stock': 50,
        'es_oferta': 1,  
        'precio_oferta': 30.00
      };

      final producto = ProductoModel.fromJson(json);

      expect(producto.id, 1);
      expect(producto.nombre, 'Frijol Negro');
      expect(producto.esOferta, true);
    });

    test('HU-30: Validación de integridad de Stock', () {
      final producto = ProductoModel(
        id: 1, nombre: 'Test', precio: 10, unidadMedida: 'x', stock: 10
      );
       
      producto.stock = -5;
       
      expect(producto.stock >= 0, true, reason: "El stock no debe ser negativo");
    });

    //  Gestión de Usuarios
    test('HU-33: UsuarioModel debe soportar roles de Admin y Cliente', () {
      final usuario = UsuarioModel(
        id: 1, 
        nombre: 'Admin', 
        email: 'admin@test.com', 
        password: 'hash', 
        rol: 'admin'
      );

      expect(usuario.rol, 'admin');
    });

    // Direcciones
    test('HU-34: DireccionModel debe vincularse a un UsuarioID', () {
      final direccion = DireccionModel(
        id: 1,
        usuarioId: 100, 
        nombre: 'Casa',
        calle: 'Av. Siempre Viva',
        numeroExterior: '742',
        colonia: 'Springfield',
        codigoPostal: '12345'
      );

      expect(direccion.usuarioId, 100);
    });

    // HU-35: Categorías
    test('HU-35: CategoriaModel debe tener ID y Nombre', () {
      final categoria = CategoriaModel(id: 5, nombre: 'Granos y Semillas');
      expect(categoria.nombre, 'Granos y Semillas');
    });

    //Detalles de Pedido
    test('HU-37: DetallePedido debe calcular subtotal correctamente', () {
      final detalle = DetallePedidoModel(
        productoId: 1,
        cantidad: 3,
        precioUnitario: 10.0,
        precioOferta: null
      );

      // 3 * 10 = 30
      expect(detalle.subtotal, 30.0);
    });
  });
}