
--Criando o banco de dados
CREATE DATABASE db_Seguro;
--Escolhendo o banco de dados criado
USE db_Seguro;

--*******************
-- Criando as tabelas
--*******************

CREATE TABLE Veiculo (
Renavam varchar(11) PRIMARY KEY,
Cor VARCHAR(20) NOT NULL,
Valor_Veiculo REAL NOT NULL,
Cpf_Segurado VARCHAR(12) NOT NULL,
Cnpj_Seguradora VARCHAR(11) NOT NULL,
)

CREATE TABLE Proprietario(
Cpf_Segurado VARCHAR(12) PRIMARY KEY,
Nome VARCHAR(50) NOT NULL,
Idade INT NOT NULL,
Endereco VARCHAR(50) NOT NULL,
Telefone VARCHAR(15) NOT NULL UNIQUE,
)

CREATE TABLE Seguradora(
Cnpj_Seguradora VARCHAR(11) PRIMARY KEY,
Endereco_Seguradora VARCHAR(50) NOT NULL,
Telefone_Seguradora VARCHAR(15) NOT NULL UNIQUE,
Valo_Seguro REAL NOT NULL
)

DROP TABLE Proprietario;

DROP TABLE Seguradora;

DROP TABLE Veiculo;
--**************************************
--Alguns comandos ALTER TABLE
--Criando e excluindo chave estrangeiras
--**************************************

ALTER TABLE Proprietario
ADD Cidade VARCHAR(50) NULL;

-- Excluindo Algumas colunas
ALTER TABLE Veiculo 
DROP COLUMN Cpf_Segurado;

ALTER TABLE Veiculo
DROP COLUMN Cnpj_Seguradora;

SELECT * FROM Veiculo;

-- Adicionando coluna e estabelecendo os relacionamentos
ALTER TABLE Veiculo
ADD Cpf_Segurado VARCHAR(12) NULL
CONSTRAINT fk_Proprietario FOREIGN KEY(Cpf_Segurado)
REFERENCES Proprietario;

ALTER TABLE Veiculo 
ADD Cnpj_Seguradora VARCHAR(11) NULL
CONSTRAINT fk_Seguradora FOREIGN KEY (Cnpj_Seguradora)
REFERENCES Seguradora;

ALTER TABLE Veiculo
ADD Marca_Modelo VARCHAR(40) NOT NULL;

-- Excluindo chave estrangeira

GO
ALTER TABLE Veiculo
DROP CONSTRAINT fk_Proprietario;
GO


GO
ALTER TABLE Veiculo
DROP CONSTRAINT fk_Seguradora;
GO

-- Criando foreign key numa coluna existente na tabela veiculo
ALTER TABLE Veiculo
ADD CONSTRAINT fk_Proprietario FOREIGN KEY(Cpf_Segurado)
REFERENCES Proprietario;

ALTER TABLE Veiculo
ADD CONSTRAINT fk_Seguradora FOREIGN KEY(Cnpj_Seguradora)
REFERENCES Seguradora;

-- Renomeando nome da coluna na tabela Seguradora

sp_rename 'Seguradora.Valo_Seguro','Valor_Seguro','COLUMN';

--*********************
-- POPULANDO AS TABELAS
--*********************

INSERT INTO Proprietario(Cpf_Segurado, Nome, Idade, Endereco, Telefone)
VALUES('2346782393', 'João', 30, 'Rua das variações musicais, n10', '11928375362'),
      ('6573926482', 'Maria', 25, 'Rua Nóbrega de Siqueira, n20', '11927625362'),
      ('8462524417', 'Carlos', 55, 'Av Bandeirantes, n1000', '11922975368'),
      ('3859152847', 'Ana', 33, 'Rua Apiacas, n45', '11926975346'),
      ('2846496622', 'Sabrina', 38, 'Rua José bastos, n11', '13985737536'),
      ('6673885512', 'José', 18, 'Rua Hafiz abi chedid , n70', '1994673985'),
      ('5967888932', 'Marcelo', 44, 'Av dos Estados, n4595', '21936472397'),
      ('7732998633', 'Sandra', 26, 'Rua Iperoing, n30', '11927639943'),
      ('3378222261', 'Joana', 49, 'Av Higianópolis, n200', '11936677887'),
      ('9922537225', 'Bruna', 27, 'Estrada do M Boi Mirim, n3573', '11967773323');

	  SELECT * FROM Proprietario;

