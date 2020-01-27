USE [MES]
GO

/****** Object:  Table [dbo].[TemporaryDuty_Head]    Script Date: 27-Jan-20 8:15:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TemporaryDuty_Head](
	[TABID] [bigint] IDENTITY(1,1) NOT NULL,
	[ECODE] [varchar](50) NULL,
	[DoB] [datetime] NULL,
	[Gpf_Pran_No] [numeric](10, 2) NULL,
	[EMP_NAME] [varchar](150) NULL,
	[Ranks] [varchar](50) NULL,
	[HeadqtrOffice] [varchar](200) NULL,
	[BasicPay] [numeric](10, 2) NULL,
	[OrderForMove_Duty] [varchar](50) NULL,
	[AuthorityRule_TR_SR] [varchar](50) NULL,
	[StationFrom_Journey_commenced] [varchar](50) NULL,
	[DateTime_Of_Start] [datetime] NULL,
	[EmpType] [char](5) NULL,
	[GPS_NPS] [varchar](50) NULL,
	[fin_year] [char](9) NULL,
	[CREATEDBY] [varchar](120) NULL,
	[CREATEDDATE] [datetime] NULL,
	[UPDATEDBY] [varchar](120) NULL,
	[UPDATEDDATE] [datetime] NULL,
	[freeze_flage] [char](1) NULL,
	[refrence_no] [varchar](50) NULL,
	[Levels] [numeric](18, 0) NULL,
	[Cells] [numeric](18, 0) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


