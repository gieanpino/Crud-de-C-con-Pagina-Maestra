CREATE DATABASE BDAbogadosAsoc;
go
USE BDAbogadosAsoc;
Go
CREATE TABLE tblTIpoDOc
( strCod_TIDO VARCHAR(2) PRIMARY KEY NOT NULL,
 strDescripcion_TIDO VARCHAR(25) NOT NULL
);
go
CREATE TABLE tblTIpoCAso
( strCod_TICA VARCHAR(2) PRIMARY KEY NOT NULL,
 strDescripcion_TICA VARCHAR(25) NOT NULL
);
go

CREATE TABLE tblCLAsifTIpoCAso
( intCod_CLAsTICA int PRIMARY KEY NOT NULL,
 strDescripcion_CLAsTICA VARCHAR(25) NOT NULL,
 strCodTICA VARCHAR(2) NOT NULL
);
go
CREATE TABLE tblASOciado
( strNroDoc_ASO VARCHAR(20) PRIMARY KEY NOT NULL,
 strTipoDoc_ASO VARCHAR(2) NOT NULL,
 strNombre_ASO VARCHAR(60) NOT NULL,
 BITActivo_ASO BIT DEFAULT 1 NOT NULL
);
go
CREATE TABLE tblCLIente
( strNroDoc_CLI VARCHAR(20) PRIMARY KEY NOT NULL,
 strTipoDoc_CLI VARCHAR(2) NOT NULL,
 strNombre_CLI VARCHAR(60) NOT NULL,
 strTelefono_CLI VARCHAR(20) NOT NULL
);
go
CREATE TABLE tblCASos
( Id_CAS INT IDENTITY PRIMARY KEY NOT NULL,
 IdCLI_CAS VARCHAR(20) NOT NULL,
 IdASO_CAS VARCHAR(20) NOT NULL,
 dtmFecha_CAS DATETIME DEFAULT GETDATE() NOT NULL,
 intCodCLAsTICA_CAS int NOT NULL
);
go
CREATE TABLE tblCASos_DETalle
( Id_CASDET INT IDENTITY PRIMARY KEY NOT NULL,
 IdCAS_CASDET INT NOT NULL,
 dtmFecha_CASDET DATETIME DEFAULT GETDATE() NOT NULL,
 IdSEG_CASDET INT NOT NULL,
 strDescripcion_CASDET VARCHAR(4000) NOT NULL,
 strObservacion_CASDET VARCHAR(4000) NOT NULL
);
go
CREATE TABLE tblSEGuimientos
( Id_SEG INT PRIMARY KEY NOT NULL,
 strDescripcion_SEG VARCHAR(20) NOT NULL
);
go
CREATE TABLE tblPreLIminares
( Id_PLI INT PRIMARY KEY NOT NULL,
 strDescripcion_PLI VARCHAR(30) NOT NULL
);
go
CREATE TABLE tblPREliminares_CASo
( Id_PRECAS INT IDENTITY PRIMARY KEY NOT NULL,
 IdCAS_PRECAS INT NOT NULL,
 IdPLI_PRECAS INT NOT NULL
);
go

ALTER TABLE tblASOciado ADD FOREIGN KEY (strTipoDoc_ASO) REFERENCES tblTIpoDOc (strCod_TIDO);
ALTER TABLE tblCLIente ADD FOREIGN KEY (strTipoDoc_CLI) REFERENCES tblTIpoDOc (strCod_TIDO);
ALTER TABLE tblCASos ADD FOREIGN KEY (IdCLI_CAS) REFERENCES tblCLIente (strNroDoc_CLI);
ALTER TABLE tblCASos ADD FOREIGN KEY (IdASO_CAS) REFERENCES tblASOciado (strNroDoc_ASO);
ALTER TABLE tblCASos ADD FOREIGN KEY (intCodCLAsTICA_CAS) REFERENCES tblCLAsifTIpoCAso (intCod_CLAsTICA);
ALTER TABLE tblCASos_DETalle ADD FOREIGN KEY (IdCAS_CASDET) REFERENCES tblCASos (Id_CAS);
ALTER TABLE tblCLAsifTIpoCAso ADD FOREIGN KEY (strCodTICA) REFERENCES tblTIpoCAso (strCod_TICA);
ALTER TABLE tblCASos_DETalle ADD FOREIGN KEY (IdSEG_CASDET) REFERENCES tblSEGuimientos (Id_SEG);
ALTER TABLE tblPREliminares_CASo ADD FOREIGN KEY (IdCAS_PRECAS) REFERENCES tblCASos (Id_CAS);
ALTER TABLE tblPREliminares_CASo ADD FOREIGN KEY (IdPLI_PRECAS) REFERENCES tblPreLIminares (Id_PLI);
goINSERT INTO tblTIpoDOc VALUES ( 'CC', 'Cédula de Ciudadanía'), ( 'NI', 'NIT'), ( 'NU', 'NUIP'),
 ( 'RU', 'RUT'), ( 'CE', 'Cédula de Extranjería'), ( 'PA', 'Pasaporte'),
 ( 'TI', 'Tarjeta de Identidad'),( 'RC', 'Registro Civil');
