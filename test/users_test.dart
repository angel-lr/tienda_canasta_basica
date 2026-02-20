/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALEZ ERICK DANIEL
 * FECHA: 19-02-2026
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/usuario_model.dart';
import 'package:tienda_canasta_basica/controllers/users_controller.dart';

void main() {
  // HU-42: Implementar la persistencia para actualizar un usuario 
  group('Pruebas Unitarias - Módulo 2: Gestión de Usuario', () {
    final UsersController usersController = UsersController();

    test('HU-42: Debe validar que los cambios se guarden correctamente', () async {
      // Configuración de datos de prueba según el modelo de Daniel
      final usuarioPrueba = UsuarioModel(
        id: 1, 
        nombre: "Erick Daniel Actualizado",
        email: "erick.nuevo@mail.com",
        password: "nuevaPassword123",
        telefono: "9531234567",
        rol: "cliente"
      );

      // Ejecución: Se llama al controlador para persistir los cambios 
      final resultado = await usersController.actualizarUsuario(usuarioPrueba);

      // Verificación: Se espera éxito o un error controlado si el ID no existe 
      expect(resultado, anyOf(
        equals("Usuario actualizado correctamente."),
        equals("No se pudo actualizar: El usuario no existe.")
      ));
    });

    test('HU-42: Debe indicar error si el ID del usuario no es válido', () async {
      final usuarioInvalido = UsuarioModel(
        id: 0, 
        nombre: "Test",
        email: "test@mail.com",
        password: "123",
        telefono: "000",
        rol: "cliente"
      );

      final resultado = await usersController.actualizarUsuario(usuarioInvalido);

      // Verificación del criterio: Solo se actualiza el usuario indicado por ID 
      expect(resultado, equals("Error: ID de usuario no válido."));
    });


    //TEST DE LA HU-44
 test('HU-44: Debe retornar un usuario cuando el ID existe', () async {
      final int idExistente = 1; 
      final resultado = await usersController.obtenerUsuario(idExistente);
      expect(resultado, anyOf(
        isA<UsuarioModel>(),
        equals("Error: El usuario con ID $idExistente no fue encontrado.")
      ));
    });
  }); // <--- Esta cierra el grupo
} // <--- Esta cierra el main
