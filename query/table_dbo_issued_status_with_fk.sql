USE [SQL_Project2_Library]
GO

/****** Object:  Table [dbo].[issued_status]    Script Date: 2026-01-31 8:07:53 PM ******/
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

ALTER TABLE [dbo].[issued_status]  WITH CHECK ADD  CONSTRAINT [FK_issued_status_issued_book_isnb] FOREIGN KEY([issued_id])
REFERENCES [dbo].[issued_status] ([issued_id])
GO

ALTER TABLE [dbo].[issued_status] CHECK CONSTRAINT [FK_issued_status_issued_book_isnb]
GO

ALTER TABLE [dbo].[issued_status]  WITH CHECK ADD  CONSTRAINT [FK_issued_status_issued_emp_id] FOREIGN KEY([issued_id])
REFERENCES [dbo].[issued_status] ([issued_id])
GO

ALTER TABLE [dbo].[issued_status] CHECK CONSTRAINT [FK_issued_status_issued_emp_id]
GO

ALTER TABLE [dbo].[issued_status]  WITH CHECK ADD  CONSTRAINT [FK_issued_status_issued_member_ID] FOREIGN KEY([issued_id])
REFERENCES [dbo].[issued_status] ([issued_id])
GO

ALTER TABLE [dbo].[issued_status] CHECK CONSTRAINT [FK_issued_status_issued_member_ID]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'references dbo.books(isbn)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'issued_status', @level2type=N'CONSTRAINT',@level2name=N'FK_issued_status_issued_book_isnb'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'referencesdbo.employees(emp_id)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'issued_status', @level2type=N'CONSTRAINT',@level2name=N'FK_issued_status_issued_emp_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'references dbo.members(members_id)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'issued_status', @level2type=N'CONSTRAINT',@level2name=N'FK_issued_status_issued_member_ID'
GO

