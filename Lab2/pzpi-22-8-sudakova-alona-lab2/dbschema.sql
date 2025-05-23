USE [master]
GO
/****** Object:  Database [FocusLearnDB]    Script Date: 27.12.2024 18:01:56 ******/
CREATE DATABASE [FocusLearnDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FocusLearn', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FocusLearn.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FocusLearn_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FocusLearn_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FocusLearnDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FocusLearnDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FocusLearnDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FocusLearnDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FocusLearnDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FocusLearnDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FocusLearnDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FocusLearnDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FocusLearnDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FocusLearnDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FocusLearnDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FocusLearnDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FocusLearnDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FocusLearnDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FocusLearnDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FocusLearnDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FocusLearnDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FocusLearnDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FocusLearnDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FocusLearnDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FocusLearnDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FocusLearnDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FocusLearnDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FocusLearnDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FocusLearnDB] SET RECOVERY FULL 
GO
ALTER DATABASE [FocusLearnDB] SET  MULTI_USER 
GO
ALTER DATABASE [FocusLearnDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FocusLearnDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FocusLearnDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FocusLearnDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FocusLearnDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FocusLearnDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FocusLearnDB', N'ON'
GO
ALTER DATABASE [FocusLearnDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [FocusLearnDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FocusLearnDB]
GO
/****** Object:  Table [dbo].[Assignment]    Script Date: 27.12.2024 18:01:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignment](
	[AssignmentId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[StudentId] [int] NULL,
	[TutorId] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[Rating] [tinyint] NULL,
	[FileLink] [nvarchar](max) NULL,
	[TaskId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConcentrationMethod]    Script Date: 27.12.2024 18:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConcentrationMethod](
	[MethodId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[WorkDuration] [int] NOT NULL,
	[BreakDuration] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IoTSession]    Script Date: 27.12.2024 18:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IoTSession](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[MethodId] [int] NOT NULL,
	[SessionType] [nvarchar](20) NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Duration]  AS (datediff(minute,[StartTime],[EndTime])),
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LearningMaterial]    Script Date: 27.12.2024 18:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LearningMaterial](
	[MaterialId] [int] IDENTITY(1,1) NOT NULL,
	[CreatorId] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[FileLink] [nvarchar](max) NULL,
	[AddedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaterialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 27.12.2024 18:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](20) NULL,
	[ProfilePhoto] [nvarchar](max) NULL,
	[Language] [nvarchar](20) NULL,
	[ProfileStatus] [nvarchar](20) NULL,
	[AuthProvider] [nvarchar](50) NULL,
	[ProviderId] [nvarchar](100) NULL,
	[RegistrationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMethodStatistics]    Script Date: 27.12.2024 18:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMethodStatistics](
	[StatisticId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[MethodId] [int] NOT NULL,
	[PeriodStartDate] [date] NOT NULL,
	[PeriodType] [nvarchar](10) NOT NULL,
	[TotalConcentrationTime] [int] NOT NULL,
	[BreakCount] [int] NOT NULL,
	[MissedBreaks] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatisticId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assignment] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ConcentrationMethod] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[LearningMaterial] ADD  DEFAULT (getdate()) FOR [AddedAt]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[UserMethodStatistics] ADD  DEFAULT ((0)) FOR [BreakCount]
GO
ALTER TABLE [dbo].[UserMethodStatistics] ADD  DEFAULT ((0)) FOR [MissedBreaks]
GO
ALTER TABLE [dbo].[UserMethodStatistics] ADD  DEFAULT (getdate()) FOR [LastUpdated]
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD FOREIGN KEY([TaskId])
REFERENCES [dbo].[LearningMaterial] ([MaterialId])
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD FOREIGN KEY([TutorId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[IoTSession]  WITH CHECK ADD FOREIGN KEY([MethodId])
REFERENCES [dbo].[ConcentrationMethod] ([MethodId])
GO
ALTER TABLE [dbo].[IoTSession]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[LearningMaterial]  WITH CHECK ADD FOREIGN KEY([CreatorId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserMethodStatistics]  WITH CHECK ADD FOREIGN KEY([MethodId])
REFERENCES [dbo].[ConcentrationMethod] ([MethodId])
GO
ALTER TABLE [dbo].[UserMethodStatistics]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD CHECK  (([Status]='Completed' OR [Status]='InProgress' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[IoTSession]  WITH CHECK ADD CHECK  (([SessionType]='Break' OR [SessionType]='Concentration'))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([ProfileStatus]='Inactive' OR [ProfileStatus]='Active'))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Role]='Admin' OR [Role]='Tutor' OR [Role]='Student'))
GO
ALTER TABLE [dbo].[UserMethodStatistics]  WITH CHECK ADD CHECK  (([PeriodType]='Month' OR [PeriodType]='Week' OR [PeriodType]='Day'))
GO
USE [master]
GO
ALTER DATABASE [FocusLearnDB] SET  READ_WRITE 
GO
