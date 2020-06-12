create database tienda;
use tienda;
create table usuarios(
	id int primary key auto_increment,
    usuario varchar(20) not null,
    password varchar(20) not null
);

create table categorias(
	idCategoria int primary key auto_increment,
	nombre varchar(50) not null
);

create table productos(
	idProducto int primary key auto_increment,
	nombre varchar(50) not null,
	precio int not null,
    idCategoria int,
    FOREIGN KEY (idCategoria) REFERENCES categorias(idCategoria)
);

create table pedidos(
	idPedido int primary key auto_increment,
    cantidad int not null,
    pagado varchar(1) not null,
    idProducto int,
    FOREIGN KEY (idProducto) REFERENCES productos(idProducto)
);

insert into usuarios(usuario, password) values ('admin', '123');
insert into categorias(nombre) values('Ropa');
insert into categorias(nombre) values('Computadoras');
insert into productos(nombre, precio, idCategoria) values('Camiseta ADIDAS',30000,1);
insert into productos(nombre, precio, idCategoria) values('Pantaloneta NIKE',35000,1);
insert into productos(nombre, precio, idCategoria) values('Short SUPREME',139000,1);
insert into productos(nombre, precio, idCategoria) values('Camisa LACOSTE',115000,1);
insert into productos(nombre, precio, idCategoria) values('NVIDIA GTX 1060Ti',1400000, 2);
insert into productos(nombre, precio, idCategoria) values('HYPERX RAM 8GB',80000, 2);
insert into productos(nombre, precio, idCategoria) values('Mouse RAZER MAMBA',52000, 2);
insert into productos(nombre, precio, idCategoria) values('Teclado Red Dragon',26000, 2);