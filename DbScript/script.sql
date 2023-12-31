Create database [UserDetail]
GO
USE [UserDetail]
GO
/****** Object:  Table [dbo].[tblCity]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](50) NULL,
	[StateId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblState]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblState](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserRegistration]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserRegistration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](12) NULL,
	[Address] [varchar](50) NULL,
	[StateId] [int] NULL,
	[CityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCity] ON 

INSERT [dbo].[tblCity] ([id], [CityName], [StateId]) VALUES (3, N'Surat', 1)
INSERT [dbo].[tblCity] ([id], [CityName], [StateId]) VALUES (4, N'Bardoli', 1)
INSERT [dbo].[tblCity] ([id], [CityName], [StateId]) VALUES (5, N'Baroda', 1)
INSERT [dbo].[tblCity] ([id], [CityName], [StateId]) VALUES (6, N'Mumbai', 2)
INSERT [dbo].[tblCity] ([id], [CityName], [StateId]) VALUES (7, N'Pune', 2)
SET IDENTITY_INSERT [dbo].[tblCity] OFF
GO
SET IDENTITY_INSERT [dbo].[tblState] ON 

INSERT [dbo].[tblState] ([id], [StateName]) VALUES (1, N'Gujarat')
INSERT [dbo].[tblState] ([id], [StateName]) VALUES (2, N'Maharashtra')
SET IDENTITY_INSERT [dbo].[tblState] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUserRegistration] ON 

INSERT [dbo].[tblUserRegistration] ([id], [Name], [Email], [Phone], [Address], [StateId], [CityId]) VALUES (3, N'temp 22', N'temp22@gmail.com', N'9887756458', N'temp village', 1, 5)
INSERT [dbo].[tblUserRegistration] ([id], [Name], [Email], [Phone], [Address], [StateId], [CityId]) VALUES (4, N'john', N'john@testmail.com', N'9875623140', N'johnvilla', 2, 7)
SET IDENTITY_INSERT [dbo].[tblUserRegistration] OFF
GO
ALTER TABLE [dbo].[tblCity]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[tblState] ([id])
GO
ALTER TABLE [dbo].[tblUserRegistration]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[tblCity] ([id])
GO
ALTER TABLE [dbo].[tblUserRegistration]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[tblState] ([id])
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE   PROCEDURE [dbo].[DeleteUser]
@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Delete from tblUserRegistration 
	where id = @Id

	select 1 as result
END

GO
/****** Object:  StoredProcedure [dbo].[dropDown]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE   PROCEDURE [dbo].[dropDown]
@Type varchar(10),
@State int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@Type = 'city')
	BEGIN
		select id Value, CityName Text from tblCity where StateId = @State
	END
	else if(@Type = 'state')
	BEGIN
		select id Value, StateName Text from tblState
	END

END

GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE   PROCEDURE [dbo].[GetAllUser]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select r.Id, r.Name, r.Email, r.Phone, c.CityName, s.StateName from tblUserRegistration r 
	inner join tblCity c on r.CityId = c.id 
	inner join tblState s on r.StateId = s.id
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE   PROCEDURE [dbo].[GetUserById]
@Id int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Id, Name, Email, Phone, Address, CityId, StateId 
	from tblUserRegistration r where id = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[SaveUser]    Script Date: 24-06-2023 4.44.08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE   PROCEDURE [dbo].[SaveUser]
@Id int,
@Name varchar(50),
@Email varchar(50),
@Phone varchar(12),
@Address varchar(50),
@StateId int,
@Cityid int

AS
BEGIN
	
	SET NOCOUNT ON;

	if(@Id > 0)
	BEGIN
		Update tblUserRegistration
		set Name = @Name,
		Email = @Email,
		Phone = @Phone,
		Address = @Address,
		StateId = @StateId,
		CityId = @Cityid
		where id = @Id

		select 1 as result
	END
	else
	BEGIN
		Insert into tblUserRegistration (
		Name, Email, Phone, Address, StateId, CityId)
		Values (@Name, @Email, @Phone, @Address, @StateId, @Cityid)

		select 2 as result
	END

END


GO
