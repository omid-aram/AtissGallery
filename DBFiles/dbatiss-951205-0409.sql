USE [dbatiss]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu', @level2type=N'COLUMN',@level2name=N'menu_type'

GO
ALTER TABLE [dbo].[purchase] DROP CONSTRAINT [FK_purchase_product]
GO
ALTER TABLE [dbo].[product_medias] DROP CONSTRAINT [FK_product_medias_product]
GO
ALTER TABLE [dbo].[product_medias] DROP CONSTRAINT [FK_product_medias_media]
GO
ALTER TABLE [dbo].[product_labels] DROP CONSTRAINT [FK_product_label_values_product]
GO
ALTER TABLE [dbo].[product_labels] DROP CONSTRAINT [FK_product_label_values_label]
GO
ALTER TABLE [dbo].[product] DROP CONSTRAINT [FK_product_media]
GO
ALTER TABLE [dbo].[menu] DROP CONSTRAINT [FK_menu_menu]
GO
ALTER TABLE [dbo].[menu] DROP CONSTRAINT [FK_menu_media]
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
ALTER TABLE [dbo].[banner] DROP CONSTRAINT [FK_banner_page]
GO
ALTER TABLE [dbo].[banner] DROP CONSTRAINT [FK_banner_media_third]
GO
ALTER TABLE [dbo].[banner] DROP CONSTRAINT [FK_banner_media_second]
GO
ALTER TABLE [dbo].[banner] DROP CONSTRAINT [FK_banner_media]
GO
/****** Object:  Index [IX_label_keycode]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP INDEX [IX_label_keycode] ON [dbo].[label]
GO
/****** Object:  Table [dbo].[user]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[user]
GO
/****** Object:  Table [dbo].[purchase]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[purchase]
GO
/****** Object:  Table [dbo].[product_medias]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[product_medias]
GO
/****** Object:  Table [dbo].[product_labels]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[product_labels]
GO
/****** Object:  Table [dbo].[product]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[product]
GO
/****** Object:  Table [dbo].[page]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[page]
GO
/****** Object:  Table [dbo].[menu]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[menu]
GO
/****** Object:  Table [dbo].[media_files]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[media_files]
GO
/****** Object:  Table [dbo].[media]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[media]
GO
/****** Object:  Table [dbo].[label]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[label]
GO
/****** Object:  Table [dbo].[file]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[file]
GO
/****** Object:  Table [dbo].[collection_products]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[collection_products]
GO
/****** Object:  Table [dbo].[collection]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[collection]
GO
/****** Object:  Table [dbo].[captcha]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[captcha]
GO
/****** Object:  Table [dbo].[banner]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP TABLE [dbo].[banner]
GO
USE [master]
GO
/****** Object:  Database [dbatiss]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
DROP DATABASE [dbatiss]
GO
/****** Object:  Database [dbatiss]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
CREATE DATABASE [dbatiss]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbatiss', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbatiss_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss_log.ldf' , SIZE = 4672KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[banner]    Script Date: 05/12/1395 04:10:09 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[banner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[banner_type_id] [int] NOT NULL,
	[first_media_id] [int] NULL,
	[first_link] [varchar](1000) NULL,
	[second_media_id] [int] NULL,
	[second_link] [varchar](1000) NULL,
	[third_media_id] [int] NULL,
	[third_link] [varchar](1000) NULL,
	[page_id] [int] NOT NULL,
	[view_order] [int] NOT NULL CONSTRAINT [DF_banner_view_order]  DEFAULT ((0)),
	[enabled] [bit] NOT NULL CONSTRAINT [DF_banner_enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_module] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[captcha]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[captcha](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[text] [varchar](50) NOT NULL,
	[idate] [datetime] NOT NULL CONSTRAINT [DF_captcha_idate]  DEFAULT (getdate()),
 CONSTRAINT [PK_captcha] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[collection]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[collection_products]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[file]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[label]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[label](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[keycode] [varchar](50) NOT NULL,
	[name_fa] [nvarchar](50) NOT NULL,
	[name_en] [nvarchar](50) NOT NULL,
	[view_order] [int] NOT NULL,
	[master_keycode] [varchar](50) NULL,
	[page_id] [int] NULL,
 CONSTRAINT [PK_label] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[media]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[media_files]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[menu]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[menu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title_fa] [nvarchar](100) NOT NULL,
	[title_en] [nvarchar](100) NOT NULL,
	[subtitle_fa] [nvarchar](200) NULL,
	[subtitle_en] [nvarchar](200) NULL,
	[address] [varchar](1000) NOT NULL,
	[menu_type] [int] NOT NULL CONSTRAINT [DF_menu_menu_type]  DEFAULT ((1)),
	[view_order] [int] NOT NULL CONSTRAINT [DF_menu_view_order]  DEFAULT ((0)),
	[col_no] [int] NOT NULL CONSTRAINT [DF_menu_col_no]  DEFAULT ((1)),
	[media_id] [int] NULL,
	[enabled] [bit] NOT NULL CONSTRAINT [DF_menu_enabled]  DEFAULT ((1)),
	[parent_id] [int] NULL,
 CONSTRAINT [PK_menu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[page]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[page](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[keycode] [varchar](50) NULL,
 CONSTRAINT [PK_page] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[product_labels]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_labels](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[label_id] [int] NOT NULL,
 CONSTRAINT [PK_product_label_values] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_medias]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
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
/****** Object:  Table [dbo].[purchase]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[purchase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[customer_name] [nvarchar](50) NOT NULL,
	[customer_phone] [varchar](50) NOT NULL,
	[customer_email] [varchar](100) NULL,
	[customer_address] [nvarchar](500) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[idate] [datetime] NOT NULL CONSTRAINT [DF_purchase_idate]  DEFAULT (getdate()),
 CONSTRAINT [PK_purchase] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[enabled] [bit] NOT NULL CONSTRAINT [DF_user_enabled]  DEFAULT ((1)),
	[last_seen] [datetime] NOT NULL CONSTRAINT [DF_Table_1_last_login]  DEFAULT (getdate()),
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[banner] ON 

INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (2, 23, 1013, NULL, 2022, NULL, NULL, NULL, 1, 1, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (4, 11, 2019, N'home/', 1014, NULL, NULL, NULL, 2, 0, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (5, 11, 3021, NULL, NULL, NULL, NULL, NULL, 3, 0, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1009, 11, 3019, NULL, NULL, NULL, NULL, NULL, 1, 0, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1010, 21, 3021, NULL, 1017, NULL, NULL, NULL, 1, 2, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1012, 33, 1018, NULL, 1016, NULL, 1013, NULL, 1, 3, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1016, 33, 1014, N'http://bing.com', 2022, N'products/collection/paeizan2', 1016, N'products/collection/paeizan', 2, 1, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1017, 11, 3019, NULL, NULL, NULL, NULL, NULL, 1003, 0, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1018, 22, 1018, NULL, 1016, NULL, NULL, NULL, 1003, 1, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1019, 11, 3021, NULL, NULL, NULL, NULL, NULL, 1004, 0, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1020, 22, 3020, NULL, 2022, NULL, NULL, NULL, 1004, 1, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1021, 22, 1018, NULL, 1017, NULL, NULL, NULL, 1004, 2, 1)
INSERT [dbo].[banner] ([id], [banner_type_id], [first_media_id], [first_link], [second_media_id], [second_link], [third_media_id], [third_link], [page_id], [view_order], [enabled]) VALUES (1023, 11, 3020, NULL, NULL, NULL, NULL, NULL, 1005, 0, 1)
SET IDENTITY_INSERT [dbo].[banner] OFF
SET IDENTITY_INSERT [dbo].[captcha] ON 

INSERT [dbo].[captcha] ([id], [text], [idate]) VALUES (1, N'9w41xe', CAST(N'2017-02-22 20:19:46.610' AS DateTime))
INSERT [dbo].[captcha] ([id], [text], [idate]) VALUES (2, N'iqpkfm', CAST(N'2017-02-22 20:20:30.083' AS DateTime))
INSERT [dbo].[captcha] ([id], [text], [idate]) VALUES (3, N'rc8nph', CAST(N'2017-02-22 20:58:47.757' AS DateTime))
INSERT [dbo].[captcha] ([id], [text], [idate]) VALUES (4, N'm62i2e', CAST(N'2017-02-22 21:20:26.050' AS DateTime))
INSERT [dbo].[captcha] ([id], [text], [idate]) VALUES (5, N'r3p4vm', CAST(N'2017-02-22 21:24:40.130' AS DateTime))
SET IDENTITY_INSERT [dbo].[captcha] OFF
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

INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1, N'collection', N'کلکسیون', N'Collection', 0, NULL, NULL)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (4, N'material', N'جنس', N'Material', 2, NULL, NULL)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (5, N'category', N'دسته بندی', N'Category', 1, NULL, NULL)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1006, N'style', N'سبک', N'Style', 3, NULL, NULL)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1007, N'gold', N'طلا', N'Gold2', 4, N'material', 3011)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1008, N'silver', N'نقره', N'Silver', 5, N'material', 3012)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1009, N'men', N'مردانه', N'Men', 6, N'style', 3013)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1010, N'women', N'زنانه', N'Women', 7, N'style', 3014)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1011, N'rings', N'حلقه', N'Rings', 9, N'category', 3016)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1012, N'earrings', N'گوشواره', N'Earrings', 8, N'category', 3015)
INSERT [dbo].[label] ([id], [keycode], [name_fa], [name_en], [view_order], [master_keycode], [page_id]) VALUES (1014, N'paeizan', N'پاییزان', N'Paeizan', 10, N'collection', 3017)
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
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (2227, 1018, 1167, N'', N'', 0, 40, 0, N'#F4F4F4', N'//yahoo.com')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3225, 3018, 2172, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3226, 3019, 1173, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (3228, 3021, 1172, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4226, 3020, 3173, N'<p style="text-align: center;">با سلام و احترام</p>', N'', 8, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4228, 2019, 1161, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (4229, 4018, 1162, N'', N'', 0, 40, 0, N'#F4F4F4', N'')
INSERT [dbo].[media_files] ([id], [media_id], [file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color], [href_link]) VALUES (5225, 2022, 1168, N'', N'', 0, 40, 0, N'#F4F4F4', N'products/collection/e2')
SET IDENTITY_INSERT [dbo].[media_files] OFF
SET IDENTITY_INSERT [dbo].[menu] ON 

INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (1, N'فر گالری', N'Far Gallery', N'بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری دنیا بهترین گالری ', N'The best gallery in the world', N'home/', 1, 0, 1, 4018, 1, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (2, N'مجموعه ها', N'Collections', N'', N'', N'collections/', 1, 1, 1, 2019, 1, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (4, N'مجموعه پاییزان', N'Paeizan Collection', N'', N'', N'products/collection/paeizan', 1, 0, 1, NULL, 1, 2)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (6, N'تست 1', N'test1', N'', N'', N'/', 1, 0, 1, NULL, 1, 1)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (7, N'تست 2', N'test2', N'', N'', N'/', 1, 1, 1, NULL, 1, 1)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (10, N'تست 1-2', N'test 1-2', N'', N'', N'/', 1, 1, 1, NULL, 1, 6)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (12, N'تست 1-1', N'test 1-1', N'', N'', N'/', 1, 0, 1, 1017, 1, 6)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (13, N'تست 1-3', N'test 1-3', N'', N'', N'', 1, 2, 1, 1014, 1, 6)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (14, N'تست 1-4', N'test 1-4', N'', N'', N'', 1, 3, 1, NULL, 1, 6)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (15, N'برگ ریزان 2', N'برگ ریزان', N'', N'', N'products/collection/paeizan2', 1, 1, 1, NULL, 1, 2)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (19, N'لینک اول', N'First Link', NULL, NULL, N'/first', 2, 0, 1, NULL, 1, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (21, N'لینک دوم', N'لینک دوم', NULL, NULL, N'', 2, 1, 1, NULL, 1, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (22, N'لینک سوم', N'Third Link', NULL, NULL, N'', 2, 2, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (23, N'محصولات', N'Products', N'', N'', N'products/', 1, 2, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (26, N'بلاگ', N'Blog', N'', N'', N'blog/', 1, 4, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (28, N'پست اول', N'پست اول', NULL, NULL, N'', 1, 1, 1, NULL, 0, 26)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (29, N'پست دوم', N'پست دوم', NULL, NULL, N'', 1, 0, 1, NULL, 0, 26)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (30, N'design/facebook.png', N'design/facebook.png', NULL, NULL, N'', 3, 0, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (31, N'درباره ما', N'About Us', N'', N'', N'about/', 1, 5, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (32, N'لینک اول - 1', N'لینک اول - 1', NULL, NULL, N'', 2, 0, 1, NULL, 0, 19)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (33, N'design/instagram.png', N'design/instagram.png', NULL, NULL, N'', 3, 1, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (34, N'design/pinterest.png', N'design/pinterest.png', NULL, NULL, N'', 3, 2, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (35, N'design/telegram.png', N'design/telegram.png', NULL, NULL, N'', 3, 3, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (36, N'design/whatsapp.png', N'design/whatsapp.png', NULL, NULL, N'', 3, 4, 1, NULL, 0, NULL)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (37, N'زنانه', N'women', N'', N'', N'products/style/women', 1, 0, 1, NULL, 0, 23)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (38, N'-', N'-', N'', N'', N'', 1, 1, 1, NULL, 0, 23)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (39, N'-', N'-', N'', N'', N'', 1, 2, 1, NULL, 0, 23)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (40, N'-', N'-', N'', N'', N'', 1, 3, 1, NULL, 0, 23)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (41, N'-', N'-', N'', N'', N'', 1, 4, 1, NULL, 0, 23)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (43, N'تست 1-5', N'تست 1-5', N'توضیحات 1-5', N'توضیحات 1-5', N'', 1, 4, 3, 2019, 0, 6)
INSERT [dbo].[menu] ([id], [title_fa], [title_en], [subtitle_fa], [subtitle_en], [address], [menu_type], [view_order], [col_no], [media_id], [enabled], [parent_id]) VALUES (47, N'کتاب فصل', N'Season Book', N'', N'', N'books/', 1, 3, 1, NULL, 0, NULL)
SET IDENTITY_INSERT [dbo].[menu] OFF
SET IDENTITY_INSERT [dbo].[page] ON 

INSERT [dbo].[page] ([id], [keycode]) VALUES (1, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (2, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (3, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (1003, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (1004, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (1005, NULL)
INSERT [dbo].[page] ([id], [keycode]) VALUES (3011, N'gold')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3012, N'silver')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3013, N'men')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3014, N'women')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3015, N'earrings')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3016, N'rings')
INSERT [dbo].[page] ([id], [keycode]) VALUES (3017, N'paeizan')
SET IDENTITY_INSERT [dbo].[page] OFF
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2, N'0', N'نام محصول', N'Product Name', 0, 630000, N'<p>محصول 2</p>', N'<p>محصول 2</p>', CAST(N'2017-01-01 04:40:35.580' AS DateTime), 1018)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (4, N'0', N'نام محصول', N'Product Name', 211, 2342242, N'<p>2342</p>', N'<p>234</p>', CAST(N'2017-01-01 04:58:54.577' AS DateTime), 1016)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2003, N'M15', N'نام محصول', N'Product Name', 34, 3, N'<p>سیوئبسوییبشسی</p>
<p>بش سیب</p>
<p>شسی ب</p>
<p>شس یب</p>
<p>&nbsp;شسی</p>
<p>ب شسی</p>
<p>بشس&nbsp;</p>
<p>ب&nbsp;</p>
<p>شسیب</p>
<p>&nbsp;شسیبسشیبشسیبشس بشسیب شسیبشسیب سینمب تسمبتیم</p>
<p>شس بشسی تبستیب تمسینبتس مس</p>
<p>ش ل مینتسمبن</p>', N'یبیلب', CAST(N'2017-01-09 03:08:33.463' AS DateTime), 1014)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2008, N'M13', N'نام محصول', N'Product Name', 50, 250000, N'<p>ینمسبیمب4 نتن &nbsp;nhj j hj</p>
<p>&nbsp;</p>', N'', CAST(N'2017-01-11 01:02:13.790' AS DateTime), 2022)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2009, N'M21', N'نام محصول', N'Product Name', 20000, 30, N'', N'', CAST(N'2017-01-29 05:13:38.643' AS DateTime), 2019)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2010, N'1214', N'نام محصول', N'Product Name', 30000, 0, N'', N'', CAST(N'2017-02-14 12:14:19.560' AS DateTime), 1013)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (2011, N'1229', N'نام محصول', N'Product Name', 0, 0, N'', N'', CAST(N'2017-02-14 12:29:50.040' AS DateTime), 2022)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (3010, N'AB-2', N'نام محصول', N'Product Name', 0, 0, N'', N'', CAST(N'2017-02-21 02:02:04.693' AS DateTime), 1012)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (3011, N'AB-3', N'نام محصول', N'Product Name', 0, 0, N'', N'', CAST(N'2017-02-21 02:12:11.937' AS DateTime), 4018)
INSERT [dbo].[product] ([id], [code], [name_fa], [name_en], [count], [price], [text_fa], [text_en], [idate], [cover_media_id]) VALUES (3013, N'AB-5', N'نام محصول', N'Product Name', 0, 0, N'', N'', CAST(N'2017-02-21 02:15:50.383' AS DateTime), 3021)
SET IDENTITY_INSERT [dbo].[product] OFF
SET IDENTITY_INSERT [dbo].[product_labels] ON 

INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (2053, 2, 1007)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (2054, 4, 1008)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3046, 2010, 1008)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3047, 2009, 1007)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3048, 2008, 1008)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3049, 2008, 1010)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3050, 2008, 1014)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3051, 2003, 1007)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3052, 2003, 1012)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3053, 2003, 1011)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (3054, 2011, 1008)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (4046, 3010, 1008)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (4047, 3011, 1007)
INSERT [dbo].[product_labels] ([id], [product_id], [label_id]) VALUES (4050, 3013, 1008)
SET IDENTITY_INSERT [dbo].[product_labels] OFF
SET IDENTITY_INSERT [dbo].[product_medias] ON 

INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (1057, 2, 1016, 0)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (2057, 2010, 1013, 0)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (2058, 2008, 1018, 0)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (2059, 2008, 2022, 1)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (2060, 2008, 3019, 2)
INSERT [dbo].[product_medias] ([id], [product_id], [media_id], [view_order]) VALUES (3057, 3010, 1013, 0)
SET IDENTITY_INSERT [dbo].[product_medias] OFF
SET IDENTITY_INSERT [dbo].[purchase] ON 

INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (1, 2008, N'امید خوش نیت', N'09124946108', NULL, N'تهران - کوچه اول', NULL, CAST(N'2017-02-14 10:13:23.460' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (2, 4, N'امید آرام', N'09124946108', N'khoshniat@gmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:21:15.227' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (3, 4, N'امید آرام', N'09124946108', N'omid.aram@hotmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:24:20.573' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (4, 4, N'امید آرام', N'09124946108', N'omid.aram@hotmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:24:51.433' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (7, 4, N'امید آرام', N'09124946108', N'omid.aram@hotmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:39:29.843' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (8, 4, N'امید آرام', N'09124946108', N'omid.aram@hotmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:39:33.940' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (9, 4, N'امید آرام', N'09124946108', N'omid.aram@hotmail.com', N'شسیبسیس', NULL, CAST(N'2017-02-23 02:39:33.983' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (10, 4, N'omid', N'09124946108', N'omid.aram@hotmail.com', N'dsadf', NULL, CAST(N'2017-02-23 02:40:13.490' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (11, 4, N'omid', N'09124946108', N'khoshniat@gmail.com', N'dsadf', NULL, CAST(N'2017-02-23 02:42:37.893' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (12, 4, N'gh', N'gh', N'omid978@yahoo.com', N'sdfs', NULL, CAST(N'2017-02-23 03:02:25.070' AS DateTime))
INSERT [dbo].[purchase] ([id], [product_id], [customer_name], [customer_phone], [customer_email], [customer_address], [description], [idate]) VALUES (14, 4, N'gh', N'gh', N'omid978@yahoo.com', N'sdfs', NULL, CAST(N'2017-02-23 03:18:58.480' AS DateTime))
SET IDENTITY_INSERT [dbo].[purchase] OFF
INSERT [dbo].[user] ([id], [username], [password], [fullname], [enabled], [last_seen]) VALUES (1, N'admin', N'2357096e7756bee1ef922b387311cacc', N'مدیر سیستم', 1, CAST(N'2017-02-22 21:25:07.910' AS DateTime))
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_label_keycode]    Script Date: 05/12/1395 04:10:10 ق.ظ ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_label_keycode] ON [dbo].[label]
(
	[keycode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[banner]  WITH CHECK ADD  CONSTRAINT [FK_banner_media] FOREIGN KEY([first_media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[banner] CHECK CONSTRAINT [FK_banner_media]
GO
ALTER TABLE [dbo].[banner]  WITH NOCHECK ADD  CONSTRAINT [FK_banner_media_second] FOREIGN KEY([second_media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[banner] CHECK CONSTRAINT [FK_banner_media_second]
GO
ALTER TABLE [dbo].[banner]  WITH CHECK ADD  CONSTRAINT [FK_banner_media_third] FOREIGN KEY([third_media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[banner] CHECK CONSTRAINT [FK_banner_media_third]
GO
ALTER TABLE [dbo].[banner]  WITH CHECK ADD  CONSTRAINT [FK_banner_page] FOREIGN KEY([page_id])
REFERENCES [dbo].[page] ([id])
GO
ALTER TABLE [dbo].[banner] CHECK CONSTRAINT [FK_banner_page]
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
ALTER TABLE [dbo].[menu]  WITH CHECK ADD  CONSTRAINT [FK_menu_media] FOREIGN KEY([media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[menu] CHECK CONSTRAINT [FK_menu_media]
GO
ALTER TABLE [dbo].[menu]  WITH CHECK ADD  CONSTRAINT [FK_menu_menu] FOREIGN KEY([parent_id])
REFERENCES [dbo].[menu] ([id])
GO
ALTER TABLE [dbo].[menu] CHECK CONSTRAINT [FK_menu_menu]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_media] FOREIGN KEY([cover_media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_media]
GO
ALTER TABLE [dbo].[product_labels]  WITH CHECK ADD  CONSTRAINT [FK_product_label_values_label] FOREIGN KEY([label_id])
REFERENCES [dbo].[label] ([id])
GO
ALTER TABLE [dbo].[product_labels] CHECK CONSTRAINT [FK_product_label_values_label]
GO
ALTER TABLE [dbo].[product_labels]  WITH CHECK ADD  CONSTRAINT [FK_product_label_values_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product_labels] CHECK CONSTRAINT [FK_product_label_values_product]
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
ALTER TABLE [dbo].[purchase]  WITH CHECK ADD  CONSTRAINT [FK_purchase_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[purchase] CHECK CONSTRAINT [FK_purchase_product]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: Main Menus, 2: Links, 3: Social Networks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu', @level2type=N'COLUMN',@level2name=N'menu_type'
GO
USE [master]
GO
ALTER DATABASE [dbatiss] SET  READ_WRITE 
GO
