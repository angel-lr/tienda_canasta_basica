import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../services/persistence_service.dart';

class ProductoController extends ChangeNotifier {
  final PersistenceService _service = PersistenceService();
  
  // Estado
  List<ProductoModel> _productos = [];
  bool _isLoading = false;
  String _error = '';

  // Getters para la vista
  List<ProductoModel> get productos => _productos;
  bool get isLoading => _isLoading;
  String get error => _error;

  /// Carga inicial de datos
  Future<void> cargarCatalogo() async {
    _isLoading = true;
    _error = '';
    notifyListeners(); // Avisa a la UI que muestre loading

    try {
      _productos = await _service.getProductos();
    } catch (e) {
      _error = 'No se pudo cargar el catálogo';
    } finally {
      _isLoading = false;
      notifyListeners(); // Avisa a la UI que ya terminó
    }
  }

  /// Filtro de búsqueda
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