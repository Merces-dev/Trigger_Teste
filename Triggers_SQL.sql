USE boletim;

CREATE TABLE Aluno_hist(
	IdAlunoHist INT IDENTITY PRIMARY KEY NOT NULL,
	IdAluno INT FOREIGN KEY REFERENCES Aluno (IdAluno),
	Nome VARCHAR(100) NOT NULL,
	Ra VARCHAR(20),
	Idade INT,
	DataDelete DATETIME
);

/*UPDATE - Tabela com os Dados Excluidos*/
CREATE TRIGGER Tgr_Backup_Aluno 
ON Aluno 
FOR UPDATE 
AS	
	INSERT INTO Aluno_hist(IdAluno,Nome,Ra,Idade,DataDelete)
	SELECT IdAluno,Nome,Ra,Idade,GETDATE() FROM DELETED;

/*INSERT - Com Dados Adicionados com Sucesso*/
CREATE TRIGGER Tgr_onInsertNome
ON Aluno 
FOR INSERT s
AS 
	IF (SELECT COUNT (*) FROM INSERTED ) = 1
			PRINT ' Dados Inseridos com Sucesso em Aluno';

/*DELETE* - Com Linhas Afetadas*/
CREATE TRIGGER Tgr_onDelete_Aluno
ON Aluno 
FOR DELETE 
AS	
	IF (SELECT COUNT (*) FROM DELETED ) = 1
	PRINT 'O(s) Usuario(s) Foi Deletado(s) Com Sucesso';

/*DELETE - Sem Linhas Afetadas*/
CREATE TRIGGER Tgr_onDeleteUnexistent_Aluno
ON Aluno 
FOR DELETE 
AS	
	IF (SELECT COUNT (*) FROM DELETED ) = 0
	PRINT 'Não Haviam Usúarios com os dados citados';

/*DML*/
DELETE FROM Aluno WHERE IdAluno = 20;
UPDATE Aluno SET Ra = '145' WHERE IdAluno = 1;
INSERT INTO Aluno (Nome, Ra) VALUES ('Geraldin','12');

--DROP TRIGGER Tgr_Backup_Aluno;
--DROP TRIGGER Tgr_onInsertNome;
--DROP TRIGGER Tgr_onDelete_Aluno;
--DROP TABLE Aluno_hist;

SELECT * FROM Aluno;
SELECT * FROM Aluno_hist;