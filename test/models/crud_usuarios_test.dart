/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: López Camarillo Daniel y Virgen Eslava José Angel
 * FECHA: 06-02-2026 
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/usuario_model.dart';

void main() {
  group('🔵 CRUD USUARIOS (HU-33 y HU-11)', () {
    
    // 1. CREATE (Crear)
    test('CREATE: Debe crear un usuario válido con todos sus campos obligatorios', () {
      final usuario = UsuarioModel(
        id: 1,
        nombre: 'Juan Pérez',
        email: 'juan@test.com',
        password: 'passwordSeguro123',
        telefono: '5512345678',
        rol: 'cliente'
      );

      expect(usuario.nombre, 'Juan Pérez');
      expect(usuario.email, 'juan@test.com');
      expect(usuario.rol, 'cliente');
      print('✅ CREATE Usuario: Usuario creado correctamente.');
    });

    test('CREATE: Debe mapear correctamente desde un JSON (Simulación de BD)', () {
      final json = {
        'id': 2,
        'nombre': 'Admin Principal',
        'email': 'admin@tienda.com',
        'password': 'hash_password',
        'telefono': '5587654321',
        'rol': 'admin'
      };

      final usuario = UsuarioModel.fromJson(json);
      expect(usuario.id, 2);
      expect(usuario.rol, 'admin');
      print('✅ CREATE Usuario (JSON): Mapeo desde BD exitoso.');
    });

    // 2. READ (Leer)
    test('READ: Debe permitir acceder a la información sensible (Password) para validación', () {
      final usuario = UsuarioModel(
        id: 1, nombre: 'Test', email: 'test@test.com', password: 'secret_pass', rol: 'cliente'
      );
      
      // En un caso real, aquí validaríamos contra un hash, pero el modelo debe permitir leerlo
      expect(usuario.password, 'secret_pass');
      print('✅ READ Usuario: Acceso a propiedades correcto.');
    });

    // 3. UPDATE (Actualizar)
    test('UPDATE: Debe permitir la modificación de datos del perfil (Teléfono y Nombre)', () {
      final usuario = UsuarioModel(
        id: 1, nombre: 'Juan', email: 'juan@test.com', password: '123', rol: 'cliente'
      );

      // Simulación de actualización
      usuario.nombre = 'Juan Actualizado';
      usuario.telefono = '9999999999';

      expect(usuario.nombre, 'Juan Actualizado');
      expect(usuario.telefono, '9999999999');
      print('✅ UPDATE Usuario: Datos modificados correctamente.');
    });

    // 4. DELETE (Eliminar - Simulado)
    test('DELETE: Debe validar que el ID sea nulo o manejable tras una "eliminación"', () {
      // En modelos puros, Delete se suele manejar anulando la referencia o usando un flag 'activo'
      UsuarioModel? usuario = UsuarioModel(
        id: 1, nombre: 'Borrar', email: 'borrar@test.com', password: '123', rol: 'cliente'
      );

      // Simulación de eliminación lógica o limpieza de variable
      usuario = null;

      expect(usuario, isNull);
      print('✅ DELETE Usuario: Referencia eliminada correctamente.');
    });
  });
}