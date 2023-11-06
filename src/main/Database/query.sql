DROP DATABASE IF EXISTS ParagonDB;
CREATE DATABASE ParagonDB;

USE ParagonDB;

CREATE TABLE marcas (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    banner_img text
);


CREATE TABLE promociones(
	id bigint auto_increment primary key,
    nombre varchar(100) not null,
	descripcion text NOT NULL,
    precio DECIMAL(10,5) NOT NULL
);

CREATE TABLE categorias (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    banner_img text,
    referencia_img text
);

CREATE TABLE productos (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
	marca_id bigint NOT NULL,
    categoria_id bigint NOT NULL,
    especificaciones TEXT NOT NULL,
    img text NOT NULL,
    cantidad INT NOT NULL,
    descuento DECIMAL(5, 2),
    estado varchar(100) NOT NULL
);

CREATE TABLE comentarios(
producto_id bigint NOT NULL,
cliente_id bigint NOT NULL,
comentario text NOT NULL,
calificacion int not null,
fecha date not null
);

CREATE TABLE combos(
	id bigint auto_increment primary key,
    promocion_id bigint NOT NULL,
    producto_id bigint NOT NULL
);

CREATE TABLE usuarios (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    rol varchar(100) NOT NULL
);

CREATE TABLE clientes (
    usuario_id bigint primary key NOT NULL,
    telefono char(9) NOT NULL,
	puntos bigint NOT NULL
);


CREATE TABLE ventas (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    transaccion varchar(255),
    fecha varchar(50) NOT NULL,
    hora varchar(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    descuento_total DECIMAL(10, 2),
    cliente_nom varchar(200) NOT NULL,
    cliente_correo varchar(200) NOT NULL,
    cliente_telefono varchar(200) NOT NULL,
    cliente_id bigint ,
	metodo_pago varchar(100)
);

CREATE TABLE venta_detalle (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    venta_id bigint NOT NULL,
    producto_id bigint NOT NULL,
    cantidad INT NOT NULL,
    monto_unit DECIMAL(10, 2) NOT NULL,
    desc_aplicado DECIMAL(10, 2),
    subtotal DECIMAL(10,2) NOT NULL
);

ALTER TABLE combos
ADD CONSTRAINT FK_combo_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
ADD CONSTRAINT FK_combo_promo FOREIGN KEY (promocion_id) REFERENCES promociones(id);


ALTER TABLE productos
ADD CONSTRAINT FK_producto_marca FOREIGN KEY (marca_id) REFERENCES marcas(id) ON DELETE CASCADE,
ADD CONSTRAINT FK_producto_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE;

ALTER TABLE comentarios
ADD CONSTRAINT FK_coment_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
ADD CONSTRAINT FK_coment_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(usuario_id) ON DELETE CASCADE;


ALTER TABLE ventas
ADD CONSTRAINT FK_ventas_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(usuario_id) ON DELETE CASCADE;

ALTER TABLE venta_detalle
ADD CONSTRAINT FK_vDetalle_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
ADD CONSTRAINT FK_vDetalle_venta FOREIGN KEY (venta_id) REFERENCES ventas(id) ON DELETE CASCADE;

ALTER TABLE clientes
ADD CONSTRAINT FK_clie_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

CREATE UNIQUE INDEX idx_email_unico ON usuarios (email);


INSERT INTO Usuarios(nombres,apellidos,email,contraseña,rol) values('Admin Nombres','Admin Apellidos','admin@paragon.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','administrador');
  
