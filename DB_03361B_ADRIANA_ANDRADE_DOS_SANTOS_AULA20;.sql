CREATE DATABASE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA20;

USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA20;



CREATE TABLE Curso (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    total_creditos INT,
    carga_horaria INT
);


INSERT INTO Curso (nome, total_creditos, carga_horaria) VALUES
('Computação', 240, 3600),             
('Jornalismo', 180, 2700),
('Psicologia', 200, 3000),
('Engenharia Elétrica', 250, 3750),
('Gastronomia', 150, 2250);


CREATE TABLE Professor (
    matricula INT PRIMARY KEY IDENTITY(100,1),
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


INSERT INTO Professor (nome, sobrenome, email) VALUES
('Marcelo', 'Guedes', 'marcelo.@bol.com'), 
('Viviane', 'Dias', 'viviane.@gmail.com'),
('Rodolfo', 'Castro', 'rodolfo.@yahoo.com'),
('Letícia', 'Rocha', 'leticia.@hotmail.com'),
('Felipe', 'Sales', 'felipe.@mail.com');    


CREATE TABLE Disciplina (
    id INT PRIMARY KEY IDENTITY(10,1),
    id_professor INT,
    id_curso INT,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT,
    creditos INT,
    FOREIGN KEY (id_professor) REFERENCES Professor(matricula),
    FOREIGN KEY (id_curso) REFERENCES Curso(id)
);


INSERT INTO Disciplina (id_professor, id_curso, nome, carga_horaria, creditos) VALUES
(100, 1, 'Aplicação de Banco de Dados', 80, 4), 
(100, 1, 'Análise de Dados', 60, 3),            
(101, 2, 'Ética e Legislação', 40, 2),
(102, 3, 'Desenvolvimento Humano', 80, 4),
(103, 4, 'Circuitos Elétricos', 100, 5),
(104, 5, 'Confeitaria Básica', 60, 3);



CREATE TABLE Aluno (
    matricula INT PRIMARY KEY IDENTITY(1000,1),
    id_curso INT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Curso(id)
);

INSERT INTO Aluno (id_curso, nome, sobrenome, email) VALUES
(1, 'João', 'Mendes', 'joao.m@yahoo.com'),     
(1, 'Sofia', 'Alves', 'sofia.@bol.com'),
(2, 'Gustavo', 'Nunes', 'gustavo.@hotmail.com'),
(3, 'Heloísa', 'Souza', 'heloisa.s@hotmail.com'),
(4, 'Igor', 'Lopes', 'igor.l@yahoo.com');


CREATE TABLE AlunoDisciplina (
    matricula_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    PRIMARY KEY (matricula_aluno, id_disciplina),
    FOREIGN KEY (matricula_aluno) REFERENCES Aluno(matricula),
    FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id)
);


INSERT INTO AlunoDisciplina (matricula_aluno, id_disciplina) VALUES
(1000, 10), 
(1000, 11), 
(1001, 10), 
(1003, 11), 
(1004, 11); 



-- Faça query básica para cada tabela, mostrando todas as colunas:

SELECT * FROM Curso;

SELECT * FROM Professor;

SELECT * FROM Disciplina;

SELECT * FROM AlunoDisciplina;

-- Liste todas as disciplinas de "Computação", usando apenas o ID do curso (SEM JOIN):

SELECT nome
FROM Disciplina
WHERE id_curso = 1;

-- Liste as disciplinas em que cada aluno está matriculado, com matricula e nome do aluno, nome do curso, e nome, créditos e carga horária da disciplina:

SELECT
    A.matricula AS Matricula_Aluno,
    A.nome AS Nome_Aluno,
    C.nome AS Nome_Curso,
    D.nome AS Nome_Disciplina,
    D.creditos AS Creditos_Disciplina,
    D.carga_horaria AS Carga_Horaria_Disciplina
FROM
    Aluno A
INNER JOIN
    Curso C ON A.id_curso = C.id
INNER JOIN
    AlunoDisciplina AD ON A.matricula = AD.matricula_aluno
INNER JOIN
    Disciplina D ON AD.id_disciplina = D.id
ORDER BY
    A.matricula, D.nome;
