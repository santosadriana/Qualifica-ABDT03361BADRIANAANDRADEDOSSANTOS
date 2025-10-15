-- ATIVIDADEAULA12

USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA06;

CREATE TABLE produtos_Aula12 (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT
);

INSERT INTO produtos_Aula12 (id_produto, nome, preco, quantidade_estoque) VALUES
(1, 'Pão Francês', 7.50, 200),
(2, 'Coxinha', 6.50, 110),
(3, 'Pão Queijo', 9.50, 100),
(4, 'Empada', 9.50, 100),
(5, 'Bolo de Chocolate', 47.00, 5),
(6, 'Pudim', 35.00, 50),
(7, 'Torta de Limao', 15.50, 90),
(8, 'Torta Salgada ', 65.00, 40),
(9, 'Bolo de Laranja', 40.00,50);

UPDATE produtos_Aula12
SET preco = 49.00, quantidade_estoque = 5
WHERE id_produto = 5;

DELETE FROM produtos_Aula12
WHERE id_produto = 4;

SELECT * FROM produtos_Aula12;


