/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: ANGEL LÓPEZ RUÍZ
 * FECHA>: 21-02-2026
 */

import 'package:flutter/material.dart';
import '../models/categoria_model.dart';
import '../services/categoria_service.dart';

class CategoriaController extends ChangeNotifier {
  final CategoriaService _service = CategoriaService();
  
  List<CategoriaModel> _categorias = [];
  bool _isLoading = false;
  String _error = '';

  List<CategoriaModel> get categorias => _categorias;
  bool get isLoading => _isLoading;
  String get error => _error;
 
  Future<void> cargarCategorias() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categorias = await _service.obtenerCategorias();
    } catch (e) {
      _error = 'No se pudieron cargar las categorías';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
 
  Future<String> crearCategoria(String nombre) async {
    if (nombre.trim().isEmpty) return "El nombre no puede estar vacío";
    
    _isLoading = true;
    notifyListeners();

    try {
      final nuevaCategoria = CategoriaModel(nombre: nombre.trim());
      bool exito = await _service.crearCategoria(nuevaCategoria);
      
      if (exito) {
        await cargarCategorias(); 
        return "Categoría creada correctamente";
      } else {
        return "Error al crear la categoría";
      }
    } catch (e) {
      return "Error en el controlador: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
 
  Future<String> actualizarCategoria(CategoriaModel categoria) async {
    if (categoria.id == null || categoria.id! < 1) return "ID de categoría no válido";
    if (categoria.nombre.trim().isEmpty) return "El nombre no puede estar vacío";

    _isLoading = true;
    notifyListeners();

    try {
      bool exito = await _service.actualizarCategoria(categoria);
      
      if (exito) {
        await cargarCategorias(); 
        return "Categoría actualizada correctamente";
      } else {
        return "No se pudo actualizar la categoría";
      }
    } catch (e) {
      return "Error en el controlador: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
 
  Future<String> eliminarCategoria(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      bool exito = await _service.eliminarCategoria(id);
      
      if (exito) {
        await cargarCategorias(); 
        return "Categoría eliminada correctamente";
      } else {
        return "No se pudo eliminar. Verifica que no tenga productos asociados.";
      }
    } catch (e) {
      return "Error en el controlador: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
 
  Future<CategoriaModel?> buscarPorId(int id) async {
    return await _service.buscarCategoriaPorId(id);
  }
 
  Future<void> buscarPorNombre(String query) async {
    if (query.trim().isEmpty) {
      await cargarCategorias();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categorias = await _service.buscarCategoriaPorNombre(query.trim());
    } catch (e) {
      _error = 'Error en la búsqueda de categorías';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}