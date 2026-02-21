/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: ANGEL LÓPEZ RUIZ
 * FECHA>: 21-02-2026
 */

import 'package:mysql_client/mysql_client.dart';
import 'db_connector.dart';
import '../models/categoria_model.dart';

class CategoriaService {
   
  Future<bool> crearCategoria(CategoriaModel categoria) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "INSERT INTO categorias (nombre) VALUES (:nombre)",
        {"nombre": categoria.nombre},
      );
      return result.affectedRows.toInt() > 0;
    } catch (e) {
      print('❌ Error al crear categoría: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
 
  Future<bool> actualizarCategoria(CategoriaModel categoria) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "UPDATE categorias SET nombre = :nombre WHERE id = :id",
        {
          "id": categoria.id,
          "nombre": categoria.nombre,
        },
      );
      return result.affectedRows.toInt() > 0;
    } catch (e) {
      print('❌ Error al actualizar categoría: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
 
  Future<bool> eliminarCategoria(int id) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "DELETE FROM categorias WHERE id = :id",
        {"id": id},
      );
      return result.affectedRows.toInt() > 0;
    } catch (e) { 
      print('❌ Error al eliminar categoría: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
 
  Future<List<CategoriaModel>> obtenerCategorias() async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute("SELECT * FROM categorias");
      
      List<CategoriaModel> lista = [];
      for (var row in result.rows) {
        lista.add(CategoriaModel.fromJson(row.assoc()));
      }
      return lista;
    } catch (e) {
      print('❌ Error al obtener categorías: $e');
      return [];
    } finally {
      await conn?.close();
    }
  }
 
  Future<CategoriaModel?> buscarCategoriaPorId(int id) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "SELECT * FROM categorias WHERE id = :id",
        {"id": id},
      );
      if (result.rows.isEmpty) return null;
      
      return CategoriaModel.fromJson(result.rows.first.assoc());
    } catch (e) {
      print('❌ Error al buscar categoría por ID: $e');
      return null;
    } finally {
      await conn?.close();
    }
  }
 
  Future<List<CategoriaModel>> buscarCategoriaPorNombre(String nombre) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "SELECT * FROM categorias WHERE nombre LIKE :nombre",
        {"nombre": "%$nombre%"},
      );
      
      List<CategoriaModel> lista = [];
      for (var row in result.rows) {
        lista.add(CategoriaModel.fromJson(row.assoc()));
      }
      return lista;
    } catch (e) {
      print('❌ Error al buscar categoría por nombre: $e');
      return [];
    } finally {
      await conn?.close();
    }
  }
}