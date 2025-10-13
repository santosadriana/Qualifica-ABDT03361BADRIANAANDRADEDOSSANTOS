CREATE DATABASE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA08;

USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA08;

--  Banco de Dados Padaria

CREATE TABLE PRODUTO (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(8,2)
);

INSERT INTO PRODUTO (nome, preco) VALUES
('Bolo de Fubá', 28.50),
('Bolo de Chocolate', 35.00),
('Pão de Queijo', 4.50),
('Broa de Milho', 7.00);

CREATE TABLE FORNECEDOR (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)
);

INSERT INTO FORNECEDOR (nome, telefone) VALUES
('Royal', 222222222),
('Estrela',111111111),
('Boa Sorte',333333333),
('Favorita', 555555555);

CREATE TABLE VENDAS (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    data_venda DATE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

INSERT INTO VENDAS (id_produto, quantidade, data_venda) VALUES

(1, 4, '2025-06-03'),
(2, 3, '2025-06-03'),
(3, 2, '2025-06-03'),
(4, 1, '2025-06-03');

SELECT * FROM PRODUTO;

SELECT
    P.nome AS Produto,
    SUM(V.quantidade) AS Total_Unidades_Vendidas
FROM
    VENDAS V
JOIN
    PRODUTO P ON V.id_produto = P.id_produto
GROUP BY
    P.nome
ORDER BY
    Total_Unidades_Vendidas DESC;
   
   SELECT
    SUM(V.quantidade) AS Total_Vendas_Bolo_Fuba
FROM
    VENDAS V
JOIN
    PRODUTO P ON V.id_produto = P.id_produto
WHERE
    P.nome = 'Bolo de Fubá';
   
    SELECT
    SUM(V.quantidade) AS Total_Vendas_Bolo_Chocolate
FROM
    VENDAS V
JOIN
    PRODUTO P ON V.id_produto = P.id_produto
WHERE
    P.nome = 'Bolo de Chocolate';
   
     SELECT DISTINCT
    P.nome AS Produto
FROM
    VENDAS V
JOIN
    PRODUTO P ON V.id_produto = P.id_produto
WHERE
    V.data_venda = '2025-06-03';
    
    
  --  Banco de Dados Escola
USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA08;

CREATE TABLE ALUNO (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),                        
    sobrenome VARCHAR(50),                    
    curso VARCHAR(100)                        
);

INSERT INTO ALUNO (nome, sobrenome, curso) VALUES
("Adriana", "Andrade", "Pedagogia"),
("Leandro", "Souza", "Tecnologia da Informacao"),
("Maria", "Santos", "Matematica"),
("Rosana", "Batista", "Letras");

CREATE TABLE PROFESSOR (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),                        
    sobrenome VARCHAR(50),                    
    curso_ministrado VARCHAR(100)              
);

INSERT INTO PROFESSOR (nome, sobrenome, curso_ministrado) VALUES
('Irene', 'Batista', 'Tecnologia da Informacao'),
('Suzana', 'Pereira', 'Matematica'),
('Lucas', 'Silva', 'Letras'),
('Jessica', 'Sousa', 'Pedagogia');

