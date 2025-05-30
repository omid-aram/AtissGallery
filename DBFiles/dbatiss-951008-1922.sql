USE [dbatiss]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'module_media', @level2type=N'COLUMN',@level2name=N'type'

GO
ALTER TABLE [dbo].[module_media_files] DROP CONSTRAINT [FK_module_media_files_module_media]
GO
ALTER TABLE [dbo].[module_media_files] DROP CONSTRAINT [FK_module_media_files_module_file]
GO
/****** Object:  Table [dbo].[module_media_files]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
DROP TABLE [dbo].[module_media_files]
GO
/****** Object:  Table [dbo].[module_media]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
DROP TABLE [dbo].[module_media]
GO
/****** Object:  Table [dbo].[module_file]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
DROP TABLE [dbo].[module_file]
GO
USE [master]
GO
/****** Object:  Database [dbatiss]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
DROP DATABASE [dbatiss]
GO
/****** Object:  Database [dbatiss]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
CREATE DATABASE [dbatiss]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbatiss', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbatiss_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\dbatiss_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[module_file]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
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
/****** Object:  Table [dbo].[module_media]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
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
/****** Object:  Table [dbo].[module_media_files]    Script Date: 08/10/1395 07:22:51 ب.ظ ******/
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
SET IDENTITY_INSERT [dbo].[module_file] ON 

INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1161, N'/media/TSquareWire_1240x740.mp4', N'/media/cover/TSquareWire_1240x740.jpg', N'video/mp4', 2088907, CAST(N'2016-12-28 01:37:29.950' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1162, N'/media/yellowdiamond_1240x740.mp4', N'/media/cover/yellowdiamond_1240x740.jpg', N'video/mp4', 2543863, CAST(N'2016-12-28 01:41:52.953' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1163, N'/media/BlueBox_490x490.mp4', N'/media/cover/BlueBox_490x490.jpg', N'video/mp4', 3049885, CAST(N'2016-12-28 01:59:53.470' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1164, N'/media/tiffany-t-square-bracelet-33263449_937658_ED_M.jpg', N'/media/cover/tiffany-t-square-bracelet-33263449_937658_ED_M.jpg', N'image/jpeg', 29294, CAST(N'2016-12-28 02:07:03.937' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1165, N'/media/tiffany-t-smile-pendant-34684448_945590_ED.jpg', N'/media/cover/tiffany-t-smile-pendant-34684448_945590_ED.jpg', N'image/jpeg', 35182, CAST(N'2016-12-28 02:07:27.833' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1166, N'/media/tiffany-keys-tiffany-victoria-key-pendant-35200568_950492_ED.jpg', N'/media/cover/tiffany-keys-tiffany-victoria-key-pendant-35200568_950492_ED.jpg', N'image/jpeg', 29285, CAST(N'2016-12-28 02:08:06.850' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1167, N'/media/atlas-open-hinged-bangle-30480562_926301_ED_M.jpg', N'/media/cover/atlas-open-hinged-bangle-30480562_926301_ED_M.jpg', N'image/jpeg', 78932, CAST(N'2016-12-28 02:08:17.503' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1168, N'/media/victoria_490x490.mp4', N'/media/cover/victoria_490x490.jpg', N'video/mp4', 1684948, CAST(N'2016-12-28 12:40:06.913' AS DateTime))
INSERT [dbo].[module_file] ([id], [address], [cover], [content_type], [length], [upload_date]) VALUES (1169, N'/media/20161227_HP_Tile6_3x2Promo_INTL_Holiday_Campaign.jpg', N'/media/cover/20161227_HP_Tile6_3x2Promo_INTL_Holiday_Campaign.jpg', N'image/jpeg', 21424, CAST(N'2016-12-28 12:40:23.927' AS DateTime))
SET IDENTITY_INSERT [dbo].[module_file] OFF
INSERT [dbo].[module_media] ([id], [type]) VALUES (1001, 0)
INSERT [dbo].[module_media] ([id], [type]) VALUES (1002, 0)
INSERT [dbo].[module_media] ([id], [type]) VALUES (1003, 0)
INSERT [dbo].[module_media] ([id], [type]) VALUES (1004, 0)
INSERT [dbo].[module_media] ([id], [type]) VALUES (1005, 0)
SET IDENTITY_INSERT [dbo].[module_media_files] ON 

INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (151, 1003, 1163, N'<h2 style="text-align: center;">&nbsp;</h2>
<h2 style="text-align: center;">WHAT IS IT ABOUT&nbsp;<br>THAT BLUE BOX?</h2>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase; text-align: center;" href="http://international.tiffany.com/holiday-gift-guide?hppromo=THPC1079">BROWSE THE GIFT GUIDE</a></p>', N'<h2 style="text-align: center;">&nbsp;</h2>
<h2 style="text-align: center;">WHAT IS IT ABOUT&nbsp;<br>THAT BLUE BOX?</h2>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase; text-align: center;" href="http://international.tiffany.com/holiday-gift-guide?hppromo=THPC1079">BROWSE THE GIFT GUIDE</a></p>', 2, 90, 0, NULL)
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (188, 1001, 1162, N'<h1 style="text-align: center;">ALL THAT GLITTERS</h1>
<p style="text-align: center;">Sometimes superlative is the only answer.</p>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" href="http://international.tiffany.com/collections/tiffany-soleste?hppromo=THPC1033" target="_blank" rel="noopener noreferrer">BROWSE TIFFANY SOLESTE</a></p>
<hr style="margin: 20px auto 5px; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="text-align: center;"><a class="l6" style="border: 0px; margin: 0px; padding: 0px; color: #000000; text-decoration: none; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" title="کلیک کن" href="http://international.tiffany.com/jewelry/new-jewelry?hppromo=THPC1028" target="_blank" rel="noopener noreferrer">BROWSE ALL NEW JEWELRY</a></p>
<p style="text-align: left;">&nbsp;</p>', N'<h1 style="margin: 0.67em 0px; padding: 0px; box-sizing: border-box; font-family: Arial, sans-serif; text-align: center;">ALL THAT GLITTERS</h1>
<p style="margin: 0px; padding: 0px; box-sizing: border-box; font-family: Arial, sans-serif; font-size: 13.3333px; text-align: center;">Sometimes superlative is the only answer.</p>
<hr style="margin: 20px auto 5px; padding: 0px; box-sizing: content-box; overflow: visible; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="margin: 0px; padding: 0px; box-sizing: border-box; font-family: Arial, sans-serif; font-size: 13.3333px; text-align: center;"><a class="l6" style="margin: 0px; padding: 0px; box-sizing: border-box; text-decoration: none; background-color: transparent; color: #000000; border: 0px; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" href="http://international.tiffany.com/collections/tiffany-soleste?hppromo=THPC1033" target="_blank" rel="noopener noreferrer">BROWSE TIFFANY SOLESTE</a></p>
<hr style="margin: 20px auto 5px; padding: 0px; box-sizing: content-box; overflow: visible; border: 0px; color: #333333; background-color: #333333; width: 60px; font-family: ''Sterling SSm A'', ''Sterling SSm B'', serif; font-size: 12px; text-align: center; height: 0px !important;">
<p style="margin: 0px; padding: 0px; box-sizing: border-box; font-family: Arial, sans-serif; font-size: 13.3333px; text-align: center;"><a class="l6" style="margin: 0px; padding: 0px; box-sizing: border-box; text-decoration: none; background-color: transparent; color: #000000; border: 0px; outline: 0px; transition: color 0.2s ease-in-out; font-size: 11px; letter-spacing: 0.75px; line-height: 14px; font-family: AvenirNextMedium, Arial, sans-serif; text-transform: uppercase;" href="http://international.tiffany.com/jewelry/new-jewelry?hppromo=THPC1028" target="_blank" rel="noopener noreferrer">BROWSE ALL NEW JEWELRY</a></p>', 6, 40, 0, N'')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (189, 1004, 1168, N'', N'', 0, 50, 0, N'')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (190, 1005, 1169, N'', N'', 0, 50, 0, N'')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (195, 1002, 1164, N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a></p>', N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', 4, 30, 0, N'#FAFAFA')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (196, 1002, 1165, N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', 4, 30, 1, N'#FAFAFA')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (197, 1002, 1166, N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', 4, 30, 2, N'#FAFAFA')
INSERT [dbo].[module_media_files] ([id], [module_media_id], [module_file_id], [text_fa], [text_en], [text_position], [text_width], [view_order], [back_color]) VALUES (198, 1002, 1167, N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', N'<p><img width="50" style="margin-right: auto; margin-left: auto; display: block;" src="http://international.tiffany.com/shared/Images/icons/drop_a_hint_filled.svg"></p>
<div style="text-align: center;">DROP A HINT</div>
<div style="text-align: center;">Send a little nudge to the ones you love and get just what you’re wishing for.</div>
<p style="text-align: center;"><a id="dropAHint0" href="http://international.tiffany.com/Customer/Request/EmailDropAHint.aspx?itemImage=33263449_937658_ED_M&amp;type=Gen&amp;url=/EmailRequest.aspx?sku=GRP07787%26selectedsku=33263449%26source=item%26search_params=s+5-p+1-c+612510-r+-x+-n+36-ri+-ni+1-lr+0-hr+-1-t+-mi+%26lstsku=GRP07787:33263449&amp;hppromo=THPC1040&amp;tracksource=hp" data-size="wide" data-iframe="true">DROP A HINT</a><br><a href="http://international.tiffany.com/jewelry/bracelets/tiffany-t-square-bracelet-GRP07787">BROWSE</a><u></u></p>', 4, 30, 3, N'#FAFAFA')
SET IDENTITY_INSERT [dbo].[module_media_files] OFF
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
