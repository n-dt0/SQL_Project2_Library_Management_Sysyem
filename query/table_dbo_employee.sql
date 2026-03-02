USE [SQL_Project2_Library]
GO

/****** Object:  Table [dbo].[employees]    Script Date: 2026-01-30 5:28:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[employees](
	[emp_id] [varchar](80) NOT NULL,
	[emp_name] [nvarchar](50) NOT NULL,
	[position] [varchar](80) NOT NULL,
	[salary] [decimal](10, 2) NOT NULL,
	[branch_id] [varchar](80) NOT NULL,
 CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

