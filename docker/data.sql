USE tienda_canasta;

-- =========================
-- CATEGORIAS
-- =========================
INSERT INTO categorias (id, nombre) VALUES
(1, 'Frutas y Verduras'),
(2, 'Lácteos y Huevos'),
(3, 'Abarrotes'),
(4, 'Limpieza del Hogar'),
(5, 'Bebidas');


-- =========================
-- PRODUCTOS
-- =========================
INSERT INTO productos (id, categoria_id, nombre, descripcion, precio, unidad_medida, stock, imagen_url, es_oferta, precio_oferta) VALUES

-- Frutas y Verduras
(1, 1, 'Manzana Roja', 'Manzana fresca por kilo', 38.00, 'kg', 100, NULL, 0, NULL),
(2, 1, 'Plátano', 'Plátano Tabasco por kilo', 25.00, 'kg', 120, NULL, 1, 20.00),
(3, 1, 'Jitomate', 'Jitomate saladet', 32.00, 'kg', 80, NULL, 0, NULL),
(4, 1, 'Cebolla Blanca', 'Cebolla blanca nacional', 28.00, 'kg', 90, NULL, 0, NULL),

-- Lácteos y Huevos
(5, 2, 'Leche Entera 1L', 'Leche entera pasteurizada', 24.00, 'pieza', 200, NULL, 0, NULL),
(6, 2, 'Huevo Blanco 18 pzas', 'Huevo blanco tamaño mediano', 65.00, 'paquete', 150, NULL, 1, 58.00),
(7, 2, 'Queso Oaxaca', 'Queso Oaxaca por kilo', 120.00, 'kg', 60, NULL, 0, NULL),
(8, 2, 'Yogurt Natural 1L', 'Yogurt natural sin azúcar', 42.00, 'pieza', 70, NULL, 0, NULL),

-- Abarrotes
(9, 3, 'Arroz 1kg', 'Arroz blanco super extra', 22.00, 'bolsa', 300, NULL, 0, NULL),
(10, 3, 'Frijol Negro 1kg', 'Frijol negro nacional', 34.00, 'bolsa', 250, NULL, 0, NULL),
(11, 3, 'Aceite Vegetal 900ml', 'Aceite comestible vegetal', 48.00, 'botella', 180, NULL, 1, 42.00),
(12, 3, 'Azúcar 1kg', 'Azúcar estándar', 26.00, 'bolsa', 220, NULL, 0, NULL),

-- Limpieza del Hogar
(13, 4, 'Detergente 1kg', 'Detergente en polvo', 45.00, 'bolsa', 140, NULL, 0, NULL),
(14, 4, 'Cloro 1L', 'Cloro desinfectante', 18.00, 'botella', 160, NULL, 0, NULL),
(15, 4, 'Jabón de Trastes', 'Jabón líquido para trastes', 28.00, 'botella', 130, NULL, 0, NULL),
(16, 4, 'Suavizante 850ml', 'Suavizante para ropa', 36.00, 'botella', 100, NULL, 1, 30.00),

-- Bebidas
(17, 5, 'Refresco Cola 2L', 'Refresco sabor cola', 38.00, 'botella', 200, NULL, 0, NULL),
(18, 5, 'Agua 1L', 'Agua purificada', 12.00, 'botella', 400, NULL, 0, NULL),
(19, 5, 'Jugo de Naranja 1L', 'Jugo natural', 30.00, 'botella', 120, NULL, 0, NULL),
(20, 5, 'Café Soluble 200g', 'Café instantáneo', 85.00, 'frasco', 90, NULL, 0, NULL);

-- =========================
-- DIRECCIONES
-- =========================
INSERT INTO direcciones (id, usuario_id, nombre, calle, numero_exterior, numero_interior, colonia, codigo_postal, referencias) VALUES
(1, 2, 'Casa Juan', 'Av. Reforma', '123', NULL, 'Centro', '68000', 'Frente al parque'),
(2, 3, 'Casa Maria', 'Calle Hidalgo', '45', '2B', 'San Isidro', '68100', 'Portón blanco');


-- =========================
-- PEDIDOS
-- =========================
INSERT INTO pedidos (id, usuario_id, direccion_id, total, estatus, fecha_creacion) VALUES
(1, 2, 1, 143.00, 'Entregado', NOW()),
(2, 3, 2, 96.00, 'Pendiente', NOW()),
(3, 2, 1, 210.00, 'En camino', NOW());


-- =========================
-- DETALLES PEDIDO
-- =========================
INSERT INTO detalles_pedido (id, pedido_id, producto_id, cantidad, precio_unitario, precio_oferta) VALUES
(1, 1, 2, 2, 25.00, 20.00),
(2, 1, 5, 1, 24.00, NULL),
(3, 1, 9, 1, 22.00, NULL),

(4, 2, 6, 1, 65.00, 58.00),
(5, 2, 14, 2, 18.00, NULL),

(6, 3, 7, 1, 120.00, NULL),
(7, 3, 11, 1, 48.00, 42.00),
(8, 3, 17, 2, 38.00, NULL);