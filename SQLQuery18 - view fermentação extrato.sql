USE [PROCESSO]
GO

/****** Object:  View [dbo].[View_Fermenta��o_Extrato]    Script Date: 28/09/2022 10:27:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











ALTER VIEW [dbo].[View_Fermenta��o_Extrato]
AS
SELECT        dbo.ADEGAS_1_FERMENTACAO.Lote
, dbo.ADEGAS_1_FERMENTACAO.DATETIME
, LEFT(dbo.ADEGAS_1_FERMENTACAO.SEQ_STRING, 1) AS ADEGAS
, RIGHT(dbo.ADEGAS_1_FERMENTACAO.SEQ_STRING, 78) 
                         AS TIPO
						 , dbo.ADEGAS_1_FERMENTACAO.Tempo
						 , dbo.ADEGAS_1_FERMENTACAO.SKU
						 , dbo.ADEGAS_1_FERMENTACAO.Tempo / 60 AS Horas
						 , CASE WHEN (dbo.Base_Extrato_SID_MULE.C�digo = 8924) and (dbo.ADEGAS_1_FERMENTACAO.Tempo > 5) THEN dbo.Base_Extrato_SID_MULE.Valor
						  WHEN  (dbo.ADEGAS_1_FERMENTACAO.Tempo < 5) THEN dbo.Fermenta��o_Extrato_MULE.Digit_ench END AS Extrato_analise
						 , dbo.ADEGAS_1_FERMENTACAO.Atenuacao 
                         , CASE WHEN dbo.Base_Extrato_SID_MULE.C�digo = 12396 THEN dbo.Base_Extrato_SID_MULE.Valor END AS Digit_inicial
						 , dbo.ADEGAS_1_FERMENTACAO.Temperatura
						 , dbo.ADEGAS_1_FERMENTACAO.Pressao
						 , dbo.ADEGAS_1_FERMENTACAO.SEQ
						 , dbo.ADEGAS_1_FERMENTACAO.SEQ_STRING
						 , dbo.ADEGAS_1_FERMENTACAO.Tmin
						 , dbo.ADEGAS_1_FERMENTACAO.T
						 , dbo.ADEGAS_1_FERMENTACAO.Tmax
						 , dbo.ADEGAS_1_FERMENTACAO.CPMin
						 , dbo.ADEGAS_1_FERMENTACAO.CP
						 , dbo.ADEGAS_1_FERMENTACAO.CPM�x
						 , dbo.ADEGAS_1_FERMENTACAO.Passo
						 , dbo.Base_Extrato_SID_MULE.Lote AS Expr1
						 , dbo.Base_Extrato_SID_MULE.C�digo
						 , dbo.Base_Extrato_SID_MULE.Valor
						 , dbo.Base_Extrato_SID_MULE.[Inclus�o]
						 , dbo.Fermenta��o_Extrato_MULE.Digit_ench
						 , CASE WHEN dbo.ADEGAS_1_FERMENTACAO.Tempo < 10 THEN dbo.Fermenta��o_Extrato_MULE.Digit_ench END AS Plato_ench
						 , dbo.ADEGAS_1_FERMENTACAO.Receita_OD
						 , dbo.LABEL_STEP_FERMENTACAO.label_Ferm
						 , dbo.ADEGAS_1_FERMENTACAO.Fermentador
						 , dbo.Fermenta��o_Extrato_MULE.LOTE_MES
						 ,(dbo.Fermenta��o_Extrato_MULE.Digit_ench - dbo.Fermenta��o_Extrato_MULE.Digit_ench * dbo.ADEGAS_1_FERMENTACAO.Atenuacao) as Extrato
						 ,(dbo.Fermenta��o_Extrato_MULE.Digit_ench - dbo.Fermenta��o_Extrato_MULE.Digit_ench * dbo.ADEGAS_1_FERMENTACAO.Atenuacao) + 1.0 as Extrato_max
						 ,(dbo.Fermenta��o_Extrato_MULE.Digit_ench - dbo.Fermenta��o_Extrato_MULE.Digit_ench * dbo.ADEGAS_1_FERMENTACAO.Atenuacao) - 1.0 as Extrato_min
						 /*INTO [PROCESSO].[dbo].[Manip_fermenta��o]*/

FROM            dbo.ADEGAS_1_FERMENTACAO INNER JOIN
                         dbo.LABEL_STEP_FERMENTACAO ON dbo.ADEGAS_1_FERMENTACAO.Passo = dbo.LABEL_STEP_FERMENTACAO.step LEFT OUTER JOIN
                         dbo.Fermenta��o_Extrato_MULE ON dbo.ADEGAS_1_FERMENTACAO.Lote = dbo.Fermenta��o_Extrato_MULE.Lote LEFT OUTER JOIN          dbo.Base_Extrato_SID_MULE ON (dbo.ADEGAS_1_FERMENTACAO.Fermentador
					 = dbo.Base_Extrato_SID_MULE.OD )
						 AND 
						 (
						(dbo.Base_Extrato_SID_MULE.inclus�o  =( LEFT(CONVERT(nvarchar(20), DATEADD(mi, -1, dbo.ADEGAS_1_FERMENTACAO.DATETIME)), 19)))
						 or
						 (dbo.Base_Extrato_SID_MULE.inclus�o  =( LEFT(CONVERT(nvarchar(20), DATEADD(mi, 0, dbo.ADEGAS_1_FERMENTACAO.DATETIME)), 19)))
						or 
						(dbo.Base_Extrato_SID_MULE.inclus�o  =( LEFT(CONVERT(nvarchar(20), DATEADD(mi, 1, dbo.ADEGAS_1_FERMENTACAO.DATETIME)), 19)))
						
						)
						 where RIGHT(dbo.ADEGAS_1_FERMENTACAO.SEQ_STRING, 78) = 'FERM'
GO


