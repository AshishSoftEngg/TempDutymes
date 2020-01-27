USE [MES]
GO

/****** Object:  Table [dbo].[TemporaryDuty_Child]    Script Date: 27-Jan-20 8:16:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TemporaryDuty_Child](
	[TABID] [bigint] IDENTITY(1,1) NOT NULL,
	[TAHEADID] [int] NOT NULL,
	[NameOfPlace_Arrived_At] [varchar](120) NULL,
	[Arvl_Date] [datetime] NULL,
	[Arvl_Hrs] [nvarchar](50) NULL,
	[Distance_by_Road] [numeric](20, 0) NULL,
	[ConveyMode] [varchar](50) NULL,
	[ConveyClass] [varchar](50) NULL,
	[Departure_Date] [datetime] NULL,
	[Departure_Hrs] [nvarchar](50) NULL,
	[NoOfDA] [numeric](18, 2) NULL,
	[Rate_RMA_DA] [numeric](18, 2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[Remark] [nvarchar](500) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