INSERT INTO tblTIpoCAso VALUES ( 'CI', 'Civil'),( 'PE', 'Penal'),
 ( 'CA', 'Contencioso/Admtivo'),( 'LA', 'Laboral');
INSERT INTO tblCLAsifTIpoCAso VALUES ( 1, 'Separación', 'CI'), ( 2, 'Divorcio', 'CI'), ( 3, 'Deuda', 'CI'),
 ( 4, 'Daños y Perjuicios', 'CI'), ( 5, 'Falta de Pagos', 'CI'), ( 6, 'Otro', 'CI'), ( 7, 'Robo', 'PE'),
 ( 8, 'Asesinato', 'PE'), ( 9, 'Falsificación', 'PE'), (10, 'Tráfico de Drogas', 'PE'),
 (11, 'Peculado', 'PE'), (12, 'Otro', 'PE'), (13, 'Actos de Gestión', 'CA'),
 (14, 'Actos de autoridad', 'CA'), (15, 'Despido', 'LA'), (16, 'Sanciones', 'LA'),
 (17, 'Jubilación', 'LA'), (18, 'Orfandad', 'LA'), (19, 'Acoso', 'LA'), (20, 'Otro', 'LA');
INSERT INTO tblASOciado VALUES ( '702040', 'CC','Beatriz Zuluaga Ramirez', 1),
 ( '909090', 'CE','Robert Higgin Towers', 1), ( '702020', 'CC','Juan P. Cardona A.', 1);
INSERT INTO tblCLIente VALUES ( '70500600', 'CC', 'María José Tobón López', '317 4202020'),
 ( '800100100','NI', 'Almacenes Don Juaco Ltda.', '2303030');
INSERT INTO tblSEGuimientos VALUES ( 1, 'Preámbulo'), ( 2, 'Indagación'),
 ( 3, 'Radicación'), ( 4, 'Consulta'), ( 5, 'Recolección'), ( 6, 'Juicio'), ( 7, 'Cerrado');
INSERT INTO tblPreLIminares VALUES ( 1, 'Llamada a Policía'), ( 2, 'Denunciado'),
 ( 3, 'Sospechosos Detenidos'),( 4, 'Personas con Cargos');
GO-- ========== Relacionada con: tblTIpoDOc =============
CREATE PROCEDURE USP_TipoDoc_BuscarGeneral
AS
 BEGIN
 SELECT strCod_TIDO Clave, strDescripcion_TIDO as Dato
 FROM tblTIpoDOc
 ORDER BY strDescripcion_TIDO
 END
-- Exec USP_TipoDoc_BuscarGeneral;
GO
-- ======== Relacionada con: tblASOciado ===========
CREATE PROCEDURE USP_Asoc_BuscarGeneral
AS
 BEGIN
 SELECT strNroDoc_ASO AS NroDoc,
 strTipoDoc_ASO AS TipoDoc,
 strNombre_ASO AS Nombre,
 bitActivo_ASO AS Activo
 FROM tblASOciado
 ORDER BY Nombre
-- EXEC USP_Asoc_BuscarGeneral;
 END
