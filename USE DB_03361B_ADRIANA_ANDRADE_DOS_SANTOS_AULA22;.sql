CREATE DATABASE Lanhouse;
USE Lanhouse;

CREATE TABLE Computador
(
    id INT PRIMARY KEY IDENTITY,
    identificacao VARCHAR(5),
    valor DECIMAL DEFAULT 2.00
);

INSERT INTO Computador (identificacao, valor) VALUES
('PC01', 2.00), -- R$ 2.00/hora (Valor Padrão)
('PC02', 2.00),
('PC03', 2.50); -- Um valor diferenciado

CREATE TABLE Cliente
(
    id INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO Cliente (nome, email, telefone) VALUES
('João Silva', 'joao.silva@yahoo.com', '11111111111'),
('Maria Oliveira', 'maria.o@gmail.com', '2222222222'),
('Pedro Souza', 'pedro.s@hotmail.com', '33333333333');

CREATE TABLE Sessao
(
    id INT PRIMARY KEY IDENTITY,
    id_cliente INT NOT NULL,
    id_computador INT NOT NULL,
    data_inicio DATE DEFAULT CURRENT_TIMESTAMP,
    data_fim DATE
    -- DEFINAM AS CONTRAINTS PARA VOCÊS TREINAREM
);

-- Sessão 1: Finalizada (Durou 3 horas e 30 minutos)
INSERT INTO Sessao (id_cliente, id_computador, data_inicio, data_fim) VALUES
(
    1, -- id_cliente: João Silva
    1, -- id_computador: PC01
    DATEADD(HOUR, -5, GETDATE()), -- Início: 5 horas atrás
    DATEADD(HOUR, -1.5, GETDATE()) -- Fim: 1.5 horas atrás (Duração: 3.5 horas)
);

-- Sessão 2: Finalizada (Durou 1 hora)
INSERT INTO Sessao (id_cliente, id_computador, data_inicio, data_fim) VALUES
(
    2, -- id_cliente: Maria Oliveira
    3, -- id_computador: PC03
    DATEADD(HOUR, -2, GETDATE()), -- Início: 2 horas atrás
    DATEADD(HOUR, -1, GETDATE()) -- Fim: 1 hora atrás (Duração: 1 hora)
);

-- Sessão 3: NÃO Finalizada (Ainda em progresso, para Atividades 1 e 3)
INSERT INTO Sessao (id_cliente, id_computador, data_inicio, data_fim) VALUES
(
    3, -- id_cliente: Pedro Souza
    2, -- id_computador: PC02
    DATEADD(HOUR, -0.5, GETDATE()), -- Início: 30 minutos atrás
    NULL -- data_fim: NULL (Sessão aberta)
);

-- LISTAR TODAS AS SESSÕES QUE AINDA NÃO FINALIZADAS
USE Lanhouse;
SELECT
    S.id AS 'ID da Sessão',
    C.nome AS 'Nome do Usuário',
    C.email AS 'Email do Usuário',
    Comp.identificacao AS 'Identificador do Computador'
FROM
    Sessao S
INNER JOIN
    Cliente C ON S.id_cliente = C.id
INNER JOIN
    Computador Comp ON S.id_computador = Comp.id
WHERE
    S.data_fim IS NULL; -- Uma sessão não finalizada tem data_fim NULL

-- LISTAR TODAS AS SESSÕES FINALIZADAS E QUANTAS HORAS CADA SESSÃO DUROU
USE Lanhouse;
SELECT
    S.id AS 'ID da Sessão',
    C.nome AS 'Nome do Usuário',
    C.email AS 'Email do Usuário',
    Comp.identificacao AS 'Identificador do Computador',
    -- Calcula a diferença em horas entre data_fim e data_inicio
    DATEDIFF(HOUR, S.data_inicio, S.data_fim) AS 'Horas Usadas'
FROM
    Sessao S
INNER JOIN
    Cliente C ON S.id_cliente = C.id
INNER JOIN
    Computador Comp ON S.id_computador = Comp.id
WHERE
    S.data_fim IS NOT NULL; -- Uma sessão finalizada tem data_fim preenchida

-- LISTAR TODAS AS SESSÕES NÃO FINALIZADAS E O VALOR DEVIDO PELA SESSÃO
USE Lanhouse;
SELECT
    S.id AS 'ID da Sessão',
    C.nome AS 'Nome do Usuário',
    C.email AS 'Email do Usuário',
    Comp.identificacao AS 'Identificador do Computador',
    -- Calcula o valor devido com base nas horas decorridas (até o momento da consulta)
    -- e o valor_hora do computador. O DATEDIFF(HOUR, ...) calcula apenas horas cheias
    -- Para maior precisão, o DATEDIFF(MINUTE, ...) é mais adequado
    (DATEDIFF(MINUTE, S.data_inicio, GETDATE()) / 60.0) * Comp.valor AS 'Valor Total Devido (R$)'
FROM
    Sessao S
INNER JOIN
    Cliente C ON S.id_cliente = C.id
INNER JOIN
    Computador Comp ON S.id_computador = Comp.id
WHERE
    S.data_fim IS NULL; -- Sessões não finalizadas