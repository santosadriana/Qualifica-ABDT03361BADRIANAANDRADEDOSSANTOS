CREATE DATABASE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA06;
USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA06;
 
CREATE TABLE Fornecedores (

id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
telefone VARCHAR(100),
cidade VARCHAR(20)
);

INSERT INTO Fornecedores (nome, telefone, cidade) VALUES
("Adriana Andrade", "111111111", "Sao Paulo"),
("Maria Santos", "222222222", "Rio de Janeiro"),
("Leandro Souza", "3333333333", "Curitiba"),
("Irene Batista", "11111111", "Salvador");
 
SELECT *
FROM Fornecedores;

SELECT nome, telefone,cidade
FROM Fornecedores;

SELECT *
FROM Fornecedores
ORDER BY nome ASC;
CREATE TABLE Produtos (

id_produto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
preco DECIMAL(10, 2) NOT NULL,
estoque SMALLINT NOT NULL,
id_fornecedor INT,
FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);
 
INSERT INTO Produtos (nome, preco, estoque, id_fornecedor) VALUES
("Caderno ", 12.00, 100, 1),
("Lapiseira", 4.50, 300, 2),
("Estojo", 5.00, 200, 3),
("Folha de Sulfite", 25.00, 200, 4);
 
SELECT *
FROM Produtos;

SELECT nome, preco
FROM Produtos
LIMIT 2;

SELECT nome, estoque
FROM Produtos
ORDER BY estoque DESC;
CREATE TABLE Vendas (

id_venda INT PRIMARY KEY AUTO_INCREMENT,
id_produto INT,
data_venda DATE,
quantidade SMALLINT NOT NULL,
valor_total DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

INSERT INTO Vendas (id_produto, data_venda, quantidade, valor_total) VALUES
(1, '2025-09-02', 2, 9.00),
(2, '2025-07-03', 5, 22.50),
(3, '2025-03-05', 10, 15.00),
(4, '2025-02-01', 2, 50.00);

SELECT *
FROM Vendas;

SELECT id_venda, valor_total
FROM Vendas
ORDER BY valor_total DESC;

SELECT *
FROM Vendas
WHERE data_venda >= '2025-03-05';  








