import 'package:mysql_client/mysql_client.dart';

class DbConnector {
  /// Crea y abre una nueva conexión a la base de datos.
  static Future<MySQLConnection> getConnection() async {
    try {
      // Configuración para MySQL 8
      final conn = await MySQLConnection.createConnection(
        host: '127.0.0.1', // IP explícita para Linux
        port: 3306,
        userName: 'root',
        password: 'root', 
        databaseName: 'tienda_canasta',
        secure: false, // Desactiva SSL para evitar problemas de handshake
      );

      // Abrimos la conexión
      await conn.connect();
      
      return conn;
    } catch (e) {
      print('❌ ERROR CRÍTICO AL CONECTAR CON MYSQL: $e');
      rethrow;
    }
  }
}