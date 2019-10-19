CREATE TABLE Granja
(
  idGranja INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (idGranja)
);

CREATE TABLE Raza
(
  idRaza SMALLINT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (idRaza)
);

CREATE TABLE TipoHuevo
(
  idTipo TINYINT NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  PRIMARY KEY (idTipo)
);

CREATE TABLE Estado
(
  idEstado TINYINT NOT NULL,
  estado VARCHAR(30) NOT NULL,
  PRIMARY KEY (idEstado)
);

CREATE TABLE Recolector
(
  idRecolector INT NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (idRecolector)
);

CREATE TABLE Provincia
(
  idProvincia TINYINT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (idProvincia)
);

CREATE TABLE Canton
(
  idCanton TINYINT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  idProvincia TINYINT NOT NULL,
  PRIMARY KEY (idCanton),
  FOREIGN KEY (idProvincia) REFERENCES Provincia(idProvincia)
);

CREATE TABLE Gallina
(
  idGallina INT NOT NULL,
  edad TINYINT NOT NULL,
  idGranja INT NOT NULL,
  idRaza SMALLINT NOT NULL,
  idEstado TINYINT NOT NULL,
  PRIMARY KEY (idGallina),
  FOREIGN KEY (idGranja) REFERENCES Granja(idGranja),
  FOREIGN KEY (idRaza) REFERENCES Raza(idRaza),
  FOREIGN KEY (idEstado) REFERENCES Estado(idEstado),
  CHECK (edad >= 0)
);

CREATE TABLE Huevo
(
  idHuevo INT NOT NULL,
  idTipo TINYINT NOT NULL,
  idGallina INT NOT NULL,
  idRecolector INT NOT NULL,
  PRIMARY KEY (idHuevo),
  FOREIGN KEY (idTipo) REFERENCES TipoHuevo(idTipo),
  FOREIGN KEY (idGallina) REFERENCES Gallina(idGallina),
  FOREIGN KEY (idRecolector) REFERENCES Recolector(idRecolector)
);

CREATE TABLE Cliente
(
  idCliente INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  idProvincia TINYINT NOT NULL,
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idProvincia) REFERENCES Provincia(idProvincia),
  CHECK (nombre != '' and apellido != '')
);

CREATE TABLE Pedido
(
  idPedidio INT NOT NULL,
  cantidad INT NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (idPedidio),
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
  CHECK (cantidad > 0)
);

CREATE TABLE TipoXPedido
(
  id INT NOT NULL,
  idTipo TINYINT NOT NULL,
  idPedidio INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idTipo) REFERENCES TipoHuevo(idTipo),
  FOREIGN KEY (idPedidio) REFERENCES Pedido(idPedidio)
);

CREATE TABLE Factura
(
  idFactura INT NOT NULL,
  monto MONEY NOT NULL,
  idPedidio INT NOT NULL,
  PRIMARY KEY (idFactura),
  FOREIGN KEY (idPedidio) REFERENCES Pedido(idPedidio),
  check (monto > 0)
);