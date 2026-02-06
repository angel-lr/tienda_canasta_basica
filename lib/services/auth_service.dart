import 'package:mysql_client/mysql_client.dart';
import '../models/usuario_model.dart';
import 'db_connector.dart';

class AuthService {
  
  Future<UsuarioModel?> login(String email, String password) async {
    MySQLConnection? conn;
    
    try {
      conn = await DbConnector.getConnection();

      // Ejecutamos la consulta (el signo ? sigue siendo el placeholder seguro)
      var result = await conn.execute(
        'SELECT id, nombre, email, password, telefono, rol FROM usuarios WHERE email = :email AND password = :password',
        {'email': email, 'password': password}, // Este paquete usa mapas para parámetros nombrados o ? para posicionales
      );

      // Verificamos si hay filas
      if (result.rows.isNotEmpty) {
        final row = result.rows.first;
        
        // Mapeamos los datos (el acceso a columnas es por nombre usando assoc())
        final data = row.assoc();
        
        return UsuarioModel(
          id: int.tryParse(data['id'] ?? '0'), // MySQL a veces devuelve strings, aseguramos el tipo
          nombre: data['nombre']!,
          email: data['email']!,
          password: data['password']!,
          telefono: data['telefono'],
          rol: data['rol']!,
        );
      }
      
      return null; // Usuario no encontrado

    } catch (e) {
      print('❌ Error en AuthService: $e');
      return null;
    } finally {
      // Importante: Cerrar la conexión
      if (conn != null && conn.connected) {
        await conn.close();
      }
    }
  }
}