/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUIZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:mysql_client/mysql_client.dart';
import 'db_connector.dart';
import '../models/producto_model.dart';
import '../models/pedido_model.dart';
//import '../models/detalle_pedido_model.dart';

class PersistenceService {
   
  Future<List<ProductoModel>> getProductos() async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection(); 
      var result = await conn.execute("SELECT * FROM productos WHERE stock > 0");
      
      List<ProductoModel> lista = [];
      for (var row in result.rows) {
        lista.add(ProductoModel.fromJson(row.assoc()));
      }
      return lista;
    } catch (e) {
      print('❌ Error al obtener productos: $e');
      return [];
    } finally {
      await conn?.close();
    }
  }
 
  Future<List<ProductoModel>> buscarProductos(String query) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection();
      var result = await conn.execute(
        "SELECT * FROM productos WHERE nombre LIKE :query AND stock > 0",
        {"query": "%$query%"}
      );
      
      return result.rows.map((r) => ProductoModel.fromJson(r.assoc())).toList();
    } catch (e) {
      print('❌ Error en búsqueda: $e');
      return [];
    } finally {
      await conn?.close();
    }
  }
 
  Future<bool> crearPedidoCompleto(PedidoModel pedido) async {
    MySQLConnection? conn;
    try {
      conn = await DbConnector.getConnection(); 
      await conn.transactional((ctx) async {
         
        var resPedido = await ctx.execute(
          "INSERT INTO pedidos (usuario_id, direccion_id, total, estatus, fecha_creacion) VALUES (:uid, :did, :total, :estatus, NOW())",
          {
            "uid": pedido.usuarioId,
            "did": pedido.direccionId,
            "total": pedido.total,
            "estatus": "Pendiente"
          }
        );
         
        final pedidoId = resPedido.lastInsertID;
        
        for (var detalle in pedido.detalles) { 
          await ctx.execute(
            "INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario, precio_oferta) VALUES (:pid, :prodId, :cant, :pu, :po)",
            {
              "pid": pedidoId,
              "prodId": detalle.productoId,
              "cant": detalle.cantidad,
              "pu": detalle.precioUnitario,
              "po": detalle.precioOferta
            }
          );
 
          await ctx.execute(
            "UPDATE productos SET stock = stock - :cant WHERE id = :prodId",
            {
              "cant": detalle.cantidad,
              "prodId": detalle.productoId
            }
          );
        }
      });

      return true;
    } catch (e) {
      print('❌ Error CRÍTICO en transacción de pedido: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
}