CREATE TABLE COMENTARIO (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,                                
    id_professor INT,                            
    comentario TEXT,                            
    nota_do_professor DECIMAL(3,1),            

    FOREIGN KEY (id_aluno) REFERENCES ALUNO(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES PROFESSOR(id_professor)
);

INSERT INTO COMENTARIO (comentario, nota_do_professor) VALUES
("Explica muito bem a disciplina", 6.5),
("Aulas organizadas, ótima didática", 7.3),
("Professor pontual", 6.3),
("Metodologia ágil, aulas interativas", 5.0);

SELECT
    nome,
    sobrenome,
    curso
FROM
    ALUNO;
   
    SELECT
    nome,
    sobrenome,
    curso_ministrado
FROM
    PROFESSOR;
   
    SELECT
    P.nome AS nome_professor,
    P.sobrenome AS sobrenome_professor,
    A.nome AS nome_aluno,
    A.sobrenome AS sobrenome_aluno,
    C.comentario,
    C.nota_do_professor
FROM
    COMENTARIO C
INNER JOIN
    PROFESSOR P ON C.id_professor = P.id_professor
INNER JOIN
    ALUNO A ON C.id_aluno = A.id_aluno;
   
    SELECT
    C.comentario,
    C.nota_do_professor,
    P.nome AS nome_professor,
    A.nome AS nome_aluno
FROM
    COMENTARIO C
INNER JOIN
    PROFESSOR P ON C.id_professor = P.id_professor
INNER JOIN
    ALUNO A ON C.id_aluno = A.id_aluno
WHERE
    C.nota_do_professor < 6.0;
   
    SELECT
    C.comentario,
    C.nota_do_professor,
    P.nome AS nome_professor,
    A.nome AS nome_aluno
FROM
    COMENTARIO C
INNER JOIN
    PROFESSOR P ON C.id_professor = P.id_professor
INNER JOIN
    ALUNO A ON C.id_aluno = A.id_aluno
WHERE
    C.nota_do_professor > 6.0;

--  Banco de Dados Locadora Carros
USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA08;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO Cliente (nome, sobrenome, telefone, email) VALUES
('Leandro', 'Batista', '333333333', 'leandro.batista@gmail.com'),
('Maria', 'Andrade', '1111111111', 'maria.andrade@hotmail.com'),
('Tereza', 'Silva', '444444444', 'tereza.silva@hotmail.com'),
('Jessica', 'Souza', '222222222', 'jessica.souza@yahoo.com');


CREATE TABLE Automovel (
    id_automovel INT PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    tipo VARCHAR(50)
);

INSERT INTO Automovel (marca, modelo, tipo) VALUES
('Hatch', 'Volkswagen', 'Polo'),
('Elétrico', 'Tesla', 'Model 3'),
('Crossover', 'Nissan', 'Kicks'),
('Crossover', 'Nissan', 'Kicks');

CREATE TABLE DataLocacao (
    id_datalocacao INT PRIMARY KEY AUTO_INCREMENT, -- Ou SERIAL para PostgreSQL
    id_cliente INT NOT NULL,
    id_automovel INT NOT NULL,
    datainiciolocacao DATE NOT NULL,
    datafinallocacao DATE,
   
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_automovel) REFERENCES Automovel(id_automovel)
);

INSERT INTO DataLocacao (id_cliente, id_automovel, datainiciolocacao, datafinallocacao) VALUES
(1, 4, '2025-10-01', '2025-08-04'),
(2, 2, '2025-10-05', '2025-07-03'),
(3, 1, '2025-10-05', '2025-10-09'),
(4, 3, '2025-10-10', '2025-10-11');

SELECT id_cliente, nome, sobrenome, telefone, email
FROM Cliente;

SELECT A.id_automovel, A.marca, A.modelo, A.tipo
FROM Automovel A
LEFT JOIN DataLocacao DL ON A.id_automovel = DL.id_automovel
WHERE DL.id_automovel IS NULL
   OR DL.datafinallocacao IS NOT NULL;
   
SELECT id_automovel, marca, modelo, tipo
FROM Automovel
WHERE id_automovel NOT IN (
    SELECT id_automovel
    FROM DataLocacao
    WHERE datafinallocacao IS NULL
);

SELECT
    C.nome AS Nome_Cliente,
    C.sobrenome AS Sobrenome_Cliente,
    A.marca AS Marca_Automovel,
    A.modelo AS Modelo_Automovel,
    DL.datainiciolocacao AS Data_Inicio,
    DL.datafinallocacao AS Data_Fim
FROM
    DataLocacao DL
INNER JOIN
    Cliente C ON DL.id_cliente = C.id_cliente
INNER JOIN
    Automovel A ON DL.id_automovel = A.id_automovel
ORDER BY
    DL.datainiciolocacao DESC;
   
SELECT DISTINCT
    A.marca AS Marca,
    A.modelo AS Modelo
FROM
    Automovel A
INNER JOIN
    DataLocacao DL ON A.id_automovel = DL.id_automovel
WHERE
    '2025-10-11' BETWEEN DL.datainiciolocacao AND COALESCE(DL.datafinallocacao, '2025-07-03');
    
   