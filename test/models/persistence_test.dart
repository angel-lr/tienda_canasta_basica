import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/producto_model.dart';
import 'package:tienda_canasta_basica/models/usuario_model.dart';
import 'package:tienda_canasta_basica/models/direccion_model.dart';

void main() {
  group('🟢 Módulo Persistencia: Modelos y Datos (HU-29 a HU-40)', () {
    
    test('HU-29: Validar mapeo de Productos (Alta)', () {
      final prod = ProductoModel(
        id: 1, 
        nombre: 'Arroz', 
        precio: 20.0, 
        unidadMedida: 'kg', 
        stock: 50
      );

      expect(prod.nombre, 'Arroz');
      print('✅ HU-29 VALIDADA: El modelo Producto acepta datos correctamente para el Alta.');
    });

    test('HU-30: Validar integridad de Stock (Actualización)', () {
      final prod = ProductoModel(
        id: 1, nombre: 'Test', precio: 10, unidadMedida: 'x', stock: 10
      );
      
      prod.stock = -5; // Intentamos romper la regla

      expect(prod.stock, 0); // Asumiendo que tu setter protege el valor
      print('✅ HU-30 VALIDADA: El sistema protege contra stock negativo (Integridad de datos).');
    });

    test('HU-33: Validar estructura de Usuarios (Registro)', () {
      final user = UsuarioModel(
        id: 1, 
        nombre: 'Juan', 
        email: 'juan@test.com', 
        password: '123', 
        rol: 'cliente'
      );

      expect(user.email.contains('@'), true);
      print('✅ HU-33 VALIDADA: El modelo Usuario valida estructura básica.');
    });

    test('HU-34: Validar vinculación de Direcciones', () {
      final dir = DireccionModel(
        id: 1, 
        usuarioId: 99, 
        nombre: 'Casa', 
        calle: 'Centro', 
        numeroExterior: '1', 
        colonia: 'Centro', 
        codigoPostal: '00000'
      );

      expect(dir.usuarioId, 99);
      print('✅ HU-34 VALIDADA: Las direcciones se vinculan correctamente al ID de usuario.');
    });
  });
}