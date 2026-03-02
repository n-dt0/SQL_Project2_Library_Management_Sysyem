USE [SQL_Project2_Library]
GO

/****** Object:  Table [dbo].[branch]    Script Date: 2026-01-30 5:22:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[branch](
	[branch_id] [varchar](80) NOT NULL,
	[manager_id] [varchar](80) NOT NULL,
	[branch_address] [varchar](80) NOT NULL,
	[contact_no] [varchar](80) NOT NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

