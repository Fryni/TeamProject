USE [master]
GO
/****** Object:  Database [xiros_george]    Script Date: 1/4/2019 21:22:33 ******/
CREATE DATABASE [xiros_george]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'xiros_george2', FILENAME = N'/var/opt/mssql/data/xiros_george2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'xiros_george2_log', FILENAME = N'/var/opt/mssql/data/xiros_george2_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [xiros_george] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [xiros_george].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [xiros_george] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [xiros_george] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [xiros_george] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [xiros_george] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [xiros_george] SET ARITHABORT OFF 
GO
ALTER DATABASE [xiros_george] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [xiros_george] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [xiros_george] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [xiros_george] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [xiros_george] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [xiros_george] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [xiros_george] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [xiros_george] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [xiros_george] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [xiros_george] SET  ENABLE_BROKER 
GO
ALTER DATABASE [xiros_george] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [xiros_george] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [xiros_george] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [xiros_george] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [xiros_george] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [xiros_george] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [xiros_george] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [xiros_george] SET RECOVERY FULL 
GO
ALTER DATABASE [xiros_george] SET  MULTI_USER 
GO
ALTER DATABASE [xiros_george] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [xiros_george] SET DB_CHAINING OFF 
GO
ALTER DATABASE [xiros_george] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [xiros_george] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [xiros_george] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'xiros_george', N'ON'
GO
ALTER DATABASE [xiros_george] SET QUERY_STORE = OFF
GO
USE [xiros_george]
GO
/****** Object:  Table [dbo].[Court]    Script Date: 1/4/2019 21:22:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Court](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BranchId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ImageCourt] [nvarchar](500) NOT NULL,
	[MaxPlayers] [int] NOT NULL,
	[Price] [decimal](5, 2) NOT NULL,
	[Description] [varchar](600) NULL,
 CONSTRAINT [pk_Court] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourtId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[BookedAt] [datetime] NOT NULL,
	[Duration] [int] NOT NULL,
	[BookKey] [varchar](32) NULL,
 CONSTRAINT [pk_Booking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BookingsByBranchAndDay]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BookingsByBranchAndDay] AS 
--PRINT @@DATEFIRST 
select Court.BranchId, datepart(dw,BookedAt) AS BookingDayNo, datename(dw,BookedAt) AS BookingDay, count(*) as CountOfBookings
from booking inner join Court 
  on Booking.CourtId = Court.Id
group by Court.BranchId, datepart(dw,BookedAt), datename(dw,BookedAt)
GO
/****** Object:  View [dbo].[WeekDays]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[WeekDays] as 
SELECT        1 AS [Day]
UNION ALL
SELECT        2 AS [Day]
UNION ALL
SELECT        3 AS [Day]
UNION ALL
SELECT        4 AS [Day]
UNION ALL
SELECT        5 AS [Day]
UNION ALL
SELECT        6 AS [Day]
UNION ALL
SELECT        7 AS [Day]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Longitude] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[City] [nvarchar](200) NULL,
	[Address] [nvarchar](200) NOT NULL,
	[ZipCode] [nvarchar](10) NULL,
	[ImageBranch] [varchar](100) NULL,
 CONSTRAINT [pk_Branch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BranchFacilities]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BranchFacilities](
	[BranchId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
 CONSTRAINT [pk_BranchFacilities] PRIMARY KEY CLUSTERED 
(
	[BranchId] ASC,
	[FacilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 1/4/2019 21:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	[ImageFacility] [varchar](100) NULL,
 CONSTRAINT [pk_Facility] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 1/4/2019 21:22:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourtId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](250) NULL,
	[CommentAt] [datetime] NOT NULL,
 CONSTRAINT [pk_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 1/4/2019 21:22:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSlot]    Script Date: 1/4/2019 21:22:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSlot](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourtId] [int] NOT NULL,
	[Day] [int] NOT NULL,
	[Hour] [time](7) NOT NULL,
	[Duration] [int] NOT NULL,
 CONSTRAINT [pk_TimeSlot] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/4/2019 21:22:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [pk_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 1/4/2019 21:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Description]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Description]) VALUES (2, N'Owner')
INSERT [dbo].[Role] ([Id], [Description]) VALUES (3, N'User')
SET IDENTITY_INSERT [dbo].[Role] OFF

GO
/****** Object:  Index [ix_Branch]    Script Date: 1/4/2019 21:22:45 ******/
CREATE UNIQUE NONCLUSTERED INDEX [ix_Branch] ON [dbo].[Branch]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_FacilityDescription]    Script Date: 1/4/2019 21:22:45 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Ix_FacilityDescription] ON [dbo].[Facility]
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_User_email]    Script Date: 1/4/2019 21:22:45 ******/
CREATE UNIQUE NONCLUSTERED INDEX [ix_User_email] ON [dbo].[User]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [fk_BookingToCourt] FOREIGN KEY([CourtId])
REFERENCES [dbo].[Court] ([Id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [fk_BookingToCourt]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [fk_BookingToUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [fk_BookingToUser]
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [fk_CompanyToUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [fk_CompanyToUsers]
GO
ALTER TABLE [dbo].[BranchFacilities]  WITH CHECK ADD  CONSTRAINT [fk_BranchFacilitiesToBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[Branch] ([Id])
GO
ALTER TABLE [dbo].[BranchFacilities] CHECK CONSTRAINT [fk_BranchFacilitiesToBranch]
GO
ALTER TABLE [dbo].[BranchFacilities]  WITH CHECK ADD  CONSTRAINT [fk_BranchFacilitiesToFacility] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[Facility] ([Id])
GO
ALTER TABLE [dbo].[BranchFacilities] CHECK CONSTRAINT [fk_BranchFacilitiesToFacility]
GO
ALTER TABLE [dbo].[Court]  WITH CHECK ADD  CONSTRAINT [fk_CourtToBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[Branch] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Court] CHECK CONSTRAINT [fk_CourtToBranch]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [fk_ReviewToCourt] FOREIGN KEY([CourtId])
REFERENCES [dbo].[Court] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [fk_ReviewToCourt]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [fk_ReviewToUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [fk_ReviewToUsers]
GO
ALTER TABLE [dbo].[TimeSlot]  WITH CHECK ADD  CONSTRAINT [fk_TimeSlotToCourt] FOREIGN KEY([CourtId])
REFERENCES [dbo].[Court] ([Id])
GO
ALTER TABLE [dbo].[TimeSlot] CHECK CONSTRAINT [fk_TimeSlotToCourt]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_RoleIdToRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_RoleIdToRole]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserIdToUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserIdToUser]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [UserRoles_1] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [UserRoles_1]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [UserRoles_2] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [UserRoles_2]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD CHECK  (([rating]<=(5) AND [rating]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[GetBookingsAt]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBookingsAt] 
	@CourtId INT,
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN

	SET DATEFIRST 1;
		
	WITH CourtTimeSlots ([Hour]) AS (
			SELECT DISTINCT T.[Hour] FROM TimeSlot T WHERE T.CourtId = @CourtId
		), WeekTimeSlots ([Day], [Hour]) AS	(
			SELECT W.[Day], T.[Hour] FROM WeekDays W, CourtTimeSlots T
		), BookedTimeSlots (BookingId, CourtId, [Day], [Hour]) AS (
			SELECT Booking.Id AS BookingId, Booking.CourtId, DATEPART(WEEKDAY,[Booking].[BookedAt]) AS [Day], cast([Booking].[BookedAt] as time) AS [Hour] FROM Booking WHERE CourtId=@CourtId AND BookedAt BETWEEN @DateFrom AND @DateTo
		)
			
	SELECT [Hour], [1] AS Day1, [2] AS Day2, [3] AS Day3, [4] AS Day4, [5] AS Day5, [6] AS Day6, [7] AS Day7
	FROM  (
		SELECT W.*
			, CASE 
				WHEN T.Id IS NULL THEN NULL ELSE 
				  CASE WHEN B.BookingId IS NULL THEN 0 ELSE B.BookingId
				END 
			  END AS [State]
	
		FROM WeekTimeSlots W
			LEFT JOIN (SELECT * FROM TimeSlot WHERE CourtId = @CourtId) T 
				ON W.[Day] = T.[Day] AND W.[Hour] = T.[Hour]
			LEFT JOIN BookedTimeSlots B 
				ON T.CourtId = B.CourtId AND T.[Day] = B.[Day] AND T.[Hour] = B.[Hour]
	
	) AS SourceTable  
	PIVOT  
	(  
		max([State])  
		FOR [Day] IN ([1], [2], [3], [4], [5], [6], [7])  
	) AS PivotTable; 
END
GO
/****** Object:  StoredProcedure [dbo].[GetBookingsByBranchAndDay]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBookingsByBranchAndDay] 
	@BranchId INT
AS 
BEGIN
	SET DATEFIRST 1;
	select datepart(dw,BookedAt) AS BookingDayNo, datename(dw,BookedAt) AS BookingDay, count(*) as CountOfBookings
	from booking inner join Court 
	  on Booking.CourtId = Court.Id
	where BranchId=@BranchId
	group by datepart(dw,BookedAt), datename(dw,BookedAt)
END
GO
/****** Object:  StoredProcedure [dbo].[GetBookingsByCourtAndDay]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetBookingsByCourtAndDay] 
	@CourtId INT
AS 
BEGIN
	SET DATEFIRST 1;
	select datepart(dw,BookedAt) AS BookingDayNo, datename(dw,BookedAt) AS BookingDay, count(*) as CountOfBookings
	from booking inner join Court 
	  on Booking.CourtId = Court.Id
	where CourtId=@CourtId
	group by datepart(dw,BookedAt), datename(dw,BookedAt)
END
GO
/****** Object:  StoredProcedure [dbo].[GetBranchesDistance]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetBranchesDistance] 
	@Latitude float,
	@Longitude float,
	@Distance float
AS
BEGIN
	DECLARE @g geography;  
	SET @g = geography::STGeomFromText('POINT('+ cast(@latitude as varchar) + ' ' + cast(@longitude as varchar) +')', 4326);  

	SELECT branch.*
		,  geography::STGeomFromText('POINT('+ cast(latitude as varchar) + ' ' + cast(longitude as varchar) +')', 4326).STDistance(@g) as Distance
		, court.*
		, facility.*
	from branch inner join Court on branch.id = Court.BranchId
	 left join BranchFacilities on Branch.Id = BranchFacilities.BranchId
	 left join Facility on BranchFacilities.FacilityId = Facility.Id

	where geography::STGeomFromText('POINT('+ cast(latitude as varchar) + ' ' + cast(longitude as varchar) +')', 4326).STDistance(@g)  <@distance
END
GO
/****** Object:  StoredProcedure [dbo].[GetTimeslots]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTimeslots] 
	@CourtId INT
AS
BEGIN
	SET DATEFIRST 1;
		
	WITH CourtTimeSlots ([Hour]) AS (
			SELECT DISTINCT T.[Hour] FROM TimeSlot T WHERE T.CourtId = @CourtId
		), WeekTimeSlots ([Day], [Hour]) AS	(
			SELECT W.[Day], T.[Hour] FROM WeekDays W, CourtTimeSlots T
		)
			
	SELECT [Hour], [1] AS Day1, [2] AS Day2, [3] AS Day3, [4] AS Day4, [5] AS Day5, [6] AS Day6, [7] AS Day7
	FROM  (
		SELECT w.*,T.id
	
		FROM WeekTimeSlots W
			LEFT JOIN (SELECT id,[day],[hour] FROM TimeSlot WHERE CourtId = @CourtId) T
				ON W.[Day] = T.[Day] AND W.[Hour] = T.[Hour]
	
	) AS SourceTable  
	PIVOT  
	(  
		max(Id)  
		FOR [Day] IN ([1], [2], [3], [4], [5], [6], [7])  
	) AS PivotTable;  
END
GO
/****** Object:  StoredProcedure [dbo].[GetTimeslotsAt]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTimeslotsAt] 
	@CourtId INT,
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN

	SET DATEFIRST 1;
		
	WITH CourtTimeSlots ([Hour]) AS (
			SELECT DISTINCT T.[Hour] FROM TimeSlot T WHERE T.CourtId = @CourtId
		), WeekTimeSlots ([Day], [Hour]) AS	(
			SELECT W.[Day], T.[Hour] FROM WeekDays W, CourtTimeSlots T
		), BookedTimeSlots (BookingId, CourtId, [Day], [Hour]) AS (
			SELECT Booking.Id AS BookingId, Booking.CourtId, DATEPART(WEEKDAY,[Booking].[BookedAt]) AS [Day], cast([Booking].[BookedAt] as time) AS [Hour] FROM Booking WHERE CourtId=@CourtId AND BookedAt BETWEEN @DateFrom AND @DateTo
		)
			
	SELECT [Hour], [1] AS Day1, [2] AS Day2, [3] AS Day3, [4] AS Day4, [5] AS Day5, [6] AS Day6, [7] AS Day7
	FROM  (
		SELECT W.*
			, CASE 
				WHEN T.Id IS NULL THEN 0 ELSE 
				  CASE WHEN B.BookingId IS NULL THEN 1 ELSE 2
				END 
			  END AS [State]
	
		FROM WeekTimeSlots W
			LEFT JOIN (SELECT * FROM TimeSlot WHERE CourtId = @CourtId) T 
				ON W.[Day] = T.[Day] AND W.[Hour] = T.[Hour]
			LEFT JOIN BookedTimeSlots B 
				ON T.CourtId = B.CourtId AND T.[Day] = B.[Day] AND T.[Hour] = B.[Hour]
	
	) AS SourceTable  
	PIVOT  
	(  
		max([State])  
		FOR [Day] IN ([1], [2], [3], [4], [5], [6], [7])  
	) AS PivotTable;  
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[InsertUser] 
	  @Email varchar(50)
	, @FirstName varchar(50)
	, @LastName varchar(50) 
	, @Password varchar(30) 
aS
begin

	declare @salt uniqueidentifier = newid()
	
	insert into [User] (email, password, salt , firstName, lastName) 
	values (@email, HASHBYTES('SHA2_512', @password+CAST(@salt AS NVARCHAR(36))), @salt , @firstName, @lastName)
	select SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserPassword]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[UpdateUserPassword] 
	  @Id int
	, @Password varchar(30) 
as 
begin
	update [User] set 
		password = HASHBYTES('SHA2_512', @password+CAST(salt AS NVARCHAR(36)))
	where Id = @id 
end
GO
/****** Object:  StoredProcedure [dbo].[ValidateUser]    Script Date: 1/4/2019 21:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ValidateUser]
	  @Email varchar(30)
	, @Password varchar(30)
as
begin
		select count(*)
		from [user] 
		where  password = HASHBYTES('SHA2_512', @password+CAST(salt AS NVARCHAR(36)))
		   and email = @email
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WeekDays'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WeekDays'
GO
USE [master]
GO
ALTER DATABASE [xiros_george] SET  READ_WRITE 
GO
