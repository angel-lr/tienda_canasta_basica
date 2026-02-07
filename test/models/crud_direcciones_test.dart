/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: López Camarillo Daniel 
 * FECHA: 06-02-2026 
 */


import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/direccion_model.dart';

void main() {
  group('🟢 CRUD DIRECCIONES (HU-34)', () {
    
    // 1. CREATE
    test('CREATE: Debe registrar una dirección completa vinculada al usuario', () {
      final dir = DireccionModel(
        id: 1,
        usuarioId: 5,
        nombre: 'Oficina',
        calle: 'Reforma',
        numeroExterior: '222',
        colonia: 'Juárez',
        codigoPostal: '06600'
      );

      expect(dir.usuarioId, 5);
      expect(dir.codigoPostal, '06600');
      print('✅ CREATE Dirección: Dirección creada y vinculada correctamente.');
    });

    // 2. READ
    test('READ: Debe leer todos los campos de ubicación correctamente', () {
      final dir = DireccionModel(
        id: 1, usuarioId: 1, nombre: 'Casa', calle: 'Madero', numeroExterior: '1', colonia: 'Centro', codigoPostal: '12345',
        referencias: 'Portón negro'
      );

      expect(dir.calle, 'Madero');
      expect(dir.referencias, 'Portón negro');
      print('✅ READ Dirección: Datos de ubicación legibles.');
    });

    // 3. UPDATE
    test('UPDATE: Debe permitir corregir el número o referencias', () {
      final dir = DireccionModel(
        id: 1, usuarioId: 1, nombre: 'Casa', calle: 'Madero', numeroExterior: '1', colonia: 'Centro', codigoPostal: '12345'
      );

      // Corrección de usuario
      dir.numeroExterior = '1-B';
      dir.referencias = 'Timbre no sirve';

      expect(dir.numeroExterior, '1-B');
      expect(dir.referencias, 'Timbre no sirve');
      print('✅ UPDATE Dirección: Corrección de datos exitosa.');
    });
    
    // 4. DELETE (Simulado)
    test('DELETE: Verificación de ID para borrado', () {
        final dir = DireccionModel(id: 55, usuarioId: 1, nombre: 'X', calle: 'X', numeroExterior: '1', colonia: 'X', codigoPostal: '0');
        expect(dir.id, 55); // Confirmamos que tenemos el ID necesario para llamar a la BD y borrar
        print('✅ DELETE Dirección: ID listo para operación de borrado.');
    });
  });
}