INSERT INTO Veiculo(Renavam, Cor, Valor_Veiculo, Cpf_Segurado, Cnpj_Seguradora, Marca_Modelo) 
 VALUES ('00478976334', 'Branco', 35000, '2346782393', '36749715284', 'Fiesta 1.6 Flex'),
		('00283745198', 'Branco', 40000, '6573926482', '54728763983', 'Gol'),
		('00384765129', 'Azul', 30000, '2346782393', '54728763983', 'Uno'),
		('00435272992', 'Cinza Metálico', 15600, '6673885512', '97463221343', 'Pálio'),
		('00323231145', 'Preto', 32200, '2846496622', '11192937465', 'Fox'),
		('00898776532', 'Vermelho',36000, '6673885512', '36749715284', 'Cross Fox'),
		('00987342123', 'Marrom', 27000, '9922537225', '36749715284', 'Siena'),
		('00656443022', 'Prata', 22800, '7732998633', '66738855122', 'Celta'),
		('00234297643', 'Azul metálico', 19400, '3378222261', '33629384776', 'Voyage'),
		('00111234472', 'Verde', 17100, '9922537225', '66738855122', 'Corsa Sedan');

		SELECT * FROM Veiculo;

		

INSERT INTO Seguradora(Cnpj_Seguradora, Endereco_Seguradora, Telefone_Seguradora, Valor_Seguro)
	VALUES('36749715284', 'Av dos Estados, n4338', '1149837452', 1200),
			('54728763983', 'Rua Praia Grande, n44', '1937281733', 1250),
			('18399283772', 'Av M Boi Mirim, n3875', '1158948372', 1100),
			('97463221343', 'Rua Oscar Freire, n100', '1135297634', 1100),
			('11192937465', 'Rua Francisca Miquelina, n36', '1139685764', 1660),
			('74847362266', 'Rua Genebra, n296', '1132161677', 1800),
			('93652673921', 'Av Humberto Coutinho, n160', '1159756463', 1150),
			('33629384776', 'Rua Dr. Edson Godói, n433', '1326818734', 1300),
			('66738855122', 'Estrada da Baronesa, n200', '1158968756', 1000),
			('77985231779', 'Estrada de Itapecerica, n3784', '1159029834', 1050);

			SELECT * FROM Seguradora;

			

-- Populando uma coluna com condições 
-- Se o DDD for 11, cidade será São Paulo

UPDATE Proprietario
SET Cidade  = 'São Paulo'
WHERE Telefone LIKE '11%'

-- Se o DDD for 21, cidade será Rio de Janeiro
UPDATE Proprietario
SET Cidade = 'Rio de Janeiro'
WHERE Telefone LIKE '21%';

-- Se o DDD for 13, cidade será Bertioga
UPDATE Proprietario
SET Cidade = 'Bertioga'
WHERE Telefone LIKE '13%';


--***********************
-- Alguns Comandos SELECT
--***********************
SELECT * FROM Proprietario;
SELECT * FROM Veiculo;
SELECT Cor FROM Veiculo;
SELECT Marca_Modelo, Cor FROM Veiculo;

-- SELECT com Alias
SELECT Marca_Modelo AS Modelo, Cor As Cores_Dos_Veiculos FROM Veiculo;

--SELECT com ORDER BY
SELECT Marca_Modelo, Cor FROM Veiculo ORDER BY Marca_Modelo;
SELECT Marca_Modelo, Cor FROM Veiculo ORDER BY Marca_Modelo DESC;
SELECT DISTINCT Marca_Modelo FROM Veiculo; 

--Selecionando Marca_Modelo que comecem com a letra "c".
SELECT Marca_Modelo FROM Veiculo WHERE Marca_Modelo LIKE 'c%';

