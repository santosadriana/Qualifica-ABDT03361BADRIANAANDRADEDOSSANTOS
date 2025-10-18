USE DB_03361B_ADRIANA_ANDRADE_DOS_SANTOS_AULA06;

CREATE TABLE PROFESSOR_Aula14 (
    id_professor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(6) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    titulacao VARCHAR(50) NOT NULL,
    CHECK (matricula REGEXP '^2[0-9]{5}')
);

CREATE TABLE ALUNO_Aula14 (
    id_aluno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(6) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    CHECK (matricula REGEXP '^1[0-9]{5}')
);

CREATE TABLE DISCIPLINA_Aula14 (
    id_disciplina INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_professor INT NOT NULL,
    nome VARCHAR(100) UNIQUE NOT NULL,
    carga_horaria INT NOT NULL,
   
    FOREIGN KEY (id_professor) REFERENCES PROFESSOR_Aula14(id_professor)
);

CREATE TABLE ALUNO_DISCIPLINA_Aula14 (
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    PRIMARY KEY (id_aluno, id_disciplina),
    FOREIGN KEY (id_aluno) REFERENCES ALUNO_Aula14(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES DISCIPLINA_Aula14(id_disciplina)
);

INSERT INTO PROFESSOR_Aula14 (matricula, nome, email, titulacao) VALUES
('200001', 'Adriana', 'adriana.gmail.com', 'Mestrado'),
('200002', 'Eliete', 'eliete.hotmail.com', 'Doutorado'),
('200003', 'Leandro', 'leandro.yahoo.com', 'Mestrado');

INSERT INTO ALUNO_Aula14 (matricula, nome, email, telefone) VALUES
('100001', 'Lucas', 'lucas@yahoo.com', '222222222'),
('100002', 'Maria', 'maria.hotmail.com', '111111111'),
('100003', 'Fernanda', 'fernanda.gmail.com', '3333333333'),
('100004', 'Suzana', 'suzana,yahoo.com', '5555555555'),
('100005', 'Irene', 'irenegmail.com', '3333333333');

INSERT INTO DISCIPLINA_Aula14 (id_professor, nome, carga_horaria) VALUES
(1, 'Computação', 120),
(2, 'Pedagogia', 300),
(3, 'Quimica', 180);

INSERT INTO ALUNO_DISCIPLINA_Aula14 (id_aluno, id_disciplina) VALUES (1, 1);
INSERT INTO ALUNO_DISCIPLINA_Aula14 (id_aluno, id_disciplina) VALUES (1, 2);
INSERT INTO ALUNO_DISCIPLINA_Aula14 (id_aluno, id_disciplina) VALUES (2, 2);
INSERT INTO ALUNO_DISCIPLINA_Aula14 (id_aluno, id_disciplina) VALUES (4, 1);
INSERT INTO ALUNO_DISCIPLINA_Aula14 (id_aluno, id_disciplina) VALUES (5, 3);

SELECT
    D.nome AS Disciplina,
    P.nome AS Professor
FROM
    DISCIPLINA_Aula14 D
JOIN
    PROFESSOR_Aula14 P ON D.id_professor = P.id_professor;


SELECT
    A.matricula,
    A.nome
FROM
    ALUNO_Aula14 A
JOIN
    ALUNO_DISCIPLINA_Aula14 AD ON A.id_aluno = AD.id_aluno
JOIN
    DISCIPLINA_Aula14 D ON AD.id_disciplina = D.id_disciplina
WHERE
    D.nome = 'Computação';

SELECT
    A.matricula,
    A.nome
FROM
    ALUNO_Aula14 A
LEFT JOIN
    ALUNO_DISCIPLINA_Aula14 AD ON A.id_aluno = AD.id_aluno
WHERE
    AD.id_aluno IS NULL;

SELECT
    D.nome AS Disciplina,
    P.nome AS Professor,
    COUNT(AD.id_aluno) AS Total_Alunos
FROM
    DISCIPLINA_Aula14 D
JOIN
    PROFESSOR_Aula14 P ON D.id_professor = P.id_professor
LEFT JOIN
    ALUNO_DISCIPLINA_Aula14 AD ON D.id_disciplina = AD.id_disciplina
GROUP BY
    D.nome, P.nome
ORDER BY
    Total_Alunos DESC, Disciplina ASC;