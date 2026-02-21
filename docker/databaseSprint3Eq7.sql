-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Feb 21, 2026 at 08:48 PM
-- Server version: 8.0.42
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tienda_canasta`
--

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Frutas y Verduras'),
(2, 'Lácteos y Huevos'),
(3, 'Abarrotes'),
(4, 'Limpieza del Hogar'),
(5, 'Bebidas');

-- --------------------------------------------------------

--
-- Table structure for table `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `id` bigint NOT NULL,
  `pedido_id` bigint DEFAULT NULL,
  `producto_id` bigint DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `precio_oferta` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detalles_pedido`
--

INSERT INTO `detalles_pedido` (`id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`, `precio_oferta`) VALUES
(1, 1, 2, 2, 25.00, 20.00),
(2, 1, 5, 1, 24.00, NULL),
(3, 1, 9, 1, 22.00, NULL),
(4, 2, 6, 1, 65.00, 58.00),
(5, 2, 14, 2, 18.00, NULL),
(6, 3, 7, 1, 120.00, NULL),
(7, 3, 11, 1, 48.00, 42.00),
(8, 3, 17, 2, 38.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `direcciones`
--

CREATE TABLE `direcciones` (
  `id` bigint NOT NULL,
  `usuario_id` bigint DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `calle` varchar(255) NOT NULL,
  `numero_exterior` varchar(20) NOT NULL,
  `numero_interior` varchar(20) DEFAULT NULL,
  `colonia` varchar(100) NOT NULL,
  `codigo_postal` varchar(10) NOT NULL,
  `referencias` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `direcciones`
--

INSERT INTO `direcciones` (`id`, `usuario_id`, `nombre`, `calle`, `numero_exterior`, `numero_interior`, `colonia`, `codigo_postal`, `referencias`) VALUES
(1, 2, 'Casa Juan', 'Av. Reforma', '123', NULL, 'Centro', '68000', 'Frente al parque'),
(2, 3, 'Casa Maria', 'Calle Hidalgo', '45', '2B', 'San Isidro', '68100', 'Portón blanco');

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

CREATE TABLE `pedidos` (
  `id` bigint NOT NULL,
  `usuario_id` bigint DEFAULT NULL,
  `direccion_id` bigint DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `estatus` varchar(50) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `direccion_id`, `total`, `estatus`, `fecha_creacion`) VALUES
(1, 2, 1, 143.00, 'Entregado', '2026-02-21 20:41:36'),
(2, 3, 2, 96.00, 'Pendiente', '2026-02-21 20:41:36'),
(3, 2, 1, 210.00, 'En camino', '2026-02-21 20:41:36');

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `id` bigint NOT NULL,
  `categoria_id` bigint DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) NOT NULL,
  `unidad_medida` varchar(50) NOT NULL,
  `stock` int NOT NULL,
  `imagen_url` text,
  `es_oferta` tinyint(1) DEFAULT '0',
  `precio_oferta` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id`, `categoria_id`, `nombre`, `descripcion`, `precio`, `unidad_medida`, `stock`, `imagen_url`, `es_oferta`, `precio_oferta`) VALUES
(1, 1, 'Manzana Roja', 'Manzana fresca por kilo', 38.00, 'kg', 100, NULL, 0, NULL),
(2, 1, 'Plátano', 'Plátano Tabasco por kilo', 25.00, 'kg', 120, NULL, 1, 20.00),
(3, 1, 'Jitomate', 'Jitomate saladet', 32.00, 'kg', 80, NULL, 0, NULL),
(4, 1, 'Cebolla Blanca', 'Cebolla blanca nacional', 28.00, 'kg', 90, NULL, 0, NULL),
(5, 2, 'Leche Entera 1L', 'Leche entera pasteurizada', 24.00, 'pieza', 200, NULL, 0, NULL),
(6, 2, 'Huevo Blanco 18 pzas', 'Huevo blanco tamaño mediano', 65.00, 'paquete', 150, NULL, 1, 58.00),
(7, 2, 'Queso Oaxaca', 'Queso Oaxaca por kilo', 120.00, 'kg', 60, NULL, 0, NULL),
(8, 2, 'Yogurt Natural 1L', 'Yogurt natural sin azúcar', 42.00, 'pieza', 70, NULL, 0, NULL),
(9, 3, 'Arroz 1kg', 'Arroz blanco super extra', 22.00, 'bolsa', 300, NULL, 0, NULL),
(10, 3, 'Frijol Negro 1kg', 'Frijol negro nacional', 34.00, 'bolsa', 250, NULL, 0, NULL),
(11, 3, 'Aceite Vegetal 900ml', 'Aceite comestible vegetal', 48.00, 'botella', 180, NULL, 1, 42.00),
(12, 3, 'Azúcar 1kg', 'Azúcar estándar', 26.00, 'bolsa', 220, NULL, 0, NULL),
(13, 4, 'Detergente 1kg', 'Detergente en polvo', 45.00, 'bolsa', 140, NULL, 0, NULL),
(14, 4, 'Cloro 1L', 'Cloro desinfectante', 18.00, 'botella', 160, NULL, 0, NULL),
(15, 4, 'Jabón de Trastes', 'Jabón líquido para trastes', 28.00, 'botella', 130, NULL, 0, NULL),
(16, 4, 'Suavizante 850ml', 'Suavizante para ropa', 36.00, 'botella', 100, NULL, 1, 30.00),
(17, 5, 'Refresco Cola 2L', 'Refresco sabor cola', 38.00, 'botella', 200, NULL, 0, NULL),
(18, 5, 'Agua 1L', 'Agua purificada', 12.00, 'botella', 400, NULL, 0, NULL),
(19, 5, 'Jugo de Naranja 1L', 'Jugo natural', 30.00, 'botella', 120, NULL, 0, NULL),
(20, 5, 'Café Soluble 200g', 'Café instantáneo', 85.00, 'frasco', 90, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `telefono`, `rol`) VALUES
(1, 'Administrador Principal', 'admin@tienda.com', 'admin123', '5512345678', 'admin'),
(2, 'Juan Pérez', 'juan@cliente.com', 'cliente123', '5587654321', 'cliente'),
(3, 'Maria López', 'maria@cliente.com', 'maria123', '5555555555', 'cliente');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_pedido` (`pedido_id`),
  ADD KEY `fk_detalle_producto` (`producto_id`);

--
-- Indexes for table `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_direccion_usuario` (`usuario_id`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pedido_usuario` (`usuario_id`),
  ADD KEY `fk_pedido_direccion` (`direccion_id`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_producto_categoria` (`categoria_id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  ADD CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Constraints for table `direcciones`
--
ALTER TABLE `direcciones`
  ADD CONSTRAINT `fk_direccion_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Constraints for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_pedido_direccion` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`),
  ADD CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_producto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
