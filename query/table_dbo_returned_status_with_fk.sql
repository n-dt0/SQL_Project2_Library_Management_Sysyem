USE [SQL_Project2_Library]
GO

/****** Object:  Table [dbo].[return_status]    Script Date: 2026-02-01 4:43:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[return_status](
	[return_id] [varchar](80) NOT NULL,
	[issued_id] [varchar](80) NOT NULL,
	[return_book_name] [varchar](80) NOT NULL,
	[return_date] [date] NOT NULL,
	[return_book_isbn] [varchar](80) NOT NULL,
 CONSTRAINT [PK_return_status] PRIMARY KEY CLUSTERED 
(
	[return_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[return_status]  WITH CHECK ADD  CONSTRAINT [FK_return_status_return_book_isbn] FOREIGN KEY([return_id])
REFERENCES [dbo].[return_status] ([return_id])
GO

ALTER TABLE [dbo].[return_status] CHECK CONSTRAINT [FK_return_status_return_book_isbn]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'referancesdbo.books(isbn)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'return_status', @level2type=N'CONSTRAINT',@level2name=N'FK_return_status_return_book_isbn'
GO

