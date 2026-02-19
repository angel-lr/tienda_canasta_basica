/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALEZ ERICK DANIEL
 * FECHA: 17-02-2026
 */

import '../models/usuario_model.dart';
import '../services/users_service.dart';

class UsersController {
  final UsersService _usersService = UsersService();

  // HU-42: Implementar la persistencia para actualizar un usuario. [cite: 22, 47]
  // Esta función llama al servicio y retorna un mensaje de éxito o error.
  Future<String> actualizarUsuario(UsuarioModel usuario) async {
    try {
      // Validación previa: Se agrega '!' para asegurar que el ID no es nulo antes de comparar
      // Cumple con el criterio: Solo se actualiza el usuario indicado por ID 
      if (usuario.id == null || usuario.id! < 1) {
        return "Error: ID de usuario no válido.";
      }

      bool exito = await _usersService.actualizarUsuario(usuario);

      if (exito) {
        return "Usuario actualizado correctamente.";
      } else {
        // Cumple con el criterio: Si el usuario no existe, se indica el error [cite: 48, 49]
        return "No se pudo actualizar: El usuario no existe.";
      }
    } catch (e) {
      return "Error en el controlador: $e";
    }
  }
}