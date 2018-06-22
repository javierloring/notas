------------------------------
-- Archivo de base de datos --
------------------------------
DROP TABLE IF EXISTS alumnos CASCADE;

CREATE TABLE alumnos
(
    id       bigserial    PRIMARY KEY
  , nombre   varchar(255) NOT NULL
);
INSERT INTO alumnos (nombre)
VALUES ('Pepe')
     , ('Juan')
     , ('María');

DROP TABLE IF EXISTS asignaturas CASCADE;

CREATE TABLE asignaturas
(
    id           bigserial    PRIMARY KEY
  , denominacion varchar(255) NOT NULL
  , trimestres   smallint     NOT NULL CONSTRAINT ck_trimestres_validos
                              CHECK (trimestres BETWEEN 1 AND 3)
);
INSERT INTO asignaturas (denominacion, trimestres)
VALUES ('matemáticas', 3)
     , ('fisíca', 2)
     , ('lengua', 3);

DROP TABLE IF EXISTS notas CASCADE;

CREATE TABLE notas
(
    id            bigserial PRIMARY KEY
  , alumno_id     bigint    NOT NULL REFERENCES alumnos (id)
  , asignatura_id bigint    NOT NULL REFERENCES asignaturas (id)
  , trimestre     smallint  NOT NULL
  , nota          smallint  NOT NULL CONSTRAINT ck_nota_valida
                            CHECK (nota BETWEEN 0 AND 10)
  , UNIQUE (alumno_id, asignatura_id, trimestre)
);