--Selecionando Marca_Modelo que terminam com a letra "a".
SELECT Marca_Modelo FROM Veiculo WHERE Marca_Modelo LIKE '%a';

--Começa com a letra "c" e Termina com a letra "a".
SELECT Marca_Modelo FROM Veiculo WHERE Marca_Modelo LIKE 'c%' AND Marca_Modelo LIKE '%a';

--Marca_Modelo e Cor começam com as letras "c" e "v", respectivamente.
SELECT Marca_Modelo, Cor FROM Veiculo WHERE Marca_Modelo LIKE 'c%' AND Cor LIKE 'v%'; 

--selecionando o Renavam que possui o terceiro dígito = 3
SELECT Renavam FROM Veiculo WHERE Renavam LIKE '__3%';


-- Selecionando tuplas na tabela veículo usando operadores relacionais 
SELECT * FROM Veiculo WHERE Valor_Veiculo > 18000; 
SELECT * FROM Veiculo WHERE Valor_Veiculo > 18000 AND Valor_Veiculo <= 30000;
SELECT * FROM Veiculo WHERE Valor_Veiculo < 20000;
SELECT * FROM Veiculo WHERE Valor_Veiculo > 25000 AND Marca_Modelo LIKE 'c%';

SELECT * FROM Veiculo WHERE Valor_Veiculo >= 30000 OR Marca_Modelo LIKE 'c%';


SELECT Cpf_Segurado FROM Proprietario
UNION ALL
SELECT Cpf_Segurado FROM Veiculo;

--SELECT INTO
--Criando novas tabelas a partir das tabelas existentes
SELECT Renavam, Marca_Modelo, Valor_Veiculo
INTO Dados_do_Veiculo
FROM Veiculo;

SELECT * FROM Dados_do_Veiculo;

--Fazendo backup de uma tabela
SELECT * INTO Veiculo_Backup FROM Veiculo;

-- Algumas funções agregadas
-- Média dos valores dos veículos
SELECT AVG(Valor_Veiculo) FROM Veiculo;

-- Menor valor do veículo
SELECT MIN(Valor_Veiculo) FROM Veiculo;

-- Maior valor do veículo
SELECT MAX(Valor_Veiculo) FROM Veiculo;

--Contar o número de registro na tabela veículo
SELECT COUNT(*) FROM Veiculo; 

-- contar o número de registro no qual a cor do veículo começa com a letra "v"
SELECT COUNT(Cor) FROM Veiculo
WHERE Cor LIKE 'v%';

--****************
--SELECT TOP
--****************
--Selecionando o valor de quatro seguros que tem o custo mais alto.
SELECT TOP(4) Valor_Seguro FROM Seguradora
ORDER BY Valor_Seguro DESC; 

--***************
-- WITH TIES
--***************
-- Se houver um registro com mesmo valor do último, o comando WITH TIES mostra. 

SELECT TOP(4) WITH TIES Valor_Seguro FROM Seguradora
ORDER BY Valor_Seguro DESC;

--******************************
-- Alguns comandos UPDATE
--******************************
SELECT * FROM Veiculo;
-- Acrescentar aumento de 10% sobre todos os valores dos carros
UPDATE Veiculo
SET Valor_Veiculo = Valor_Veiculo * 1.1;

SELECT * FROM Seguradora;
--Diminuir 5% sobre todos os valores dos seguros
UPDATE Seguradora
SET Valor_Seguro = Valor_Seguro * 0.95;

--Atualizar o endereço da seguradora que tem o cnpj 54728763983
UPDATE Seguradora
SET Endereco_Seguradora = 'Av Grande, n1000'
WHERE Cnpj_Seguradora = 54728763983;

-- Aumentar os valores dos seguros em 15% das seguradoras que cobram menos do que R$ 1.000,00
UPDATE Seguradora
SET Valor_Seguro = Valor_Seguro*1.15
WHERE Valor_Seguro < 1000;




