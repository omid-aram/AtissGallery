USE [master]
GO
/****** Object:  Database [dbatiss]    Script Date: 08/10/1395 07:17:51 ب.ظ ******/
CREATE DATABASE [dbatiss]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbatiss', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbatiss_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbatiss] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbatiss].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbatiss] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbatiss] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbatiss] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbatiss] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbatiss] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbatiss] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbatiss] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbatiss] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbatiss] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbatiss] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbatiss] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbatiss] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbatiss] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbatiss] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbatiss] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbatiss] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbatiss] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbatiss] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbatiss] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbatiss] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbatiss] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbatiss] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbatiss] SET RECOVERY FULL 
GO
ALTER DATABASE [dbatiss] SET  MULTI_USER 
GO
ALTER DATABASE [dbatiss] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbatiss] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbatiss] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbatiss] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbatiss] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbatiss', N'ON'
GO
USE [dbatiss]
GO
/****** Object:  Table [dbo].[module_file]    Script Date: 08/10/1395 07:17:51 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[module_file](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [varchar](500) NOT NULL,
	[cover] [varchar](500) NOT NULL,
	[content_type] [varchar](50) NOT NULL,
	[length] [bigint] NOT NULL CONSTRAINT [DF_module_file_length]  DEFAULT ((0)),
	[upload_date] [datetime] NOT NULL CONSTRAINT [DF_module_file_upload_date]  DEFAULT (getdate()),
 CONSTRAINT [PK_module_file] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[module_media]    Script Date: 08/10/1395 07:17:51 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[module_media](
	[id] [int] NOT NULL,
	[type] [int] NOT NULL CONSTRAINT [DF_module_media_type]  DEFAULT ((0)),
 CONSTRAINT [PK_module_media] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[module_media_files]    Script Date: 08/10/1395 07:17:51 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[module_media_files](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[module_media_id] [int] NOT NULL,
	[module_file_id] [int] NOT NULL,
	[text_fa] [nvarchar](max) NULL,
	[text_en] [nvarchar](max) NULL,
	[text_position] [int] NOT NULL CONSTRAINT [DF_module_media_files_text_position]  DEFAULT ((0)),
	[text_width] [int] NOT NULL CONSTRAINT [DF_module_media_files_text_width]  DEFAULT ((50)),
	[view_order] [int] NOT NULL CONSTRAINT [DF_module_media_files_view_order]  DEFAULT ((1)),
	[back_color] [varchar](50) NULL,
 CONSTRAINT [PK_module_media_files] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[module_media_files]  WITH CHECK ADD  CONSTRAINT [FK_module_media_files_module_file] FOREIGN KEY([module_file_id])
REFERENCES [dbo].[module_file] ([id])
GO
ALTER TABLE [dbo].[module_media_files] CHECK CONSTRAINT [FK_module_media_files_module_file]
GO
ALTER TABLE [dbo].[module_media_files]  WITH CHECK ADD  CONSTRAINT [FK_module_media_files_module_media] FOREIGN KEY([module_media_id])
REFERENCES [dbo].[module_media] ([id])
GO
ALTER TABLE [dbo].[module_media_files] CHECK CONSTRAINT [FK_module_media_files_module_media]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: single, 1: slideshow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'module_media', @level2type=N'COLUMN',@level2name=N'type'
GO
USE [master]
GO
ALTER DATABASE [dbatiss] SET  READ_WRITE 
GO
