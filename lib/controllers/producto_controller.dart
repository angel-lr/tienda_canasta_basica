/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUÍZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../services/persistence_service.dart';

class ProductoController extends ChangeNotifier {
  final PersistenceService _service = PersistenceService();
   
  List<ProductoModel> _productos = [];
  bool _isLoading = false;
  String _error = '';
 
  List<ProductoModel> get productos => _productos;
  bool get isLoading => _isLoading;
  String get error => _error;
 
  Future<void> cargarCatalogo() async {
    _isLoading = true;
    _error = '';
    notifyListeners(); 

    try {
      _productos = await _service.getProductos();
    } catch (e) {
      _error = 'No se pudo cargar el catálogo';
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
 
  Future<void> buscar(String query) async {
    if (query.isEmpty) {
      await cargarCatalogo();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _productos = await _service.buscarProductos(query);
    } catch (e) {
      _error = 'Error en la búsqueda';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}