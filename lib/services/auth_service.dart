/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUÍZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:mysql_client/mysql_client.dart';
import '../models/usuario_model.dart';
import 'db_connector.dart';

class AuthService {
  
  Future<UsuarioModel?> login(String email, String password) async {
    MySQLConnection? conn;
    
    try {
      conn = await DbConnector.getConnection();
 
      var result = await conn.execute(
        'SELECT id, nombre, email, password, telefono, rol FROM usuarios WHERE email = :email AND password = :password',
        {'email': email, 'password': password}, 
      );
 
      if (result.rows.isNotEmpty) {
        final row = result.rows.first;
        final data = row.assoc();
        
        return UsuarioModel(
          id: int.tryParse(data['id'] ?? '0'),
          nombre: data['nombre']!,
          email: data['email']!,
          password: data['password']!,
          telefono: data['telefono'],
          rol: data['rol']!,
        );
      }
      
      return null; 

    } catch (e) {
      print('❌ Error en AuthService: $e');
      return null;
    } finally { 
      if (conn != null && conn.connected) {
        await conn.close();
      }
    }
  }
}