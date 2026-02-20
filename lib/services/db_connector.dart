/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUIZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:mysql_client/mysql_client.dart';

class DbConnector { 
  static Future<MySQLConnection> getConnection() async {
    try {
      // En caso de dandroid sse ussara 10.0.0.2
      final conn = await MySQLConnection.createConnection(
        host: '127.0.0.1',
        port: 3306,
        userName: 'admin',
        password: 'admin', 
        databaseName: 'tienda_canasta',
        secure: false,  
      );
 
      await conn.connect();
      
      return conn;
    } catch (e) {
      print('❌ ERROR CRÍTICO AL CONECTAR CON MYSQL: $e');
      rethrow;
    }
  }
}