GO
CREATE PROCEDURE USP_Asoc_BuscarXcodigo
@strCodigo VARCHAR(20)
AS
 BEGIN
 SELECT strNroDoc_ASO AS NroDoc,
 strTipoDoc_ASO AS strTipo,
 strNombre_ASO AS Abogado,
 bitActivo_ASO AS Activo
 FROM tblASOciado
 WHERE strNroDoc_ASO = @strCodigo
 -- EXEC USP_Asoc_BuscarXcodigo 702040;
 END
GO
CREATE PROCEDURE USP_Asoc_Grabar
@strCodigo VARCHAR(20),
@strTipo VARCHAR(2),
@strNombre VARCHAR(60),
@bitActivo BIT
AS
 BEGIN
 IF EXISTS( SELECT * FROM tblASOciado
 WHERE strNroDoc_ASO = @strCodigo OR
 strNombre_ASO = @strNombre )
 BEGIN
 SELECT -1 AS Rpta
 Return
 END
 ELSE
 BEGIN
 BEGIN TRANSACTION tx
 INSERT INTO tblASOciado
 VALUES (@strCodigo, @strTipo, @strNombre, @bitActivo);
 IF ( @@ERROR > 0 )
 BEGIN
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 END
 COMMIT TRANSACTION tx
 SELECT @strCodigo AS Rpta
 Return
 END
 -- EXEC USP_Asoc_Grabar '70500600', 'CC', 'Juan Aristizábal', 1;
 -- EXEC USP_Asoc_BuscarXcodigo '70500600';
 END
GO
CREATE PROCEDURE USP_Asoc_Modificar
@strCodigo VARCHAR(20),
@strTipo VARCHAR(2),
@strNombre VARCHAR(60),
@bitActivo BIT
As
 BEGIN
 IF EXISTS( SELECT *
 FROM tblASOciado
 WHERE strNroDoc_ASO <> @strCodigo AND
 strNombre_ASO = @strNombre )
 BEGIN
 SELECT -1 AS Rpta
 Return
 END
 ELSE
 BEGIN
 BEGIN TRANSACTION tx
 UPDATE tblASOciado
 SET strTipoDoc_ASO = @strTipo,
 strNombre_ASO = @strNombre,
 bitActivo_ASO = @bitActivo
 WHERE strNroDoc_ASO = @strCodigo
 IF ( @@ERROR > 0 )
 Begin
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 End
 COMMIT TRANSACTION tx
 SELECT @strCodigo AS Rpta
 Return
 END
 -- EXEC USP_Asoc_Modificar '70500600', 'CE', 'Juan P. Aristizábal C.', 1;
 -- EXEC USP_Asoc_BuscarXcodigo '70500600';
 END
GO
CREATE PROCEDURE USP_Asoc_LlenarCombo
AS
 BEGIN
 SELECT strNroDoc_ASO as Clave, strNombre_ASO As Dato
 FROM tblASOciado
 ORDER BY strNombre_ASO
 -- EXEC USP_Asoc_LlenarCombo;
 END
GO
-- ======== Relacionada con: tblTIpoCAso ===========
CREATE PROCEDURE USP_TipoCaso_BuscarGeneral
AS
 BEGIN
 SELECT strCod_TICA As Clave, strDescripcion_TICA As Dato
 FROM tblTIpoCAso
 ORDER BY strDescripcion_TICA
 -- EXEC USP_TipoCaso_BuscarGeneral;
 END
GO
-- ===== Relacionada con: tblCLAsifTIpoCAso ======
CREATE PROCEDURE USP_tblCLAsifTIpoCAso_BuscarGeneral
@strCodigo VARCHAR(2)
AS
 BEGIN
 SELECT intCod_CLAsTICA As Clave,
strDescripcion_CLAsTICA As Dato
 FROM tblCLAsifTIpoCAso
 WHERE strCodTICA = @strCodigo
 ORDER BY Clave asc
 -- EXEC USP_tblCLAsifTIpoCAso_BuscarGeneral 'LA';
 END
GO
-- ======== Relacionada con: tblCLIente ===========
CREATE PROCEDURE USP_Cliente_BuscarCliente
@strCodigo VARCHAR(20)
AS
 BEGIN
 SELECT strNombre_CLI as Cliente
 FROM tblCLIente
 WHERE strNroDoc_CLI = @strCodigo
 -- EXEC USP_Cliente_BuscarCliente 70500600;
 END
