DROP DATABASE IF EXISTS db_formula1;

CREATE DATABASE db_formula1
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE db_formula1;

CREATE TABLE paises (
    codigo CHAR(3) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    CONSTRAINT pk_paises PRIMARY KEY (codigo)
);

CREATE TABLE equipes (
    sigla CHAR(3) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    cod_pais CHAR(3) NOT NULL,
    CONSTRAINT pk_equipes PRIMARY KEY (sigla),
    CONSTRAINT fk_equipes_paises FOREIGN KEY (cod_pais) REFERENCES paises (codigo)
);

CREATE TABLE pilotos (
    numero INT NOT NULL,
    nome VARCHAR(80) NOT NULL,
    cod_pais CHAR(3) NOT NULL,
    sigla_equipe CHAR(3) NOT NULL,
    CONSTRAINT pk_pilotos PRIMARY KEY (numero),
    CONSTRAINT fk_pilotos_paises FOREIGN KEY (cod_pais) REFERENCES paises (codigo),
    CONSTRAINT fk_pilotos_equipes FOREIGN KEY (sigla_equipe) REFERENCES equipes (sigla)
);

CREATE TABLE corridas (
    sigla_gp VARCHAR(5) NOT NULL,
    nome_gp VARCHAR(80) NOT NULL,
    cod_pais CHAR(3) NOT NULL,
    qtd_voltas INT NOT NULL,
    CONSTRAINT pk_corridas PRIMARY KEY (sigla_gp),
    CONSTRAINT fk_corridas_paises FOREIGN KEY (cod_pais) REFERENCES paises (codigo)
);

CREATE TABLE participantes (
    sigla_gp VARCHAR(5) NOT NULL,
    num_piloto INT NOT NULL,
    posicao_largada INT NOT NULL,
    CONSTRAINT pk_participantes PRIMARY KEY (sigla_gp, num_piloto),
    CONSTRAINT fk_part_corridas FOREIGN KEY (sigla_gp) REFERENCES corridas (sigla_gp),
    CONSTRAINT fk_part_pilotos FOREIGN KEY (num_piloto) REFERENCES pilotos (numero)
);

INSERT INTO paises (codigo, nome) VALUES
('BRA', 'Brasil'),
('ITA', 'Itália'),
('FRA', 'França'),
('GBR', 'Reino Unido'),
('DEU', 'Alemanha'),
('ESP', 'Espanha'),
('AUT', 'Áustria'),
('MCO', 'Mônaco'),
('AUS', 'Austrália'),
('FIN', 'Finlândia'),
('MEX', 'México'),
('JPN', 'Japão'),
('USA', 'Estados Unidos'),
('CHE', 'Suíça'),
('NLD', 'Países Baixos');

INSERT INTO equipes (sigla, nome, cod_pais) VALUES
('FER', 'Scuderia Ferrari', 'ITA'),
('MCL', 'McLaren Racing', 'GBR'),
('MER', 'Mercedes-AMG', 'DEU'),
('RBR', 'Red Bull Racing', 'AUT'),
('ALP', 'Alpine F1 Team', 'FRA'),
('AMR', 'Aston Martin', 'GBR'),
('WIL', 'Williams Racing', 'GBR'),
('HAA', 'Haas F1 Team', 'USA'),
('SAU', 'Sauber Motorsport', 'CHE'),
('RB', 'Racing Bulls', 'ITA');

INSERT INTO pilotos (numero, nome, cod_pais, sigla_equipe) VALUES
(8, 'Ayrton Senna', 'BRA', 'MCL'),
(5, 'Gabriel Bortoleto', 'BRA', 'SAU'),
(19, 'Felipe Massa', 'BRA', 'FER'),
(20, 'Nelson Piquet', 'BRA', 'WIL'),
(22, 'Rubens Barrichello', 'BRA', 'FER'),
(12, 'Kimi Antonelli', 'ITA', 'MER'),
(51, 'Alberto Ascari', 'ITA', 'FER'),
(21, 'Giancarlo Fisichella', 'ITA', 'ALP'),
(2, 'Alain Prost', 'FRA', 'WIL'),
(6, 'Isack Hadjar', 'FRA', 'RB'),
(44, 'Lewis Hamilton', 'GBR', 'FER'),
(3, 'Michael Schumacher', 'DEU', 'FER'),
(1, 'Max Verstappen', 'NLD', 'RBR'),
(16, 'Charles Leclerc', 'MCO', 'FER'),
(4, 'Lando Norris', 'GBR', 'MCL'),
(81, 'Oscar Piastri', 'AUS', 'MCL'),
(63, 'George Russell', 'GBR', 'MER');

