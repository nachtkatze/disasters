/*
 * Cambios a realizar en el script de HSQLDB:
 * -Eliminar todos los 'SET', 'CREATE USER', 'CREATE SCHEMA' y 'ALTER' --> Mantener solo los 'CREATE MEMORY TABLE' e 'INSERT INTO'
 * -Annadir ';' en todas las filas
 * -Eliminar el 'MEMORY' y los 'PUBLIC.' en todos los 'CREATE MEMORY TABLE' y sus 'REFERENCES'
 * -Cambiar 'GENERATED BY DEFAULT AS IDENTITY(START WITH 1)' por 'AUTO_INCREMENT' en las IDs
 * -Annadir 'DEFAULT 0' a 'FECHA' en la tabla CATASTROFES
 */
CREATE TABLE TIPOS_ESTADOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO_ESTADO VARCHAR(30),DESCRIPCION VARCHAR(250));
CREATE TABLE TIPOS_MARCADORES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO_MARCADOR VARCHAR(30),DESCRIPCION VARCHAR(250));
CREATE TABLE TIPOS_CATASTROFES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_MARCADOR INTEGER,TIPO_CATASTROFE VARCHAR(30),DESCRIPCION VARCHAR(250),FOREIGN KEY(ID_MARCADOR) REFERENCES TIPOS_MARCADORES(ID));
CREATE TABLE TIPOS_USUARIOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO VARCHAR(30),ID_CATASTROFE INTEGER,NIVEL INTEGER,DESCRIPCION VARCHAR(250),FOREIGN KEY(ID_CATASTROFE) REFERENCES TIPOS_CATASTROFES(ID));
CREATE TABLE TIPOS_ACTIVIDADES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO VARCHAR(30),TIPO_MARCADOR INTEGER,TIPO_EMERGENCIA INTEGER,ESTADO_EMERGENCIA INTEGER,DESCRIPCION VARCHAR(250),FOREIGN KEY(TIPO_MARCADOR) REFERENCES TIPOS_MARCADORES(ID),FOREIGN KEY(TIPO_EMERGENCIA) REFERENCES TIPOS_CATASTROFES(ID),FOREIGN KEY(ESTADO_EMERGENCIA) REFERENCES TIPOS_ESTADOS(ID));
CREATE TABLE TIPOS_EVENTOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO VARCHAR(30),DESCRIPCION VARCHAR(250));
CREATE TABLE TIPOS_SINTOMAS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,TIPO VARCHAR(30),DESCRIPCION VARCHAR(250));
CREATE TABLE USUARIOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,NOMBRE_USUARIO VARCHAR(60),PASSWORD VARCHAR(90),TIPO_USUARIO INTEGER,NOMBRE_REAL VARCHAR(60),CORREO VARCHAR(60),LATITUD DECIMAL(8,6),LONGITUD DECIMAL(9,6),LOCALIZACION BOOLEAN,PLANTA INTEGER,PROYECTO VARCHAR(30),FOREIGN KEY(TIPO_USUARIO) REFERENCES TIPOS_USUARIOS(ID));
CREATE TABLE CATASTROFES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,MARCADOR INTEGER,TIPO INTEGER,CANTIDAD INTEGER,NOMBRE VARCHAR(60),DESCRIPCION VARCHAR(250),INFO VARCHAR(250),LATITUD DECIMAL(8,6),LONGITUD DECIMAL(9,6),DIRECCION VARCHAR(250),SIZE VARCHAR(30),TRAFFIC VARCHAR(30),PLANTA INTEGER,ESTADO INTEGER,IDASSIGNED INTEGER,FECHA TIMESTAMP DEFAULT 0,MODIFICADO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,USUARIO INTEGER,FOREIGN KEY(MARCADOR) REFERENCES TIPOS_MARCADORES(ID),FOREIGN KEY(TIPO) REFERENCES TIPOS_CATASTROFES(ID),FOREIGN KEY(ESTADO) REFERENCES TIPOS_ESTADOS(ID),FOREIGN KEY(USUARIO) REFERENCES USUARIOS(ID));
CREATE TABLE HISTORIAL(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_USUARIO INTEGER,TIPO VARCHAR(30),ID_TIPO INTEGER,ID_EMERGENCIA INTEGER,EVENTO VARCHAR(250),FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(ID_USUARIO) REFERENCES USUARIOS(ID),FOREIGN KEY(ID_EMERGENCIA) REFERENCES CATASTROFES(ID));
CREATE TABLE MENSAJES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,CREADOR INTEGER,TIPO_RECEPTOR INTEGER,RECEPTOR INTEGER,MENSAJE VARCHAR(250),FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(CREADOR) REFERENCES USUARIOS(ID));
CREATE TABLE ASOCIACIONES_HERIDOS_EMERGENCIAS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_HERIDO INTEGER,ID_EMERGENCIA INTEGER,ESTADO INTEGER,FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(ID_HERIDO) REFERENCES CATASTROFES(ID),FOREIGN KEY(ID_EMERGENCIA) REFERENCES CATASTROFES(ID),FOREIGN KEY(ESTADO) REFERENCES TIPOS_ESTADOS(ID));
CREATE TABLE ACTIVIDADES(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_USUARIO INTEGER,ID_EMERGENCIA INTEGER,ID_TIPO_ACTIVIDAD INTEGER,ESTADO INTEGER,FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(ID_USUARIO) REFERENCES USUARIOS(ID),FOREIGN KEY(ID_EMERGENCIA) REFERENCES CATASTROFES(ID),FOREIGN KEY(ID_TIPO_ACTIVIDAD) REFERENCES TIPOS_ACTIVIDADES(ID),FOREIGN KEY(ESTADO) REFERENCES TIPOS_ESTADOS(ID));
CREATE TABLE ASOCIACIONES_EMERGENCIAS_CON_TIPOS_USUARIOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_TIPO_USUARIO INTEGER,ID_TIPO_EMERGENCIA INTEGER,LOCALIZACION INTEGER,FOREIGN KEY(ID_TIPO_USUARIO) REFERENCES TIPOS_USUARIOS(ID),FOREIGN KEY(ID_TIPO_EMERGENCIA) REFERENCES TIPOS_CATASTROFES(ID));
CREATE TABLE ASOCIACIONES_USUARIOS_CON_TIPOS_USUARIOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_TIPO_USUARIO INTEGER,ID_TIPO_USUARIO_VER INTEGER,VISUALIZAR INTEGER,FOREIGN KEY(ID_TIPO_USUARIO) REFERENCES TIPOS_USUARIOS(ID),FOREIGN KEY(ID_TIPO_USUARIO_VER) REFERENCES TIPOS_USUARIOS(ID));
CREATE TABLE ASOCIACIONES_ACTIVIDADES_CON_TIPOS_USUARIOS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_TIPO_USUARIO INTEGER,ID_TIPO_ACTIVIDAD INTEGER,FOREIGN KEY(ID_TIPO_USUARIO) REFERENCES TIPOS_USUARIOS(ID),FOREIGN KEY(ID_TIPO_ACTIVIDAD) REFERENCES TIPOS_ACTIVIDADES(ID));
CREATE TABLE SINTOMAS(ID INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,ID_HERIDO INTEGER,ID_SINTOMA INTEGER,ESTADO INTEGER,FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(ID_HERIDO) REFERENCES CATASTROFES(ID),FOREIGN KEY(ID_SINTOMA) REFERENCES TIPOS_SINTOMAS(ID),FOREIGN KEY(ESTADO) REFERENCES TIPOS_ESTADOS(ID));
INSERT INTO TIPOS_ESTADOS VALUES(1,'active','');
INSERT INTO TIPOS_ESTADOS VALUES(2,'controlled','');
INSERT INTO TIPOS_ESTADOS VALUES(3,'controlled2','');
INSERT INTO TIPOS_ESTADOS VALUES(4,'acting','');
INSERT INTO TIPOS_ESTADOS VALUES(5,'erased','');
INSERT INTO TIPOS_MARCADORES VALUES(1,'event','Emergencias');
INSERT INTO TIPOS_MARCADORES VALUES(2,'people','Heridos');
INSERT INTO TIPOS_MARCADORES VALUES(3,'resource','Agentes');
INSERT INTO TIPOS_CATASTROFES VALUES(1,1,'fire','Incendio');
INSERT INTO TIPOS_CATASTROFES VALUES(2,1,'flood','Inundacion');
INSERT INTO TIPOS_CATASTROFES VALUES(3,1,'collapse','Derrumbamiento');
INSERT INTO TIPOS_CATASTROFES VALUES(4,1,'injuredPerson','Persona herida');
INSERT INTO TIPOS_CATASTROFES VALUES(5,1,'lostPerson','Persona perdida');
INSERT INTO TIPOS_CATASTROFES VALUES(6,2,'healthy','Sano');
INSERT INTO TIPOS_CATASTROFES VALUES(7,2,'slight','Leve');
INSERT INTO TIPOS_CATASTROFES VALUES(8,2,'serious','Grave');
INSERT INTO TIPOS_CATASTROFES VALUES(9,2,'dead','Muerto');
INSERT INTO TIPOS_CATASTROFES VALUES(10,2,'trapped','Atrapado');
INSERT INTO TIPOS_CATASTROFES VALUES(11,3,'nurse','Enfermero');
INSERT INTO TIPOS_CATASTROFES VALUES(12,3,'gerocultor','Gerocultor');
INSERT INTO TIPOS_CATASTROFES VALUES(13,3,'assistant','Auxiliar');
INSERT INTO TIPOS_CATASTROFES VALUES(14,3,'otherStaff','Otro personal');
INSERT INTO TIPOS_CATASTROFES VALUES(15,3,'police','Policia');
INSERT INTO TIPOS_CATASTROFES VALUES(16,3,'firemen','Bombero');
INSERT INTO TIPOS_CATASTROFES VALUES(17,3,'ambulance','Ambulancia');
INSERT INTO TIPOS_CATASTROFES VALUES(18,3,'coordinator','Coordinador');
INSERT INTO TIPOS_CATASTROFES VALUES(19,3,'orderly','Celador');
INSERT INTO TIPOS_CATASTROFES VALUES(20,3,'receptionist','Recepcionista');
INSERT INTO TIPOS_USUARIOS VALUES(1,'administrator',NULL,5,'Administrador');
INSERT INTO TIPOS_USUARIOS VALUES(2,'coordinator',18,5,'Coordinador');
INSERT INTO TIPOS_USUARIOS VALUES(3,'nurse',11,4,'Enfermero');
INSERT INTO TIPOS_USUARIOS VALUES(4,'gerocultor',12,4,'Gerocultor');
INSERT INTO TIPOS_USUARIOS VALUES(5,'assistant',13,4,'Auxiliar');
INSERT INTO TIPOS_USUARIOS VALUES(6,'police',15,4,'Policia');
INSERT INTO TIPOS_USUARIOS VALUES(7,'firemen',16,4,'Bombero');
INSERT INTO TIPOS_USUARIOS VALUES(8,'ambulance',17,4,'Ambulancia');
INSERT INTO TIPOS_USUARIOS VALUES(9,'otherStaff',13,3,'Otro personal');
INSERT INTO TIPOS_USUARIOS VALUES(10,'relative',NULL,2,'Familiar');
INSERT INTO TIPOS_USUARIOS VALUES(11,'citizen',NULL,1,'Ciudadano');
INSERT INTO TIPOS_USUARIOS VALUES(12,'orderly',19,4,'Celador');
INSERT INTO TIPOS_USUARIOS VALUES(13,'receptionist',20,3,'Recepcionista');
INSERT INTO TIPOS_ACTIVIDADES VALUES(1,'apagar',1,1,1,'Apagar incendio');
INSERT INTO TIPOS_ACTIVIDADES VALUES(2,'controlar',1,2,1,'Controlar inundacion');
INSERT INTO TIPOS_ACTIVIDADES VALUES(3,'acordonar',1,3,1,'Acordonar derrumbamiento');
INSERT INTO TIPOS_ACTIVIDADES VALUES(4,'atender',2,NULL,1,'Atender herido');
INSERT INTO TIPOS_ACTIVIDADES VALUES(5,'evacuar',2,6,1,'Evacuar residente');
INSERT INTO TIPOS_ACTIVIDADES VALUES(6,'rescatar',2,10,1,'Rescatar atrapado');
INSERT INTO TIPOS_ACTIVIDADES VALUES(7,'ayudar',NULL,NULL,2,'Ayudar en una actividad empezada');
INSERT INTO TIPOS_ACTIVIDADES VALUES(8,'trasladar',2,NULL,2,'Trasladar herido');
INSERT INTO TIPOS_ACTIVIDADES VALUES(9,'evacuado',2,6,2,'Final de la evacuacion');
INSERT INTO TIPOS_ACTIVIDADES VALUES(10,'volver',2,6,2,'Volver a la residencia');
INSERT INTO TIPOS_ACTIVIDADES VALUES(11,'dejar',NULL,NULL,2,'Dejar la actividad');
INSERT INTO TIPOS_ACTIVIDADES VALUES(12,'apagado',1,1,2,'Incendio apagado');
INSERT INTO TIPOS_ACTIVIDADES VALUES(13,'controlado',1,2,2,'Inundacion controlada');
INSERT INTO TIPOS_ACTIVIDADES VALUES(14,'acordonado',1,3,2,'Derrumbamiento acordonado');
INSERT INTO TIPOS_ACTIVIDADES VALUES(15,'curado',2,NULL,2,'Herido curado');
INSERT INTO TIPOS_ACTIVIDADES VALUES(16,'vuelto',2,6,3,'De vuelta en la residencia');
INSERT INTO TIPOS_ACTIVIDADES VALUES(17,'rescatado',2,10,2,'Persona rescatada');
INSERT INTO TIPOS_ACTIVIDADES VALUES(18,'trasladado',2,NULL,3,'Herido trasladado');
INSERT INTO TIPOS_ACTIVIDADES VALUES(19,'buscar',2,5,1,'Buscar persona');
INSERT INTO TIPOS_ACTIVIDADES VALUES(20,'encontrado',2,5,2,'Persona encontrada');
INSERT INTO TIPOS_EVENTOS VALUES(1,'login','Iniciar sesion');
INSERT INTO TIPOS_EVENTOS VALUES(2,'logout','Cerrar secion');
INSERT INTO TIPOS_EVENTOS VALUES(3,'nuevaCatastrofe','Crear una nueva emergencia/herido');
INSERT INTO TIPOS_EVENTOS VALUES(4,'modificarCatastrofe','Modificacion de una emergencia/herido');
INSERT INTO TIPOS_EVENTOS VALUES(5,'finCatastrofe','Cierre de una emergencia');
INSERT INTO TIPOS_EVENTOS VALUES(6,'nuevaActividad','Iniciar actividad');
INSERT INTO TIPOS_EVENTOS VALUES(7,'cambioActividad','Cambiar de actividad');
INSERT INTO TIPOS_EVENTOS VALUES(8,'finActividad','Finalizar actividad');
INSERT INTO TIPOS_EVENTOS VALUES(9,'asociar','Asociar herido con emergencia');
INSERT INTO TIPOS_EVENTOS VALUES(10,'desasociar','Desasociar herido con emergencia');
INSERT INTO TIPOS_EVENTOS VALUES(11,'modificarInfo','Modificar informacion de usuario');
INSERT INTO TIPOS_EVENTOS VALUES(12,'nuevoUsuario','Crear nuevo usuario');
INSERT INTO TIPOS_SINTOMAS VALUES(1,'fatigue','Fatiga');
INSERT INTO TIPOS_SINTOMAS VALUES(2,'fever','Fiebre');
INSERT INTO TIPOS_SINTOMAS VALUES(3,'dyspnea','Disnea');
INSERT INTO TIPOS_SINTOMAS VALUES(4,'nausea','Nauseas');
INSERT INTO TIPOS_SINTOMAS VALUES(5,'headache','Dolor de cabeza');
INSERT INTO TIPOS_SINTOMAS VALUES(6,'vomiting','Vomitos');
INSERT INTO TIPOS_SINTOMAS VALUES(7,'abdominal_pain','Dolor abdominal');
INSERT INTO TIPOS_SINTOMAS VALUES(8,'weight_loss','Perdida de peso');
INSERT INTO TIPOS_SINTOMAS VALUES(9,'blurred_vision','Vision borrosa');
INSERT INTO TIPOS_SINTOMAS VALUES(10,'muscle_weakness','Debilidad muscular');
INSERT INTO USUARIOS VALUES(1,'admin','713bfda78870bf9d1b261f565286f85e97ee614efe5f0faf7c34e7ca4f65baca',1,'Administrador','admin@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(2,'enfermero','c51e72643e50ffa26f1f1af3850a4b2ad2ada9298c84fa7324703f108aac2b63',3,'Enfermero 1','enfermero@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(3,'nurse','84b2278f8bf409fa095cbee2fd3564fbcd103ac167ba9bf20aa1522d43eadbd0',3,'Enfermero 2','enfermero@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(4,'auxiliar','1778678087df9b58cb1cc730731fda2f386a4a030ea4f7bf0741bb9758023110',5,'Auxiliar 1','auxiliar@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(5,'assistant','5b2c2694dd95f7ab95f19236a1be8f5705de9fb7f5852d64d7b74ec17b513019',5,'Auxiliar 2','auxiliar@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(6,'gerocultor','e8ff927852ceb7ff7a1be64b7e216f3ff62374d47ce3729030763582be46d663',4,'Gerocultor','gerocultor@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(7,'celador','e544e65be12b04db3a81acc25320e65591f787f421347de7dc6a2fc5741e070d',9,'Celador','celador@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(8,'ciudadano','be0c1899cb651aaedbe2265be503aefb0bbcb4039ba025a49793c7a936a5b26c',11,'Ciudadano 1','ciudadano@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(9,'citizen','a7c989cd998dc0a377552507a4b79b166ac4cba236c55118574d32a71442c8f0',11,'Ciudadano 2','citizen@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO USUARIOS VALUES(10,'coordinador','a8f4e6cfff44592621a5783e0157e2af131481cdbdfe90e32813858f91985151',2,'Coordinador','coordinador@correo.com',38.523414,-0.170175,FALSE,-2,'caronte');
INSERT INTO CATASTROFES VALUES(1,1,1,1,'Incendio en la residencia','Fuego en la cocina de la residencia','Explosion de gas',38.523414,-0.170175,'Calle Tramuntana','big','low',0,1,0,'2001-04-03 00:00:01.000000','2008-04-15 13:07:00.500000',1);
INSERT INTO CATASTROFES VALUES(2,2,6,1,'Pepe','Anciano de la residencia','',38.523414,-0.170400,'Calle Tramuntana','medio','normal',0,1,0,'2001-04-03 00:00:01.000000','2008-04-15 13:07:00.500000',1);
INSERT INTO CATASTROFES VALUES(3,2,6,1,'Maria','Anciano de la residencia','',38.523514,-0.170130,'Calle Tramuntana','bajo','normal',0,1,0,'2001-04-03 00:00:01.000000','2008-04-15 13:07:00.500000',1);
INSERT INTO CATASTROFES VALUES(4,2,6,1,'Manolo','Anciano de la residencia','',38.523314,-0.170165,'Calle Tramuntana','medio','normal',0,1,0,'2001-04-03 00:00:01.000000','2008-04-15 13:07:00.500000',1);
