                                            /* INICIO CREACION DE LAS TABLAS */

CREATE TABLE Aeropuertos  (
   ID_Aeropuerto INTEGER NOT NULL PRIMARY KEY,
   Nombre VARCHAR2(100) NOT NULL,
   Ciudad VARCHAR2(100) NOT NULL,
   Pais VARCHAR2(100) NOT NULL,
   Codigo_IATA VARCHAR2(50) NOT NULL,
   Codigo_ICAO VARCHAR2(50) NOT NULL
)  STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Aerolineas  (
   ID_Aerolinea INTEGER NOT NULL PRIMARY KEY,
   Nombre VARCHAR2(100) NOT NULL,
   Pais VARCHAR2(100) NOT NULL,
   ID_Aeropuerto INTEGER REFERENCES Aeropuertos(ID_Aeropuerto)
)  STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Vuelos (
    ID_Vuelo INTEGER NOT NULL PRIMARY KEY,
    Origen VARCHAR2(100) NOT NULL,
    Destino VARCHAR2(100) NOT NULL,
    Fecha_Salida DATE NOT NULL,
    Fecha_Llegada DATE NOT NULL,
    Estado VARCHAR2(50) NOT NULL,
    ID_Aerolinea INTEGER REFERENCES Aerolineas(ID_Aerolinea)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Comida_a_Bordo (
    ID_Comida INTEGER NOT NULL PRIMARY KEY,
    Tipo_de_Comida VARCHAR2(100) NOT NULL,
    Disponibilidad VARCHAR2(100) NOT NULL,
    Precio NUMBER(6,2) NOT NULL,
    ID_Vuelo INTEGER REFERENCES Vuelos(ID_Vuelo)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Horarios (
    ID_Horario INTEGER PRIMARY KEY,
    Dia_Semana VARCHAR2(20) NOT NULL,
    Hora_Salida VARCHAR2(10) NOT NULL,
    Hora_Llegada VARCHAR2(10) NOT NULL,
    ID_Vuelo INTEGER REFERENCES Vuelos(ID_Vuelo)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Precios (
    ID_Precio INTEGER PRIMARY KEY,
    Clase VARCHAR2(20) NOT NULL,
    Costo NUMBER NOT NULL,
    ID_Vuelo INTEGER REFERENCES Vuelos(ID_Vuelo)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Pasajeros (
    ID_Pasajero INTEGER PRIMARY KEY,
    Nombre VARCHAR2(50) NOT NULL,
    Apellido VARCHAR2(50) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Genero VARCHAR2(10) NOT NULL,
    Nacionalidad VARCHAR2(50) NOT NULL
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Reservas (
    ID_Reserva INTEGER PRIMARY KEY,
    Num_Asiento VARCHAR2(10) NOT NULL,
    Fecha_Reserva DATE NOT NULL,
    ID_Pasajero INTEGER REFERENCES Pasajeros(ID_Pasajero),
    ID_Vuelo INTEGER REFERENCES Vuelos(ID_Vuelo)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Equipaje (
    ID_Equipaje INTEGER PRIMARY KEY,
    Peso NUMBER NOT NULL,
    Color VARCHAR2(20) NOT NULL,
    ID_Pasajero INTEGER REFERENCES Pasajeros(ID_Pasajero)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

CREATE TABLE Comentarios_y_Reservas (
    ID_Comentarios_y_Reservas INTEGER PRIMARY KEY,
    Puntuacion NUMBER(2,1),
    Comentario VARCHAR2(300),
    ID_Vuelo INTEGER REFERENCES Vuelos(ID_Vuelo),
    ID_Pasajero INTEGER REFERENCES Pasajeros(ID_Pasajero)
)   STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

ALTER TABLE Comentarios_y_Reservas DROP COLUMN Puntuacion;
ALTER TABLE Comentarios_y_Reservas ADD Puntuacion NUMBER(2,1);





                                                /* FIN CREACION DE LAS TABLAS */

                                                /* INICIO CRUD TABLA AEROPUERTOS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_AEROPUERTOS;
CREATE OR REPLACE PROCEDURE Crear_Aeropuerto(
    a_Nombre VARCHAR2,
    a_Ciudad VARCHAR2,
    a_Pais VARCHAR2,
    a_Codigo_IATA VARCHAR2,
    a_Codigo_ICAO VARCHAR2) AS
BEGIN
    INSERT INTO Aeropuertos (ID_Aeropuerto, Nombre, Ciudad, Pais, Codigo_IATA, Codigo_ICAO)
    VALUES (SEQ_AEROPUERTOS.NEXTVAL, a_Nombre, a_Ciudad, a_Pais, a_Codigo_IATA, a_Codigo_ICAO);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Aeropuerto(
    a_ID_Aeropuerto NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_aeropuerto SYS_REFCURSOR;
BEGIN
    OPEN e_aeropuerto FOR
    SELECT * FROM Aeropuertos WHERE ID_Aeropuerto = a_ID_Aeropuerto;
    RETURN e_aeropuerto;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Aeropuerto(
    a_ID_Aeropuerto NUMBER,
    a_NuevoNombre VARCHAR2,
    a_NuevaCiudad VARCHAR2,
    a_NuevoPais VARCHAR2,
    a_NuevoCodigo_IATA VARCHAR2,
    a_NuevoCodigo_ICAO VARCHAR2) AS
BEGIN
    UPDATE Aeropuertos
    SET Nombre = a_NuevoNombre,
        Ciudad = a_NuevaCiudad,
        Pais = a_NuevoPais,
        Codigo_IATA = a_NuevoCodigo_IATA,
        Codigo_ICAO = a_NuevoCodigo_ICAO
    WHERE ID_Aeropuerto = a_ID_Aeropuerto;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Aeropuerto(
    a_ID_Aeropuerto NUMBER) AS
BEGIN
    DELETE FROM Aeropuertos WHERE ID_Aeropuerto = a_ID_Aeropuerto;
    COMMIT;
END;

                                                /* FIN CRUD TABLA AEROPUERTOS */
                                                
                                                /* INICIO CRUD TABLA AEROLINEAS */
                                                
/* CREATE */  
CREATE SEQUENCE SEQ_AEROLINEAS;
CREATE OR REPLACE PROCEDURE Crear_Aerolinea(
    a_Nombre VARCHAR2,
    a_Pais VARCHAR2,
    a_ID_Aeropuerto INTEGER) AS
BEGIN
    INSERT INTO Aerolineas (ID_Aerolinea, Nombre, Pais, ID_Aeropuerto)
    VALUES (SEQ_AEROLINEAS.NEXTVAL, a_Nombre, a_Pais, a_ID_Aeropuerto);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Aerolinea(
    a_ID_Aerolinea NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_aerolinea SYS_REFCURSOR;
BEGIN
    OPEN e_aerolinea FOR
    SELECT * FROM Aerolineas WHERE ID_Aerolinea = a_ID_Aerolinea;
    RETURN e_aerolinea;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Aerolinea(
    a_ID_Aerolinea NUMBER,
    a_NuevoNombre VARCHAR2,
    a_NuevoPais VARCHAR2,
    a_NuevoID_Aeropuerto INTEGER) AS
BEGIN
    UPDATE Aerolineas
    SET Nombre = a_NuevoNombre,
        Pais = a_NuevoPais,
        ID_Aeropuerto = a_NuevoID_Aeropuerto
    WHERE ID_Aerolinea = a_ID_Aerolinea;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Aerolinea(
    a_ID_Aerolinea NUMBER) AS
BEGIN
    DELETE FROM Aerolineas WHERE ID_Aerolinea = a_ID_Aerolinea;
    COMMIT;
END;
                                                
                                                /* FIN CRUD TABLA AEROLINEAS */
                                                
                                                /* INICIO CRUD TABLA VUELOS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_VUELOS;
CREATE OR REPLACE PROCEDURE Crear_Vuelo(
    a_Origen VARCHAR2,
    a_Destino VARCHAR2,
    a_Fecha_Salida DATE,
    a_Fecha_Llegada DATE,
    a_Estado VARCHAR2,
    a_ID_Aerolinea INTEGER) AS
BEGIN
    INSERT INTO Vuelos (ID_Vuelo, Origen, Destino, Fecha_Salida, Fecha_Llegada, Estado, ID_Aerolinea)
    VALUES (SEQ_VUELOS.NEXTVAL, a_Origen, a_Destino, a_Fecha_Salida, a_Fecha_Llegada, a_Estado, a_ID_Aerolinea);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Vuelo(
    a_ID_Vuelo NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_vuelo SYS_REFCURSOR;
BEGIN
    OPEN e_vuelo FOR
    SELECT * FROM Vuelos WHERE ID_Vuelo = a_ID_Vuelo;
    RETURN e_vuelo;
END;

/* UPDATE */      
CREATE OR REPLACE PROCEDURE Actualizar_Vuelo(
    a_ID_Vuelo NUMBER,
    a_NuevoOrigen VARCHAR2,
    a_NuevoDestino VARCHAR2,
    a_NuevaFecha_Salida DATE,
    a_NuevaFecha_Llegada DATE,
    a_NuevoEstado VARCHAR2,
    a_NuevoID_Aerolinea INTEGER) AS
BEGIN
    UPDATE Vuelos
    SET Origen = a_NuevoOrigen,
        Destino = a_NuevoDestino,
        Fecha_Salida = a_NuevaFecha_Salida,
        Fecha_Llegada = a_NuevaFecha_Llegada,
        Estado = a_NuevoEstado,
        ID_Aerolinea = a_NuevoID_Aerolinea
    WHERE ID_Vuelo = a_ID_Vuelo;
    COMMIT;
END;

/* DELETE */        
CREATE OR REPLACE PROCEDURE Eliminar_Vuelo(
    a_ID_Vuelo NUMBER) AS
BEGIN
    DELETE FROM Vuelos WHERE ID_Vuelo = a_ID_Vuelo;
    COMMIT;
END;
                                   
                                                /* FIN CRUD TABLA VUELOS */
                                                
                                                /* INICIO CRUD TABLA COMIDA A BORDO */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_COMIDA_A_BORDO;
CREATE OR REPLACE PROCEDURE Crear_Comida_a_Bordo(
    a_Tipo_de_Comida VARCHAR2,
    a_Disponibilidad VARCHAR2,
    a_Precio NUMBER,
    a_ID_Vuelo INTEGER) AS
BEGIN
    INSERT INTO Comida_a_Bordo (ID_Comida, Tipo_de_Comida, Disponibilidad, Precio, ID_Vuelo)
    VALUES (SEQ_COMIDA_A_BORDO.NEXTVAL, a_Tipo_de_Comida, a_Disponibilidad, a_Precio, a_ID_Vuelo);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Comida_a_Bordo(
    a_ID_Comida NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_comida SYS_REFCURSOR;
BEGIN
    OPEN e_comida FOR
    SELECT * FROM Comida_a_Bordo WHERE ID_Comida = a_ID_Comida;
    RETURN e_comida;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Comida_a_Bordo(
    a_ID_Comida NUMBER,
    a_NuevoTipo_de_Comida VARCHAR2,
    a_NuevaDisponibilidad VARCHAR2,
    a_NuevoPrecio NUMBER,
    a_NuevoID_Vuelo INTEGER) AS
BEGIN
    UPDATE Comida_a_Bordo
    SET Tipo_de_Comida = a_NuevoTipo_de_Comida,
        Disponibilidad = a_NuevaDisponibilidad,
        Precio = a_NuevoPrecio,
        ID_Vuelo = a_NuevoID_Vuelo
    WHERE ID_Comida = a_ID_Comida;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Comida_a_Bordo(
    a_ID_Comida NUMBER) AS
BEGIN
    DELETE FROM Comida_a_Bordo WHERE ID_Comida = a_ID_Comida;
    COMMIT;
END;
                                     
                                                /* FIN CRUD TABLA COMIDA A BORDO */
                                                
                                                /* INICIO CRUD TABLA HORARIOS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_HORARIOS;
CREATE OR REPLACE PROCEDURE Crear_Horario(
    a_Dia_Semana VARCHAR2,
    a_Hora_Salida VARCHAR2,
    a_Hora_Llegada VARCHAR2,
    a_ID_Vuelo INTEGER) AS
BEGIN
    INSERT INTO Horarios (ID_Horario, Dia_Semana, Hora_Salida, Hora_Llegada, ID_Vuelo)
    VALUES (SEQ_HORARIOS.NEXTVAL, a_Dia_Semana, a_Hora_Salida, a_Hora_Llegada, a_ID_Vuelo);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Horario(
    a_ID_Horario NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_horario SYS_REFCURSOR;
BEGIN
    OPEN e_horario FOR
    SELECT * FROM Horarios WHERE ID_Horario = a_ID_Horario;
    RETURN e_horario;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Horario(
    a_ID_Horario NUMBER,
    a_NuevoDia_Semana VARCHAR2,
    a_NuevaHora_Salida VARCHAR2,
    a_NuevaHora_Llegada VARCHAR2,
    a_NuevoID_Vuelo INTEGER) AS
BEGIN
    UPDATE Horarios
    SET Dia_Semana = a_NuevoDia_Semana,
        Hora_Salida = a_NuevaHora_Salida,
        Hora_Llegada = a_NuevaHora_Llegada,
        ID_Vuelo = a_NuevoID_Vuelo
    WHERE ID_Horario = a_ID_Horario;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Horario(
    a_ID_Horario NUMBER) AS
BEGIN
    DELETE FROM Horarios WHERE ID_Horario = a_ID_Horario;
    COMMIT;
END;                
                                                /* FIN CRUD TABLA HORARIOS */
                                                
                                                /* INICIO CRUD TABLA PRECIOS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_PRECIOS;
CREATE OR REPLACE PROCEDURE Crear_Precio(
    a_Clase VARCHAR2,
    a_Costo NUMBER,
    a_ID_Vuelo INTEGER) AS
BEGIN
    INSERT INTO Precios (ID_Precio, Clase, Costo, ID_Vuelo)
    VALUES (SEQ_PRECIOS.NEXTVAL, a_Clase, a_Costo, a_ID_Vuelo);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Precio(
    a_ID_Precio NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_precio SYS_REFCURSOR;
BEGIN
    OPEN e_precio FOR
        SELECT * FROM Precios WHERE ID_Precio = a_ID_Precio;
    RETURN e_precio;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Precio(
    a_ID_Precio NUMBER,
    a_Nueva_Clase VARCHAR2,
    a_Nuevo_Costo NUMBER,
    a_Nuevo_ID_Vuelo INTEGER) AS
BEGIN
    UPDATE Precios
    SET Clase = a_Nueva_Clase,
        Costo = a_Nuevo_Costo,
        ID_Vuelo = a_Nuevo_ID_Vuelo
    WHERE ID_Precio = a_ID_Precio;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Precio(
    a_ID_Precio NUMBER) AS
BEGIN
    DELETE FROM Precios WHERE ID_Precio = a_ID_Precio;
    COMMIT;
END;
                                       
                                                /* FIN CRUD TABLA PRECIOS */
                                                
                                                /* INICIO CRUD TABLA PASAJEROS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_PASAJEROS;
CREATE OR REPLACE PROCEDURE Crear_Pasajero(
    a_Nombre VARCHAR2,
    a_Apellido VARCHAR2,
    a_Fecha_Nacimiento DATE,
    a_Genero VARCHAR2,
    a_Nacionalidad VARCHAR2) AS
BEGIN
    INSERT INTO Pasajeros (ID_Pasajero, Nombre, Apellido, Fecha_Nacimiento, Genero, Nacionalidad)
    VALUES (SEQ_PASAJEROS.NEXTVAL, a_Nombre, a_Apellido, a_Fecha_Nacimiento, a_Genero, a_Nacionalidad);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Pasajero(
    a_ID_Pasajero NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_pasajero SYS_REFCURSOR;
BEGIN
    OPEN e_pasajero FOR
        SELECT * FROM Pasajeros WHERE ID_Pasajero = a_ID_Pasajero;
    RETURN e_pasajero;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Pasajero(
    a_ID_Pasajero NUMBER,
    a_Nuevo_Nombre VARCHAR2,
    a_Nuevo_Apellido VARCHAR2,
    a_Nueva_Fecha_Nacimiento DATE,
    a_Nuevo_Genero VARCHAR2,
    a_Nueva_Nacionalidad VARCHAR2) AS
BEGIN
    UPDATE Pasajeros
    SET Nombre = a_Nuevo_Nombre,
        Apellido = a_Nuevo_Apellido,
        Fecha_Nacimiento = a_Nueva_Fecha_Nacimiento,
        Genero = a_Nuevo_Genero,
        Nacionalidad = a_Nueva_Nacionalidad
    WHERE ID_Pasajero = a_ID_Pasajero;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Pasajero(
    a_ID_Pasajero NUMBER) AS
BEGIN
    DELETE FROM Pasajeros WHERE ID_Pasajero = a_ID_Pasajero;
    COMMIT;
END;                                                
                                                
                                                /* FIN CRUD TABLA PASAJEROS */
                                                
                                                /* INICIO CRUD TABLA RESERVAS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_RESERVAS;
CREATE OR REPLACE PROCEDURE Crear_Reserva(
    a_Num_Asiento VARCHAR2,
    a_Fecha_Reserva DATE,
    a_ID_Pasajero INTEGER,
    a_ID_Vuelo INTEGER) AS
BEGIN
    INSERT INTO Reservas (ID_Reserva, Num_Asiento, Fecha_Reserva, ID_Pasajero, ID_Vuelo)
    VALUES (SEQ_RESERVAS.NEXTVAL, a_Num_Asiento, a_Fecha_Reserva, a_ID_Pasajero, a_ID_Vuelo);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Reserva(
    a_ID_Reserva NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_reserva SYS_REFCURSOR;
BEGIN
    OPEN e_reserva FOR
        SELECT * FROM Reservas WHERE ID_Reserva = a_ID_Reserva;
    RETURN e_reserva;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Reserva(
    a_ID_Reserva NUMBER,
    a_Nuevo_Num_Asiento VARCHAR2,
    a_Nueva_Fecha_Reserva DATE,
    a_Nuevo_ID_Pasajero INTEGER,
    a_Nuevo_ID_Vuelo INTEGER) AS
BEGIN
    UPDATE Reservas
    SET Num_Asiento = a_Nuevo_Num_Asiento,
        Fecha_Reserva = a_Nueva_Fecha_Reserva,
        ID_Pasajero = a_Nuevo_ID_Pasajero,
        ID_Vuelo = a_Nuevo_ID_Vuelo
    WHERE ID_Reserva = a_ID_Reserva;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Reserva(
    a_ID_Reserva NUMBER) AS
BEGIN
    DELETE FROM Reservas WHERE ID_Reserva = a_ID_Reserva;
    COMMIT;
END;
                                                                                                
                                                /* FIN CRUD TABLA RESERVAS */
                                                
                                                /* INICIO CRUD TABLA EQUIPAJE */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_EQUIPAJE;
CREATE OR REPLACE PROCEDURE Crear_Equipaje(
    a_Peso NUMBER,
    a_Color VARCHAR2,
    a_ID_Pasajero INTEGER) AS
BEGIN
    INSERT INTO Equipaje (ID_Equipaje, Peso, Color, ID_Pasajero)
    VALUES (SEQ_EQUIPAJE.NEXTVAL, a_Peso, a_Color, a_ID_Pasajero);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Equipaje(
    a_ID_Equipaje NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_equipaje SYS_REFCURSOR;
BEGIN
    OPEN e_equipaje FOR
        SELECT * FROM Equipaje WHERE ID_Equipaje = a_ID_Equipaje;
    RETURN e_equipaje;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Equipaje(
    a_ID_Equipaje NUMBER,
    a_Nuevo_Peso NUMBER,
    a_Nuevo_Color VARCHAR2,
    a_Nuevo_ID_Pasajero INTEGER) AS
BEGIN
    UPDATE Equipaje
    SET Peso = a_Nuevo_Peso,
        Color = a_Nuevo_Color,
        ID_Pasajero = a_Nuevo_ID_Pasajero
    WHERE ID_Equipaje = a_ID_Equipaje;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Equipaje(
    a_ID_Equipaje NUMBER) AS
BEGIN
    DELETE FROM Equipaje WHERE ID_Equipaje = a_ID_Equipaje;
    COMMIT;
END;                                                
                                                
                                                /* FIN CRUD TABLA EQUIPAJE */
                                                
                                        /* INICIO CRUD TABLA COMENTARIOS Y RESERVAS */
                                                
/* CREATE */
CREATE SEQUENCE SEQ_COMENTAR_RESER;
CREATE OR REPLACE PROCEDURE Crear_Comentario_y_Reserva(
    a_Puntuacion NUMBER,
    a_Comentario VARCHAR2,
    a_ID_Vuelo INTEGER,
    a_ID_Pasajero INTEGER) AS
BEGIN
    INSERT INTO Comentarios_y_Reservas (ID_Comentarios_y_Reservas, Puntuacion, Comentario, ID_Vuelo, ID_Pasajero)
    VALUES (SEQ_COMENTAR_RESER.NEXTVAL, a_Puntuacion, a_Comentario, a_ID_Vuelo, a_ID_Pasajero);
    COMMIT;
END;

/* READ */
CREATE OR REPLACE FUNCTION Leer_Comentario_y_Reserva(
    a_ID_Comentario_y_Reserva NUMBER) 
    RETURN SYS_REFCURSOR AS
    e_comentario SYS_REFCURSOR;
BEGIN
    OPEN e_comentario FOR
        SELECT * FROM Comentarios_y_Reservas WHERE ID_Comentarios_y_Reservas = a_ID_Comentario_y_Reserva;
    RETURN e_comentario;
END;

/* UPDATE */
CREATE OR REPLACE PROCEDURE Actualizar_Comentario_y_Reserva(
    a_ID_Comentario_y_Reserva NUMBER,
    a_Nueva_Puntuacion NUMBER,
    a_Nuevo_Comentario VARCHAR2,
    a_Nuevo_ID_Vuelo INTEGER,
    a_Nuevo_ID_Pasajero INTEGER) AS
BEGIN
    UPDATE Comentarios_y_Reservas
    SET Puntuacion = a_Nueva_Puntuacion,
        Comentario = a_Nuevo_Comentario,
        ID_Vuelo = a_Nuevo_ID_Vuelo,
        ID_Pasajero = a_Nuevo_ID_Pasajero
    WHERE ID_Comentarios_y_Reservas = a_ID_Comentario_y_Reserva;
    COMMIT;
END;

/* DELETE */
CREATE OR REPLACE PROCEDURE Eliminar_Comentario_y_Reserva(
    a_ID_Comentario_y_Reserva NUMBER) AS
BEGIN
    DELETE FROM Comentarios_y_Reservas WHERE ID_Comentarios_y_Reservas = a_ID_Comentario_y_Reserva;
    COMMIT;
END;                                                
                                                
                                        /* FIN CRUD TABLA COMENTARIOS Y RESERVAS */
                                        
/* VISTAS */

/** Vista de Detalles de Vuelo **/
CREATE OR REPLACE VIEW Detalles_Vuelo AS
SELECT
    v.ID_Vuelo,
    v.Origen,
    v.Destino,
    v.Fecha_Salida,
    v.Fecha_Llegada,
    v.Estado,
    a.Nombre AS Aerolinea
FROM Vuelos v
JOIN Aerolineas a ON v.ID_Aerolinea = a.ID_Aerolinea;

/** Vista de Reservas y Pasajeros **/
CREATE OR REPLACE VIEW Reservas_Pasajeros AS
SELECT
    r.ID_Reserva,
    r.Num_Asiento,
    r.Fecha_Reserva,
    p.Nombre AS Nombre_Pasajero,
    p.Apellido AS Apellido_Pasajero
FROM Reservas r
JOIN Pasajeros p ON r.ID_Pasajero = p.ID_Pasajero;

/** Vista de Equipaje y Pasajeros **/
CREATE OR REPLACE VIEW Equipaje_Pasajeros AS
SELECT
    e.ID_Equipaje,
    e.Peso,
    e.Color,
    p.Nombre AS Nombre_Pasajero,
    p.Apellido AS Apellido_Pasajero
FROM Equipaje e
JOIN Pasajeros p ON e.ID_Pasajero = p.ID_Pasajero;

/** Vista de Comentarios y Reservas Detallados **/
CREATE OR REPLACE VIEW Comentarios_Reservas_Detallados AS
SELECT
    cr.ID_Comentarios_y_Reservas,
    cr.Puntuacion,
    cr.Comentario,
    v.Origen,
    v.Destino,
    p.Nombre AS Nombre_Pasajero,
    p.Apellido AS Apellido_Pasajero
FROM Comentarios_y_Reservas cr
JOIN Vuelos v ON cr.ID_Vuelo = v.ID_Vuelo
JOIN Pasajeros p ON cr.ID_Pasajero = p.ID_Pasajero;

/** Vista de Detalles de Precio **/
CREATE OR REPLACE VIEW Detalles_Precio AS
SELECT
    p.ID_Precio,
    p.Clase,
    p.Costo,
    v.Origen,
    v.Destino
FROM Precios p
JOIN Vuelos v ON p.ID_Vuelo = v.ID_Vuelo;


/* FUNCIONES */

/** Función para Obtener Comidas Disponibles en un Vuelo **/
CREATE OR REPLACE FUNCTION Obtener_Comidas_Disponibles(a_ID_Vuelo NUMBER)
RETURN SYS_REFCURSOR AS
    e_comidas SYS_REFCURSOR;
BEGIN
    OPEN e_comidas FOR
    SELECT * FROM Comida_a_Bordo WHERE ID_Vuelo = a_ID_Vuelo AND Disponibilidad = 'Disponible';
    RETURN e_comidas;
END;

/** Función para Calcular Edad de un Pasajero **/
CREATE OR REPLACE FUNCTION Calcular_Edad_Pasajero(a_ID_Pasajero NUMBER)
RETURN NUMBER AS
    v_edad NUMBER;
BEGIN
    SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, Fecha_Nacimiento) / 12) INTO v_edad
    FROM Pasajeros
    WHERE ID_Pasajero = a_ID_Pasajero;
    
    RETURN v_edad;
END;

/** Función para Obtener Horarios de un Vuelo **/
CREATE OR REPLACE FUNCTION Obtener_Horarios_Vuelo(a_ID_Vuelo NUMBER)
RETURN SYS_REFCURSOR AS
    e_horarios SYS_REFCURSOR;
BEGIN
    OPEN e_horarios FOR
    SELECT * FROM Horarios WHERE ID_Vuelo = a_ID_Vuelo;
    RETURN e_horarios;
END;

/** Función para Obtener Reservas por Fecha **/
CREATE OR REPLACE FUNCTION Obtener_Reservas_Por_Fecha(a_Fecha DATE)
RETURN SYS_REFCURSOR AS
    e_reservas SYS_REFCURSOR;
BEGIN
    OPEN e_reservas FOR
    SELECT * FROM Reservas WHERE Fecha_Reserva = a_Fecha;
    RETURN e_reservas;
END;

-- Función para Obtener Equipaje por Peso
CREATE OR REPLACE FUNCTION Obtener_Equipaje_Por_Peso(a_Peso NUMBER)
RETURN SYS_REFCURSOR AS
    e_equipaje SYS_REFCURSOR;
BEGIN
    OPEN e_equipaje FOR
    SELECT * FROM Equipaje WHERE Peso >= a_Peso;
    RETURN e_equipaje;
END;

/** Función para Calcular Promedio de Puntuaciones por Aerolínea **/
CREATE OR REPLACE FUNCTION Calcular_Promedio_Puntuaciones_Aerolinea(a_ID_Aerolinea NUMBER)
RETURN NUMBER AS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(Puntuacion) INTO v_promedio
    FROM Comentarios_y_Reservas cr
    JOIN Vuelos v ON cr.ID_Vuelo = v.ID_Vuelo
    WHERE v.ID_Aerolinea = a_ID_Aerolinea;
    
    RETURN v_promedio;
END;

/** Función para Obtener Comentarios Recientes **/
CREATE OR REPLACE FUNCTION Obtener_Comentarios_Recientes(a_Numero_Comentarios NUMBER)
RETURN SYS_REFCURSOR AS
    e_comentarios SYS_REFCURSOR;
BEGIN
    OPEN e_comentarios FOR
    SELECT * FROM Comentarios_y_Reservas
    ORDER BY ID_Comentarios_y_Reservas DESC
    FETCH FIRST a_Numero_Comentarios ROWS ONLY;
    
    RETURN e_comentarios;
END;

                                                     /*BIENVENIDA AL SISTEMA*/

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE BIENVENIDA AS 
BEGIN                                                                             
    DBMS_OUTPUT.PUT_LINE('BIENVENIDO AL SISTEMA GO TRAVEL, 
    PROCEDA CON SU CONSULTA');
END;
 

EXEC BIENVENIDA;   


                                                     /*TOTAL AEROLINEAS*/

CREATE OR REPLACE PROCEDURE TOTAL_AEROLINEAS AS 
    TOTAL_AEROLINEAS  NUMBER(4);                                                  
BEGIN
    SELECT COUNT(*) INTO TOTAL_AEROLINEAS
    FROM Aerolineas; 
    DBMS_OUTPUT.PUT_LINE('Total de aerolineas '||total_aerolineas);
END;

EXEC TOTAL_AEROLINEAS;


                                                      /*TOTAL PASAJEROS*/

CREATE OR REPLACE PROCEDURE TOTAL_PASAJEROS AS 
    TOTAL_PASAJEROS  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_PASAJEROS                                           
    FROM Pasajeros; 
    DBMS_OUTPUT.PUT_LINE('Total de pasajeros '||total_pasajeros);
END;
 
EXEC TOTAL_PASAJEROS;

                                                       /*TOTAL VUELOS*/

CREATE OR REPLACE PROCEDURE TOTAL_VUELOS AS 
    TOTAL_VUELOS  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_VUELOS                                              
    FROM Vuelos; 
    DBMS_OUTPUT.PUT_LINE('Total de vuelos '||total_vuelos);
END;
 
EXEC TOTAL_VUELOS;


                                                        /*TOTAL RESERVAS*/

CREATE OR REPLACE PROCEDURE TOTAL_RESERVAS AS 
    TOTAL_RESERVAS  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_RESERVAS                                              
    FROM Reservas; 
    DBMS_OUTPUT.PUT_LINE('Total de reservas '||total_reservas);
END;
 
EXEC TOTAL_RESERVAS;


                                                         /*RESERVAS POR ID*/

CREATE OR REPLACE PROCEDURE RESERVAS_ID(ID_U IN Reservas.ID_Pasajero%TYPE) AS 
    TOTAL_RESERVAS  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_RESERVAS                                               
    FROM Reservas 
    WHERE ID_Pasajero = ID_U;
    DBMS_OUTPUT.PUT_LINE('Total de reservas ' || TOTAL_RESERVAS);
END;

EXEC RESERVAS_ID(&ID_USUARIO);


                                                          /*EQUIPAJE POR ID*/

CREATE OR REPLACE PROCEDURE EQUIPAJE_COUNT(ID_U IN Pasajeros.ID_Pasajero%TYPE) AS 
    TOTAL_EQUIPAJE  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_EQUIPAJE                                               
    FROM Equipaje 
    WHERE ID_Pasajero = ID_U;
    DBMS_OUTPUT.PUT_LINE('Total de equipajes ' || TOTAL_EQUIPAJE);
END;
 
EXEC EQUIPAJE_COUNT(&ID_PASAJERO);


                                                           /*AEROLINEA POR ID DE VUELO*/

CREATE OR REPLACE PROCEDURE VUELOS_POR_AEROLINEA(ID_Aerolinea IN Aerolineas.ID_Aerolinea%TYPE) AS 
    TOTAL_VUELOS  NUMBER(4);
BEGIN
    SELECT COUNT(*) INTO TOTAL_VUELOS                                               
    FROM Vuelos 
    WHERE ID_Aerolinea = ID_Aerolinea;
    DBMS_OUTPUT.PUT_LINE('Total de vuelos para la aerolínea ' || ID_Aerolinea || ' son ' || TOTAL_VUELOS);
END;

EXEC VUELOS_POR_AEROLINEA(&ID_AEROLINEA);



                                                            /*CURSOR PARA ALMACENAR TABLA VUELOS*/

CREATE OR REPLACE PROCEDURE DATOS_VUELOS (MI_CURSOR OUT SYS_REFCURSOR)AS
BEGIN                                                                                  
OPEN MI_CURSOR FOR SELECT * FROM Vuelos;
END;


                                                             /*CURSOR PARA ALMACENAR TABLA PASAJEROS*/

CREATE OR REPLACE PROCEDURE DATOS_USUARIOS (MI_CURSOR OUT SYS_REFCURSOR)AS
BEGIN                                                                                    
OPEN MI_CURSOR FOR SELECT * FROM Pasajeros;
END;
 

                                                             /*CURSOR PARA ALMACENAR TABLA AEROLINEAS*/

CREATE OR REPLACE PROCEDURE DATOS_AEROLINEAS (MI_CURSOR OUT SYS_REFCURSOR)AS
BEGIN                                                                                         
OPEN MI_CURSOR FOR SELECT * FROM Aerolineas;
END; 
 

                                                           /*CURSOR PARA ALMACENAR TABLA RESERVAS*/

CREATE OR REPLACE PROCEDURE DATOS_BOLETOS (MI_CURSOR OUT SYS_REFCURSOR)AS
BEGIN                                                                                         
OPEN MI_CURSOR FOR SELECT * FROM Reservas;
END; 