INSERT INTO corridas (sigla_gp, nome_gp, cod_pais, qtd_voltas) VALUES
('INT', 'GP do Brasil', 'BRA', 71),
('MNZ', 'GP da Itália', 'ITA', 53),
('MON', 'GP de Mônaco', 'MCO', 78),
('SIL', 'GP da Grã-Bretanha', 'GBR', 52),
('BCN', 'GP da Espanha', 'ESP', 66),
('SPI', 'GP da Áustria', 'AUT', 71),
('SUZ', 'GP do Japão', 'JPN', 53),
('MEL', 'GP da Austrália', 'AUS', 58),
('COA', 'GP dos Estados Unidos', 'USA', 56),
('MEX', 'GP do México', 'MEX', 71);

INSERT INTO participantes (sigla_gp, num_piloto, posicao_largada) VALUES
('INT', 8, 1),
('INT', 1, 2),
('INT', 44, 3),
('INT', 16, 4),
('INT', 4, 5),
('INT', 5, 6),
('MNZ', 16, 1),
('MNZ', 12, 2),
('MNZ', 63, 3),
('MNZ', 44, 4),
('MNZ', 81, 5),
('MON', 16, 1),
('MON', 4, 2),
('MON', 81, 3),
('MON', 22, 4),
('MON', 1, 5),
('SUZ', 1, 1),
('SUZ', 4, 2),
('SUZ', 81, 3),
('SUZ', 63, 4);

SELECT nome
FROM paises
WHERE nome LIKE 'B%L';

SELECT p.nome AS piloto, pa.nome AS pais
FROM pilotos p
JOIN paises pa ON pa.codigo = p.cod_pais
WHERE pa.nome IN ('Brasil', 'Itália', 'França');

SELECT nome
FROM pilotos;

SELECT nome_gp AS 'Grande Prêmio',
       qtd_voltas AS 'Quantidade de Voltas'
FROM corridas;

SELECT p.nome AS piloto,
       pa.nome AS pais
FROM pilotos p
JOIN paises pa ON pa.codigo = p.cod_pais;

ALTER TABLE pilotos
    ADD COLUMN salario DECIMAL(12,2) NULL;

UPDATE pilotos SET salario = 200000.00 WHERE numero = 44;
UPDATE pilotos SET salario = 180000.00 WHERE numero = 3;
UPDATE pilotos SET salario = 150000.00 WHERE numero = 8;
UPDATE pilotos SET salario = 200000.00 WHERE numero = 1;
UPDATE pilotos SET salario = 120000.00 WHERE numero = 2;
UPDATE pilotos SET salario = 150000.00 WHERE numero = 16;
UPDATE pilotos SET salario = 95000.00 WHERE numero = 4;
UPDATE pilotos SET salario = 85000.00 WHERE numero = 81;
UPDATE pilotos SET salario = 100000.00 WHERE numero = 63;
UPDATE pilotos SET salario = 70000.00 WHERE numero = 12;
UPDATE pilotos SET salario = 55000.00 WHERE numero = 5;
UPDATE pilotos SET salario = 50000.00 WHERE numero = 6;
UPDATE pilotos SET salario = 80000.00 WHERE numero = 19;
UPDATE pilotos SET salario = 72000.00 WHERE numero = 20;
UPDATE pilotos SET salario = 72000.00 WHERE numero = 22;
UPDATE pilotos SET salario = 70000.00 WHERE numero = 51;
UPDATE pilotos SET salario = 65000.00 WHERE numero = 21;

SELECT nome, salario
FROM pilotos
WHERE salario BETWEEN 70000 AND 100000;

SELECT cod_pais,
       AVG(salario) AS media_salarial
FROM pilotos
GROUP BY cod_pais;

SELECT DISTINCT salario
FROM pilotos
ORDER BY salario ASC;
