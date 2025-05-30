USE [dbatiss]
GO
ALTER TABLE [dbo].[product_medias] DROP CONSTRAINT [FK_product_medias_product]
GO
ALTER TABLE [dbo].[product_medias] DROP CONSTRAINT [FK_product_medias_media]
GO
ALTER TABLE [dbo].[product_label_values] DROP CONSTRAINT [FK_product_label_values_product]
GO
ALTER TABLE [dbo].[product_label_values] DROP CONSTRAINT [FK_product_label_values_label]
GO
ALTER TABLE [dbo].[page_modules] DROP CONSTRAINT [FK_page_modules_page]
GO
ALTER TABLE [dbo].[media_files] DROP CONSTRAINT [FK_media_files_media]
GO
ALTER TABLE [dbo].[media_files] DROP CONSTRAINT [FK_media_files_file]
GO
ALTER TABLE [dbo].[collection_products] DROP CONSTRAINT [FK_collection_products_product]
GO
ALTER TABLE [dbo].[collection_products] DROP CONSTRAINT [FK_collection_products_collection]
GO
ALTER TABLE [dbo].[collection] DROP CONSTRAINT [FK_collection_media]
GO
ALTER TABLE [dbo].[banner] DROP CONSTRAINT [FK_banner_module_type]
GO
/****** Object:  Table [dbo].[product_medias]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[product_medias]
GO
/****** Object:  Table [dbo].[product_label_values]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[product_label_values]
GO
/****** Object:  Table [dbo].[product]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[product]
GO
/****** Object:  Table [dbo].[page_modules]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[page_modules]
GO
/****** Object:  Table [dbo].[page]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[page]
GO
/****** Object:  Table [dbo].[module_type]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[module_type]
GO
/****** Object:  Table [dbo].[media_files]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[media_files]
GO
/****** Object:  Table [dbo].[media]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[media]
GO
/****** Object:  Table [dbo].[label]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[label]
GO
/****** Object:  Table [dbo].[file]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[file]
GO
/****** Object:  Table [dbo].[collection_products]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[collection_products]
GO
/****** Object:  Table [dbo].[collection]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[collection]
GO
/****** Object:  Table [dbo].[banner]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP TABLE [dbo].[banner]
GO
USE [master]
GO
/****** Object:  Database [dbatiss]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
DROP DATABASE [dbatiss]
GO
/****** Object:  Database [dbatiss]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
CREATE DATABASE [dbatiss]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbatiss', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbatiss_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
EXEC sys.sp_db_vardecimal_storage_format N'dbatiss', N'ON'
GO
USE [dbatiss]
GO
/****** Object:  Table [dbo].[banner]    Script Date: 22/10/1395 05:08:33 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[module_type_id] [int] NOT NULL,
	[first_media_id] [int] NULL,
	[second_media_id] [int] NULL,
 CONSTRAINT [PK_module] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[collection]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collection](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
	[header_media_id] [int] NOT NULL,
	[cover_media_id] [int] NOT NULL,
	[text_fa] [nvarchar](max) NOT NULL,
	[text_en] [nvarchar](max) NOT NULL,
	[idate] [datetime] NOT NULL CONSTRAINT [DF_collection_idate]  DEFAULT (getdate()),
 CONSTRAINT [PK_collection] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[collection_products]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collection_products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[collection_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
 CONSTRAINT [PK_collection_products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[file]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[file](
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
/****** Object:  Table [dbo].[label]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[label](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
	[view_order] [int] NOT NULL,
 CONSTRAINT [PK_label] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[media]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[media](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[in_date] [datetime] NOT NULL CONSTRAINT [DF_media_idate]  DEFAULT (getdate()),
	[user_id] [int] NULL,
 CONSTRAINT [PK_module_media] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[media_files]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[media_files](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[media_id] [int] NOT NULL,
	[file_id] [int] NOT NULL,
	[text_fa] [nvarchar](max) NULL,
	[text_en] [nvarchar](max) NULL,
	[text_position] [int] NOT NULL CONSTRAINT [DF_module_media_files_text_position]  DEFAULT ((0)),
	[text_width] [int] NOT NULL CONSTRAINT [DF_module_media_files_text_width]  DEFAULT ((50)),
	[view_order] [int] NOT NULL CONSTRAINT [DF_module_media_files_view_order]  DEFAULT ((1)),
	[back_color] [varchar](50) NULL,
	[href_link] [varchar](1000) NULL,
 CONSTRAINT [PK_module_media_files] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[module_type]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[module_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
	[filename] [varchar](50) NOT NULL,
 CONSTRAINT [PK_module_type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[page]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[page](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_page] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[page_modules]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[page_modules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[page_id] [int] NOT NULL,
	[module_id] [int] NOT NULL,
	[view_order] [int] NOT NULL CONSTRAINT [DF_page_modules_view_order]  DEFAULT ((0)),
	[module_type_id] [int] NOT NULL,
 CONSTRAINT [PK_page_modules] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](50) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
	[count] [int] NOT NULL,
	[price] [int] NOT NULL,
	[text_fa] [nvarchar](4000) NULL,
	[text_en] [nvarchar](4000) NULL,
	[idate] [datetime] NOT NULL CONSTRAINT [DF_product_idate]  DEFAULT (getdate()),
	[cover_media_id] [int] NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product_label_values]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_label_values](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[label_id] [int] NOT NULL,
	[value_fa] [nvarchar](100) NOT NULL,
	[value_en] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_product_label_values] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_medias]    Script Date: 22/10/1395 05:08:34 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_medias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[media_id] [int] NOT NULL,
	[view_order] [int] NOT NULL CONSTRAINT [DF_product_medias_view_order]  DEFAULT ((0)),
 CONSTRAINT [PK_product_medias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[banner] ON 

INSERT [dbo].[banner] ([id], [module_type_id], [first_media_id], [second_media_id]) VALUES (1, 1, 2019, -1)
INSERT [dbo].[banner] ([id], [module_type_id], [first_media_id], [second_media_id]) VALUES (2, 3, 1013, 1016)
INSERT [dbo].[banner] ([id], [module_type_id], [first_media_id], [second_media_id]) VALUES (3, 2, 1018, 1017)
INSERT [dbo].[banner] ([id], [module_type_id], [first_media_id], [second_media_id]) VALUES (4, 1, 2019, 1014)
INSERT [dbo].[banner] ([id], [module_type_id], [first_media_id], [second_media_id]) VALUES (5, 1, 3021, -1)
SET IDENTITY_INSERT [dbo].[banner] OFF
SET IDENTITY_INSERT [dbo].[collection] ON 

INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1, N'ماهی سیاه کوچولو', N'Little Black Fish', 1016, 1018, N'<p>ماهی سیاه کوچولو</p>', N'<p>Little Black Fish</p>', CAST(N'2016-12-31 14:20:20.433' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (2, N'sdfgsd ', N'sdfgsdf ', 1017, 1017, N'<p>dgsdf gsdfg sdfg</p>
<p>sd fgsd</p>', N'<p>sdfg sdfgsdfg</p>
<p>sd fgsdf</p>
<p>&nbsp;</p>', CAST(N'2017-01-01 01:36:34.450' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (4, N'حلقه', N'حلقه', 1017, 1017, N'<p>حلقه</p>', N'<p>حلقه</p>', CAST(N'2017-01-01 03:13:05.130' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (6, N'حلقه 2', N'حلقه', 1016, 1016, N'<p>حلقه</p>', N'<p>حلقه</p>', CAST(N'2017-01-01 03:20:40.610' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (7, N'انگشتری', N'انگشتری', 1014, 1016, N'<p>انگشتری</p>', N'<p>انگشتری</p>', CAST(N'2017-01-01 03:31:37.830' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1002, N'لاب', N'یب', 1009, 1009, N'<p>یبا</p>', N'<p>یب</p>', CAST(N'2017-01-08 21:15:52.730' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1003, N'ِبلس', N'ِبلس', 2022, 1013, N'ِبلس', N'ِبلس', CAST(N'2017-01-08 21:23:58.680' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1004, N'fgfh', N'fgfh', 2022, 2022, N'fgfh', N'fgfh', CAST(N'2017-01-08 21:26:44.100' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1006, N'fghf', N'fghf', 1013, 1013, N'fghf', N'fghf', CAST(N'2017-01-08 21:28:36.363' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1007, N'cvcv', N'cvcv', 1014, 2022, N'cvcv', N'cvcv', CAST(N'2017-01-08 21:33:15.587' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (1008, N'bnb', N'bnb', 1018, 1018, N'bnb', N'bnb', CAST(N'2017-01-08 21:55:51.750' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (2004, N'jh', N'jh', 3020, 3020, N'jh', N'jh', CAST(N'2017-01-09 19:26:35.430' AS DateTime))
INSERT [dbo].[collection] ([id], [name_fa], [name_en], [header_media_id], [cover_media_id], [text_fa], [text_en], [idate]) VALUES (3002, N'الماس', N'الماس', 4018, 2022, N'الماس', N'الماس', CAST(N'2017-01-11 03:51:54.703' AS DateTime))
SET IDENTITY_INSERT [dbo].[collection] OFF
SET IDENTITY_INSERT [dbo].[file] ON 

INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1161, N'/media/TSquareWire_1240x740.mp4', N'/media/cover/TSquareWire_1240x740.jpg', N'video/mp4', 2088907, CAST(N'2016-12-28 01:37:29.950' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1162, N'/media/yellowdiamond_1240x740.mp4', N'/media/cover/yellowdiamond_1240x740.jpg', N'video/mp4', 2543863, CAST(N'2016-12-28 01:41:52.953' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1163, N'/media/BlueBox_490x490.mp4', N'/media/cover/BlueBox_490x490.jpg', N'video/mp4', 3049885, CAST(N'2016-12-28 01:59:53.470' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1164, N'/media/tiffany-t-square-bracelet-33263449_937658_ED_M.jpg', N'/media/cover/tiffany-t-square-bracelet-33263449_937658_ED_M.jpg', N'image/jpeg', 29294, CAST(N'2016-12-28 02:07:03.937' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1165, N'/media/tiffany-t-smile-pendant-34684448_945590_ED.jpg', N'/media/cover/tiffany-t-smile-pendant-34684448_945590_ED.jpg', N'image/jpeg', 35182, CAST(N'2016-12-28 02:07:27.833' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1166, N'/media/tiffany-keys-tiffany-victoria-key-pendant-35200568_950492_ED.jpg', N'/media/cover/tiffany-keys-tiffany-victoria-key-pendant-35200568_950492_ED.jpg', N'image/jpeg', 29285, CAST(N'2016-12-28 02:08:06.850' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1167, N'/media/atlas-open-hinged-bangle-30480562_926301_ED_M.jpg', N'/media/cover/atlas-open-hinged-bangle-30480562_926301_ED_M.jpg', N'image/jpeg', 78932, CAST(N'2016-12-28 02:08:17.503' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1168, N'/media/victoria_490x490.mp4', N'/media/cover/victoria_490x490.jpg', N'video/mp4', 1684948, CAST(N'2016-12-28 12:40:06.913' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1169, N'/media/20161227_HP_Tile6_3x2Promo_INTL_Holiday_Campaign.jpg', N'/media/cover/20161227_HP_Tile6_3x2Promo_INTL_Holiday_Campaign.jpg', N'image/jpeg', 21424, CAST(N'2016-12-28 12:40:23.927' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1171, N'/media/HP_Phase3_Phase4_TCO_Loop_2_v2.mp4', N'/media/cover/HP_Phase3_Phase4_TCO_Loop_2_v2.jpg', N'video/mp4', 1338987, CAST(N'2016-12-29 11:47:08.010' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1172, N'/media/20161227_HP_Tile5_5x3Promo_INTL_Holiday_Campaign.jpg', N'/media/cover/20161227_HP_Tile5_5x3Promo_INTL_Holiday_Campaign.jpg', N'image/jpeg', 124393, CAST(N'2016-12-30 18:16:19.070' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1173, N'/media/HP_Phase2_TCO_Loop_4_v2.mp4', N'/media/cover/HP_Phase2_TCO_Loop_4_v2.jpg', N'video/mp4', 1600806, CAST(N'2017-01-01 04:31:54.707' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (2172, N'/media/shajarian-bastami-owj.mp4', N'/media/cover/shajarian-bastami-owj.jpg', N'video/mp4', 7174836, CAST(N'2017-01-04 20:24:33.553' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (2173, N'/media/11537131_10153365398619146_483064696_n.mp4', N'/media/cover/11537131_10153365398619146_483064696_n.jpg', N'video/mp4', 4905777, CAST(N'2017-01-07 23:29:33.313' AS DateTime))
INSERT [dbo].[file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (3173, N'/media/bd6fe5fcaac110f39235829eb441ee33.gif', N'/media/cover/bd6fe5fcaac110f39235829eb441ee33.gif', N'image/gif', 240184, CAST(N'2017-01-09 00:31:14.827' AS DateTime))
SET IDENTITY_INSERT [dbo].[file] OFF
SET IDENTITY_INSERT [dbo].[label] ON 

INSERT [dbo].[label] ([id], [name_fa], [name_en], [view_order]) VALUES (1, N'نوع محصول', N'Product Type', 0)
INSERT [dbo].[label] ([id], [name_fa], [name_en], [view_order]) VALUES (4, N'جنس', N'Material', 2)
INSERT [dbo].[label] ([id], [name_fa], [name_en], [view_order]) VALUES (5, N'حدود قیمت', N'Price Range', 1)
SET IDENTITY_INSERT [dbo].[label] OFF
SET IDENTITY_INSERT [dbo].[media] ON 

INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1009, CAST(N'2016-12-31 04:06:21.193' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1012, CAST(N'2016-12-31 05:02:18.163' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1013, CAST(N'2016-12-31 05:04:52.217' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1014, CAST(N'2016-12-31 09:43:39.950' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1016, CAST(N'2016-12-31 10:26:04.897' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1017, CAST(N'2016-12-31 10:27:45.537' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (1018, CAST(N'2017-01-01 03:30:48.167' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (2019, CAST(N'2017-01-07 23:36:52.457' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (2022, CAST(N'2017-01-07 23:54:30.130' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (3018, CAST(N'2017-01-08 19:58:34.133' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (3019, CAST(N'2017-01-09 00:29:17.313' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (3020, CAST(N'2017-01-09 00:31:18.423' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (3021, CAST(N'2017-01-09 00:32:12.210' AS DateTime), 1)
INSERT [dbo].[media] ([id], [in_date], [user_id]) VALUES (4018, CAST(N'2017-01-09 20:29:24.267' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[media] OFF
SET IDENTITY_INSERT [dbo].[media_files] ON 

INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (204, 1009, 1161, N'', N'', 0, 40, 0, N'#F4F4F4', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (235, 1012, 1165, N'<h1 style="text-align: center;">ALL THAT GLITTERS</h1>
<p style="text-align: center;">Sometimes superlative is the only answer.</p>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" href="http://international.tiffany.com/collections/tiffany-soleste?hppromo=THPC1033" target="_blank" rel="noopener noreferrer">BROWSE TIFFANY SOLESTE</a></p>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" title="کلیک کن" href="http://international.tiffany.com/jewelry/new-jewelry?hppromo=THPC1028" target="_blank" rel="noopener noreferrer">BROWSE ALL NEW JEWELRY</a></p>', N'', 4, 40, 0, N'', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (237, 1016, 1164, N'', N'', 0, 40, 0, N'#F4F4F4', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2206, 1013, 1166, N'', N'', 0, 40, 0, N'#F4F4F4', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2215, 1014, 1163, N'<h2 style="text-align: center;">&nbsp;</h2>
<h2 style="text-align: center;">WHAT IS IT ABOUT&nbsp;<br>THAT BLUE BOX?</h2>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase; text-align: center;" href="http://international.tiffany.com/holiday-gift-guide?hppromo=THPC1079">BROWSE THE GIFT GUIDE</a></p>', N'', 2, 90, 0, N'', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2222, 1017, 1169, N'', N'', 0, 40, 0, N'', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2224, 2022, 1168, N'', N'', 0, 40, 0, N'#F4F4F4', NULL)
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2227, 1018, 1167, N'', N'', 0, 40, 0, N'#F4F4F4', N'//yahoo.com')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3225, 3018, 2172, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3226, 3019, 1173, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3228, 3021, 1172, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4226, 3020, 3173, N'<p style="text-align: center;">با سلام و احترام</p>', N'', 8, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4228, 2019, 1161, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4229, 4018, 1162, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
SET IDENTITY_INSERT [dbo].[media_files] OFF
SET IDENTITY_INSERT [dbo].[module_type] ON 

INSERT [dbo].[module_type] ([id], [name_fa], [name_en], [filename]) VALUES (1, N'بنر تک', N'Banner Single', N'banner')
INSERT [dbo].[module_type] ([id], [name_fa], [name_en], [filename]) VALUES (2, N'بنر دوتایی - مربع اول', N'Banner Double - Square First', N'banner')
INSERT [dbo].[module_type] ([id], [name_fa], [name_en], [filename]) VALUES (3, N'بنر دوتایی - مربع دوم', N'Banner Double - Square Second', N'banner')
SET IDENTITY_INSERT [dbo].[module_type] OFF
SET IDENTITY_INSERT [dbo].[page] ON 

INSERT [dbo].[page] ([id], [name_fa], [name_en]) VALUES (1, N'گالری آتیس', N'Atiss Gallery')
INSERT [dbo].[page] ([id], [name_fa], [name_en]) VALUES (2, N'مجموعه ها', N'Collections')
INSERT [dbo].[page] ([id], [name_fa], [name_en]) VALUES (3, N'محصولات', N'Products')
SET IDENTITY_INSERT [dbo].[page] OFF
SET IDENTITY_INSERT [dbo].[page_modules] ON 

INSERT [dbo].[page_modules] ([id], [page_id], [module_id], [view_order], [module_type_id]) VALUES (2, 1, 1, 0, 1)
INSERT [dbo].[page_modules] ([id], [page_id], [module_id], [view_order], [module_type_id]) VALUES (3, 1, 2, 1, 2)
INSERT [dbo].[page_modules] ([id], [page_id], [module_id], [view_order], [module_type_id]) VALUES (4, 1, 3, 2, 3)
SET IDENTITY_INSERT [dbo].[page_modules] OFF
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2, N'0', N'محصول 4', N'محصول 3', 0, 630000, N'<p>محصول 2</p>', N'<p>محصول 2</p>', CAST(N'2017-01-01 04:40:35.580' AS DateTime), 1018)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (4, N'0', N'3424', N'2344', 211, 2342242, N'<p>2342</p>', N'<p>234</p>', CAST(N'2017-01-01 04:58:54.577' AS DateTime), 1016)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2003, N'0', N'یبیلب', N'یبیلب', 34, 3, N'یبیلب', N'یبیلب', CAST(N'2017-01-09 03:08:33.463' AS DateTime), 1014)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2008, N'M13', N'ستاره', N'star', 50, 250000, N'', N'', CAST(N'2017-01-11 01:02:13.790' AS DateTime), 2022)
SET IDENTITY_INSERT [dbo].[product] OFF
SET IDENTITY_INSERT [dbo].[product_label_values] ON 

INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (2, 2003, 1, N'آویز', N'آویز')
INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (4, 2, 1, N'سبس', N'سبس')
INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (5, 2, 5, N'نتانتان', N'نتانتان')
INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (6, 2, 4, N'نتانتنذد', N'نتانتنذد')
INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (9, 2008, 1, N'گوشواره', N'Earing')
INSERT [dbo].[product_label_values] ([id], [product_id], [label_id], [value_fa], [value_en]) VALUES (10, 2008, 4, N'پلاتینیوم', N'پلاتینیوم')
SET IDENTITY_INSERT [dbo].[product_label_values] OFF
SET IDENTITY_INSERT [dbo].[product_medias] ON 

INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (18, 2008, 1018, 0)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (19, 2008, 2022, 1)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (20, 2008, 3019, 2)
SET IDENTITY_INSERT [dbo].[product_medias] OFF
ALTER TABLE [dbo].[banner]  WITH CHECK ADD  CONSTRAINT [FK_banner_module_type] FOREIGN KEY([module_type_id])
REFERENCES [dbo].[module_type] ([id])
GO
ALTER TABLE [dbo].[banner] CHECK CONSTRAINT [FK_banner_module_type]
GO
ALTER TABLE [dbo].[collection]  WITH CHECK ADD  CONSTRAINT [FK_collection_media] FOREIGN KEY([header_media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[collection] CHECK CONSTRAINT [FK_collection_media]
GO
ALTER TABLE [dbo].[collection_products]  WITH CHECK ADD  CONSTRAINT [FK_collection_products_collection] FOREIGN KEY([collection_id])
REFERENCES [dbo].[collection] ([id])
GO
ALTER TABLE [dbo].[collection_products] CHECK CONSTRAINT [FK_collection_products_collection]
GO
ALTER TABLE [dbo].[collection_products]  WITH CHECK ADD  CONSTRAINT [FK_collection_products_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[collection_products] CHECK CONSTRAINT [FK_collection_products_product]
GO
ALTER TABLE [dbo].[media_files]  WITH CHECK ADD  CONSTRAINT [FK_media_files_file] FOREIGN KEY([file_id])
REFERENCES [dbo].[file] ([id])
GO
ALTER TABLE [dbo].[media_files] CHECK CONSTRAINT [FK_media_files_file]
GO
ALTER TABLE [dbo].[media_files]  WITH CHECK ADD  CONSTRAINT [FK_media_files_media] FOREIGN KEY([media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[media_files] CHECK CONSTRAINT [FK_media_files_media]
GO
ALTER TABLE [dbo].[page_modules]  WITH CHECK ADD  CONSTRAINT [FK_page_modules_page] FOREIGN KEY([page_id])
REFERENCES [dbo].[page] ([id])
GO
ALTER TABLE [dbo].[page_modules] CHECK CONSTRAINT [FK_page_modules_page]
GO
ALTER TABLE [dbo].[product_label_values]  WITH CHECK ADD  CONSTRAINT [FK_product_label_values_label] FOREIGN KEY([label_id])
REFERENCES [dbo].[label] ([id])
GO
ALTER TABLE [dbo].[product_label_values] CHECK CONSTRAINT [FK_product_label_values_label]
GO
ALTER TABLE [dbo].[product_label_values]  WITH CHECK ADD  CONSTRAINT [FK_product_label_values_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product_label_values] CHECK CONSTRAINT [FK_product_label_values_product]
GO
ALTER TABLE [dbo].[product_medias]  WITH CHECK ADD  CONSTRAINT [FK_product_medias_media] FOREIGN KEY([media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[product_medias] CHECK CONSTRAINT [FK_product_medias_media]
GO
ALTER TABLE [dbo].[product_medias]  WITH CHECK ADD  CONSTRAINT [FK_product_medias_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product_medias] CHECK CONSTRAINT [FK_product_medias_product]
GO
USE [master]
GO
ALTER DATABASE [dbatiss] SET  READ_WRITE 
GO
