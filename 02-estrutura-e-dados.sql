/*
    FoodConnect — Laboratório de SQL Server
    Script 02: estrutura da tabela Clientes e cinco registros fictícios.

    Objetivo: permitir reproduzir a prática em uma instalação do SQL Server.
    Seguro para repetir: não exclui dados e só insere IDs que ainda não existem.
    Executar no SQL Server Management Studio (SSMS).

    Observação: este laboratório usa SQL Server. A proposta acadêmica original
    também estudou PostgreSQL, MongoDB e Redis, mas não os implementa aqui.
*/

-- 1. Criar o banco apenas se ele ainda não existir.
IF DB_ID(N'FoodConnect_Lab') IS NULL
BEGIN
    CREATE DATABASE FoodConnect_Lab;
END;
GO

-- 2. Selecionar o banco de dados.
USE FoodConnect_Lab;
GO

-- 3. Criar a tabela apenas se ela ainda não existir.
IF OBJECT_ID(N'dbo.Clientes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Clientes (
        id_cliente INT PRIMARY KEY,
        nome NVARCHAR(100) NOT NULL,
        cidade NVARCHAR(100) NOT NULL
    );
END;
GO

-- 4. Inserir os cinco clientes fictícios sem duplicar IDs existentes.
INSERT INTO dbo.Clientes (id_cliente, nome, cidade)
SELECT novos.id_cliente, novos.nome, novos.cidade
FROM (VALUES
    (1, N'Ana',     N'São Luís'),
    (2, N'João',    N'Imperatriz'),
    (3, N'Carla',   N'Bacabal'),
    (4, N'Pedro',   N'Caxias'),
    (5, N'Mariana', N'São Luís')
) AS novos (id_cliente, nome, cidade)
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Clientes AS atuais
    WHERE atuais.id_cliente = novos.id_cliente
);
GO

-- 5. Conferir o resultado, ordenado pelo identificador.
SELECT id_cliente, nome, cidade
FROM dbo.Clientes
ORDER BY id_cliente;
GO
