use master
GO

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases
WHERE ('['+ name +']' = 'Trsocial'
OR name = 'Trsocial')))

DROP DATABASE Trsocial
GO

CREATE DATABASE Trsocial ON PRIMARY
(
	name = 'Trsocial',
	FILENAME = 'C:\t\Trsocial.mdf',
	SIZE = 5 MB,
	MAXSIZE = 20 MB,
	FILEGROWTH = 1 MB
)
LOG ON
(
	name = 'Trsocial_log',
	FILENAME = 'C:\t\Trsocial.log',
	SIZE = 5 MB,
	MAXSIZE = 20 MB,
	FILEGROWTH = 1 MB
);
GO

USE Trsocial
GO


CREATE TABLE Deteccion 
(
	idDeteccion INT NOT NULL,
	docente int null,
	administrativo int null,
	psicologo int null
	CONSTRAINT PKDeteccion PRIMARY KEY (idDeteccion)
)
GO

CREATE TABLE Problematica
(
	idProblema INT not null,
	fecha DATE NULL,
	probPersonal INT NULL,
	probCurricular INT NULL
	CONSTRAINT PKProblematica PRIMARY KEY (idProblema)	
)
GO

CREATE TABLE Resultado
(
	idResultado INT NOT NULL,
	muyBueno INT NULL,
	bueno INT NULL,
	regular INT NULL,
	malo INT NULL,
	muyMalo INT NULL
	CONSTRAINT PKResultado PRIMARY KEY (idResultado)
)
GO

CREATE TABLE Alumno
(

	id int not null,
	matricula varchar(20) not null,
	nombre varchar(30) null,
	apPaterno varchar(30) null,
	apMaterno varchar(30) null,
	sexo varchar(30) null,
	turno varchar(30) null,
	carrera varchar(30) null,
	semestre varchar(30) null,
	idDeteccion INT NULL,
	idResultado INT NULL,
	idProblema INT NULL
	CONSTRAINT PKAlumno PRIMARY KEY (id)
)
GO

-- LLAVES FORANEAS--
ALTER TABLE Alumno ADD CONSTRAINT FKDeteccion
FOREIGN KEY (idDeteccion) REFERENCES Deteccion(idDeteccion)

ALTER TABLE Alumno ADD CONSTRAINT FKProblematica
FOREIGN KEY (idProblema) REFERENCES Problematica (idProblema)

ALTER TABLE Alumno ADD CONSTRAINT FKResultado
FOREIGN KEY (idResultado) REFERENCES Resultado (idResultado)

--index-- 
CREATE INDEX IXAlumno ON Alumno (matricula)
GO

CREATE INDEX IXDeteccion ON Deteccion (idDeteccion)
GO

CREATE INDEX IXProblematica ON Problematica (idProblema)
GO

----------------------------------------------------------------------------