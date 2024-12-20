
-- SELECT 
--* -- colunas que queremos ver (TODAS = *)
--FROM
-- pacientes -- tabela(s) que vamos consultar
-- WHERE -- SÓ SE QUERO FILTRAR
-- id_consulta BETWEEN 8 AND 12  -- id_consulta >= 8 and id_consulta =< 12
-- id_medico IN (1, 3) -- id_medico = 1 OR id_medico = 3
-- nome_paciente LIKE '%a%' -- paciente com pelo menos um 'a' no seu nome ------------
-- nome_paciente LIKE 'a%' -- paciente que o nome dele começa com 'a' ------------
-- EXTRACT(YEAR FROM data_nascimento) = 1990 
-- UPPER / LOWER
-- CONCAT(nome_paciente, '/' , genero) AS nome_genero
-- CAST(data_nascimento AS VARCHAR)  -------------

-- Me retorne todos os pacientes que fazem aniversario em julho. 
-- WHERE EXTRACT(MONTH FROM data_nascimento) = 7
-- Mostre o nome dele e a data de nascimento
-- Me retorne paciente que nasceram entre os anos 1995 e 2000
-- WHERE extract(year from data_nascimento) between 1995 and 2000

-- Retorne pacientes que o seu CPF começa com 5 (dica: cast e like)
/*
SELECT *
FROM pacientes
WHERE CAST(CPF AS VARCHAR) LIKE '5%'
*/

-- Retorne pacientes com endereço em uma Avenida e que tenham mais de 45 anos
-- (dica, comparação de Data com string, por exemplo WHERE data_nasicmento < '2000-01-01'
--  LIKE)

/*
SELECT *
FROM pacientes
WHERE endereco LIKE '%Avenida%' AND data_nascimento < '1978-12-11'
*/

--------- CHAVES ESTRANGEIRAS -------------

/*
ALTER TABLE consultas 
ADD CONSTRAINT FK_pacientes_id_paciente FOREIGN KEY (id_paciente)
REFERENCES pacientes (id_paciente)
*/

-------------------- JOIN -------------------

-- INNER JOIN
/*
SELECT A.data_consulta, C.nome_paciente, B.nome_medico, A.cid
FROM consultas A
INNER JOIN medicos B ON A.id_medico = B.id_medico
INNER JOIN pacientes C ON A.id_paciente = C.id_paciente
*/

SELECT A.data_consulta , A.cid, B.nome_doenca
FROM consultas A
LEFT JOIN doencas B ON A.cid = B.cid




-- select * from doencas


-- GROUP BY



