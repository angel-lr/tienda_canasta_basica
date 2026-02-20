-- ============================================
-- Script de Base de Datos para MySQL
-- Sistema de Tienda en Línea
-- ============================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tienda_database 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE tienda_database;

-- Desactivar verificación de claves foráneas temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- TABLA: usuarios
-- ============================================
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    rol ENUM('admin', 'cliente') NOT NULL,
    INDEX idx_email (email),
    INDEX idx_rol (rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tabla de usuarios del sistema con roles de admin y cliente';

-- ============================================
-- TABLA: categorias
-- ============================================
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    INDEX idx_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Categorías de productos';

-- ============================================
-- TABLA: productos
-- ============================================
DROP TABLE IF EXISTS productos;

CREATE TABLE productos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    categoria_id BIGINT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    unidad_medida VARCHAR(50) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen_url VARCHAR(500),
    es_oferta BOOLEAN DEFAULT FALSE,
    precio_oferta DECIMAL(10,2),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_categoria (categoria_id),
    INDEX idx_nombre (nombre),
    INDEX idx_es_oferta (es_oferta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Catálogo de productos con sistema de ofertas';

-- ============================================
-- TABLA: direcciones
-- ============================================
DROP TABLE IF EXISTS direcciones;

CREATE TABLE direcciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    calle VARCHAR(255) NOT NULL,
    numero_exterior VARCHAR(20) NOT NULL,
    numero_interior VARCHAR(20),
    colonia VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    referencias TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_usuario (usuario_id),
    INDEX idx_codigo_postal (codigo_postal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Direcciones de envío de los usuarios';

-- ============================================
-- TABLA: pedidos
-- ============================================
DROP TABLE IF EXISTS pedidos;

CREATE TABLE pedidos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    direccion_id BIGINT,
    total DECIMAL(10,2) NOT NULL,
    estatus ENUM('pendiente', 'enviado', 'entregado') NOT NULL DEFAULT 'pendiente',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (direccion_id) REFERENCES direcciones(id) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_usuario (usuario_id),
    INDEX idx_estatus (estatus),
    INDEX idx_fecha (fecha_creacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Pedidos realizados por los clientes';

-- ============================================
-- TABLA: detalles_pedido
-- ============================================
DROP TABLE IF EXISTS detalles_pedido;

CREATE TABLE detalles_pedido (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT,
    producto_id BIGINT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_pedido (pedido_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Detalle de items en cada pedido con precio histórico';

-- Reactivar verificación de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- DATOS DE EJEMPLO (Opcional)
-- ============================================

-- Insertar categorías de ejemplo
INSERT INTO categorias (nombre) VALUES 
('Frutas y Verduras'),
('Lácteos'),
('Carnes y Pescados'),
('Panadería'),
('Bebidas'),
('Despensa');

-- Insertar usuario administrador de ejemplo
INSERT INTO usuarios (nombre, email, password, telefono, rol) VALUES 
('Administrador', 'admin@tienda.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '5512345678', 'admin');
-- Nota: La contraseña es un hash de ejemplo. En producción usar bcrypt o similar.

-- Insertar algunos productos de ejemplo
INSERT INTO productos (categoria_id, nombre, descripcion, precio, unidad_medida, stock, es_oferta, precio_oferta) VALUES 
(1, 'Manzana Red Delicious', 'Manzanas frescas de temporada', 35.00, 'kg', 100, TRUE, 29.90),
(1, 'Plátano Chiapas', 'Plátanos orgánicos', 18.00, 'kg', 150, FALSE, NULL),
(2, 'Leche Entera', 'Leche fresca de vaca 1L', 22.50, 'litro', 80, FALSE, NULL),
(2, 'Queso Panela', 'Queso panela artesanal', 85.00, 'kg', 30, FALSE, NULL),
(5, 'Agua Natural', 'Agua purificada 1.5L', 12.00, 'pieza', 200, FALSE, NULL);

-- ============================================
-- VISTAS ÚTILES
-- ============================================

-- Vista de productos con nombre de categoría
CREATE OR REPLACE VIEW vista_productos_completa AS
SELECT 
    p.id,
    p.nombre AS producto,
    c.nombre AS categoria,
    p.descripcion,
    p.precio,
    p.precio_oferta,
    p.es_oferta,
    CASE 
        WHEN p.es_oferta = TRUE THEN p.precio_oferta 
        ELSE p.precio 
    END AS precio_actual,
    p.unidad_medida,
    p.stock,
    p.imagen_url
FROM productos p
LEFT JOIN categorias c ON p.categoria_id = c.id;

-- Vista de pedidos con información del cliente
CREATE OR REPLACE VIEW vista_pedidos_completa AS
SELECT 
    pe.id AS pedido_id,
    pe.fecha_creacion,
    pe.estatus,
    pe.total,
    u.nombre AS cliente,
    u.email,
    u.telefono,
    CONCAT(d.calle, ' ', d.numero_exterior, ', ', d.colonia, ' CP:', d.codigo_postal) AS direccion_entrega
FROM pedidos pe
LEFT JOIN usuarios u ON pe.usuario_id = u.id
LEFT JOIN direcciones d ON pe.direccion_id = d.id;

-- ============================================
-- PROCEDIMIENTOS ALMACENADOS ÚTILES
-- ============================================

DELIMITER //

-- Procedimiento para calcular el total de un pedido
CREATE PROCEDURE sp_calcular_total_pedido(IN p_pedido_id BIGINT)
BEGIN
    UPDATE pedidos 
    SET total = (
        SELECT COALESCE(SUM(cantidad * precio_unitario), 0)
        FROM detalles_pedido 
        WHERE pedido_id = p_pedido_id
    )
    WHERE id = p_pedido_id;
END//

-- Procedimiento para actualizar stock después de un pedido
CREATE PROCEDURE sp_actualizar_stock(
    IN p_producto_id BIGINT, 
    IN p_cantidad INT
)
BEGIN
    UPDATE productos 
    SET stock = stock - p_cantidad 
    WHERE id = p_producto_id;
END//

DELIMITER ;

-- ============================================
-- FIN DEL SCRIPT
-- ============================================

-- Mostrar resumen de tablas creadas
SHOW TABLES;

-- Verificar la estructura
SELECT 
    TABLE_NAME as 'Tabla',
    TABLE_ROWS as 'Registros',
    ENGINE as 'Motor',
    TABLE_COMMENT as 'Descripción'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'tienda_database' 
AND TABLE_TYPE = 'BASE TABLE';
