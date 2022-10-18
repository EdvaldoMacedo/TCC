USE [PROCESSO]
GO

/****** Object:  View [dbo].[View_Fermentação_Extrato_MULE]    Script Date: 28/09/2022 10:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












ALTER VIEW [dbo].[View_Fermentação_Extrato_MULE]
AS

SELECT        dbo.ADEGAS_1_FERMENTACAO.Lote
			, MAX(dbo.Base_Extrato_SID_MULE.Lote) as LOTE_MES
			, MAX(CASE WHEN dbo.Base_Extrato_SID_MULE.Código = 12396 THEN dbo.Base_Extrato_SID_MULE.Valor END) AS Digit_ench
			, dbo.ADEGAS_1_FERMENTACAO.Fermentador
			,MIN (DATETIME) as inicial
			,CONCAT(dbo.ADEGAS_1_FERMENTACAO.Lote,'_',dbo.ADEGAS_1_FERMENTACAO.Fermentador) as CLE
FROM            dbo.ADEGAS_1_FERMENTACAO 

LEFT OUTER JOIN          dbo.Base_Extrato_SID_MULE ON (dbo.ADEGAS_1_FERMENTACAO.Fermentador
					 = dbo.Base_Extrato_SID_MULE.OD )
						 AND 
						 (
						 datediff(MINUTE,dbo.Base_Extrato_SID_MULE.DT_inclusão, dbo.ADEGAS_1_FERMENTACAO.DATETIME) between -1 and 1
						)
						
where (dbo.ADEGAS_1_FERMENTACAO.Lote > 0) and (dbo.ADEGAS_1_FERMENTACAO.SKU <> 43) and (CONCAT(dbo.ADEGAS_1_FERMENTACAO.Lote,'_',dbo.ADEGAS_1_FERMENTACAO.Fermentador))
not in (SELECT [CLE] FROM [PROCESSO].[dbo].[Fermentação_Extrato_MULE])

GROUP BY dbo.ADEGAS_1_FERMENTACAO.Lote, dbo.ADEGAS_1_FERMENTACAO.Fermentador



GO