GO
-- ====== Relacionada con: tblCASos_DETalle =========
CREATE PROCEDURE USP_Caso_BuscarDetalle_X_Caso
@intCaso int
AS
 BEGIN
 SELECT convert ( VARCHAR(12), dtmFecha_CASDET, 103) As Fecha,
 Id_CASDET as CodSeg,
 strDescripcion_SEG as Seguimiento,
 strDescripcion_CASDET As Descripción,
 strObservacion_CASDET As Observación
 FROM tblCASos_DETalle
 INNER JOIN tblSEGuimientos ON IdSEG_CASDET = Id_SEG
 WHERE IdCAS_CASDET = @intCaso
 -- EXEC USP_Caso_BuscarDetalle_X_Caso '1';
 END
GO
CREATE PROCEDURE USP_Caso_GrabarDetalle
@IdCaso int,
@IdSeg int,
@Descripcion VARCHAR(4000),
@Observaciones VARCHAR(4000)
AS
 BEGIN
 BEGIN TRANSACTION tx
 INSERT INTO tblCASos_DETalle
( IdCAS_CASDET, IdSEG_CASDET,
 strDescripcion_CASDET, strObservacion_CASDET )
 VALUES ( @IdCaso, @IdSeg, @Descripcion, @Observaciones );
 IF ( @@ERROR > 0 )
 BEGIN
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 END
 COMMIT TRANSACTION tx
 SELECT @IdCaso AS Rpta
 Return
-- EXEC USP_Caso_GrabarDetalle 1, 1, 'Posible asesinato', 'Por venganza';
-- EXEC USP_Caso_GrabarDetalle 1, 2, 'Consulta a testigos', 'A machete';
 END
GO
CREATE PROCEDURE USP_Caso_BorrarDetalle
@intIdDet int
AS
 BEGIN TRANSACTION tx
 DELETE FROM tblCASos_DETalle
 WHERE Id_CASDET = @intIdDet;
 IF ( @@ERROR > 0 )
 BEGIN
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 END
 COMMIT TRANSACTION tx
 SELECT @intIdDet AS Rpta
 Return
 -- EXEC USP_Caso_BorrarDetalle 1
GO
-- ======== Relacionada con: tblCASos ===========
CREATE PROCEDURE USP_Caso_BuscarXCodigo
@intCaso int
AS
 BEGIN
 SELECT Id_CAS As Cod,
 Convert (varchar(10), dtmFecha_CAS, 103) As Fecha,
 IdASO_CAS as Asoc, IdCLI_CAS as NroDoc,
 strNombre_CLI as Cliente,
 strCod_TICA as TipoCaso,
 intCodCLAsTICA_CAS as TIpoCAso_Caso
 FROM tblCASos
 INNER JOIN tblCLIente ON strNroDoc_CLI = IdCLI_CAS
 INNER JOIN tblCLAsifTIpoCAso ON
 intCodCLAsTICA_CAS = intCod_CLAsTICA
 INNER JOIN tblTIpoCAso ON
 strCodTICA = strCod_TICA
 WHERE Id_CAS = @intCaso
 EXEC USP_Caso_BuscarDetalle_X_Caso @intCaso;
 -- EXEC USP_Caso_BuscarXCodigo 1;
 END
GO
CREATE PROCEDURE USP_Caso_Grabar
@IdCli VARCHAR(20),
@IdAsoc VARCHAR(20),
@intTipoCasoCaso int
AS
 BEGIN
 BEGIN TRANSACTION tx
 INSERT INTO tblCASos ( IdCLI_CAS, IdASO_CAS,
 dtmFecha_CAS, intCodCLAsTICA_CAS )
 VALUES (@IdCli, @IdAsoc, GETDATE(), @intTipoCasoCaso);
 IF ( @@ERROR > 0 )
 BEGIN
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 END
 COMMIT TRANSACTION tx
 SELECT @@IDENTITY AS Rpta
 Return
 -- EXEC USP_Caso_Grabar '70500600','702020', 8;
 END
