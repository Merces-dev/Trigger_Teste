-- Criamos a Database
CREATE DATABASE TestePagamento;
USE TestePagamento;

-- Criamos a Tabela
CREATE TABLE Pagamento(
	IdPagamento INT IDENTITY PRIMARY KEY NOT NULL,
	NomeProduto VARCHAR(35),
	ValorProduto DECIMAL(10,2),
	DescontoPorcento INT
)

-- Criamos a Tabela
CREATE TABLE PagamentoDesconto(
	IdPagamentoDesc INT IDENTITY PRIMARY KEY NOT NULL,
	IdPagamento INT FOREIGN KEY REFERENCES Pagamento (IdPagamento),
	NomeProduto VARCHAR(35),
	ValorDesconto DECIMAL(10,2)
)
-- Criamos o TRIGGER
-- Geracao de valores derivados de colunas na base de dados
CREATE TRIGGER Tgr_Pagamento
ON Pagamento
FOR INSERT 
AS
	INSERT INTO PagamentoDesconto(IdPagamento,NomeProduto,ValorDesconto)
	SELECT IdPagamento,NomeProduto,(ValorProduto - (ValorProduto * DescontoPorcento/100)) AS ValorPromocao FROM INSERTED;

-- DML
--																		   NomeProduto      ValorProduto      %
INSERT INTO  Pagamento (NomeProduto,ValorProduto,DescontoPorcento) VALUES ('Iphone',          3200.99,        15);
INSERT INTO  Pagamento (NomeProduto,ValorProduto,DescontoPorcento) VALUES ('Playstation 4',   1200.00,        15);
INSERT INTO  Pagamento (NomeProduto,ValorProduto,DescontoPorcento) VALUES ('Joguin',		   250.00,		  10);



	
-- Visualizar Dados
SELECT * FROM Pagamento;
SELECT * FROM PagamentoDesconto;

-- DROP'S
DROP DATABASE TestePagamento;
DROP TABLE PagamentoDesconto;
DROP TABLE Pagamento;
DROP TRIGGER Tgr_Pagamento;