--*********************************************************
--Select USANDO INNER JOIN. Intersecção entre duas tabelas.
--*********************************************************
SELECT * FROM Veiculo 
INNER JOIN Proprietario
ON Veiculo.Cpf_Segurado = Proprietario.Cpf_Segurado;

-- Buscando a Marca_Modelo do carro, nome e idade do proprietário.
SELECT Marca_Modelo, Nome, Idade FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;

--Busca com alias
SELECT Marca_Modelo AS Modelo, Nome AS Proprietário, Idade FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;

--Refinando a busca INNER JOIN com WHERE
SELECT Marca_Modelo AS Modelo, Nome AS Proprietário, Idade FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE Nome LIKE 'j%';

-- Quero saber os nome dos proprietários, Modelos dos carro, valores dos carros e valores dos seguros. 
SELECT Nome AS Proprietário, Marca_Modelo AS Modelo, Valor_Veiculo, Valor_Seguro FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
INNER JOIN Seguradora AS S
ON V.Cnpj_Seguradora = S.Cnpj_seguradora; 

-- Quero o renavam do carro, telefone da seguradora localizada
--na cidade de são paulo e telefone da seguradora do veículo

SELECT Renavam,Telefone_Seguradora, Telefone AS Telefone_do_Proprietário FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
INNER JOIN Seguradora AS S
ON V.Cnpj_Seguradora = S.Cnpj_Seguradora
WHERE Telefone_Seguradora LIKE '11%';

--Aumentar os valores dos seguros de todos os proprietários que moram em são paulo

UPDATE Seguradora
SET Valor_Seguro = S.Valor_Seguro * 1.1
FROM Seguradora AS S
INNER JOIN Veiculo AS V
ON V.Cnpj_Seguradora = S.Cnpj_Seguradora
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE Cidade = 'São Paulo';

--************************
--Select USANDO LEFT JOIN. 
--************************

SELECT * FROM Veiculo AS V
LEFT JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;


SELECT V.Renavam,  V.Marca_Modelo, P.Cpf_Segurado, P.Nome FROM Veiculo AS V
LEFT JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;


INSERT INTO Proprietario(Cpf_Segurado, Nome, Idade, Endereco, Telefone, Cidade) 
VALUES('11111111111', 'Edson', 38, 'Rua Hafiz Abi Chedid, n 20', '11999999999', 'São Paulo');

ALTER TABLE Veiculo
DROP CONSTRAINT fk_Proprietario;

ALTER TABLE Veiculo
DROP CONSTRAINT fk_Seguradora;

INSERT INTO Veiculo(Renavam, Cor, Valor_Veiculo, Cpf_Segurado, Cnpj_Seguradora, Marca_Modelo)
VALUES('123456789', 'BRANCO', 40000, null , '1234567', 'FORD');

SELECT * FROM Proprietario;
SELECT * FROM Veiculo; 
--************************************************
--LEFT JOIN EXCLUINDO CORRESPONDÊNCIAS 
--************************************************
-- Retorna Somente dados da tabela veículo que não tem correspondência com a tabela proprietário.

SELECT * FROM Veiculo AS V
LEFT JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE P.Cpf_Segurado IS NULL;


SELECT V.Renavam, V.Marca_Modelo, P.Cpf_Segurado, P.Nome FROM Veiculo AS V
LEFT JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE P.Cpf_Segurado IS NULL; 

--**********
--RIGHT JOIN
--**********
SELECT * FROM Proprietario AS P
RIGHT JOIN Veiculo AS V
ON V.Cpf_Segurado = P.Cpf_Segurado;

--************************************
--RIGHT JOIN Excluindo correspondência
--************************************
SELECT * FROM Proprietario AS P
RIGHT JOIN Veiculo AS V
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE V.Cpf_Segurado IS NULL;

--*********
--FULL JOIN
--Retorna todos os dados das tabelas, dados com e sem correspondências.
--*********
SELECT * FROM Veiculo AS V
FULL JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;

--************************************
--FULL JOIN excluindo correspondências
--Dados que não possuem correspondências entre as tabelas
--************************************

