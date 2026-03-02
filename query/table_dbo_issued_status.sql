USE [SQL_Project2_Library]
GO

/****** Object:  Table [dbo].[issued_status]    Script Date: 2026-01-31 7:28:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[issued_status](
	[issued_id] [varchar](80) NOT NULL,
	[issued_member_id] [varchar](80) NOT NULL,
	[issued_book_name] [varchar](80) NOT NULL,
	[issued_date] [date] NOT NULL,
	[issued_book_isbn] [varchar](80) NOT NULL,
	[issued_emp_id] [varchar](80) NOT NULL,
 CONSTRAINT [PK_issued_status] PRIMARY KEY CLUSTERED 
(
	[issued_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

