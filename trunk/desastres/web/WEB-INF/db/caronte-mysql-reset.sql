/* Elimina los datos de las tablas en orden inverso al que fueron creadas y vuelve a introducir sus datos */
TRUNCATE TABLE SINTOMAS;
TRUNCATE TABLE ACTIVIDADES;
TRUNCATE TABLE ASOCIACIONES_HERIDOS_EMERGENCIAS;
TRUNCATE TABLE MENSAJES;
TRUNCATE TABLE HISTORIAL;
TRUNCATE TABLE CATASTROFES;
TRUNCATE TABLE USUARIOS;
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