GO
CREATE PROCEDURE USP_Caso_Modificar
@IdCodigo int,
@IdAsoc VARCHAR(20),
@IdCliente VARCHAR(20),
@intTipoCasoCaso int
As
 BEGIN
 BEGIN TRANSACTION tx
 UPDATE tblCASos
 SET IdCLI_CAS = @IdCliente,
 IdASO_CAS = @IdAsoc,
 intCodCLAsTICA_CAS = @intTipoCasoCaso
 WHERE Id_CAS = @IdCodigo
DELETE FROM tblPREliminares_CASo
 WHERE IdCAS_PRECAS = @IdCodigo
 IF ( @@ERROR > 0 )
 Begin
 ROLLBACK TRANSACTION tx
 SELECT 0 AS Rpta
 Return
 End
 COMMIT TRANSACTION tx
 SELECT @IdCodigo AS Rpta
 Return
 -- EXEC USP_Caso_Modificar 1,'70500600','702020', 9;
 END
GO
CREATE PROCEDURE USP_Caso_BuscarCasos_X_Cliente
@strCodigo VARCHAR(20)
AS
 BEGIN
 SELECT Id_CAS AS Caso,
 Convert (varchar(10), dtmFecha_CAS, 103) AS Fecha,
 strDescripcion_TICA + ' -> ' +
 strDescripcion_CLAsTICA AS Tipo_Caso,
 strNombre_ASO AS Abogado
 FROM tblCASos
 INNER JOIN tblASOciado ON strNroDoc_ASO = IdASO_CAS
 INNER JOIN tblCLAsifTIpoCAso ON
 intCodCLAsTICA_CAS = intCod_CLAsTICA
 INNER JOIN tblTIpoCAso ON strCodTICA = strCod_TICA
 WHERE IdCLI_CAS = @strCodigo
 ORDER BY Caso desc
 -- EXEC USP_Caso_BuscarCasos_X_Cliente '70500600';
 END
GO
-- ====== Relacionada con: tblPreLIminares ========
CREATE PROCEDURE USP_Preliminares_BuscarGeneral
AS
 BEGIN
 SELECT Id_PLI as Clave, strDescripcion_PLI as Dato
 FROM tblPreLIminares
 ORDER BY Clave
 -- EXEC USP_Preliminares_BuscarGeneral;
 END
GO
-- ====== Relacionada con: tblPREliminares_CASo ========
CREATE PROCEDURE USP_Caso_GrabarPreliminares
@IdCaso int,
@IdPreliminar int
AS
 BEGIN
 BEGIN TRANSACTION tx
 INSERT INTO tblPREliminares_CASo
 ( IdCAS_PRECAS, IdPLI_PRECAS )
 VALUES ( @IdCaso, @IdPreliminar );
 IF ( @@ERROR > 0 )
 BEGIN
 ROLLBACK TRANSACTION tx
 END
 COMMIT TRANSACTION tx
 Return
 -- EXEC USP_Caso_GrabarPreliminares 1, 2;
 -- EXEC USP_Caso_GrabarPreliminares 1, 4;
 END
GO
CREATE PROCEDURE USP_Preliminares_X_caso
@IdCaso int
AS
 BEGIN
 SELECT IdPLI_PRECAS As Clave
 FROM tblPREliminares_CASo
 WHERE IdCAS_PRECAS = @IdCaso
 ORDER BY Clave asc
 -- EXEC USP_Preliminares_X_caso 3;
 END
GO
CREATE PROCEDURE USP_Caso_BuscarInicialesXCodigo
@intCaso int
AS
 BEGIN
 SELECT Id_PRECAS IdCasoPrelim, IdPLI_PRECAS IdPrelim
 FROM tblPREliminares_CASo
 WHERE IdCAS_PRECAS = @intCaso
 -- EXEC USP_Caso_BuscarInicialesXCodigo 3;
 END
GO
-- ======== Relacionada con: tblSEGuimientos ===========
CREATE PROCEDURE USP_Seguimiento_BuscarGeneral
AS
 BEGIN
 SELECT Id_SEG as Clave, strDescripcion_SEG as Dato
 FROM tblSEGuimientos
 ORDER BY Id_SEG
-- EXEC USP_Seguimiento_BuscarGeneral;
 END
GO
