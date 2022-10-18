USE [PROCESSO]
GO

/****** Object:  View [dbo].[Base_Extrato_SID_MULE]    Script Date: 28/09/2022 10:19:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO















ALTER VIEW [dbo].[Base_Extrato_SID_MULE]
AS
SELECT			cast(SUBSTRING (dbo.Base_Extrato_SID.Ponto,PATINDEX('%[0-9]%',dbo.Base_Extrato_SID.Ponto),LEN (dbo.Base_Extrato_SID.Ponto))as real) as OD
				,cast(SUBSTRING (Lote,6,4) as int) as Lote
				, Código
				, Valor
				, LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19) as inclusão
				, convert(datetime,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19),103) as DT_inclusão
				, case when dbo.Base_Extrato_SID.[Data fechamento] <> '' then LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data fechamento], 103)),19) end as Encerramento
				, convert(datetime,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data fechamento], 103)),19),103) as DT_Encerramento
				,DATEDIFF(minute,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19),LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data fechamento], 103)),19)) diff
				, DATEDIFF(MONTH,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19),GETDATE()) as DELTA
FROM            dbo.Base_Extrato_SID
where  ( DATEDIFF(MONTH,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19),GETDATE()) < 7 )
/*
 and
 ((
			DATEDIFF(minute,LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data Inclusão], 103)),19),LEFT(CONVERT(nvarchar(20), CONVERT(datetime, dbo.Base_Extrato_SID.[Data fechamento], 103)),19)) > 0

		)

      or
	    (
	   dbo.Base_Extrato_SID.[Data fechamento] = ''
	   
		)
		
		
		)
*/
GO


