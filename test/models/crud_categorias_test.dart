/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: López Camarillo Daniel  
 * FECHA: 06-02-2026 
 */


import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/categoria_model.dart';

void main() {
  group('🟡 CRUD CATEGORÍAS (HU-35)', () {
    
    // 1. CREATE
    test('CREATE: Debe crear una categoría con nombre válido', () {
      final cat = CategoriaModel(id: 1, nombre: 'Lácteos');
      expect(cat.nombre, 'Lácteos');
      print('✅ CREATE Categoría: Categoría creada.');
    });

    // 2. READ
    test('READ: Debe permitir leer el ID y nombre para listados', () {
      final cat = CategoriaModel(id: 10, nombre: 'Frutas y Verduras');
      expect(cat.id, 10);
      expect(cat.nombre, 'Frutas y Verduras');
      print('✅ READ Categoría: Datos accesibles para UI.');
    });

    // 3. UPDATE
    test('UPDATE: Debe permitir renombrar la categoría', () {
      final cat = CategoriaModel(id: 1, nombre: 'Frutas');
      
      cat.nombre = 'Frutas Frescas';
      expect(cat.nombre, 'Frutas Frescas');
      print('✅ UPDATE Categoría: Nombre actualizado.');
    });
  });
}