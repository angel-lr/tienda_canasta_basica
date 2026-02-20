/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALEZ ERICK DANIEL
 * FECHA: 19-02-2026
 */

import '../models/usuario_model.dart';
import '../services/users_service.dart';

class UsersController {
  final UsersService _usersService = UsersService();

  // HU-42: Implementar la persistencia para actualizar un usuario.
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
        // Cumple con el criterio: Si el usuario no existe, se indica el error 
        return "No se pudo actualizar: El usuario no existe.";
      }
    } catch (e) {
      return "Error en el controlador: $e";
    }
  }


  /**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ CAMARILLO DANIEL
 * FECHA: 20-02-2026
 */

  
  // HU-44: Lógica para buscar un usuario por su ID
  Future<dynamic> obtenerUsuario(int? id) async {
    try {
      if (id == null || id! < 1) {
        return "Error: ID de usuario no válido.";
      }
      UsuarioModel? usuario = await _usersService.buscarUsuarioPorId(id!);
      if (usuario != null) {
        return usuario;
      } else {
        return "Error: El usuario con ID $id no fue encontrado.";
      }
    } catch (e) {
      return "Error en el controlador al buscar: $e";
    }
  }
}
