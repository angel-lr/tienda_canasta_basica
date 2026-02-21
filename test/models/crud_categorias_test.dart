
import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/models/categoria_model.dart';
import 'package:tienda_canasta_basica/controllers/categoria_controller.dart';

void main() {
  /**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL GRUPO DE PRUEBAS: López Camarillo Daniel  
 * FECHA: 06-02-2026 (Actualizado: 06-02-2026)
 */
  group('🟡 CRUD CATEGORÍAS - Pruebas de Modelo en Memoria (HU-35)', () {
    
    // 1. CREATE
    test('CREATE: Debe crear una categoría con nombre válido', () {
      final cat = CategoriaModel(id: 1, nombre: 'Lácteos');
      expect(cat.nombre, 'Lácteos');
      print('✅ CREATE Categoría: Categoría creada en memoria.');
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
      print('✅ UPDATE Categoría: Nombre actualizado en memoria.');
    });
  });

  /**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL GRUPO DE PRUEBAS: LÓPEZ RUÍZ ANGEL
 * FECHA: 06-02-2026 
 */ 
  group('🟡 CATEGORÍAS - Pruebas de Integración y Persistencia (HU-50 A  HU-53)', () {
    final CategoriaController controller = CategoriaController();

    test('Flujo: CREATE, READ, UPDATE y DELETE real en Base de Datos', () async {
      // 1. CREATE: Creamos una categoría temporal con un sufijo de tiempo para evitar duplicados
      final String nombrePrueba = 'Cat Prueba Borrado ${DateTime.now().millisecondsSinceEpoch}';
      final resultadoCrear = await controller.crearCategoria(nombrePrueba);
      expect(resultadoCrear, equals("Categoría creada correctamente"));
      print('✅ BD CREATE: Categoría de prueba insertada.');

      // 2. READ: Buscamos la categoría recién creada para obtener el ID que le asignó MySQL
      await controller.buscarPorNombre(nombrePrueba);
      final categoriasEncontradas = controller.categorias;
      expect(categoriasEncontradas, isNotEmpty);
      
      final categoriaTemporal = categoriasEncontradas.first;
      final int idGenerado = categoriaTemporal.id!;
      print('✅ BD READ: Categoría recuperada con ID: $idGenerado.');

      // 3. UPDATE: Le cambiamos el nombre para comprobar la actualización
      categoriaTemporal.nombre = '$nombrePrueba Modificada';
      final resultadoUpdate = await controller.actualizarCategoria(categoriaTemporal);
      expect(resultadoUpdate, equals("Categoría actualizada correctamente"));
      print('✅ BD UPDATE: Categoría modificada en la base de datos.');

      // 4. DELETE: Eliminamos la categoría usando el ID para dejar limpia la base de datos
      final resultadoDelete = await controller.eliminarCategoria(idGenerado);
      expect(resultadoDelete, equals("Categoría eliminada correctamente"));
      
      // 5. COMPROBACIÓN FINAL: Intentamos buscarla por ID para asegurar que ya no existe
      final busquedaPostBorrado = await controller.buscarPorId(idGenerado);
      expect(busquedaPostBorrado, isNull);
      print('✅ BD DELETE: Categoría de prueba eliminada exitosamente. La BD está limpia.');
    });

    test('Validación de Integridad: NO debe permitir eliminar una categoría con productos', () async { 
      final int idCategoriaOcupada = 1; 

      final resultado = await controller.eliminarCategoria(idCategoriaOcupada);
       
      expect(resultado, equals("No se pudo eliminar. Verifica que no tenga productos asociados."));
      print('✅ BD RESTRICCIÓN: Se bloqueó correctamente la eliminación de una categoría en uso.');
    });

    test('Validación de Búsqueda: Debe retornar error si se actualiza con ID inválido', () async {
      final categoriaInvalida = CategoriaModel(id: 0, nombre: 'Fantasma');
      final resultado = await controller.actualizarCategoria(categoriaInvalida);
      
      expect(resultado, equals("ID de categoría no válido"));
      print('✅ BD VALIDACIÓN: Se detectó correctamente un ID inválido.');
    });
  });
}