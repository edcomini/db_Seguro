
--Criando o banco de dados
CREATE DATABASE db_Seguro;
--Escolhendo o banco de dados criado
USE db_Seguro;

-- Criando as tabelas
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

-- Excluindo Algumas colunas
ALTER TABLE Veiculo 
DROP COLUMN Cpf_Segurado;

ALTER TABLE Veiculo
DROP COLUMN Cnpj_Seguradora;

-- Adicionando coluna e estabelecendo os relacionamentos
ALTER TABLE Veiculo
ADD Cpf_Segurado VARCHAR(12) NOT NULL
CONSTRAINT fk_Proprietario FOREIGN KEY(Cpf_Segurado)
REFERENCES Proprietario;

ALTER TABLE Veiculo 
ADD Cnpj_Seguradora VARCHAR(11) NOT NULL
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

-- INSERINDO DADOS NAS TABELAS

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

-- SELECIONANDO COLUNAS ESPECÍFICA DA TABELA VEÍCULO APLICANDO ALGUNS COMANDOS

SELECT * FROM Veiculo;
SELECT Cor FROM Veiculo;
SELECT Marca_Modelo, Cor FROM Veiculo;
SELECT Marca_Modelo AS Modelo, Cor As Cores_Dos_Veiculos FROM Veiculo;
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


--Select USANDO INNER JOIN. Intersecção entre duas tabelas.

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

-- Quero saber os nome dos proprietários, Modelos dos carro, valores dos carros e valores dos seguros. 
SELECT Nome AS Proprietário, Marca_Modelo AS Modelo, Valor_Veiculo, Valor_Seguro AS Custo_do_Seguro FROM Veiculo AS V
INNER JOIN Proprietario AS P
ON V.Cpf_Segurado = P.Cpf_Segurado
INNER JOIN Seguradora AS S
ON V.Cnpj_Seguradora = S.Cnpj_seguradora; 