SELECT * FROM Veiculo AS V
FULL JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
WHERE V.Cpf_Segurado IS NULL
OR P.Cpf_Segurado IS NULL;


--********************
--Operador IN e NOT IN
--********************
--Aplica um filtro na busca pelo os dados

SELECT * FROM Proprietario
WHERE Idade IN (30 , 40);


SELECT * FROM Veiculo;

--**********************************************
--Inserindo um campo calculado na tabela veículo
--**********************************************
--Inserindo uma coluna chamada IPVA

ALTER TABLE Veiculo
ADD IPVA AS (0.04 * Valor_Veiculo);


--Criando regras
--**********************************
-- CREATE RULE
--**********************************

SELECT * FROM Seguradora;
-- Criar uma regra na qual o valor do seguro não pode ser menor que 
--R$1.000,00 e maior que R$2.000,00 reais.

CREATE RULE regra_valor_seguro AS @valor >= 1000 AND @Valor <= 2000;

--Agora vou vincular a regra à coluna do valor do seguro.
EXECUTE sp_bindrule regra_valor_seguro, 'Seguradora.Valor_Seguro'; 

-- Testando se a regra funcionou
UPDATE Seguradora
SET Valor_Seguro = 900
WHERE Cnpj_Seguradora = '11192937465';

--Criando uma regra para o número de dígitos do CPF.
--O CPF tem exatamente 11 dígitos. A regra impõe essa condição.

CREATE RULE regra_cpf_segurado AS @digitos LIKE '___________'; 

EXECUTE sp_bindrule regra_cpf_segurado, 'Proprietario.Cpf_Segurado';

UPDATE Proprietario
SET Cpf_Segurado = '12345677777'
WHERE Cpf_Segurado = '2346782393';

SELECT * FROM Proprietario; 
SELECT * FROM Seguradora;
SELECT * FROM Veiculo;

--**********
--VIEWS
--**********
-- Vou criar uma VIEW que mostra o renavam e modelo 
-- do veículo, junto com o nome e endereço do proprietário. 

CREATE VIEW view_veiculo_proprietario
AS SELECT V.Renavam, V.Marca_Modelo, P.Nome, P.Endereco
FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado;

SELECT * FROM view_veiculo_proprietario;

--SELECT Sobre o VIEW
SELECT * FROM view_veiculo_proprietario
WHERE Nome LIKE 'J%';

--Criando um VIEW usando INNER JOIN agora com as três tabelas.
CREATE VIEW view_veiculo_proprietario_Seguradora
AS SELECT V.Renavam, V.Marca_Modelo, P.Nome, P.Endereco, S.Cnpj_Seguradora AS CNPJ, S.Valor_Seguro
FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
INNER JOIN Seguradora AS S
ON V.Cnpj_Seguradora = S.Cnpj_Seguradora;


SELECT * FROM view_veiculo_proprietario_Seguradora;

-- DELETANDO UMA VIEW

DROP VIEW view_veiculo_proprietario;


--Atualizando todos os campos de uma coluna com base em valores de duas tabelas.

(UPDATE Seguradora 
SET Valor_Seguro  = (0.04 * Valor_Veiculo)
FROM Veiculo
INNER JOIN Seguradora
ON Veiculo.Cnpj_Seguradora = Seguradora.Cnpj_Seguradora) AS tab_atualizada


-- Como há pessoas que possuem mais de um veículo, então, quero saber
-- o total de imposto que cada pessoa irá pagar.

SELECT Resultado.Nome_do_Proprietario, SUM(Valor_do_Seguro) AS Total_de_Imposto
FROM
(SELECT P.Nome AS Nome_do_Proprietario, V.Marca_Modelo AS Carro, S.Valor_Seguro AS Valor_do_Seguro
FROM Proprietario AS P
INNER JOIN Veiculo AS V
ON V.Cpf_Segurado = P.Cpf_Segurado
INNER JOIN Seguradora AS S
ON V.Cnpj_Seguradora = S.Cnpj_Seguradora) AS Resultado
GROUP BY Resultado.Nome_do_Proprietario
ORDER BY Total_de_Imposto DESC; 


