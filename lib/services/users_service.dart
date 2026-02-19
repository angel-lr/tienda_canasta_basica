/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: RAMIREZ GONZALEZ ERICK DANIEL
 * FECHA: 17-02-2026
 */

import 'package:mysql_client/mysql_client.dart';
import 'db_connector.dart';
import '../models/usuario_model.dart';

class UsersService {
  
  // HU-42: Implementar la persistencia para actualizar un usuario.
  // Criterio: Los cambios se guardan correctamente y se valida el ID.
  Future<bool> actualizarUsuario(UsuarioModel usuario) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      
      // Solo se actualiza el usuario indicado por ID
      var result = await conn.execute(
        "UPDATE usuarios SET nombre = :nom, email = :email, password = :pass, telefono = :tel, rol = :rol WHERE id = :id",
        {
          "id": usuario.id,
          "nom": usuario.nombre,
          "email": usuario.email,
          "pass": usuario.password,
          "tel": usuario.telefono,
          "rol": usuario.rol,
        },
      );

      // Si las filas afectadas son mayores a 0, la actualización fue exitosa
      return result.affectedRows.toInt() > 0;
      
    } catch (e) {
      print('❌ Error al actualizar usuario: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
}