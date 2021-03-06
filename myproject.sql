USE [master]
GO
/****** Object:  Database [p6g4]    Script Date: 12/06/2020 23:42:11 ******/
CREATE DATABASE [p6g4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'p6g4', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p6g4.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'p6g4_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p6g4_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [p6g4] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [p6g4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [p6g4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [p6g4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [p6g4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [p6g4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [p6g4] SET ARITHABORT OFF 
GO
ALTER DATABASE [p6g4] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [p6g4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [p6g4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [p6g4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [p6g4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [p6g4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [p6g4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [p6g4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [p6g4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [p6g4] SET  ENABLE_BROKER 
GO
ALTER DATABASE [p6g4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [p6g4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [p6g4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [p6g4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [p6g4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [p6g4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [p6g4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [p6g4] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [p6g4] SET  MULTI_USER 
GO
ALTER DATABASE [p6g4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [p6g4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [p6g4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [p6g4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [p6g4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [p6g4] SET QUERY_STORE = OFF
GO
USE [p6g4]
GO
/****** Object:  User [p6g4]    Script Date: 12/06/2020 23:42:11 ******/
CREATE USER [p6g4] FOR LOGIN [p6g4] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p6g4]
GO
/****** Object:  Schema [fisioterapia]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [fisioterapia]
GO
/****** Object:  Schema [gestaoconferencias]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [gestaoconferencias]
GO
/****** Object:  Schema [gestaodestocks]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [gestaodestocks]
GO
/****** Object:  Schema [prescricaomedicamentos]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [prescricaomedicamentos]
GO
/****** Object:  Schema [rentacar]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [rentacar]
GO
/****** Object:  Schema [reservavoos]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [reservavoos]
GO
/****** Object:  Schema [universidade]    Script Date: 12/06/2020 23:42:12 ******/
CREATE SCHEMA [universidade]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_LOGINCOOR]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_LOGINCOOR](@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20)
	IF( EXISTS (SELECT [fisioterapia].Coordenador.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Coordenador ON [fisioterapia].Staff.nif=[fisioterapia].Coordenador.nif
				WHERE @nif = [fisioterapia].Coordenador.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Coordenador'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_LOGINEST]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_LOGINEST](@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20)
	IF( EXISTS (SELECT [fisioterapia].Estagiario.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif
				WHERE @nif = [fisioterapia].Estagiario.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Estagiario'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_LOGINORI]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_LOGINORI](@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20);
	IF( EXISTS (SELECT [fisioterapia].Orientador.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif
				WHERE @nif = [fisioterapia].Orientador.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Orientador'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO
/****** Object:  Table [fisioterapia].[Pessoa]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Pessoa](
	[nif] [int] NOT NULL,
	[nome] [varchar](30) NULL,
	[mail] [varchar](30) NULL,
	[sexo] [char](1) NULL,
	[data_nasc] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fisioterapia].[Staff]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Staff](
	[nif] [int] NOT NULL,
	[password] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_PesquisaSTAFFnome]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_PesquisaSTAFFnome](@nome varchar(30))
RETURNS TABLE AS
RETURN(
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
	WHERE [fisioterapia].Pessoa.nome LIKE @nome
)
GO
/****** Object:  Table [fisioterapia].[Orientador]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Orientador](
	[nif] [int] NOT NULL,
	[horario] [varchar](200) NULL,
	[nif_coord] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fisioterapia].[Plano]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Plano](
	[id] [int] NOT NULL,
	[n_total_sess] [int] NULL,
	[horario_sess] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fisioterapia].[Sessao]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Sessao](
	[id] [int] NOT NULL,
	[data] [date] NULL,
	[id_plano] [int] NOT NULL,
	[nif_orient] [int] NOT NULL,
	[nif_est] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fisioterapia].[Paciente]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Paciente](
	[nif] [int] NOT NULL,
	[n_processo] [int] NULL,
	[descricao] [varchar](200) NULL,
	[altura] [int] NULL,
	[peso] [int] NULL,
	[condicao] [varchar](100) NULL,
	[n_sessoes] [int] NULL,
	[dia_entrada] [date] NULL,
	[id_plano] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ORIENCPACI]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ORIENCPACI](@nif int)
RETURNS Table AS
RETURN (
		SELECT	t1.nome AS NOMEPAC,
				t1.NIFPAC AS NIF,
				t1.mail AS MAIL,
				t1.sexo AS SEXO,
				t1.data_nasc AS DATANASC
			FROM 
			(SELECT nome,
					mail,
					sexo,
					data_nasc,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_orient AS SESSNIFORI,
				[fisioterapia].Paciente.nif AS NIFPAC
				
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Orientador.nif AS ORINIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif) t2
									ON t1.SESSNIFORI=t2.ORINIF
			WHERE @nif = ORINIF
			)
GO
/****** Object:  Table [fisioterapia].[Estagiario]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Estagiario](
	[nif] [int] NOT NULL,
	[horario_est] [varchar](200) NULL,
	[nif_ori] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ORIENCEST]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ORIENCEST](@nif int)
RETURNS Table AS
RETURN (
		SELECT
				t2.nome AS NOMEEst,
				t2.NIFEST AS NIF,
				t2.mail AS MAIL,
				t2.sexo AS SEXO,
				t2.data_nasc AS DATANASC

		FROM (SELECT nome,
				[fisioterapia].Orientador.nif AS NIFORI
					FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Pessoa.nif=[fisioterapia].Orientador.nif) t1
			JOIN 
				(SELECT nome, 
						nif_ori,
						mail,
						sexo,
						data_nasc,
					[fisioterapia].Estagiario.nif AS NIFEST
						FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Pessoa.nif=[fisioterapia].Estagiario.nif) t2
					ON t1.NIFORI=t2.nif_ori
			WHERE @nif = NIFORI
					 
)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_TodoStaff]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_TodoStaff]()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			[fisioterapia].Staff.nif AS NIF
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ESTENCPACI]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ESTENCPACI](@nif int)
RETURNS Table AS
RETURN (
		SELECT	t1.nome AS NOMEPAC,
				t1.NIFPAC AS NIF,
				t1.mail AS MAIL,
				t1.sexo AS SEXO,
				t1.data_nasc AS DATANASC
			FROM 
			(SELECT nome AS NOME,
					mail, sexo, data_nasc,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_est AS SESSNIFEST,
				[fisioterapia].Paciente.nif AS NIFPAC
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Estagiario.nif AS ESTNIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif) t2
									ON t1.SESSNIFEST=t2.ESTNIF
			WHERE @nif = ESTNIF
			)
GO
/****** Object:  Table [fisioterapia].[Tratamento]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Tratamento](
	[id] [int] NOT NULL,
	[titulo] [varchar](15) NULL,
	[timestamp] [time](7) NULL,
	[descricao] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fisioterapia].[Possui]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Possui](
	[id_sess] [int] NOT NULL,
	[id_trata] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sess] ASC,
	[id_trata] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_PERFILPAC]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_PERFILPAC](@nif int)
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				 [fisioterapia].Paciente.nif AS NIF,
				 n_processo AS N_PROCESSO,
				 [fisioterapia].Paciente.descricao AS DESCRICAO,
				 altura AS ALTURA,
				 peso AS PESO,
				 condicao AS CONDICAO,
				 n_sessoes AS N_SESSOES,
				 n_total_sess AS N_TOTAL_SESS,
				 [fisioterapia].Paciente.id_plano AS PLANO,
				 t2.titulo AS TRATAMENTO,
				 t2.descricao AS DESCTRAT
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Paciente ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif
									JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
									JOIN (SELECT  id_plano,id_trata, titulo, descricao
											FROM [fisioterapia].Sessao JOIN [fisioterapia].Possui ON [fisioterapia].Sessao.id=[fisioterapia].Possui.id_sess
																		JOIN [fisioterapia].Tratamento ON [fisioterapia].Possui.id_sess=[fisioterapia].Tratamento.id) t2 
																		ON [fisioterapia].Plano.id=t2.id_plano
					where @nif = [fisioterapia].Paciente.nif
		)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_TodoEstag]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_TodoEstag]()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			[fisioterapia].Estagiario.nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario_est AS Horario
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif
)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_TodoORI]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_TodoORI]()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			[fisioterapia].Orientador.nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario AS Horario
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif
)
GO
/****** Object:  Table [fisioterapia].[Mensagem]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Mensagem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[timestamp] [time](7) NULL,
	[sender_mail] [varchar](30) NULL,
	[texto] [varchar](100) NULL,
	[nif_pessoa] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_MENSNIF]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_MENSNIF](@nif int)
RETURNS TABLE AS
RETURN (
		SELECT nome AS RECEIVER,
				timestamp AS TIME_DATE,
				sender_mail AS SENT_BY,
				texto AS MENSAGEM
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Mensagem ON [fisioterapia].Pessoa.nif=[fisioterapia].Mensagem.nif_pessoa
									JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
		WHERE @nif=nif_pessoa
		)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ESTPAC]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ESTPAC](@nif int)
RETURNS Table AS
RETURN (
		SELECT	t2.NOME AS NOMEPAC,
				t2.ESTNIF AS NIF
			FROM 
			(SELECT nome AS NOME,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_est AS SESSNIFEST,
				[fisioterapia].Paciente.nif AS NIFPAC
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Estagiario.nif AS ESTNIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif) t2
									ON t1.SESSNIFEST=t2.ESTNIF
			WHERE @nif = NIFPAC
			)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ORIEST]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ORIEST](@nif int)
RETURNS Table AS
RETURN (
		SELECT
				t1.nome AS NOMEORI,
				t1.NIFORI AS NIF

		FROM (SELECT nome,
				[fisioterapia].Orientador.nif AS NIFORI
					FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Pessoa.nif=[fisioterapia].Orientador.nif) t1
			JOIN 
				(SELECT nome, 
						nif_ori,
					[fisioterapia].Estagiario.nif AS NIFEST
						FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Pessoa.nif=[fisioterapia].Estagiario.nif) t2
					ON t1.NIFORI=t2.nif_ori
			WHERE @nif = NIFEST
					 
)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_PesquisaSTAFFnif]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_PesquisaSTAFFnif](@nif int)
RETURNS TABLE AS
RETURN(
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
	WHERE [fisioterapia].Staff.nif LIKE @nif
)
GO
/****** Object:  View [dbo].[STAFF_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[STAFF_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
GROUP BY nome, mail, sexo, data_nasc
GO
/****** Object:  View [dbo].[ORIENT_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ORIENT_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario AS Horario
FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif
GROUP BY nome, mail, sexo, data_nasc, horario
GO
/****** Object:  Table [fisioterapia].[Coordenador]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fisioterapia].[Coordenador](
	[nif] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[COORD_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[COORD_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Coordenador ON [fisioterapia].Staff.nif=[fisioterapia].Coordenador.nif
GROUP BY nome, mail, sexo, data_nasc
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ESTHOR]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ESTHOR](@nif int)
RETURNS Table AS
RETURN (
		SELECT horario_est AS HORARIO
		FROM [fisioterapia].Estagiario
		WHERE nif=@nif
		)
GO
/****** Object:  View [dbo].[ESTAG_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ESTAG_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario AS Horario
FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif
GROUP BY nome, mail, sexo, data_nasc, horario
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_ORIHOR]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_ORIHOR](@nif int)
RETURNS Table AS
RETURN (
		SELECT horario AS HORARIO
		FROM [fisioterapia].Orientador
		WHERE nif=@nif
		)
GO
/****** Object:  View [dbo].[PACI_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PACI_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			altura AS Altura,
			peso AS Peso,
			n_sessoes AS Numero_Sessoes,
			dia_entrada AS Dia_Entrada
FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
GROUP BY nome, mail, sexo, altura, peso, data_nasc, n_sessoes, dia_entrada
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_HORAORIEN]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_HORAORIEN]()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario AS HORARIO
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif= [fisioterapia].Orientador.nif
		)
GO
/****** Object:  View [dbo].[MENS_VIEW]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MENS_VIEW]
AS SELECT	nome AS Nome,
			mail AS E_Mail,
			sender_mail AS Sender_email,
			texto AS Conteudo_Mail,
			timestamp AS Hora_Dia_Rececao
FROM [fisioterapia].Pessoa JOIN [fisioterapia].Mensagem ON [fisioterapia].Pessoa.nif=[fisioterapia].Mensagem.nif_pessoa
GROUP BY nome, mail, sender_mail, texto, timestamp
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_HORAEST]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_HORAEST]()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario_est AS HORARIO
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif= [fisioterapia].Estagiario.nif
		)
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_HORAESTORI]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_HORAESTORI]()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario AS HORARIOORI,
				horario_est AS HORARIOEST
		FROM [fisioterapia].Pessoa  JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									FULL JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif= [fisioterapia].Estagiario.nif
									 FULL JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif= [fisioterapia].Orientador.nif
		)				
GO
/****** Object:  UserDefinedFunction [fisioterapia].[UDF_PESSOA]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [fisioterapia].[UDF_PESSOA]()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Pessoa
)
GO
/****** Object:  View [dbo].[BusinessBooks]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BusinessBooks] AS
	SELECT title_id, title, type, pub_id, price, notes
	FROM pubs.dbo.titles
	WHERE [type] = 'business';
GO
/****** Object:  View [dbo].[PublishersEmployee]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PublishersEmployee] AS
	SELECT pub_name, fname, minit, lname
	FROM pubs.dbo.publishers, pubs.dbo.employee
	WHERE publishers.pub_id=employee.pub_id;
GO
/****** Object:  View [dbo].[StoreSales]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StoreSales] AS
	SELECT stor_name, title
	FROM pubs.dbo.sales, pubs.dbo.stores, pubs.dbo.titles
	WHERE sales.stor_id=stores.stor_id AND sales.stor_id=stores.stor_id;
GO
/****** Object:  View [dbo].[TitleAuthors]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TitleAuthors] AS
SELECT title, au_fname, au_lname
FROM pubs.dbo.titles, pubs.dbo.titleauthor, pubs.dbo.authors
WHERE titles.title_id = titleauthor.title_id AND authors.au_id = titleauthor.au_id;
GO
/****** Object:  Table [dbo].[Hello]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hello](
	[MsgID] [int] NOT NULL,
	[MsgSubject] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MsgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Artigo]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Artigo](
	[num_reg] [varchar](30) NOT NULL,
	[titulo] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_reg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Autor]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Autor](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
	[nome_inst] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Estudante]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Estudante](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
	[comprov] [varchar](15) NULL,
	[nome_inst] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Instituicao]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Instituicao](
	[nome] [varchar](15) NOT NULL,
	[address] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[NaoEstud]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[NaoEstud](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
	[refer] [int] NULL,
	[nome_inst] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Participa]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Participa](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
	[num_artigo] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC,
	[num_artigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Participante]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Participante](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
	[data_insc] [date] NULL,
	[address] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaoconferencias].[Pessoa]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaoconferencias].[Pessoa](
	[nome] [varchar](30) NOT NULL,
	[mail] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaodestocks].[Contem]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaodestocks].[Contem](
	[num_enc] [int] NOT NULL,
	[cod_prod] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_enc] ASC,
	[cod_prod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaodestocks].[Encomenda]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaodestocks].[Encomenda](
	[num_enc] [int] NOT NULL,
	[data] [date] NULL,
	[nif_forn] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[num_enc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaodestocks].[Fornecedor]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaodestocks].[Fornecedor](
	[nif] [int] NOT NULL,
	[nome] [varchar](15) NULL,
	[address] [varchar](30) NULL,
	[cond_pag] [varchar](max) NULL,
	[fax] [varchar](25) NULL,
	[cod_int_forn] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [gestaodestocks].[Produto]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaodestocks].[Produto](
	[codigo] [int] NOT NULL,
	[preco] [decimal](5, 2) NULL,
	[taxa_iva] [decimal](2, 2) NULL,
	[stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [gestaodestocks].[Tipo_Forn]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gestaodestocks].[Tipo_Forn](
	[cod_int] [int] NOT NULL,
	[designacao] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_int] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Contem]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Contem](
	[num_presc] [int] NOT NULL,
	[nome] [varchar](10) NOT NULL,
	[formula] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_presc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Farmaceutica]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Farmaceutica](
	[num_reg] [int] NOT NULL,
	[nome] [varchar](15) NULL,
	[telef] [int] NULL,
	[address] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_reg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Farmacia]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Farmacia](
	[nif] [int] NOT NULL,
	[address] [varchar](30) NULL,
	[nome] [varchar](30) NULL,
	[telef] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Farmaco]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Farmaco](
	[nome] [varchar](10) NOT NULL,
	[formula] [varchar](30) NOT NULL,
	[num_farmaceutica] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[formula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Medico]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Medico](
	[num_sns] [int] NOT NULL,
	[nome] [varchar](15) NULL,
	[especialidade] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_sns] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Paciente]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Paciente](
	[num_ut] [int] NOT NULL,
	[nome] [varchar](15) NULL,
	[address] [varchar](30) NULL,
	[data_nasc] [char](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_ut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prescricaomedicamentos].[Prescricao]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prescricaomedicamentos].[Prescricao](
	[num_presc] [int] NOT NULL,
	[data] [date] NULL,
	[nif_farm] [int] NOT NULL,
	[num_ut] [int] NOT NULL,
	[num_med] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_presc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Aluguer]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Aluguer](
	[numero] [int] NOT NULL,
	[duracao] [int] NULL,
	[data] [date] NULL,
	[nif_cliente] [int] NOT NULL,
	[num_balcao] [int] NOT NULL,
	[mat_veic] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Balcao]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Balcao](
	[numero] [int] NOT NULL,
	[nome] [varchar](15) NULL,
	[address] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Cliente]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Cliente](
	[nif] [int] NOT NULL,
	[address] [varchar](30) NULL,
	[nome] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Ligeiro]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Ligeiro](
	[cod] [char](17) NOT NULL,
	[numlugares] [int] NULL,
	[portas] [int] NULL,
	[combustivel] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Pesado]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Pesado](
	[cod] [char](17) NOT NULL,
	[peso] [int] NULL,
	[passageiro] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Tipo_Veic]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Tipo_Veic](
	[codigo] [char](17) NOT NULL,
	[designacao] [varchar](max) NULL,
	[arcondicionado] [varchar](3) NULL,
	[similariedade] [char](17) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [rentacar].[Veiculo]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rentacar].[Veiculo](
	[matricula] [varchar](12) NOT NULL,
	[marca] [varchar](10) NULL,
	[ano] [int] NULL,
	[cod_veic] [char](17) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Airplane]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Airplane](
	[airplane_id] [int] NOT NULL,
	[total_no_seats] [int] NULL,
	[type_name] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[airplane_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[AirplaneType]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[AirplaneType](
	[type_name] [varchar](10) NOT NULL,
	[company] [varchar](10) NULL,
	[max_seats] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Airport]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Airport](
	[airport_cod] [char](10) NOT NULL,
	[city] [varchar](10) NULL,
	[state] [varchar](10) NULL,
	[name] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[airport_cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Can_Land]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Can_Land](
	[airport_code] [char](10) NOT NULL,
	[type_name] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[airport_code] ASC,
	[type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Fare]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Fare](
	[code] [char](10) NOT NULL,
	[amount] [float] NULL,
	[restrictions] [varchar](15) NULL,
	[flight_num] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Flight]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Flight](
	[number] [int] NOT NULL,
	[airline] [varchar](15) NULL,
	[weekdays] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Flight_Leg]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Flight_Leg](
	[leg_no] [int] NOT NULL,
	[flight_num] [int] NOT NULL,
	[airport_code] [char](10) NOT NULL,
	[dep_time] [time](7) NULL,
	[arr_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[leg_no] ASC,
	[flight_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[LegInstance]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[LegInstance](
	[date] [date] NOT NULL,
	[no_all_seats] [int] NULL,
	[flight_num] [int] NOT NULL,
	[airport_cod] [char](10) NOT NULL,
	[dep_time] [time](7) NULL,
	[arr_time] [time](7) NULL,
	[leg_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[date] ASC,
	[flight_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [reservavoos].[Seat]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [reservavoos].[Seat](
	[seat_no] [int] NOT NULL,
	[flight_num] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[seat_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Departamento]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Departamento](
	[nome] [varchar](25) NOT NULL,
	[local] [varchar](30) NULL,
	[nmec_prof] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Estudante_Grad]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Estudante_Grad](
	[nmec] [int] NOT NULL,
	[grau] [varchar](15) NULL,
	[advisor] [int] NOT NULL,
	[nmec_prof] [int] NOT NULL,
	[nome_dep] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nmec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Particip_Grad]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Particip_Grad](
	[nmec] [int] NOT NULL,
	[id_proj] [int] NOT NULL,
	[data_int] [date] NULL,
	[data_fin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[nmec] ASC,
	[id_proj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Particip_Prof]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Particip_Prof](
	[nmec_prof] [int] NOT NULL,
	[id_proj] [int] NOT NULL,
	[data_int] [date] NULL,
	[data_fin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[nmec_prof] ASC,
	[id_proj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Pessoa]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Pessoa](
	[nmec] [int] NOT NULL,
	[nome] [varchar](30) NULL,
	[mail] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[nmec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Professor]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Professor](
	[nmec] [int] NOT NULL,
	[area] [varchar](10) NULL,
	[dedicacao] [decimal](2, 2) NULL,
	[categoria] [varchar](10) NULL,
	[nome_dep] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nmec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [universidade].[Projeto]    Script Date: 12/06/2020 23:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [universidade].[Projeto](
	[id] [int] NOT NULL,
	[nome] [varchar](20) NULL,
	[ent_fin] [varchar](20) NULL,
	[orcamento] [int] NULL,
	[nmec_prof] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Hello] ([MsgID], [MsgSubject]) VALUES (1245, N'Ola tudo Bem')
GO
INSERT [fisioterapia].[Coordenador] ([nif]) VALUES (345612345)
INSERT [fisioterapia].[Coordenador] ([nif]) VALUES (876598675)
GO
INSERT [fisioterapia].[Estagiario] ([nif], [horario_est], [nif_ori]) VALUES (342524356, N'Segunda-feira a Sexta Feira das 08:30 as 17:30', 435324543)
INSERT [fisioterapia].[Estagiario] ([nif], [horario_est], [nif_ori]) VALUES (489347234, N'Sabado e Domingo das 10:00 as 18:00', 435324543)
INSERT [fisioterapia].[Estagiario] ([nif], [horario_est], [nif_ori]) VALUES (840384724, N'Segunda-feira a Sexta Feira das 08:30 as 17:30', 234527643)
GO
SET IDENTITY_INSERT [fisioterapia].[Mensagem] ON 

INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (1, CAST(N'20:23:21' AS Time), N'andregomes00@gmail.com', N'Nao esquecer marcar a consulta de quarta-feira!', 876598675)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (2, CAST(N'17:00:00' AS Time), N'pedrobastos10@gmail.com', N'Mudar plano de Rui Torres.', 345612345)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (3, CAST(N'08:21:40' AS Time), N'pereirita@gmail.com', N'Desmarcar a sessao de Joana Pires.', 489347234)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (4, CAST(N'11:10:23' AS Time), N'luiscarvalho@gmail.com', N' Reunir o staff na terca-feira.', 234527643)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (5, CAST(N'08:44:46.8200000' AS Time), N'andregomes@gmail.com', N'Teste', 435324543)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (6, CAST(N'09:04:10.9166667' AS Time), N'andregomes@gmail.com', N'Apresentaçao Teste', 435324543)
INSERT [fisioterapia].[Mensagem] ([id], [timestamp], [sender_mail], [texto], [nif_pessoa]) VALUES (7, CAST(N'23:18:18.1000000' AS Time), N'andre@gmail.com', N'Teste Orientador -> Estagiario', 840384724)
SET IDENTITY_INSERT [fisioterapia].[Mensagem] OFF
GO
INSERT [fisioterapia].[Orientador] ([nif], [horario], [nif_coord]) VALUES (234527643, N'Segunda-feira a Sexta Feira das 08:30 as 17:30', 876598675)
INSERT [fisioterapia].[Orientador] ([nif], [horario], [nif_coord]) VALUES (435324543, N'Segunda-feira a Sexta Feira das 08:30 as 17:30', 876598675)
INSERT [fisioterapia].[Orientador] ([nif], [horario], [nif_coord]) VALUES (436256456, N'Sabado e Domingo das 10:00 as 18:00', 345612345)
INSERT [fisioterapia].[Orientador] ([nif], [horario], [nif_coord]) VALUES (437465243, N'Sabado e Domingo das 10:00 as 18:00', 345612345)
GO
INSERT [fisioterapia].[Paciente] ([nif], [n_processo], [descricao], [altura], [peso], [condicao], [n_sessoes], [dia_entrada], [id_plano]) VALUES (333344444, 23342, N'Paciente com um entorce no tornozelo esquerdo', 175, 80, N'Paciente a progredir bem', 7, CAST(N'2020-04-07' AS Date), 2)
INSERT [fisioterapia].[Paciente] ([nif], [n_processo], [descricao], [altura], [peso], [condicao], [n_sessoes], [dia_entrada], [id_plano]) VALUES (567834512, 24522, N'Recuperacao de um paciente com uma fratura de uma clavicula', 167, 70, N'Paciente ainda na fase inicial do tratamento', 1, CAST(N'2020-04-05' AS Date), 3)
INSERT [fisioterapia].[Paciente] ([nif], [n_processo], [descricao], [altura], [peso], [condicao], [n_sessoes], [dia_entrada], [id_plano]) VALUES (840384724, 25234, N'Recuperacao de um paciente com um entorse no pulso direito', 170, 50, N'Paciente a meio do tratamento mas sem progresso', 9, CAST(N'2020-04-20' AS Date), 1)
INSERT [fisioterapia].[Paciente] ([nif], [n_processo], [descricao], [altura], [peso], [condicao], [n_sessoes], [dia_entrada], [id_plano]) VALUES (985672103, 24123, N'Recuperacao de um paciente com uma fratura no tornozelo direito', 189, 90, N'Paciente quase recuperado na fase final do tratamento', 14, CAST(N'2020-04-01' AS Date), 2)
GO
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (234527643, N'Rita Pereira', N'perRita@gmail.com', N'F', CAST(N'2001-03-19' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (333344444, N'Rui Torres', N'rtrtrt@gmail.com', N'M', CAST(N'1990-02-10' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (342524356, N'Luis Carvalho', N'luiscarvalho@gmail.com', N'M', CAST(N'1985-04-03' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (345612345, N'Andre Gomes', N'andre@gmail.com', N'M', CAST(N'1994-12-20' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (435324543, N'Miguel Cruz', N'miguelcruz@gmail.com', N'M', CAST(N'1990-07-20' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (436256456, N'Pedro Castro', N'pedrocastro@gmail.com', N'M', CAST(N'2002-12-20' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (437465243, N'Telmo Silva', N'telva20@gmail.com', N'M', CAST(N'2001-11-03' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (489347234, N'Pedro Bastos', N'pedrobastos10@gmail.com', N'M', CAST(N'1989-02-25' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (567834512, N'Joana Pires', N'joaninha2@gmail.com', N'F', CAST(N'1974-01-01' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (840384724, N'Joao Neto', N'joanete@gmail.com', N'M', CAST(N'2001-07-25' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (876598675, N'Miguel Morais', N'tresemes@gmail.com', N'M', CAST(N'1988-11-22' AS Date))
INSERT [fisioterapia].[Pessoa] ([nif], [nome], [mail], [sexo], [data_nasc]) VALUES (985672103, N'Maria Domingues', N'maridomi@gmail.com', N'F', CAST(N'2000-03-15' AS Date))
GO
INSERT [fisioterapia].[Plano] ([id], [n_total_sess], [horario_sess]) VALUES (1, 10, N'Segunda-Feira das 14:00 as 15:00')
INSERT [fisioterapia].[Plano] ([id], [n_total_sess], [horario_sess]) VALUES (2, 15, N'Terca-Feira das 10:00 as 11:00')
INSERT [fisioterapia].[Plano] ([id], [n_total_sess], [horario_sess]) VALUES (3, 5, N'Sabado das 16:00 as 17:00')
GO
INSERT [fisioterapia].[Possui] ([id_sess], [id_trata]) VALUES (1, 3)
INSERT [fisioterapia].[Possui] ([id_sess], [id_trata]) VALUES (2, 4)
INSERT [fisioterapia].[Possui] ([id_sess], [id_trata]) VALUES (3, 2)
GO
INSERT [fisioterapia].[Sessao] ([id], [data], [id_plano], [nif_orient], [nif_est]) VALUES (1, CAST(N'2020-04-20' AS Date), 3, 436256456, 840384724)
INSERT [fisioterapia].[Sessao] ([id], [data], [id_plano], [nif_orient], [nif_est]) VALUES (2, CAST(N'2020-04-18' AS Date), 2, 435324543, 489347234)
INSERT [fisioterapia].[Sessao] ([id], [data], [id_plano], [nif_orient], [nif_est]) VALUES (3, CAST(N'2020-04-23' AS Date), 1, 436256456, 342524356)
GO
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (234527643, N'123123987')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (342524356, N'naosei')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (345612345, N'piorpass')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (435324543, N'paaforte')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (436256456, N'bdnaoefixe')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (437465243, N'bdefixe')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (489347234, N'password111')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (840384724, N'olaola123')
INSERT [fisioterapia].[Staff] ([nif], [password]) VALUES (876598675, N'passwordfraca')
GO
INSERT [fisioterapia].[Tratamento] ([id], [titulo], [timestamp], [descricao]) VALUES (1, N'Tratamento1', NULL, N'Descricao do Tratamento1 muito cientifica para mim')
INSERT [fisioterapia].[Tratamento] ([id], [titulo], [timestamp], [descricao]) VALUES (2, N'Tratamento2', NULL, N'Descricao do Tratamento2 muito cientifica para mim')
INSERT [fisioterapia].[Tratamento] ([id], [titulo], [timestamp], [descricao]) VALUES (3, N'Tratamento3', NULL, N'Descricao do Tratamento3 muito cientifica para mim')
INSERT [fisioterapia].[Tratamento] ([id], [titulo], [timestamp], [descricao]) VALUES (4, N'Tratamento4', NULL, N'Descricao do Tratamento4 muito cientifica para mim')
GO
ALTER TABLE [fisioterapia].[Coordenador]  WITH CHECK ADD  CONSTRAINT [COORDSTAFF] FOREIGN KEY([nif])
REFERENCES [fisioterapia].[Staff] ([nif])
GO
ALTER TABLE [fisioterapia].[Coordenador] CHECK CONSTRAINT [COORDSTAFF]
GO
ALTER TABLE [fisioterapia].[Estagiario]  WITH CHECK ADD  CONSTRAINT [ESTORI] FOREIGN KEY([nif_ori])
REFERENCES [fisioterapia].[Orientador] ([nif])
GO
ALTER TABLE [fisioterapia].[Estagiario] CHECK CONSTRAINT [ESTORI]
GO
ALTER TABLE [fisioterapia].[Estagiario]  WITH CHECK ADD  CONSTRAINT [ESTSTAFF] FOREIGN KEY([nif])
REFERENCES [fisioterapia].[Staff] ([nif])
GO
ALTER TABLE [fisioterapia].[Estagiario] CHECK CONSTRAINT [ESTSTAFF]
GO
ALTER TABLE [fisioterapia].[Mensagem]  WITH CHECK ADD  CONSTRAINT [MENSPESS] FOREIGN KEY([nif_pessoa])
REFERENCES [fisioterapia].[Pessoa] ([nif])
GO
ALTER TABLE [fisioterapia].[Mensagem] CHECK CONSTRAINT [MENSPESS]
GO
ALTER TABLE [fisioterapia].[Orientador]  WITH CHECK ADD  CONSTRAINT [ORIENCOORD] FOREIGN KEY([nif_coord])
REFERENCES [fisioterapia].[Coordenador] ([nif])
GO
ALTER TABLE [fisioterapia].[Orientador] CHECK CONSTRAINT [ORIENCOORD]
GO
ALTER TABLE [fisioterapia].[Orientador]  WITH CHECK ADD  CONSTRAINT [ORIENSTAFF] FOREIGN KEY([nif])
REFERENCES [fisioterapia].[Staff] ([nif])
GO
ALTER TABLE [fisioterapia].[Orientador] CHECK CONSTRAINT [ORIENSTAFF]
GO
ALTER TABLE [fisioterapia].[Paciente]  WITH CHECK ADD  CONSTRAINT [PACIPESS] FOREIGN KEY([nif])
REFERENCES [fisioterapia].[Pessoa] ([nif])
GO
ALTER TABLE [fisioterapia].[Paciente] CHECK CONSTRAINT [PACIPESS]
GO
ALTER TABLE [fisioterapia].[Paciente]  WITH CHECK ADD  CONSTRAINT [PACIPLAN] FOREIGN KEY([id_plano])
REFERENCES [fisioterapia].[Plano] ([id])
GO
ALTER TABLE [fisioterapia].[Paciente] CHECK CONSTRAINT [PACIPLAN]
GO
ALTER TABLE [fisioterapia].[Possui]  WITH CHECK ADD  CONSTRAINT [POSSSESS] FOREIGN KEY([id_sess])
REFERENCES [fisioterapia].[Sessao] ([id])
GO
ALTER TABLE [fisioterapia].[Possui] CHECK CONSTRAINT [POSSSESS]
GO
ALTER TABLE [fisioterapia].[Possui]  WITH CHECK ADD  CONSTRAINT [POSSTRAT] FOREIGN KEY([id_trata])
REFERENCES [fisioterapia].[Tratamento] ([id])
GO
ALTER TABLE [fisioterapia].[Possui] CHECK CONSTRAINT [POSSTRAT]
GO
ALTER TABLE [fisioterapia].[Sessao]  WITH CHECK ADD  CONSTRAINT [SESSEST] FOREIGN KEY([nif_est])
REFERENCES [fisioterapia].[Estagiario] ([nif])
GO
ALTER TABLE [fisioterapia].[Sessao] CHECK CONSTRAINT [SESSEST]
GO
ALTER TABLE [fisioterapia].[Sessao]  WITH CHECK ADD  CONSTRAINT [SESSORIEN] FOREIGN KEY([nif_orient])
REFERENCES [fisioterapia].[Orientador] ([nif])
GO
ALTER TABLE [fisioterapia].[Sessao] CHECK CONSTRAINT [SESSORIEN]
GO
ALTER TABLE [fisioterapia].[Sessao]  WITH CHECK ADD  CONSTRAINT [SESSPLAN] FOREIGN KEY([id_plano])
REFERENCES [fisioterapia].[Plano] ([id])
GO
ALTER TABLE [fisioterapia].[Sessao] CHECK CONSTRAINT [SESSPLAN]
GO
ALTER TABLE [fisioterapia].[Staff]  WITH CHECK ADD  CONSTRAINT [STAFFPESS] FOREIGN KEY([nif])
REFERENCES [fisioterapia].[Pessoa] ([nif])
GO
ALTER TABLE [fisioterapia].[Staff] CHECK CONSTRAINT [STAFFPESS]
GO
ALTER TABLE [gestaoconferencias].[Autor]  WITH CHECK ADD  CONSTRAINT [AUTINST] FOREIGN KEY([nome_inst])
REFERENCES [gestaoconferencias].[Instituicao] ([nome])
GO
ALTER TABLE [gestaoconferencias].[Autor] CHECK CONSTRAINT [AUTINST]
GO
ALTER TABLE [gestaoconferencias].[Autor]  WITH CHECK ADD  CONSTRAINT [AUTPESS] FOREIGN KEY([nome], [mail])
REFERENCES [gestaoconferencias].[Pessoa] ([nome], [mail])
GO
ALTER TABLE [gestaoconferencias].[Autor] CHECK CONSTRAINT [AUTPESS]
GO
ALTER TABLE [gestaoconferencias].[Estudante]  WITH CHECK ADD  CONSTRAINT [ESTINST] FOREIGN KEY([nome_inst])
REFERENCES [gestaoconferencias].[Instituicao] ([nome])
GO
ALTER TABLE [gestaoconferencias].[Estudante] CHECK CONSTRAINT [ESTINST]
GO
ALTER TABLE [gestaoconferencias].[Estudante]  WITH CHECK ADD  CONSTRAINT [ESTPART] FOREIGN KEY([nome], [mail])
REFERENCES [gestaoconferencias].[Participante] ([nome], [mail])
GO
ALTER TABLE [gestaoconferencias].[Estudante] CHECK CONSTRAINT [ESTPART]
GO
ALTER TABLE [gestaoconferencias].[NaoEstud]  WITH CHECK ADD  CONSTRAINT [NESTINST] FOREIGN KEY([nome_inst])
REFERENCES [gestaoconferencias].[Instituicao] ([nome])
GO
ALTER TABLE [gestaoconferencias].[NaoEstud] CHECK CONSTRAINT [NESTINST]
GO
ALTER TABLE [gestaoconferencias].[NaoEstud]  WITH CHECK ADD  CONSTRAINT [NESTPART] FOREIGN KEY([nome], [mail])
REFERENCES [gestaoconferencias].[Participante] ([nome], [mail])
GO
ALTER TABLE [gestaoconferencias].[NaoEstud] CHECK CONSTRAINT [NESTPART]
GO
ALTER TABLE [gestaoconferencias].[Participa]  WITH CHECK ADD  CONSTRAINT [PARTARTI] FOREIGN KEY([num_artigo])
REFERENCES [gestaoconferencias].[Artigo] ([num_reg])
GO
ALTER TABLE [gestaoconferencias].[Participa] CHECK CONSTRAINT [PARTARTI]
GO
ALTER TABLE [gestaoconferencias].[Participa]  WITH CHECK ADD  CONSTRAINT [PARTAUT] FOREIGN KEY([nome], [mail])
REFERENCES [gestaoconferencias].[Autor] ([nome], [mail])
GO
ALTER TABLE [gestaoconferencias].[Participa] CHECK CONSTRAINT [PARTAUT]
GO
ALTER TABLE [gestaoconferencias].[Participante]  WITH CHECK ADD  CONSTRAINT [PARTPESS] FOREIGN KEY([nome], [mail])
REFERENCES [gestaoconferencias].[Pessoa] ([nome], [mail])
GO
ALTER TABLE [gestaoconferencias].[Participante] CHECK CONSTRAINT [PARTPESS]
GO
ALTER TABLE [gestaodestocks].[Contem]  WITH CHECK ADD  CONSTRAINT [CONTENC] FOREIGN KEY([num_enc])
REFERENCES [gestaodestocks].[Encomenda] ([num_enc])
GO
ALTER TABLE [gestaodestocks].[Contem] CHECK CONSTRAINT [CONTENC]
GO
ALTER TABLE [gestaodestocks].[Contem]  WITH CHECK ADD  CONSTRAINT [CONTENC2] FOREIGN KEY([cod_prod])
REFERENCES [gestaodestocks].[Produto] ([codigo])
GO
ALTER TABLE [gestaodestocks].[Contem] CHECK CONSTRAINT [CONTENC2]
GO
ALTER TABLE [gestaodestocks].[Encomenda]  WITH CHECK ADD  CONSTRAINT [ENCFORN] FOREIGN KEY([nif_forn])
REFERENCES [gestaodestocks].[Fornecedor] ([nif])
GO
ALTER TABLE [gestaodestocks].[Encomenda] CHECK CONSTRAINT [ENCFORN]
GO
ALTER TABLE [gestaodestocks].[Fornecedor]  WITH CHECK ADD  CONSTRAINT [FORNTIP] FOREIGN KEY([cod_int_forn])
REFERENCES [gestaodestocks].[Tipo_Forn] ([cod_int])
GO
ALTER TABLE [gestaodestocks].[Fornecedor] CHECK CONSTRAINT [FORNTIP]
GO
ALTER TABLE [prescricaomedicamentos].[Contem]  WITH CHECK ADD  CONSTRAINT [CONTFARMAC] FOREIGN KEY([nome], [formula])
REFERENCES [prescricaomedicamentos].[Farmaco] ([nome], [formula])
GO
ALTER TABLE [prescricaomedicamentos].[Contem] CHECK CONSTRAINT [CONTFARMAC]
GO
ALTER TABLE [prescricaomedicamentos].[Contem]  WITH CHECK ADD  CONSTRAINT [CONTPRESC] FOREIGN KEY([num_presc])
REFERENCES [prescricaomedicamentos].[Prescricao] ([num_presc])
GO
ALTER TABLE [prescricaomedicamentos].[Contem] CHECK CONSTRAINT [CONTPRESC]
GO
ALTER TABLE [prescricaomedicamentos].[Farmaco]  WITH CHECK ADD  CONSTRAINT [FARMCFARAMACE] FOREIGN KEY([num_farmaceutica])
REFERENCES [prescricaomedicamentos].[Farmaceutica] ([num_reg])
GO
ALTER TABLE [prescricaomedicamentos].[Farmaco] CHECK CONSTRAINT [FARMCFARAMACE]
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao]  WITH CHECK ADD  CONSTRAINT [PRESCMED] FOREIGN KEY([num_med])
REFERENCES [prescricaomedicamentos].[Medico] ([num_sns])
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao] CHECK CONSTRAINT [PRESCMED]
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao]  WITH CHECK ADD  CONSTRAINT [PRESCPAC] FOREIGN KEY([num_ut])
REFERENCES [prescricaomedicamentos].[Paciente] ([num_ut])
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao] CHECK CONSTRAINT [PRESCPAC]
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao]  WITH CHECK ADD  CONSTRAINT [PRESFARMAC] FOREIGN KEY([nif_farm])
REFERENCES [prescricaomedicamentos].[Farmacia] ([nif])
GO
ALTER TABLE [prescricaomedicamentos].[Prescricao] CHECK CONSTRAINT [PRESFARMAC]
GO
ALTER TABLE [rentacar].[Aluguer]  WITH CHECK ADD  CONSTRAINT [ALUBALC] FOREIGN KEY([num_balcao])
REFERENCES [rentacar].[Balcao] ([numero])
GO
ALTER TABLE [rentacar].[Aluguer] CHECK CONSTRAINT [ALUBALC]
GO
ALTER TABLE [rentacar].[Aluguer]  WITH CHECK ADD  CONSTRAINT [ALUCLI] FOREIGN KEY([nif_cliente])
REFERENCES [rentacar].[Cliente] ([nif])
GO
ALTER TABLE [rentacar].[Aluguer] CHECK CONSTRAINT [ALUCLI]
GO
ALTER TABLE [rentacar].[Aluguer]  WITH CHECK ADD  CONSTRAINT [ALUVEIC] FOREIGN KEY([mat_veic])
REFERENCES [rentacar].[Veiculo] ([matricula])
GO
ALTER TABLE [rentacar].[Aluguer] CHECK CONSTRAINT [ALUVEIC]
GO
ALTER TABLE [rentacar].[Ligeiro]  WITH CHECK ADD  CONSTRAINT [LIGTIPV] FOREIGN KEY([cod])
REFERENCES [rentacar].[Tipo_Veic] ([codigo])
GO
ALTER TABLE [rentacar].[Ligeiro] CHECK CONSTRAINT [LIGTIPV]
GO
ALTER TABLE [rentacar].[Pesado]  WITH CHECK ADD  CONSTRAINT [PESTIPV] FOREIGN KEY([cod])
REFERENCES [rentacar].[Tipo_Veic] ([codigo])
GO
ALTER TABLE [rentacar].[Pesado] CHECK CONSTRAINT [PESTIPV]
GO
ALTER TABLE [rentacar].[Tipo_Veic]  WITH CHECK ADD  CONSTRAINT [SIMTIPV] FOREIGN KEY([similariedade])
REFERENCES [rentacar].[Tipo_Veic] ([codigo])
GO
ALTER TABLE [rentacar].[Tipo_Veic] CHECK CONSTRAINT [SIMTIPV]
GO
ALTER TABLE [rentacar].[Veiculo]  WITH CHECK ADD  CONSTRAINT [VEICTIPV] FOREIGN KEY([cod_veic])
REFERENCES [rentacar].[Tipo_Veic] ([codigo])
GO
ALTER TABLE [rentacar].[Veiculo] CHECK CONSTRAINT [VEICTIPV]
GO
ALTER TABLE [reservavoos].[Airplane]  WITH CHECK ADD  CONSTRAINT [AIRPLANETP] FOREIGN KEY([type_name])
REFERENCES [reservavoos].[AirplaneType] ([type_name])
GO
ALTER TABLE [reservavoos].[Airplane] CHECK CONSTRAINT [AIRPLANETP]
GO
ALTER TABLE [reservavoos].[Can_Land]  WITH CHECK ADD  CONSTRAINT [CANAIRP] FOREIGN KEY([airport_code])
REFERENCES [reservavoos].[Airport] ([airport_cod])
GO
ALTER TABLE [reservavoos].[Can_Land] CHECK CONSTRAINT [CANAIRP]
GO
ALTER TABLE [reservavoos].[Can_Land]  WITH CHECK ADD  CONSTRAINT [CANTYPE] FOREIGN KEY([type_name])
REFERENCES [reservavoos].[AirplaneType] ([type_name])
GO
ALTER TABLE [reservavoos].[Can_Land] CHECK CONSTRAINT [CANTYPE]
GO
ALTER TABLE [reservavoos].[Fare]  WITH CHECK ADD  CONSTRAINT [FareFLI] FOREIGN KEY([flight_num])
REFERENCES [reservavoos].[Flight] ([number])
GO
ALTER TABLE [reservavoos].[Fare] CHECK CONSTRAINT [FareFLI]
GO
ALTER TABLE [reservavoos].[Flight_Leg]  WITH CHECK ADD  CONSTRAINT [FLIAIR] FOREIGN KEY([airport_code])
REFERENCES [reservavoos].[Airport] ([airport_cod])
GO
ALTER TABLE [reservavoos].[Flight_Leg] CHECK CONSTRAINT [FLIAIR]
GO
ALTER TABLE [reservavoos].[Flight_Leg]  WITH CHECK ADD  CONSTRAINT [FLIFLIGHT] FOREIGN KEY([flight_num])
REFERENCES [reservavoos].[Flight] ([number])
GO
ALTER TABLE [reservavoos].[Flight_Leg] CHECK CONSTRAINT [FLIFLIGHT]
GO
ALTER TABLE [reservavoos].[LegInstance]  WITH CHECK ADD  CONSTRAINT [LEGFLIG] FOREIGN KEY([leg_no], [flight_num])
REFERENCES [reservavoos].[Flight_Leg] ([leg_no], [flight_num])
GO
ALTER TABLE [reservavoos].[LegInstance] CHECK CONSTRAINT [LEGFLIG]
GO
ALTER TABLE [reservavoos].[LegInstance]  WITH CHECK ADD  CONSTRAINT [LINAIR] FOREIGN KEY([airport_cod])
REFERENCES [reservavoos].[Airport] ([airport_cod])
GO
ALTER TABLE [reservavoos].[LegInstance] CHECK CONSTRAINT [LINAIR]
GO
ALTER TABLE [reservavoos].[Seat]  WITH CHECK ADD  CONSTRAINT [SEAFLI] FOREIGN KEY([flight_num])
REFERENCES [reservavoos].[Flight] ([number])
GO
ALTER TABLE [reservavoos].[Seat] CHECK CONSTRAINT [SEAFLI]
GO
ALTER TABLE [universidade].[Departamento]  WITH CHECK ADD  CONSTRAINT [DERPPROF] FOREIGN KEY([nmec_prof])
REFERENCES [universidade].[Professor] ([nmec])
GO
ALTER TABLE [universidade].[Departamento] CHECK CONSTRAINT [DERPPROF]
GO
ALTER TABLE [universidade].[Estudante_Grad]  WITH CHECK ADD  CONSTRAINT [ESTGADV] FOREIGN KEY([advisor])
REFERENCES [universidade].[Estudante_Grad] ([nmec])
GO
ALTER TABLE [universidade].[Estudante_Grad] CHECK CONSTRAINT [ESTGADV]
GO
ALTER TABLE [universidade].[Estudante_Grad]  WITH CHECK ADD  CONSTRAINT [ESTGDERP] FOREIGN KEY([nome_dep])
REFERENCES [universidade].[Departamento] ([nome])
GO
ALTER TABLE [universidade].[Estudante_Grad] CHECK CONSTRAINT [ESTGDERP]
GO
ALTER TABLE [universidade].[Estudante_Grad]  WITH CHECK ADD  CONSTRAINT [ESTGPESS] FOREIGN KEY([nmec])
REFERENCES [universidade].[Pessoa] ([nmec])
GO
ALTER TABLE [universidade].[Estudante_Grad] CHECK CONSTRAINT [ESTGPESS]
GO
ALTER TABLE [universidade].[Estudante_Grad]  WITH CHECK ADD  CONSTRAINT [ESTGPROF] FOREIGN KEY([nmec_prof])
REFERENCES [universidade].[Professor] ([nmec])
GO
ALTER TABLE [universidade].[Estudante_Grad] CHECK CONSTRAINT [ESTGPROF]
GO
ALTER TABLE [universidade].[Particip_Grad]  WITH CHECK ADD  CONSTRAINT [PARTGESTG] FOREIGN KEY([nmec])
REFERENCES [universidade].[Estudante_Grad] ([nmec])
GO
ALTER TABLE [universidade].[Particip_Grad] CHECK CONSTRAINT [PARTGESTG]
GO
ALTER TABLE [universidade].[Particip_Grad]  WITH CHECK ADD  CONSTRAINT [PARTGPROJ] FOREIGN KEY([id_proj])
REFERENCES [universidade].[Projeto] ([id])
GO
ALTER TABLE [universidade].[Particip_Grad] CHECK CONSTRAINT [PARTGPROJ]
GO
ALTER TABLE [universidade].[Particip_Prof]  WITH CHECK ADD  CONSTRAINT [PARTPROFPROF] FOREIGN KEY([nmec_prof])
REFERENCES [universidade].[Professor] ([nmec])
GO
ALTER TABLE [universidade].[Particip_Prof] CHECK CONSTRAINT [PARTPROFPROF]
GO
ALTER TABLE [universidade].[Particip_Prof]  WITH CHECK ADD  CONSTRAINT [PARTPROFPROJ] FOREIGN KEY([id_proj])
REFERENCES [universidade].[Projeto] ([id])
GO
ALTER TABLE [universidade].[Particip_Prof] CHECK CONSTRAINT [PARTPROFPROJ]
GO
ALTER TABLE [universidade].[Professor]  WITH CHECK ADD  CONSTRAINT [PROFDEP] FOREIGN KEY([nome_dep])
REFERENCES [universidade].[Departamento] ([nome])
GO
ALTER TABLE [universidade].[Professor] CHECK CONSTRAINT [PROFDEP]
GO
ALTER TABLE [universidade].[Professor]  WITH CHECK ADD  CONSTRAINT [PROFPESS] FOREIGN KEY([nmec])
REFERENCES [universidade].[Pessoa] ([nmec])
GO
ALTER TABLE [universidade].[Professor] CHECK CONSTRAINT [PROFPESS]
GO
ALTER TABLE [universidade].[Projeto]  WITH CHECK ADD  CONSTRAINT [PROJPROF] FOREIGN KEY([nmec_prof])
REFERENCES [universidade].[Professor] ([nmec])
GO
ALTER TABLE [universidade].[Projeto] CHECK CONSTRAINT [PROJPROF]
GO
ALTER TABLE [fisioterapia].[Paciente]  WITH CHECK ADD CHECK  (([altura]>=(0)))
GO
ALTER TABLE [fisioterapia].[Paciente]  WITH CHECK ADD CHECK  (([peso]>=(0)))
GO
ALTER TABLE [fisioterapia].[Plano]  WITH CHECK ADD CHECK  (([n_total_sess]>=(0)))
GO
/****** Object:  StoredProcedure [fisioterapia].[ALTESTPACI]    Script Date: 12/06/2020 23:42:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [fisioterapia].[ALTESTPACI](@nifpac int,
										@nifest int
										)
AS
BEGIN
	BEGIN  
		UPDATE [fisioterapia].Sessao
		SET nif_est = (SELECT nif_est =@nifest
							FROM [fisioterapia].Sessao JOIN [fisioterapia].Plano ON [fisioterapia].Sessao.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Paciente ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Pessoa ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif 
							)
        
		WHERE @nifpac = (SELECT [fisioterapia].Pessoa.nif
							FROM [fisioterapia].Sessao JOIN [fisioterapia].Plano ON [fisioterapia].Sessao.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Paciente ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Pessoa ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif )
	END
END
GO
/****** Object:  StoredProcedure [fisioterapia].[ALTMAIL]    Script Date: 12/06/2020 23:42:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [fisioterapia].[ALTMAIL](@nif int,
										@mail varchar(30)
										)
AS
BEGIN
	BEGIN  
        UPDATE [fisioterapia].Pessoa
			SET   mail  =@mail  
        WHERE nif = @nif 
    END  
	
END
GO
/****** Object:  StoredProcedure [fisioterapia].[ALTORIEST]    Script Date: 12/06/2020 23:42:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [fisioterapia].[ALTORIEST](@nifest int,
										@nif_ori int
										)
AS
BEGIN
	BEGIN  
        UPDATE [fisioterapia].Estagiario
			SET nif = @nifest,
				nif_ori = @nif_ori
			WHERE nif=@nifest 
	END
END
GO
/****** Object:  StoredProcedure [fisioterapia].[MAILSEND]    Script Date: 12/06/2020 23:42:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [fisioterapia].[MAILSEND](@nif_pessoa int,
										@sender_mail varchar(30),
										@texto varchar(100)
										)
AS
BEGIN
	BEGIN
		INSERT INTO [fisioterapia].Mensagem (nif_pessoa, timestamp, sender_mail, texto)
									VALUES  (@nif_pessoa,CURRENT_TIMESTAMP, @sender_mail, @texto)
	END
END
GO
/****** Object:  Trigger [fisioterapia].[BACKUP_PESSOA]    Script Date: 12/06/2020 23:42:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [fisioterapia].[BACKUP_PESSOA] ON [fisioterapia].[Pessoa] INSTEAD OF DELETE AS
BEGIN
	IF  NOT (EXISTS (
				SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'fisioterapia' AND TABLE_NAME = 'PESSOA_BACKUP'))
				CREATE TABLE [fisioterapia].PESSOA_BACKUP (
														nif INT NOT NULL,
														nome INT NOT NULL,
														mail VARCHAR(50) NOT NULL,
														sexo char NOT NULL,
														data_nasc date NOT NULL)
	INSERT INTO [fisioterapia].PESSOA_BACKUP SELECT * FROM DELETED
	Delete FROM [fisioterapia].Pessoa Where [fisioterapia].Pessoa.nif=( SELECT nif FROM DELETED)
END
GO
ALTER TABLE [fisioterapia].[Pessoa] ENABLE TRIGGER [BACKUP_PESSOA]
GO
USE [master]
GO
ALTER DATABASE [p6g4] SET  READ_WRITE 
GO
