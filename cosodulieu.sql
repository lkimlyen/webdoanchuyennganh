USE [master]
GO
/****** Object:  Database [database]    Script Date: 30/10/2016 15:42:15 ******/
CREATE DATABASE [database]
GO
ALTER DATABASE [database] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [database].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [database] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [database] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [database] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [database] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [database] SET ARITHABORT OFF 
GO
ALTER DATABASE [database] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [database] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [database] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [database] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [database] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [database] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [database] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [database] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [database] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [database] SET  ENABLE_BROKER 
GO
ALTER DATABASE [database] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [database] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [database] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [database] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [database] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [database] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [database] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [database] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [database] SET  MULTI_USER 
GO
ALTER DATABASE [database] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [database] SET DB_CHAINING OFF 
GO
USE [database]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idshop] [varchar](10) NULL,
	[name] [nvarchar](255) NULL,
	[birthday] [datetime] NULL,
	[sex] [bit] NULL,
	[idcard] [varchar](9) NULL,
	[image] [varchar](255) NULL,
	[email] [varchar](255) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[address] [nvarchar](255) NULL,
	[moblie] [varchar](20) NULL,
	[date_added] [datetime] NULL,
	[last_modified] [datetime] NULL,
	[status] [bit] NULL,
	[note] [nvarchar](255) NULL,
	[randomkey] [varchar](20) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[iddh] [int] NULL,
	[idsp] [int] NULL,
	[soluong] [int] NULL,
	[dongia] [decimal](18, 0) NULL,
	[thanhtien] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idshop] [varchar](10) NULL,
	[price] [decimal](18, 0) NULL,
	[idkh] [int] NULL,
	[phonenumber] [varchar](20) NULL,
	[thoidiemdathang] [datetime] NULL,
	[tennguoinhan] [nvarchar](255) NULL,
	[diachi] [nvarchar](255) NULL,
	[gmail] [varchar](255) NULL,
	[status] [bit] NULL,
	[state] [nvarchar](255) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_admin]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_admin](
	[Username] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Priority] [int] NOT NULL,
 CONSTRAINT [PK_tbl_admin] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_header]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_header](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[image] [nvarchar](255) NULL,
	[phone1] [varchar](50) NULL,
	[tittle] [nvarchar](255) NULL,
	[phone2] [varchar](50) NULL,
	[shortcuticon] [varchar](255) NULL,
 CONSTRAINT [PK_tbl_header] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_information]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_information](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TenTT] [nvarchar](255) NOT NULL,
	[NoiDung] [nvarchar](max) NULL,
	[Status] [bit] NULL,
	[GioiThieu] [bit] NULL,
	[alias] [varchar](255) NULL,
 CONSTRAINT [PK_tbl_information] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TenMenu] [nvarchar](255) NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[ThuTu] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_menu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_menubottom]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_menubottom](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tenmenu] [nvarchar](255) NOT NULL,
	[url] [varchar](255) NOT NULL,
	[thutu] [int] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_menubottom] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_news]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_news](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](255) NOT NULL,
	[TomTat] [nvarchar](max) NOT NULL,
	[UrlHinh] [nvarchar](255) NOT NULL,
	[NoiDung] [nvarchar](max) NOT NULL,
	[LuotXem] [int] NULL CONSTRAINT [DF_tbl_news_LuotXem]  DEFAULT ((0)),
	[NgayCapNhat] [datetime] NULL,
	[status] [bit] NOT NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[keyword] [nvarchar](255) NULL,
	[alias] [varchar](255) NULL,
 CONSTRAINT [PK_tbl_news] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Product]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](255) NOT NULL,
	[UrlHinh] [nvarchar](255) NULL,
	[GiaHienTai] [decimal](18, 0) NOT NULL CONSTRAINT [DF_tbl_Product_GiaHienTai1]  DEFAULT ((0)),
	[MoTa] [nvarchar](max) NULL,
	[MoTaCT] [nvarchar](max) NULL,
	[SoLuongTon] [int] NOT NULL CONSTRAINT [DF_tbl_Product_SoLuongTon1]  DEFAULT ((1)),
	[SLDaBan] [int] NOT NULL CONSTRAINT [DF_tbl_Product_SLDaBan1]  DEFAULT ((0)),
	[LuotXem] [int] NULL CONSTRAINT [DF_tbl_Product_LuotXem1]  DEFAULT ((0)),
	[NgayCapNhat] [datetime] NULL,
	[Status] [bit] NOT NULL,
	[IDLoaiSP] [int] NULL,
	[GiaCu] [decimal](18, 0) NULL,
	[KhuyenMai] [int] NULL,
	[CaTuoiMoiNgay] [bit] NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[keyword] [nvarchar](255) NULL,
	[alias] [varchar](255) NULL,
 CONSTRAINT [PK_tbl_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product_types]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product_types](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NULL,
	[Status] [bit] NOT NULL,
	[alias] [varchar](255) NULL,
 CONSTRAINT [PK_tbl_product_types] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_shop]    Script Date: 30/10/2016 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_shop](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tenshop] [nvarchar](255) NULL,
	[emailshop] [varchar](255) NULL,
	[phoneshop1] [varchar](255) NULL,
	[thoigianlamviec1] [nvarchar](max) NULL,
	[masodoanhnghiep] [nvarchar](255) NULL,
	[addressshop] [nvarchar](255) NULL,
	[thoigianlamviec2] [nvarchar](max) NULL,
	[phoneshop2] [varchar](50) NULL,
	[longtitude] [varchar](50) NULL,
	[lattitude] [varchar](50) NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[keyword] [nvarchar](255) NULL,
	
 CONSTRAINT [PK_tbl_shop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([id], [idshop], [name], [birthday], [sex], [idcard], [image], [email], [password], [address], [moblie], [date_added], [last_modified], [status], [note], [randomkey]) VALUES (3, NULL, N'Lương yến', NULL, NULL, NULL, NULL, N'lkimlyen2912@gmail.com', N'hoahongtim', N'92/9 ung văn khiêm, phường 25, tp.hcm', N'01669380986', CAST(N'2016-10-12 13:29:13.183' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Customers] ([id], [idshop], [name], [birthday], [sex], [idcard], [image], [email], [password], [address], [moblie], [date_added], [last_modified], [status], [note], [randomkey]) VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, N'luongthiyen1060@hotmail.com', N'hoahongtim', NULL, NULL, CAST(N'2016-10-12 14:30:27.897' AS DateTime), NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([id], [iddh], [idsp], [soluong], [dongia], [thanhtien]) VALUES (1, 1, 2, 1, CAST(750000 AS Decimal(18, 0)), CAST(750000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([id], [iddh], [idsp], [soluong], [dongia], [thanhtien]) VALUES (2, 2, 3, 1, CAST(690000 AS Decimal(18, 0)), CAST(690000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([id], [iddh], [idsp], [soluong], [dongia], [thanhtien]) VALUES (3, 2, 2, 1, CAST(750000 AS Decimal(18, 0)), CAST(750000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([id], [iddh], [idsp], [soluong], [dongia], [thanhtien]) VALUES (4, 2, 12, 1, CAST(750000 AS Decimal(18, 0)), CAST(750000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([id], [idshop], [price], [idkh], [phonenumber], [thoidiemdathang], [tennguoinhan], [diachi], [gmail], [status], [state]) VALUES (1, NULL, CAST(750000 AS Decimal(18, 0)), 3, NULL, CAST(N'2016-10-20 16:27:46.967' AS DateTime), NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Orders] ([id], [idshop], [price], [idkh], [phonenumber], [thoidiemdathang], [tennguoinhan], [diachi], [gmail], [status], [state]) VALUES (2, NULL, CAST(2190000 AS Decimal(18, 0)), 3, N'01669380986', CAST(N'2016-10-28 09:57:34.550' AS DateTime), N'yến yến ', N'tphcm', N'', 0, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
INSERT [dbo].[tbl_admin] ([Username], [Password], [Priority]) VALUES (N'admin', N'admin', 1)
INSERT [dbo].[tbl_admin] ([Username], [Password], [Priority]) VALUES (N'kskull41196', N'5560020123aA', 1)
INSERT [dbo].[tbl_admin] ([Username], [Password], [Priority]) VALUES (N'yenyen', N'123456', 1)
SET IDENTITY_INSERT [dbo].[tbl_header] ON 

INSERT [dbo].[tbl_header] ([id], [image], [phone1], [tittle], [phone2], [shortcuticon]) VALUES (1, N'images/logo.png', N' 091 3456 991', N'Hasasa.vn: Cung cấp sỉ &amp; lẻ hải sản sạch, tươi sống, đông lạnh, ngon, giá rẻ', N' 091 3456 993', N'images/icon.png')
SET IDENTITY_INSERT [dbo].[tbl_header] OFF
SET IDENTITY_INSERT [dbo].[tbl_information] ON 

INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (1, N'Giới thiệu về hasasa.vn', N'<p><strong>Hasasa.vn</strong> tự hào là Website chuyên cung cấp sỉ/lẻ các loại hải sản <strong>TƯƠI - NGON - SẠCH&nbsp;</strong>với giá tốt nhất thị trường. Hải sản tại <strong>Hasasa.vn</strong> được nhập trực tiếp tại các nguồn đánh bắt với sự tuyển chọn khắt khe và quy trình vận chuyển, bảo quản chuyên nghiệp đảm bảo hải sản luôn giữ được chất lượng tốt nhất khi giao đến tay khách hàng.&nbsp;</p><p>
	Với mong muốn “<em><strong>Mang hương biển đến mọi nhà</strong></em>”, <strong><em>"Hải Sản Sạch và Tươi"</em></strong>&nbsp;chúng tôi cam kết đem đến cho Quý khách hàng những trải nghiệm mua sắm hải sản tiện ích và chất lượng nhất. Giờ đây, không cần lặn lội đến các vùng biển như Phan Thiết, Phú Quốc, Nha Trang... mới có thể  thưởng thức được những đặc sản tươi ngon từ biển mà&nbsp;chỉ cần vài bước đặt hàng đơn giản trên Website <strong>Hasasa.vn</strong>, Quý khách hàng sẽ nhận ngay những loại hải sản&nbsp;ngon,&nbsp;độc,&nbsp;lạ&nbsp;và bổ dưỡng ngay tại nhà!</p><p>
	Nếu Quý khách là khách sạn nhà hàng, quán ăn hải sản đang tìm kiếm một nhà cung cấp hải sản uy tín chất lượng với giá cả phải chăng hãy liên hệ trực tiếp với&nbsp;chúng tôi để nhận được báo giá tốt nhất. <strong></strong>Chúng tôi<strong> </strong>luôn có những chế độ ưu đãi đặc biệt dành cho các Khách hàng thân thiết cộng tác bền lâu cùng <strong>Hasasa.vn</strong>!</p><p>Không chỉ cung cấp hải sản chất lượng, Website <strong>Hasasa.vn</strong>&nbsp;còn cập nhập những thông tin bổ ích về ẩm thực, dinh dưỡng cũng như công thức chế biến món ngon từ các loại hải sản giúp nhằm giúp&nbsp;bà nội trợ tự tin hơn trong mỗi bữa ăn gia đình. </p><p>
	<strong>Hãy liên hệ với chúng tôi để trải nghiệm dịch vụ mua sắm hải sản tại nhà tiện ích nhất!</strong></p><p><strong>CÔNG TY TNHH TMDV KHỞI NGUỒN&nbsp;</strong></p><ul><li><strong style="background-color: initial;">Hotline:&nbsp;</strong>1900.636.045 -&nbsp; 091.3456.991 - 091.3456.993</li><li><strong style="background-color: initial;">Mail</strong>: <a href="mailto:mailto:hotro@hasasa.vn" style="background-color: initial;">hotro@hasasa.vn</a></li><li><strong style="background-color: initial;">Thời gian làm việc:</strong></li></ul><h5><strong><span style="color: rgb(149, 55, 52);">Từ Thứ 2 đến Chủ Nhật hàng tuần&nbsp;</span></strong></h5><h5><b style="color: rgb(149, 55, 52); background-color: initial;">Buổi&nbsp;Sáng: 8h - 12h</b></h5><h5><b style="color: rgb(149, 55, 52); background-color: initial;">Buổi chiều: 13h - 20h</b></h5>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (2, N'Hướng dẫn mua hàng', N'<h4></h4><h3></h3><h3>Cách 1: Mua trực tiếp tại cửa hàng</h3><h4>
<ul> 
<li>Hasasa.vn luôn khuyến khích Khách hàng đến trực tiếp cửa hàng&nbsp;21 Tự Lập, Phường 4, Quận Tân Bình, Tp.Hồ Chí Minh để cảm nhận trực tiếp chất lượng hải sản&nbsp;của chúng tôi và chọn lựa cho mình những sản phẩm&nbsp;ưng ý nhất.</li></ul><ul> 
<li>Tại cửa hàng, nhân viên của Hasasa.vn luôn tư vấn và phục vụ nhiệt tình ý muốn của Khách hàng.</li></ul><ul> 
<li>Thời gian làm việc:</li></ul></h4><h5><strong>Từ Thứ 2 đến Chủ Nhật hàng tuần </strong></h5><h5><strong>-&nbsp;Buổi Sáng: 8h - 12h</strong></h5><h5><strong>-&nbsp;Buổi chiều: 13h - 20h</strong></h5><h4></h4><h3>Cách 2: Mua hàng qua điện thoại</h3><ul> 
<li>Gọi trực tiếp đường dây nóng 1900 636045 - 091 3456 991 từ 8h – 20h (Cả thứ 7 và Chủ Nhật).</li></ul><ul> 
<li>Nhân viên CSKH của HuongBien.vn sẽ hỗ trợ giúp khách đặt đơn hàng một cách nhanh chóng và tiện lợi nhất.</li></ul><h3>Cách 3: Đặt hàng qua Fanpage&nbsp;</h3><h4><a href="https://www.facebook.com/huongbien.vn">https://www.facebook.com/hasasa.vn</a></h4><ul> 
<li>Khách hàng comment hoặc inbox đặt hàng trực tiếp tại Fanpage HuongBien.vn, Admin của chúng tôi sẽ chuyển ngay đơn đặt hàng đến bộ phận CSKH và liên hệ lại cho Khách hàng một cách nhanh nhất. </li></ul><ul> 
<li>Khi đặt hàng trên Fanpage, Khách hàng vui lòng ghi rõ số điện thoại liên lạc cũng như tên, số lượng sản phẩm cần đặt.</li></ul><ul> 
<li>Ngoài ra, nếu Khách hàng có bất kì thắc mắc nào đừng ngại comment, inbox trực tiếp tại các post của Fanpage, Admin của chúng tôi sẽ hồi đáp và tư vấn kịp thời.</li></ul><h3><span style="color: rgb(12, 12, 12);">Cách 4: Đặt mua trên website Hasasa.vn</span></h3><p><strong></strong></p><p>
	Để tiện lợi cho Quý khách hàng mua sắm thoải mái trên hệ thống website Hasasa<strong>.vn</strong>, chúng tôi có 2 hình thức đặt mua trực tuyến sau:</p><h4>
	<strong><span style="color: rgb(192, 80, 77);">Hình thức 1: Đặt nhanh</span></strong></h4><p>
	<strong>Bước 1 – Chọn sản phẩm</strong></p><p>
	Sau tìm được sản phẩm ưng ý, Quý khách có thể click vào <strong>“Mua”</strong>, Hệ thống sẽ chuyển sang giao diện chi tiết của sản phẩm. Tại đây Quý khách sử dụng các thanh trượt lên xuống để chọn số lượng cần mua và <strong></strong>Click<strong> “Mua ngay”</strong></p><p><strong style="background-color: initial;">Bước 2 – Nhập thông tin</strong></p><p>Hệ thống hiện pop – up yêu cầu Quý khách nhập <strong style="background-color: initial;">tên, nhập số điện thoại hoặc địa chỉ email</strong>.&nbsp;</p><p>
	<strong>Bước 3 – Hoàn tất đơn hàng</strong></p><p>
	Sau khi nhập đầy đủ thông tin và gửi đi, trên đầu Menu của trang thông báo đơn hàng đã hoàn tất. Nhân viên CSKH của <strong>Huongbien.vn</strong> sẽ liên lạc ngay với Quý khách trong thời gian sớm nhất (5 – 60 phút) để xác nhận đơn hàng và tiến hành giao hàng.</p><h4>
	<strong><span style="color: rgb(192, 80, 77);">Hình thức 2: Đặt mua phổ thông</span></strong></h4><p>
	<strong>Bước 1 – Chọn sản phẩm</strong></p><p>
	Sau tìm được sản phẩm ưng ý, Quý khách có thể click vào <strong>“Mua”</strong>, Hệ thống sẽ chuyển sang giao diện chi tiết của sản phẩm.Tại đây Quý khách sử dụng các thanh trượt lên xuống để chọn số lượng cần mua.</p><p><strong style="background-color: initial;">Bước 2 – Click “Cho vào giỏ hàng”</strong></p><p>
	Sau khi sản phẩm được cho vào giỏ hàng, hệ thống sẽ mở ra pop-up như sau:</p><p>
	Nếu Quý khách còn mua chọn mua thêm các sản phẩm khác, hãy để pop – up tự tắt. Thông tin giỏ hàng của Quý khách có thể xem ngay ở menu trang. Tại đây Quý khách có thể click để thanh toán bất kỳ lúc nào có nhu cầu.</p><p>Nếu Quý khách muốn kết thúc việc mua hàng thực hiện tiếp <strong style="background-color: initial;">Bước 4</strong>.</p><p>
	<strong>Bước 3 – Click “Đặt hàng”</strong></p><p>
	Nếu Quý khách đã đăng nhập trước đó, click “<strong>Tiếp tục</strong>”. Nếu chưa, vui lòng đăng nhập tài khoản. <br>
	</p><p><strong style="background-color: initial;">Bước 4 - Điền thông tin thanh toán, vận chuyển</strong></p><p>
	Cập nhật địa chỉ giao hàng của quý khách, có thể bỏ qua bước này nếu địa chỉ giao hàng là địa chỉ Quý khách đã đăng kí trước đó.</p><p>
	Chọn hình thức thanh toán mong muốn.</p><p>
	Điền ghi chú cho đơn hàng nếu có.</p><p>
	Nhấn nút “<strong>Đặt hàng</strong>” để hoàn tất mua hàng.</p><p>
	<strong>Bước 5 – Hoàn tất đơn hàng</strong></p><p>
	Sau khi nhấn nút “<strong>Đặt hàng</strong>”, Quý khách sẽ được chuyển đến trang thông báo đặt mua thành công, đồng thời Quý khách sẽ nhận được e-mail “<strong>Xác nhận đơn hàng</strong>” do <strong>Hasasa.vn</strong> gửi về e-mail đăng nhập của mình.</p><p>
	Click vào “<strong>Chi tiết đơn hàng</strong>” để xem thông tin đơn hàng vừa đặt thành công!</p>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (3, N'Hướng dẫn thanh toán', N'<p><strong>A. THANH TO&Aacute;N TIỀN MẶT</strong></p>
<p>H&igrave;nh thức thanh to&aacute;n n&agrave;y &aacute;p dụng trong trường hợp sau:</p>
<ul>
<li>Kh&aacute;ch mua h&agrave;ng trực tiếp tại cửa h&agrave;ng ở địa chỉ <strong>21 Tự Lập, Phường 4, Quận T&acirc;n B&igrave;nh, Tp.Hồ Ch&iacute; Minh</strong>.</li>
<li>Kh&aacute;ch muốn thanh to&aacute;n khi nhận h&agrave;ng. Với trường hợp n&agrave;y Qu&yacute; kh&aacute;ch vui l&ograve;ng đọc kĩ h&oacute;a đơn giao h&agrave;ng v&agrave; thanh to&aacute;n đầy đủ gi&aacute; trị đơn h&agrave;ng cho nh&acirc;n vi&ecirc;n giao h&agrave;ng của Hasasa.vn</li>
</ul>
<p><strong>B. THANH TO&Aacute;N CHUYỂN KHOẢN</strong></p>
<ul>
<li>&Aacute;p dụng cho c&aacute;c Kh&aacute;ch h&agrave;ng ở tỉnh xa đặt h&agrave;ng v&agrave; chuyển h&agrave;ng theo nh&agrave; xe hoặc Kh&aacute;ch h&agrave;ng muốn đặt mua hải sản gửi tặng cho bạn bạn b&egrave; người th&acirc;n theo địa chỉ y&ecirc;u cầu.</li>
<li>Qu&yacute; Kh&aacute;ch vui l&ograve;ng chọn một trong những ng&acirc;n h&agrave;ng b&ecirc;n dưới v&agrave;&nbsp;thanh to&aacute;n chuyển khoản tổng tiền h&agrave;ng v&agrave; phụ ph&iacute; ph&aacute;t sinh nếu c&oacute;. Sau khi nhận được th&ocirc;ng b&aacute;o chuyển khoản từ ng&acirc;n h&agrave;ng, Shop sẽ đ&oacute;ng g&oacute;i v&agrave; chuyển h&agrave;ng ngay theo nh&agrave; xe Kh&aacute;ch y&ecirc;u cầu.&nbsp;</li>
</ul>
<p><strong>1.T&Agrave;I KHOẢN VIETCOMBANK</strong></p>
<p>-&nbsp;Chủ T&agrave;i Khoản:&nbsp;NGUYỄN THỊ HỒNG HẠNH</p>
<p>- Số T&agrave;i Khoản:&nbsp;0071000934098</p>
<p>-&nbsp;CHI NH&Aacute;NH B&Igrave;NH T&Acirc;Y - TP.HỒ CH&Iacute; MINH</p>
<p><strong>2.T&Agrave;I KHOẢN N&Ocirc;NG NGHIỆP V&Agrave; PH&Aacute;T TRIỂN N&Ocirc;NG TH&Ocirc;N &ndash; AGRIBANK</strong></p>
<p>- Chủ T&agrave;i Khoản: NGUYỄN THỊ HỒNG HẠNH</p>
<p>-&nbsp;Số T&agrave;i Khoản:&nbsp;1900206267244</p>
<p>-&nbsp;CHI NH&Aacute;NH MẠC THỊ BƯỞI- TP. HỒ CH&Iacute; MINH</p>
<p><strong>3.T&Agrave;I KHOẢN VIETINBANK</strong></p>
<p>- Chủ T&agrave;i Khoản: NGUYỄN THỊ HỒNG HẠNH</p>
<p>- Số T&agrave;i Khoản:&nbsp;711AB5288671</p>
<p>-&nbsp;PH&Ograve;NG GIAO DỊCH T&Ocirc; HIẾN TH&Agrave;NH &ndash; TP. HỒ CH&Iacute; MINH</p>
<p><strong>4.T&Agrave;I KHOẢN&nbsp;&Aacute; CH&Acirc;U &ndash; ACB BANK</strong></p>
<p>- Chủ T&agrave;i Khoản: NGUYỄN THỊ HỒNG HẠNH</p>
<p>- Số T&agrave;i Khoản:&nbsp;188443359</p>
<p>-&nbsp;CHI NH&Aacute;NH H&Ograve;A HƯNG &ndash; TP. HỒ CH&Iacute; MINH</p>
<ul>
<li>Mọi th&ocirc;ng tin thắc mắc v&agrave; khiếu nại Qu&yacute; kh&aacute;ch vui l&ograve;ng li&ecirc;n hệ tới:<br /><strong>Hotline:&nbsp; 091.3456.991 - 0913.456.993 - 1900.636.045</strong><br /><strong>Mail:</strong><a href="mailto:mailto:hotro@huongbien.vn">hotro@hasasa.vn</a></li>
</ul>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (4, N'Chính sách giao hàng', N'<h4>
	<strong>1. Đối với khách mua trực tiếp tại cửa hàng</strong></h4><hr>
<p><strong></strong></p><p>
	- 
	<strong>Hasasa.vn</strong>&nbsp;khuyến khích khách hàng đến trực tiếp địa chỉ <strong>21 Tự Lập, Phường 4, Quận Tân Bình</strong> để tùy ý lựa chọn theo sở thích và cảm nhận trực tiếp chất lượng sản phẩm của chúng tôi.</p><p>
	- Bên cạnh sự phục vụ chu đáo và tận tình của đội ngũ nhân viên, 
	<strong>Hasasa.vn</strong> luôn có những chính sách ưu đãi đặc biệt (giảm giá hoặc chiết khấu thêm)&nbsp;đối với Quý khách hàng mua trực tiếp&nbsp;tại cửa hàng!</p><h4><strong><br></strong></h4><h4><strong>2. Chính sách giao hàng tại khu vực Tp.Hồ Chí Minh</strong></h4><hr>
<p><strong></strong></p><p>
	Nhằm phục vụ khách hàng một cách tốt nhất, 
	<strong>Hasasa.vn</strong>&nbsp;thực hiện chính sách giao hàng tận nhà tại khu vực Tp.Hồ Chí Minh theo biểu phí giao hàng như sau:</p><p>- Miễn Phí giao hàng&nbsp;cho các đơn hàng đặt từ 1kg ở các địa chỉ cách Shop &lt;&nbsp;7km&nbsp;</p><p>-&nbsp;Tính Phí giao hàng cho các đơn hàng ở địa chỉ &gt;7km theo biểu phí sau:</p><p><strong>Từ 7 - 9 km: 10,000 vnđ/lần giao</strong></p><p><strong>Từ 9&nbsp;- 10 km: 15,000 vnđ/lần giao</strong></p><p><strong>Từ 10 - 12 km: 20,000 vnđ/lần giao</strong></p><p><strong>Từ 12 - 17 km: 30,000 vnđ/lần giao</strong></p><p>- Đối với các đơn hàng đặt dưới 1kg, Shop thu thêm phụ phí giao hàng 20,000 vnđ + phí giao&nbsp;hàng nếu có.&nbsp;</p><h4><strong><strong style="color: rgb(0, 0, 0); background-color: initial;">3. Chính sách giao hàng ngoại tỉnh</strong></strong></h4><hr>
<p><strong></strong></p><p>
	- Đối với khách hàng ngoại tỉnh đặt mua sản phẩm,<strong> 
	 Hasasa.vn</strong> sẽ liên hệ trực tiếp để thỏa thuận phương thức vận chuyển thỏa đáng nhất và phù hợp nhất theo yêu cầu của khách hàng.</p><p>
	- Cước phí vận chuyển phát sinh do khách hàng thanh toán.</p><p>- Shop thu thêm phụ phí thùng xốp nếu có từ 20,000 - 50,000 vnđ tùy theo thùng lớn nhỏ.&nbsp;</p><p>
	- Khách hàng ngoại tỉnh có thể tham khảo thêm các phương thức vận chuyển sau:</p><ul>
	<li>Vận chuyển bằng đường hàng không</li>	<li>Vận chuyển qua nhà xe</li>	<li>Chuyển phát nhanh qua dịch vụ thứ 3</li></ul>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (5, N'Chính sách bảo mật thông tin', N'<p>
	Cảm ơn Quý khách đã truy cập vào Website 
	<strong>Hasasa.vn</strong>&nbsp;của <strong> Công ty TNHH – Thương Mại Dịch Vụ Khởi Nguồn</strong>. Chúng tôi tôn trọng và cam kết sẽ bảo mật những thông tin mang tính riêng tư của bạn. Xin vui lòng đọc bản <strong>Chính sách bảo mật</strong> dưới đây để hiểu hơn những cam kết mà chúng tôi thực hiện nhằm tôn trọng và bảo vệ quyền lợi của người truy cập. 
&nbsp;</p><h4>
	<strong>1. Thu thập thông tin cá nhân</strong></h4><hr>
<h4><strong></strong></h4><p>
	-Để sử dụng được các dịch vụ của 
	<em>Hasasa.vn</em>, Quý khách phải đăng ký tài khoản và cung cấp một số thông tin cá nhân. Phần thủ tục đăng k‎ý này nhằm giúp chúng tôi:</p><ul>
	
<li>
	Hỗ trợ khách hàng khi mua sản phẩm.</li>	
<li>
	Giải đáp thắc mắc khách hàng</li>	
<li>
	Cung cấp cho bạn thông tin mới nhất trên Website của chúng tôi</li>	
<li>
	Xem xét và nâng cấp nội dung và giao diện của Website</li>	
<li>
	Nâng cấp tài khoản thành viên.</li>	
<li>
	Thực hiện các bản khảo sát khách hàng</li>	
<li>
	Thực hiện các hoạt động quảng bá liên quan đến các sản phẩm và dịch vụ của Hasasa.vn</li></ul><p>
	 -Để truy cập, đặt hàng và sử dụng các dịch vụ tại 
	<em>Hasasa.vn</em>, Quý khách có thể sẽ được yêu cầu đăng ký với chúng tôi thông tin cá nhân (Email, Họ tên, Ngày tháng năm sinh, Số ĐT liên lạc, địa chỉ&hellip;). Mọi thông tin khai báo phải đảm bảo tính chính xác và hợp pháp. <em>Hasasa.vn</em>&nbsp;không chịu mọi trách nhiệm liên quan đến pháp luật của thông tin khai báo.</p><p>
	- Khi thực hiện giao dịch, khách hàng lựa chọn phương thức thanh toán và cung cấp thêm thông tin cá nhân cho chúng tôi (Địa chỉ liên hệ, người nhận hàng, thông tin về số tài khoản nếu chuyển khoản).</p><p>
	- Chúng tôi cũng có thể thu thập thông tin về danh sách đơn hàng, sản phẩm đã mua, sản phẩm đã xem, số lần viếng thăm, số links (liên kết) bạn click và những thông tin khác liên quan đến việc kết nối đến 
	<em>Hasasa.vn</em>. Chúng tôi cũng thu thập các thông tin mà trình duyệt Web (Browser) Quý khách sử dụng mỗi khi truy cập vào website Huongbien.vn, bao gồm: địa chỉ IP, loại Browser, ngôn ngữ sử dụng, thời gian và những địa chỉ mà Browser truy xuất đến.</p><h4>
	<strong>2. Sử dụng thông tin cá nhân</strong></h4><hr>
<h4><strong></strong></h4><p>
	- 
	<em>Hasasa.vn</em> thu thập và sử dụng thông tin cá nhân Quý khách với mục đích phù hợp và hoàn toàn tuân thủ nội dung của “Chính sách bảo mật” này.</p><p>
	- Khi cần thiết, chúng tôi có thể sử dụng những thông tin này để liên hệ trực tiếp với bạn dưới các hình thức như: gởi thư ngỏ, đơn đặt hàng, mã đơn hàng, chứng nhận khóa học đã tham gia, thư cảm ơn, thông tin về kỹ thuật và bảo mật, Quý khách có thể nhận được thư định kỳ cung cấp thông tin sản phẩm, dịch vụ mới, thông tin về các sự kiện sắp tới, nâng cấp thành viên hoặc thông tin tuyển dụng nếu Quý khách đăng kí nhận email thông báo.</p><h4>
	<strong>3. Chia sẻ thông tin cá nhân</strong></h4><hr>
<h4><strong></strong></h4><p>
	- Ngoại trừ các trường hợp về sử dụng thông tin cá nhân như đã nêu trong chính sách này, chúng tôi cam kết sẽ không tiết lộ thông tin cá nhân bạn ra ngoài.</p><p>
	- Trong một số trường hợp, chúng tôi có thể thuê một đơn vị độc lập để tiến hành các dự án nghiên cứu thị trường và khi đó thông tin của bạn sẽ được cung cấp cho đơn vị này để tiến hành dự án. Bên thứ ba này bị ràng buộc bởi một thỏa thuận về bảo mật mà theo đó họ chỉ được phép sử dụng những thông tin được cung cấp cho mục đích hoàn thành dự án.</p><p>
	- Chúng tôi có thể tiết lộ hoặc cung cấp thông tin cá nhân của bạn trong các trường hợp thật sự cần thiết như sau:</p><ul>
	
<li>Khi có yêu cầu của các cơ quan pháp luật;</li>	
<li>Trong trường hợp mà chúng tôi tin rằng điều đó sẽ giúp chúng tôi bảo vệ quyền lợi chính đáng của mình trước pháp luật;</li>	
<li>Tình huống khẩn cấp và cần thiết để bảo vệ quyền an toàn cá nhân của các thành viên <em>Huongbien.vn</em> khác.</li></ul><h4>
	<strong>4. Truy xuất thông tin cá nhân</strong></h4><hr>
<p><strong> </strong></p><p>
	- Bất cứ thời điểm nào Quý khách cũng có thể truy cập và chỉnh sửa những thông tin cá nhân trong tài khoản cá nhân của mình.</p><h4>
	<strong>5. Bảo mật thông tin cá nhân</strong></h4><hr>
<p><strong></strong></p><p>
- Khi bạn gửi thông tin cá nhân của bạn cho chúng tôi, bạn đã đồng ý với các điều khoản mà chúng tôi đã nêu ở trên, 
	<em>Hasasa.vn</em>&nbsp;cam kết bảo mật thông tin cá nhân của Quý khách bằng mọi cách thức có thể. Chúng tôi sẽ sử dụng nhiều công nghệ bảo mật thông tin khác nhau nhằm bảo vệ thông tin này không bị truy lục, sử dụng hoặc tiết lộ ngoài ý muốn.</p><p>
	- Việc cung cấp sai thông tin cá nhân sẽ không thể thực hiện được việc liên hệ giao hàng hay sử dụng các dịch vụ mà chúng tôi cung cấp.</p><p>
	- Tuy nhiên do hạn chế về mặt kỹ thuật, không một dữ liệu nào có thể được truyền trên đường truyền internet mà có thể được bảo mật 100%. Do vậy, chúng tôi không thể đưa ra một cam kết chắc chắn rằng thông tin Quý khách cung cấp cho chúng tôi sẽ được bảo mật một cách tuyệt đối an toàn, và chúng tôi không thể chịu trách nhiệm trong trường hợp có sự truy cập trái phép thông tin cá nhân của Quý khách như các trường hợp Quý khách tự ý chia sẻ thông tin với người khác&hellip;.</p><p>
	- Vì vậy, 
	<em>Hasasa.vn</em> cũng khuyến cáo Quý khách nên bảo mật các thông tin liên quan đến mật khẩu truy xuất của Quý khách, không nên chia sẻ với bất kỳ người nào khác.</p><p>
	- Nếu sử dụng máy tính chung nhiều người, Quý khách nên đăng xuất, hoặc thoát hết tất cả cửa sổ Website đang mở.</p><h4>
	<strong>6. Sử dụng “Cookie”</strong></h4><hr>
<h4><strong></strong></h4><p>
- 
	<em>Hasasa.vn</em>&nbsp;dùng "Cookie" để giúp cá nhân hóa và nâng cao tối đa hiệu quả sử dụng thời gian trực tuyến của Quý khách.</p><p>
	- Một cookie là một file văn bản được đặt trên đĩa cứng của bạn bởi một máy chủ của trang web. Cookie không được dùng để chạy chương trình hay đưa virus vào máy tính của Quý khách. Cookie được chỉ định vào máy tính của Quý khách và chỉ có thể được đọc bởi một máy chủ trang web trên miền được đưa ra cookie cho Quý khách.</p><p>
	- Một trong những mục đích của Cookie là cung cấp những tiện ích để tiết kiệm thời gian của Quý khách khi truy cập tại website 
	<em>Hasasa.vn</em>&nbsp;hoặc viếng thăm website <em>Hasasa.vn</em>&nbsp;lần nữa mà không cần đăng ký lại thông tin sẵn có.</p><p>
	- Quý khách có thể chấp nhận hoặc từ chối dùng cookie. Hầu hết những Browser tự động chấp nhận cookie, nhưng Quý khách có thể thay đổi những cài đặt để từ chối tất cả những cookie nếu Quý khách thích. Tuy nhiên, nếu Quý khách chọn từ chối cookie, điều đó có thể gây cản trở và ảnh hưởng không tốt đến một số dịch vụ và tính năng phụ thuộc vào cookie tại website 
	<em>Hasasa.vn</em>.</p><h4>
	<strong>7. Quy định về “Spam”</strong></h4><hr>
<h4><strong></strong></h4><p>
- 
	<em>Hasasa.vn</em>&nbsp;thực sự quan ngại đến vấn nạn Spam (thư rác), các email giả mạo danh tín chúng tôi. Do đó, Huongbien.vn khẳng định chỉ email đến Quý khách khi và chỉ khi Quý khách có đăng ký hoặc sử dụng dịch vụ từ hệ thống của chúng tôi.</p><p>
	- 
	<em>Hasasa.vn</em>&nbsp;cam kết không bán, thuê lại hoặc cho thuê email của Quý khách từ bên thứ ba. Nếu Quý khách vô tình nhận được email không theo yêu cầu từ hệ thống chúng tôi do một nguyên nhân ngoài ý muốn, xin vui lòng nhấn vào link từ chối nhận email này kèm theo, hoặc thông báo trực tiếp đến ban quản trị Website.</p><h4>
	<strong>8. Thay đổi về chính sách</strong></h4><hr>
<h4><strong></strong></h4><p>
- Chúng tôi hoàn toàn có thể thay đổi nội dung trong trang này mà không cần phải thông báo trước, để phù hợp với các nhu cầu của 
	<em>Hasasa.vn</em>&nbsp;cũng như nhu cầu và sự phản hồi từ khách hàng nếu có. Khi cập nhật nội dung chính sách này, chúng tôi sẽ chỉnh sửa lại thời gian “Cập nhật lần cuối” bên trên.</p><p>
	- Nội dung “
	<strong>Chính sách bảo mật</strong>” này chỉ áp dụng tại <em>Hasasa.vn</em>, không bao gồm hoặc liên quan đến các bên thứ ba đặt quảng cáo hay có links tại Hasasa.vn. Chúng tôi khuyến khích bạn đọc kỹ chính sách An toàn và Bảo mật của các trang web của bên thứ ba trước khi cung cấp thông tin cá nhân cho các trang web đó. Chúng tôi không chịu trách nhiệm dưới bất kỳ hình thức nào về nội dung và tính pháp lý của trang web thuộc bên thứ ba.</p><p>
	- Vì vậy, bạn đã đồng ý rằng, khi bạn sử dụng website của chúng tôi sau khi chỉnh sửa nghĩa là bạn đã thừa nhận, đồng ý tuân thủ cũng như tin tưởng vào sự chỉnh sửa này. Do đó, chúng tôi đề nghị bạn nên xem trước nội dung trang này trước khi truy cập các nội dung khác trên website cũng như bạn nên đọc và tham khảo kỹ nội dung “
	<strong>Chính sách bảo mật</strong>” của từng website mà bạn đang truy cập.</p><h4>
	<strong>9. Thông tin liên hệ</strong></h4><hr>
<h4><strong></strong></h4><p>
Nếu quý khách muốn truy cập thông tin cá nhân của mình, có khiếu nại về việc vi phạm quyền riêng tư của quý khách hoặc có bất cứ câu hỏi nào về cách thức chúng tôi thu thập hoặc sử dụng thông tin cá nhân của quý khách, vui lòng gửi yêu cầu, khiếu nại hoặc câu hỏi của quý khách tới địa chỉ dưới đây. Chúng tôi sẽ trả lời câu hỏi hoặc khiếu nại của quý khách trong thời gian sớm nhất có thể.</p><p>
	<strong>Địa chỉ văn phòng: </strong></p><p>
	21 Tự Lập, Phường 4, Quận Tân Bình, Tp.Hồ Chí Minh
	<br>
	<strong>Tell:</strong> <span style="color: rgb(192, 80, 77);"><strong>1900 636045  </strong></span><br>
	<strong>Mail:</strong>
	<a href="mailto:hotro@huongbien.vn"><span style="color: rgb(192, 80, 77);">hotro@hasasa.vn</span></a></p><p>
	<strong>
	Thời gian làm việc:
	</strong></p>
<table style="border-collapse: collapse;" border="1" cellpadding="5" cellspacing="0">
<tbody>
<tr>
	<th>
		<span style="color: rgb(192, 80, 77);">
		Thứ 2 - Thứ 6
		</span>
	</th>
	<th>
		<span style="color: rgb(192, 80, 77);">
		Thứ 7 - Chủ Nhật
		</span>
	</th>
</tr>
<tr>
	<td>
		Sáng: 8 - 12 giờ
	</td>
	<td>
		Sáng: 8 - 12 giờ
	</td>
</tr>
<tr>
	<td>
		Chiều: 13-23 giờ
	</td>
	<td>
		Chiều: 13-21 giờ
		<br>p
	</td>
</tr>
</tbody>
</table>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (6, N'Quy trình xử lý khiếu nại', N'<p><strong>Hasasa.vn</strong> sẵn sàng tiếp nhận mọi khiếu nại của khách hàng liên quan đến việc sử dụng dịch vụ và sản phẩm&nbsp;của chúng tôi&nbsp;qua đường dây nóng:&nbsp;<strong><span style="color: rgb(192, 80, 77);">091.3456.991 - 1900.636.045.</span></strong></p><p>- Shop có chính sách bán và giao hàng tận nơi, do đó ngay khi nhận được sản phẩm Quý Khách vui lòng kiểm tra kĩ gói hàng xem có đúng mặt hàng và số lượng mình đã đặt mua hay không. Nếu xảy ra sai sót không đúng mặt hàng và số lượng đã đặt&nbsp;Quý Khách được quyền không nhận hàng và đồng thời&nbsp;không phải trả bất kì chi phí nào.&nbsp;</p><p>- Trường hợp không hài lòng về mẫu mã hoặc quy cách sản phẩm&nbsp;Quý Khách có quyền không nhận hàng&nbsp;tuy nhiên Shop sẽ thu thêm phụ phí giao hàng theo tuyến đường đã giao.&nbsp;</p><p>- Sau khi đã nhận sản phẩm nếu xảy ra các vấn đề liên quan đến chất lượng, Quý Khách có thể&nbsp;có thể chụp hình sản phẩm hoặc giữ lại mẫu sản phẩm và gửi ngay phản hồi đến đường dây nóng&nbsp;cho Shop trong vòng 24h sau khi nhận hàng. Shop sẽ cho nhân viên đến thu hồi và đổi trả ngay sản phẩm mới hoặc hoàn trả lại tiền cho Quý Khách nếu Khách&nbsp;yêu cầu.</p><p>- Trường hợp Quý&nbsp;Khách đã sử dụng hết sản phẩm Shop sẽ bồi thường 30 -&nbsp;50% giá trị đơn hàng tùy trường hợp.</p><p>- Các trường hợp phản hồi trễ sau 24h đồng hồ, không có hình ảnh, mẫu sản phẩm hoặc hình ảnh hay mẫu sản phẩm không chứng minh được sản phẩm kém chất, Shop sẽ không giải quyết đền bù.</p><p><strong>CÁC BƯỚC XỬ LÝ KHIẾU NẠI:</strong></p><p>1. Khách hàng gửi phản hồi.</p><p>2. Nhân viên chăm sóc&nbsp;tiếp nhận, liên hệ nhận hình ảnh và mẫu thử.&nbsp;</p><p>3. Các bộ phận kiểm tra chất lượng thẩm định mẫu, hình ảnh.&nbsp;</p><p>4. Nhân viên chăm sóc liên hệ trả lời khiếu nại và đề xuất phương án giải quyết.&nbsp;</p><p>* Thời gian giải quyết khiếu nại trong thời hạn tối đa là 03 ngày làm việc kể từ khi nhận được khiếu nại của của khách hàng. Trong trường hợp bất khả kháng 2 bên sẽ tự thương lượng.</p>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (7, N'Trả hàng và hoàn tiền', N'<p><strong>Hasasa.vn</strong> sẵn sàng tiếp nhận mọi khiếu nại của khách hàng liên quan đến việc sử dụng dịch vụ và sản phẩm của chúng tôi qua đường dây nóng: <strong>091.3456.991 - 1900.636.045.</strong></p><p>- Shop có chính sách bán và giao hàng tận nơi, do đó ngay khi nhận được sản phẩm Quý Khách vui lòng kiểm tra kĩ gói hàng xem có đúng mặt hàng và số lượng mình đã đặt mua hay không. Nếu xảy ra sai sót không đúng mặt hàng và số lượng đã đặt Quý Khách được quyền không nhận hàng và đồng thời không phải trả bất kì chi phí nào. </p><p>- Trường hợp không hài lòng về mẫu mã hoặc quy cách sản phẩm Quý Khách có quyền trả hàng tuy nhiên Shop sẽ thu thêm phụ phí giao hàng theo tuyến đường đã giao. </p><p>- Sau khi đã nhận sản phẩm nếu xảy ra các vấn đề liên quan đến chất lượng, Quý Khách có thể có thể chụp hình sản phẩm hoặc giữ lại mẫu sản phẩm và gửi ngay phản hồi đến đường dây nóng cho Shop trong vòng 24h sau khi nhận hàng. Shop sẽ cho nhân viên đến thu hồi và đổi trả ngay sản phẩm mới hoặc hoàn trả lại tiền cho Quý Khách nếu Khách yêu cầu.</p><p>- Trường hợp Quý Khách đã sử dụng hết sản phẩm Shop sẽ bồi thường 30 - 50% giá trị đơn hàng tùy trường hợp.</p><p>- Các trường hợp phản hồi trễ sau 24h đồng hồ, không có hình ảnh, mẫu sản phẩm hoặc hình ảnh hay mẫu sản phẩm không chứng minh được sản phẩm kém chất, Shop sẽ không giải quyết đền bù.</p>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (8, N'Tuyển dụng', N'<p><strong>Hasasa.vn&nbsp;</strong>l&agrave; website kinh doanh trực tuyến trực thuộc <strong>C&ocirc;ng ty TNHH &ndash; Thương Mại Dịch Vụ Khởi Nguồn</strong> chuy&ecirc;n cung cấp c&aacute;c loại hải sản tươi ngon tại&nbsp;Tp.Hồ Ch&iacute; Minh v&agrave; c&aacute;c tỉnh th&agrave;nh l&acirc;n cận. Với phương ch&acirc;m &ldquo;<em>Tạo m&ocirc;i trường l&agrave;m việc phẳng cho nh&acirc;n vi&ecirc;n ph&aacute;t huy tối đa năng lực v&agrave; t&iacute;nh s&aacute;ng tạo để ph&aacute;t triển sự nghiệp</em>&rdquo;, <strong>Hasasa.vn</strong>&nbsp;lu&ocirc;n ch&agrave;o đ&oacute;n c&aacute;c bạn trẻ t&acirc;m huyết v&agrave; ham học hỏi v&agrave;o đại gia đ&igrave;nh của m&igrave;nh. Mục ti&ecirc;u của ch&uacute;ng t&ocirc;i l&agrave; hướng đến một m&ocirc;i trường l&agrave;m việc chuy&ecirc;n nghiệp, th&acirc;n thiện, gắn kết b&ecirc;n cạnh đ&oacute; l&agrave; c&aacute;c chế độ, ch&iacute;nh s&aacute;ch hỗ trợ vượt trội d&agrave;nh cho c&aacute;c CBNV c&ocirc;ng ty.</p>
<p><strong>Chế độ đại ngộ tại Hasasa.vn</strong></p>
<ul>
<li>Một m&ocirc;i trường năng động, chuy&ecirc;n nghiệp, đội ngũ nh&acirc;n vi&ecirc;n ho&agrave; đồng lu&ocirc;n sẵn s&agrave;ng hỗ trợ bạn l&uacute;c ho&agrave; nhập cũng như gi&uacute;p bạn vượt qua những kh&oacute; khăn trong c&ocirc;ng việc.</li>
<li>Lương cạnh tranh theo vị tr&iacute; c&ocirc;ng việc, kinh nghiệm v&agrave; kỹ năng.</li>
<li>Đảm bảo an sinh bằng c&aacute;c chế độ bảo hiểm y tế, bảo hiểm x&atilde; hội, bảo hiểm thất nghiệp,&hellip;</li>
<li>C&aacute;c ch&iacute;nh s&aacute;ch thưởng hấp dẫn gi&uacute;p cho những nh&acirc;n vi&ecirc;n c&oacute; th&agrave;nh t&iacute;ch vượt trội được tưởng thưởng xứng đ&aacute;ng.</li>
<li>Ch&iacute;nh s&aacute;ch thưởng cuối năm hấp dẫn (lương th&aacute;ng 13, thưởng hiệu quả kinh doanh).</li>
<li>Cơ hội thăng tiến cho người t&agrave;i, đội ngũ quản l&yacute; trẻ trung đều từ nh&acirc;n vi&ecirc;n thăng tiến l&ecirc;n. V&igrave; thế c&aacute;c cấp quản l&yacute; lu&ocirc;n hiểu v&agrave; quan t&acirc;m đến nh&acirc;n vi&ecirc;n của m&igrave;nh. Sự chia sẻ hướng dẫn c&ocirc;ng việc tận t&igrave;nh từ cấp tr&ecirc;n, gi&uacute;p nh&acirc;n vi&ecirc;n mới h&ograve;a nhập nhanh ch&oacute;ng c&ocirc;ng việc.</li>
<li>Văn h&oacute;a c&ocirc;ng ty mang đến một m&ocirc;i trường gắn b&oacute;, c&aacute;c chương tr&igrave;nh du lịch thường ni&ecirc;n, đ&agrave;o tạo kỹ năng ngo&agrave;i trời, n&acirc;ng cao kiến thức gi&uacute;p nh&acirc;n vi&ecirc;n ph&aacute;t triển to&agrave;n diện.</li>
<li>Tạo điều kiện về thời gian v&agrave; cơ sở vật chất l&agrave;m việc tốt nhất.</li>
</ul>
<h3 style="text-align: center;"><strong>C&aacute;c vị tr&iacute; cần tuyển</strong></h3>
<h4><strong>1. Nh&acirc;n vi&ecirc;n Kế To&aacute;n</strong></h4>
<hr />
<p>&nbsp;</p>
<h4><strong>M&ocirc; tả c&ocirc;ng việc</strong></h4>
<ul>
<li>Kiểm so&aacute;t qui tr&igrave;nh c&aacute;c nghiệp vụ kinh tế của đơn vị, ph&aacute;t hiện c&aacute;c trường hợp thực thi sai qui tr&igrave;nh dẫn đến việc ghi nhận sai hạch to&aacute;n kế to&aacute;n.R&agrave; so&aacute;t, đối chiếu to&agrave;n bộ c&aacute;c nghiệp vụ kế to&aacute;n ph&aacute;t sinh giữa c&aacute;c b&aacute;o c&aacute;o t&agrave;i ch&iacute;nh tổng hợp v&agrave; b&aacute;o c&aacute;o chi tiết theo đối tượng, khoản mục.</li>
<li>Lập b&aacute;o c&aacute;o t&agrave;i ch&iacute;nh theo mục ti&ecirc;u quản trị, qui chế t&agrave;i ch&iacute;nh của đơn vị.</li>
<li>R&agrave; so&aacute;t, đối chiếu hệ thống b&aacute;o c&aacute;o t&agrave;i ch&iacute;nh quản trị với hệ thống b&aacute;o c&aacute;o t&agrave;i ch&iacute;nh theo chuẩn mực kế to&aacute;n Việt Nam.</li>
<li>Ph&acirc;n t&iacute;ch c&aacute;c chỉ ti&ecirc;u đ&aacute;nh gi&aacute; năng lực (KPIs) t&agrave;i ch&iacute;nh theo định hướng của Trưởng ph&ograve;ng T&agrave;i ch&iacute;nh &ndash; Kế to&aacute;n.</li>
<li>Lập b&aacute;o c&aacute;o nhanh (ng&agrave;y/ tuần) cho c&aacute;c khoản mục kế to&aacute;n, t&agrave;i ch&iacute;nh (tiền mặt, phải thu, phải trả).</li>
</ul>
<h4><strong>Kỹ năng</strong></h4>
<ul>
<li>Tốt nghiệp Đại học chuy&ecirc;n ng&agrave;nh kế to&aacute;n, t&agrave;i ch&iacute;nh hoặc c&aacute;c chuy&ecirc;n ng&agrave;nh c&oacute; li&ecirc;n quan.</li>
<li>Tối thiểu 3 năm kinh nghiệm l&agrave;m kế to&aacute;n tổng hợp, ph&acirc;n t&iacute;ch t&agrave;i ch&iacute;nh tại c&aacute;c doanh nghiệp thương mại, dịch vụ (Thương mại điện tử l&agrave; điểm cộng).</li>
<li>Hiểu r&otilde; nguy&ecirc;n tắc kế to&aacute;n theo chuẩn mực kế to&aacute;n việt nam (VAS).</li>
<li>C&oacute; kỹ năng giao tiếp, khả năng l&agrave;m việc độc lập, l&agrave;m việc nh&oacute;m, kỹ năng xử l&yacute; t&igrave;nh huống, kỹ năng đối chiếu, đối so&aacute;t v&agrave; ph&aacute;t hiện sai s&oacute;t.</li>
<li>C&oacute; tinh thần tr&aacute;ch nhiệm cao, chịu được &aacute;p lực c&ocirc;ng việc (c&oacute; thể l&agrave;m trễ l&agrave; điểm cộng).</li>
<li>Sử dụng th&agrave;nh thạo c&aacute;c phần mềm ứng dụng Microsoft office, phần mềm kế to&aacute;n, hệ thống quản l&yacute; nguổn lực doanh nghiệp &ndash; ERP - S.A.P, F.A.S.T, OpenERP l&agrave; điểm cộng)</li>
</ul>
<h4><strong>2. Nh&acirc;n vi&ecirc;n Sales</strong></h4>
<hr />
<p>&nbsp;</p>
<h4><strong>M&ocirc; tả c&ocirc;ng việc</strong></h4>
<ul>
<li>Đề xuất &yacute; tưởng kế hoạch, ch&iacute;nh s&aacute;ch li&ecirc;n quan đến hoạt động b&aacute;n bu&ocirc;n, ph&aacute;t triển đại l&yacute;.</li>
<li>Thiết lập mối quan hệ với c&aacute;c đối t&aacute;c, đại l&yacute; v&agrave; c&aacute;c mối quan hệ kh&aacute;c phục vụ cho c&ocirc;ng việc b&aacute;n bu&ocirc;n, ph&aacute;t triển đại l&yacute;.</li>
<li>Thống k&ecirc; ph&acirc;n t&iacute;ch số liệu doanh thu chi ph&iacute; v&agrave; đ&aacute;nh gi&aacute; hiệu quả c&aacute;c k&ecirc;nh quảng c&aacute;o.</li>
<li>Nghi&ecirc;n cứu thị trường b&aacute;n bu&ocirc;n tại c&aacute;c tỉnh th&agrave;nh tr&ecirc;n cả nước dưới dự điều đồng hoặc chủ động đề xuất v&agrave; được ph&ecirc; duyệt của ban l&atilde;nh đạo c&ocirc;ng ty.</li>
<li>X&acirc;y dựng v&agrave; quảng b&aacute; thương hiệu, tạo h&igrave;nh ảnh thương hiệu tại địa điểm ph&aacute;t triển đại l&yacute;.</li>
<li>C&ugrave;ng bộ phận Marketing c&ocirc;ng ty đề xuất, l&ecirc;n kế hoạch, tổ chức triển khai, tổng kết đ&aacute;nh gi&aacute; c&aacute;c chương tr&igrave;nh marketing, chăm s&oacute;c kh&aacute;ch h&agrave;ng.
- Thực hiện c&aacute;c c&ocirc;ng việc ph&aacute;t sinh kh&aacute;c dưới sự điều động của ban l&atilde;nh đạo c&ocirc;ng ty.</li>
</ul>
<h4><strong>Kỹ năng</strong></h4>
<ul>
<li>Tốt nghiệp Cao đẳng chuy&ecirc;n ng&agrave;nh QTKD, thương mại&hellip; trở l&ecirc;n.</li>
<li>Kinh nghiệm: L&agrave;m ở mảng ph&aacute;t triển thị trường tối thiểu l&agrave; 1 năm.</li>
<li>Sử dụng th&agrave;nh thạo m&aacute;y t&iacute;nh.</li>
<li>C&oacute; khả năng l&agrave;m việc độc lập, c&oacute; kinh nghiệm, khả năng giao tiếp với kh&aacute;ch h&agrave;ng.</li>
</ul>
<h4><strong>3. Nh&acirc;n vi&ecirc;n Marketing</strong></h4>
<hr />
<p>&nbsp;</p>
<h4><strong>M&ocirc; tả C&ocirc;ng việc</strong></h4>
<ul>
<li>Nghi&ecirc;n cứu thị trường.</li>
<li>Nghi&ecirc;n cứu sản phẩm của c&ocirc;ng ty v&agrave; c&aacute;c đối thủ cạnh tranh kh&aacute;c</li>
<li>Tổ chức c&aacute;c chương tr&igrave;nh khuyến mại.</li>
<li>Đề xuất &yacute; tưởng PR, marketing tr&ecirc;n c&aacute;c k&ecirc;nh truyền th&ocirc;ng v&agrave; kế hoạch marketing cho c&ocirc;ng ty.</li>
<li>Li&ecirc;n hệ quảng c&aacute;o, theo d&otilde;i v&agrave; b&aacute;o c&aacute;o kết quả của c&aacute;c hoạt động marketing, quảng c&aacute;o, truyền th&ocirc;ng theo sự chỉ đạo của quản l&yacute; trực tiếp.</li>
<li>Thống k&ecirc; ph&acirc;n t&iacute;ch số liệu doanh thu chi ph&iacute; v&agrave; đ&aacute;nh gi&aacute; hiệu quả c&aacute;c k&ecirc;nh quảng c&aacute;o khuyến mại&hellip;</li>
</ul>
<h4><strong>Kỹ năng</strong></h4>
<ul>
<li>Kinh nghiệm l&agrave;m việc từ 2 năm trở l&ecirc;n trong lĩnh vực Online Marketing.<br />Kinh nghiệm thực tế, triển khai c&aacute;c chiến dịch marketing tr&ecirc;n c&aacute;c k&ecirc;nh online marketing (SEO, PPC, Email, Facebook, Ad networks, PR).<br />Am hiểu SEO, Google Analytics, Forum Seeding v&agrave; c&aacute;c c&ocirc;ng cụ quảng c&aacute;o trực tuyến c&aacute;c web thương mại điện tử, mạng x&atilde; hội.<br />Khả năng l&agrave;m việc độc lập v&agrave; l&agrave;m việc dưới &aacute;p lực cao.<br />Năng động, s&aacute;ng tạo, nhạy b&eacute;n v&agrave; xử l&yacute; t&igrave;nh huống tốt.</li>
</ul>
<h4><strong>4. Nh&acirc;n vi&ecirc;n Tư vấn &ndash; CSKH</strong></h4>
<hr />
<h4>&nbsp;</h4>
<h4><strong>M&ocirc; tả c&ocirc;ng việc:</strong></h4>
<ul>
<li>Trực số Điện thoại/ Email/ Fanpage tư vấn của C&ocirc;ng ty: Tư vấn cho kh&aacute;ch h&agrave;ng c&aacute;c sản phẩm C&ocirc;ng ty ph&acirc;n phối.</li>
<li>Xử l&yacute; đơn h&agrave;ng khi kh&aacute;ch h&agrave;ng gọi đặt h&agrave;ng qua điện thoại, website.</li>
<li>Phụ tr&aacute;ch Tư vấn/ giải đ&aacute;p c&aacute;c chương tr&igrave;nh b&aacute;n h&agrave;ng của C&ocirc;ng ty tới c&aacute;c nh&agrave; ph&acirc;n phối, đại l&yacute;.</li>
<li>Chăm s&oacute;c kh&aacute;ch h&agrave;ng sau b&aacute;n h&agrave;ng.</li>
<li>L&agrave;m việc với đối t&aacute;c cung cấp dịch vụ chuyển ph&aacute;t kiểm tra t&igrave;nh trạng đơn h&agrave;ng.</li>
<li>Hỗ trợ bộ phận B&aacute;n h&agrave;ng/ Marketing Thực hiện c&aacute;c Event, Chương tr&igrave;nh khuyến m&atilde;i.</li>
</ul>
<h4><strong>Kỹ năng</strong></h4>
<ul>
<li>&Iacute;t nhất 01 năm kinh nghiệm l&agrave;m Tư vấn, b&aacute;n h&agrave;ng qua điện thoại.</li>
<li>Giọng n&oacute;i r&otilde; r&agrave;ng, truyền cảm, dễ nghe.</li>
<li>C&oacute; kỹ năng tư vấn kh&aacute;ch h&agrave;ng, b&aacute;n h&agrave;ng qua điện thoại</li>
<li>Khả năng đ&agrave;m ph&aacute;n v&agrave; giải quyết vấn đề tốt</li>
<li>C&oacute; khả năng sử dụng word, Excel, c&aacute;c c&ocirc;ng cụ tr&ecirc;n internet</li>
<li>Chăm chỉ, cần c&ugrave;, c&oacute; tinh thần phấn đấu v&agrave; vươn l&ecirc;n trong c&ocirc;ng việc.</li>
</ul>
<h4><strong>5. Nh&acirc;n vi&ecirc;n giao h&agrave;ng</strong></h4>
<hr />
<h4>&nbsp;</h4>
<h4><strong>M&ocirc; tả c&ocirc;ng việc:</strong></h4>
<ul>
<li>Giao h&agrave;ng từ cửa h&agrave;ng đến kh&aacute;ch theo lịch sắp xếp.</li>
<li>Kiểm tra h&agrave;ng h&oacute;a trước khi giao.</li>
<li>Giao h&agrave;ng đảm bảo đ&uacute;ng địa chỉ y&ecirc;u cầu tr&ecirc;n phiếu giao h&agrave;ng, bảo quan chứng từ giao nhận v&agrave; thu tiền đầy đủ theo y&ecirc;u cầu tr&ecirc;n h&oacute;a đơn.</li>
<li>Bảo quản sản phẩm trong điều kiện tốt trong thời gian vận chuyển từ l&uacute;c nhận h&agrave;ng cho đến l&uacute;c h&agrave;ng được giao th&agrave;nh c&ocirc;ng tới tay kh&aacute;ch h&agrave;ng.</li>
<li>Mang tiền, phiếu giao h&agrave;ng về nộp lại cho bộ phận Kế to&aacute;n.</li>
<li>Hỗ trợ xếp dỡ h&agrave;ng h&oacute;a khi c&oacute; y&ecirc;u cầu.</li>
<li>Thực hiện c&aacute;c c&ocirc;ng việc kh&aacute;c theo y&ecirc;u cầu của Trưởng Bộ phận.</li>
</ul>
<h4><strong>Kỹ năng:</strong></h4>
<ul>
<li>Tr&igrave;nh độ: Tốt nghiệp THPT trở l&ecirc;n</li>
<li>Th&ocirc;ng thạo đường phố tại khu vực Tp. HCM</li>
<li>Độ tuổi: từ 18 tuổi trở l&ecirc;n</li>
<li>Giao tiếp nhanh nhẹn, th&aacute;i độ cầu thị</li>
<li>Sức khỏe tốt, cẩn thận, trung thực</li>
<li>C&oacute; bằng l&aacute;i xe m&aacute;y</li>
</ul>
<p>&nbsp;</p>
<h4><strong>C&aacute;ch thức ứng tuyển</strong></h4>
<hr />
<h4>&nbsp;</h4>
<p>Ứng vi&ecirc;n quan t&acirc;m vui l&ograve;ng gửi hồ sơ v&agrave;o Email: <a href="mailto:mailto:tuyendung@huongbien.vn">tuyendung@hasasa.vn</a>. Ti&ecirc;u đề ghi r&otilde;: <strong>Họ T&ecirc;n_Ứng tuyển [Vị tr&iacute;]</strong>. V&iacute; dụ: L&ecirc; Văn A_Ứng tuyển Kế to&aacute;n</p>
<p><em><strong>Hồ sơ ứng tuyển bao gồm:</strong></em></p>
<ol>
<li>Đơn xin dự tuyển</li>
<li>Giấy tờ x&aacute;c định nh&acirc;n th&acirc;n, học vấn v&agrave; c&aacute;c chứng nhận c&oacute; li&ecirc;n quan</li>
<li>Giấy kh&aacute;m sức khỏe.</li>
</ol>
<p>(Lưu &yacute;: Hồ sơ photo kh&ocirc;ng cần c&ocirc;ng chứng, hồ sơ đ&atilde; nộp kh&ocirc;ng ho&agrave;n lại)</p>
<p>Mọi thắc mắc về c&ocirc;ng việc vui l&ograve;ng li&ecirc;n hệ:</p>
<p><strong>C&ocirc;ng ty TNHH &ndash; Thương Mại Dịch Vụ Khởi Nguồn</strong><br /> <strong>Địa chỉ: </strong>21 Tự Lập, Phường 4, Quận T&acirc;n B&igrave;nh, Tp.Hồ Ch&iacute; Minh<br /> <strong>Hotline:</strong> 1900 636045<br /> <strong>Mail</strong>: <a href="mailto:mailto:hotro@huongbien.vn">hotro@hasasa.vn</a></p>
<p><strong>Thời gian l&agrave;m việc:</strong></p>
<table>
<tbody>
<tr><th>Thứ 2 - Thứ 6</th><th>Thứ 7 - Chủ Nhật</th></tr>
<tr>
<td>S&aacute;ng: 8 - 12 giờ</td>
<td>S&aacute;ng: 8 - 12 giờ</td>
</tr>
<tr>
<td>Chiều: 13-23 giờ</td>
<td>Chiều: 13-21 giờ</td>
</tr>
</tbody>
</table>', 1)
INSERT [dbo].[tbl_information] ([id], [TenTT], [NoiDung], [Status]) VALUES (9, N'Liên hệ', N'<p>
	<strong>Công ty TNHH – Thương Mại Dịch Vụ Khởi Nguồn</strong><br>
	<strong>Địa chỉ: </strong>21 Tự Lập, Phường 4, Quận Tân Bình, Tp.Hồ Chí Minh<br>
	<strong>Hotline:</strong> <span style="color: rgb(192, 80, 77);">1900 636045 - 0913.456.991 - 0913.456.993</span><br>
	<strong>Mail</strong>: <span style="color: rgb(192, 80, 77);"><a href="mailto:mailto:hotro@huongbien.vn">hotro@huongbien.vn</a></span></p><p>
	<strong>Thời gian làm việc:</strong></p>
<table style="border-collapse: collapse;" border="1" cellpadding="5" cellspacing="0">
<tbody>
<tr>
	<th>
		<span style="color: rgb(192, 80, 77);">
		Thứ 2 - Thứ 6
		</span>
	</th>
	<th>
		<span style="color: rgb(192, 80, 77);">
		Thứ 7 - Chủ Nhật
		</span>
	</th>
</tr>
<tr>
	<td>
		Sáng: 8 - 12 giờ
	</td>
	<td>
		Sáng: 8 - 12 giờ
	</td>
</tr>
<tr>
	<td>
		Chiều: 13&nbsp;-&nbsp;20 giờ
	</td>
	<td>
		Chiều: 13-20 giờ
		<br>
	</td>
</tr>
</tbody>
</table>', 1)
SET IDENTITY_INSERT [dbo].[tbl_information] OFF
SET IDENTITY_INSERT [dbo].[tbl_menu] ON 

INSERT [dbo].[tbl_menu] ([id], [TenMenu], [url], [ThuTu], [Status]) VALUES (1, N'Trang chủ', N'/Home/Index', 1, 1)
INSERT [dbo].[tbl_menu] ([id], [TenMenu], [url], [ThuTu], [Status]) VALUES (2, N'Tươi sống', N'/Home/ProductType/1', 2, 1)
INSERT [dbo].[tbl_menu] ([id], [TenMenu], [url], [ThuTu], [Status]) VALUES (3, N'Khô', N'/Home/ProductType/2', 3, 1)
INSERT [dbo].[tbl_menu] ([id], [TenMenu], [url], [ThuTu], [Status]) VALUES (4, N'Đông lạnh', N'/Home/ProductType/3', 4, 1)
INSERT [dbo].[tbl_menu] ([id], [TenMenu], [url], [ThuTu], [Status]) VALUES (5, N'Cá tươi mỗi ngày', N'/Home/Laycatuoi', 5, 1)
SET IDENTITY_INSERT [dbo].[tbl_menu] OFF
SET IDENTITY_INSERT [dbo].[tbl_menubottom] ON 

INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (1, N'Về thuyhaisancamau.com', N'/Home/infomation/1', 1, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (2, N'Chính sách & quy định chung', N'/Home/infomation/4', 2, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (3, N'Chính sách bảo mật', N'/Home/infomation/5', 3, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (4, N'Sơ đồ web', N'/Home/Sodoweb', 4, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (5, N'Liên hệ', N'/Home/infomation/9', 5, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (6, N'Hướng dẫn mua hàng', N'/Home/infomation/2', 6, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (7, N'Hướng dẫn thanh toán', N'/Home/infomation/3', 7, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (8, N'Chính sách Trả hàng & Hoàn tiền', N'/Home/infomation/7', 8, 1)
INSERT [dbo].[tbl_menubottom] ([id], [tenmenu], [url], [thutu], [status]) VALUES (9, N'Quy trình xử lý khiếu nại', N'/Home/infomation/6', 9, 1)
SET IDENTITY_INSERT [dbo].[tbl_menubottom] OFF
SET IDENTITY_INSERT [dbo].[tbl_news] ON 

INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (4, N'HẢI SẢN NÀO PHÙ HỢP BỔ SUNG DINH DƯỠNG CHO MẸ BẦU', N'<p>Mẹ Bầu n&ecirc;n ăn những loại hải sản n&agrave;o lu&ocirc;n l&agrave; c&acirc;u hỏi được nhiều người quan t&acirc;m nhất??? Vậy n&ecirc;n ăn hải sản n&agrave;o để cả Mẹ v&agrave; B&eacute; đều khỏe mạnh? Em b&eacute; hấp thụ đầy đủ chất dinh dưỡng nhất v&agrave; th&ocirc;ng minh ngay từ khi c&ograve;n nằm trong bụng Mẹ?</p>', N'', N'<p>Mẹ Bầu n&ecirc;n ăn những loại hải sản n&agrave;o lu&ocirc;n l&agrave; c&acirc;u hỏi được nhiều người quan t&acirc;m nhất??? Vậy n&ecirc;n ăn hải sản n&agrave;o để cả Mẹ v&agrave; B&eacute; đều khỏe mạnh? Em b&eacute;&nbsp;hấp thụ đầy đủ chất dinh dưỡng nhất v&agrave; th&ocirc;ng minh&nbsp;ngay từ khi c&ograve;n nằm trong bụng Mẹ?<br /><br /><strong>Hải sản</strong> l&agrave; nguồn dưỡng chất cực tốt cho b&agrave; bầu. Hải sản bao gồm c&aacute;, t&ocirc;m, cua, s&ograve;, ốc&hellip; cung cấp rất nhiều dưỡng chất c&oacute; lợi như protein, &iacute;t chất b&eacute;o b&atilde;o h&ograve;a v&agrave; rất gi&agrave;u axit omega-3 tốt cho sức khỏe, bổ sung sắt v&agrave; canxi cho cơ thể gi&uacute;p cả Mẹ v&agrave; B&eacute; đều khỏe mạnh. Bạn n&ecirc;n ăn hải sản điều độ v&agrave; thay đổi lu&acirc;n phi&ecirc;n để tr&aacute;nh bị ng&aacute;n<br /><br /><strong>✤ NHỮNG ĐIỀU MẸ BẦU CẦN LƯU &Yacute; N&Ecirc;N TR&Aacute;NH</strong><br /><br /></p>
<p>B&agrave; bầu n&ecirc;n tr&aacute;nh những loại c&aacute; biển (chứa nhiều thủy ng&acirc;n) như c&aacute; mập, c&aacute; kiếm, c&aacute; ngừ&hellip; C&aacute; hồi c&oacute; lượng thủy ng&acirc;n thấp n&ecirc;n bạn vẫn c&oacute; thể sử dụng (khoảng 1 bữa/tuần).</p>
<p>Kh&ocirc;ng ăn c&aacute; sống, gỏi c&aacute;, m&oacute;n sushi&hellip; C&aacute;c loại c&aacute; chưa được nấu ch&iacute;n dễ bị nhiễm khuẩn E.coli v&agrave; s&aacute;n n&ecirc;n c&oacute; thể g&acirc;y ngộ độc. Chỉ n&ecirc;n sử dụng những loại c&aacute; tươi v&agrave; nấu ch&iacute;n kỹ trước khi sử dụng. Kh&ocirc;ng n&ecirc;n ăn qu&aacute; 350g c&aacute;/tuần (chia đều khoảng 3 bữa c&aacute;, mỗi bữa khoảng 100g).</p>
<p>B&agrave; bầu kh&ocirc;ng n&ecirc;n ăn nội tạng c&aacute; hay c&aacute;c loại dầu gan c&aacute; v&igrave; ch&uacute;ng chứa rất nhiều vitamin A. Một lượng lớn vitamin A từ cơ thể người mẹ c&oacute; thể g&acirc;y hại cho em b&eacute;.</p>
<p>V&igrave; c&aacute; (t&ocirc;m, cua&hellip;) cũng rất gi&agrave;u chất đạm, bạn n&ecirc;n c&acirc;n bằng hợp l&yacute; nguồn dinh dưỡng n&agrave;y với c&aacute;c loại thực phẩm kh&aacute;c như thịt gia s&uacute;c, gia cầm. Nếu bữa cơm đ&atilde; c&oacute; m&oacute;n c&aacute; (t&ocirc;m, cua&hellip;) th&igrave; bạn n&ecirc;n cắt giảm c&aacute;c m&oacute;n chứa thịt.<br /><br /><strong>✤ HẢI SẢN GI&Agrave;U DINH DƯỠNG MẸ BẦU N&Ecirc;N ĂN</strong><br /><br />Theo lời khuy&ecirc;n của c&aacute;c chuy&ecirc;n gia, b&agrave; bầu n&ecirc;n bổ sung đủ 350-400 gram hải sản mỗi tuần, n&ecirc;n bổ sung đều đặn v&agrave; c&acirc;n bằng trong chế độ ăn uống hằng ng&agrave;y để cơ thể người Mẹ khỏe mạnh, khi đ&oacute; B&eacute; mới hấp thu đủ chất dinh dưỡng từ cơ thể của Mẹ&nbsp;<br /><br />Những b&agrave; mẹ ăn c&aacute; (t&ocirc;m, cua&hellip;) trong thời gian mang thai c&oacute; khả năng giảm 72% hội chứng hen suyễn ở b&eacute; sau n&agrave;y. B&ecirc;n cạnh đ&oacute;, nh&oacute;m b&agrave; mẹ ăn 1-2 bữa c&aacute; (t&ocirc;m, cua&hellip;) một tuần cũng c&oacute; t&aacute;c dụng ph&ograve;ng tr&aacute;nh được chứng ch&agrave;m bội nhiễm ở b&eacute; &ndash; Đ&acirc;y l&agrave; kết quả nghi&ecirc;n cứu của c&aacute;c nh&agrave; khoa học Anh quốc.<br /><br />Khi c&oacute; thai, đặc biệt l&agrave; từ th&aacute;ng thứ 3 trở đi cho đến l&uacute;c sinh nở, nhu cầu về năng lượng v&agrave; c&aacute;c chất dinh dưỡng của thai phụ tăng l&ecirc;n rất nhiều. Theo nhu cầu khuyến nghị về dinh dưỡng cho người VIệt Nam của Bộ Y tế, phụ nữ mang thai cần ăn th&ecirc;m mức năng lượng khoảng 300 &ndash; 500kcal v&agrave; cần tăng cường ăn th&ecirc;m kho&aacute;ng chất như canxi, sắt&hellip; mỗi ng&agrave;y để đảm bảo cung cấp dinh dưỡng gi&uacute;p thai nhi ph&aacute;t triển tốt nhất.</p>
<p>&nbsp;</p>
<p><strong>1. C&aacute; ngừ</strong></p>
<p>Đ&acirc;y l&agrave; loại&nbsp;<strong><a href="http://www.dinhduongbabau.vn/">hải sản cần thiết bổ sung dinh dưỡng cho b&agrave; bầu</a>.&nbsp;</strong>C&oacute; nhiều người khi mang bầu lại kh&ocirc;ng d&aacute;m ăn c&aacute; ngừ v&igrave; sợ bị phong, nghĩ rằng kh&ocirc;ng tốt cho sức khỏe. Đ&oacute; l&agrave; quan niệm sai lầm. C&aacute; ngừ l&agrave; nguồn thực phẩm dồi d&agrave;o vitamin B6 c&oacute; t&aacute;c dụng rất tốt cho sức khỏe cơ bắp, da v&agrave; m&aacute;u của b&agrave; bầu<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/N%E1%BA%A1c%20c%C3%A1%20ng%E1%BB%AB.jpg" alt="" width="600" /><br /><br /></p>
<p><strong>2. Con trai&nbsp;</strong></p>
<p>C&aacute;c m&oacute;n ăn từ trai gi&uacute;p bổ sung canxi v&agrave; đặc biệt c&ograve;n gi&uacute;p b&agrave; bầu giảm chứng hoa mắt ch&oacute;ng mặt v&agrave; thiếu m&aacute;u. Ngo&agrave;i ra, c&aacute;c m&oacute;n ăn từ trai như canh trai nấu rau mồng tơi, ch&aacute;o trai...cũng l&agrave; m&oacute;n ăn bổ dưỡng tốt cho người bị đ&aacute;i th&aacute;o đường, tăng huyết &aacute;p&hellip;<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/Canh%20trai.jpg" alt="" width="600" /></p>
<div><br />
<p><strong>3. H&agrave;u</strong></p>
<p>H&agrave;u l&agrave; loại<em>&nbsp;hải sản cần thiết bổ sung dinh dưỡng cho b&agrave; bầu&nbsp;</em>v&igrave; n&oacute; l&agrave; nguồn thực phẩm dồi d&agrave;o chất sắt v&agrave; vitamin B12. Tuy nhi&ecirc;n b&agrave; bầu cần ch&uacute; &yacute; phải ăn h&agrave;u đ&atilde; được chế biến sạch v&agrave; ch&iacute;n để tr&aacute;nh đau bụng v&agrave; mắc c&aacute;c bệnh kh&aacute;c li&ecirc;n quan đến ti&ecirc;u h&oacute;a</p>
<p><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/12369232_942521769174809_3359792190065496277_n.jpg" alt="" width="600" /><br /><br /></p>
<p><strong>4. C&aacute; m&ograve;i</strong></p>
<p>C&aacute; m&ograve;i rất gi&agrave;u canxi &ndash; l&agrave; nguồn dưỡng chất cần thiết cho&nbsp;thai phụ. Bạn c&oacute; thể ăn m&oacute;n c&aacute; n&agrave;y với salad khoai t&acirc;y v&agrave; nước sốt sẽ rất ngon miệng đấy<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/C%C3%A1%20M%C3%B2i.jpg" alt="" width="600" /><br /><br /></p>
<p><strong>5. T&ocirc;m</strong></p>
<p>T&ocirc;m rất gi&agrave;u chất dinh dưỡng đặc biệt l&agrave; canxi. V&igrave; vậy, chị em đừng bỏ qua loại&nbsp;<span style="text-decoration: underline;">hải sản cần thiết bổ sung dinh dưỡng cho b&agrave; bầu</span>&nbsp;n&agrave;y trong chế độ ăn h&agrave;ng tuần.</p>
<p style="text-align: left;">T&ocirc;m c&oacute; thể chế biến được rất nhiều m&oacute;n ngon như t&ocirc;m chi&ecirc;n, t&ocirc;m hấp&hellip;&nbsp;<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/%5EB33B370CFA4D2D04CE246E7CC280EB2A598A252A2729E4E65A%5Epimgpsh_fullsize_distr.jpg" alt="" width="600" /><strong><br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; T&ocirc;m H&ugrave;m BaBy </strong>thịt săn chắc, dai ngọt, gi&agrave;u dinh dưỡng n&ecirc;n c&aacute;c Mẹ thường bổ sung hằng tuần<br /><br /><br /><strong>6. C&aacute; hồi</strong></p>
<p>C&aacute; hồi l&agrave; nguồn thực phẩm rất gi&agrave;u vitamin B12, canxi. Bạn h&atilde;y thử chế biến m&oacute;n n&agrave;y với củ cải đường, nước sốt sữa chua v&agrave; c&aacute;c loại gia vị kh&aacute;c&hellip; sẽ rất hấp dẫn đấy<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="../../images/C%C3%A1%20H%E1%BB%93i%20N%C6%B0%E1%BB%9Bng.jpg" alt="" width="600" /><br /><br /><strong>7. Ngao - S&ograve; - Ốc&nbsp;</strong></p>
<p>Về mặt dinh dưỡng, Ngao - S&ograve; - Ốc l&agrave; thực phẩm cung cấp năng lượng, đặc biệt l&agrave; bổ sung chất đạm, kho&aacute;ng chất (canxi, sắt&hellip;), mỡ, cacbon hydrate&hellip; cho cơ thể. Ốc c&oacute; vị ngọt, t&iacute;nh h&agrave;n rất dễ ăn v&agrave; kh&ocirc;ng g&acirc;y ng&aacute;n như c&aacute;c m&oacute;n ăn kh&aacute;c n&ecirc;n đ&acirc;y cũng l&agrave; loại thực phẩm rất tốt cho thai phụ<br /><br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/%5EC769B4974D6C563056E70C6498A5094FD03712A337C8669A9F%5Epimgpsh_fullsize_distr.jpg?1471412403406" alt="" width="600" /><br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<strong> Ngao 2 Cồi</strong> thịt dai, ngọt lịm n&ecirc;n lu&ocirc;n l&agrave; sự lựa chọn h&agrave;ng đầu cho c&aacute;c Mẹ Bầu<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/%5EF684C13B446DBC341D91D6E99C9264C3D35F5E9A59F78FFCF4%5Epimgpsh_fullsize_distr.jpg?1471412438280" alt="" width="600" /><br /><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Ốc Hương</strong> thit dai gi&ograve;n, ngọt hậu, b&eacute;o b&eacute;o n&ecirc;n c&aacute;c Mẹ hay mua về hấp sả, hấp gừng<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/%5EB6D96C5D1A465E73E5E5024629BCA5303E5949B4BFED6EE396%5Epimgpsh_fullsize_distr.jpg?1471412470785" alt="" width="600" /><br /><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Vẹm Xanh</strong> thịt mềm ngọt, dễ ăn n&ecirc;n c&aacute;c Mẹ Bầu thường mua về nấu ch&aacute;o</p>
<p>&nbsp;</p>
</div>', 1, CAST(N'2016-10-23 20:41:09.457' AS DateTime), 1)
INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (14, N'7 LỢI ÍCH VÀNG TỪ HẢI SẢN MANG LẠI CHO SỨC KHỎE', N'Tại Sao Bạn Nên Bổ Sung Hải Sản Thường Xuyên??? ', N'images/Hải_sản.jpg', N'  <strong>Tại Sao Bạn N&ecirc;n Bổ Sung Hải Sản Thường Xuy&ecirc;n???&nbsp;</strong><br />✤Cho d&ugrave; bạn l&agrave; ai, cho d&ugrave; bạn l&agrave;m nghề g&igrave; th&igrave; sức khỏe l&agrave; đều quan trọng nhất n&ecirc;n ăn uống phải đầy đủ chất, đủ dinh dưỡng th&igrave; cơ thể mới khỏe mạnh, năng lượng mới dồi d&agrave;o, &yacute; tưởng mới phong ph&uacute;, l&agrave;m việc mới hiệu quả đ&uacute;ng kh&ocirc;ng ạ?<br />✤Ăn hải sản thật sự rất tốt cho sức khỏe v&igrave; hải sản gi&agrave;u vitamin v&agrave; kho&aacute;ng chất tự nhi&ecirc;n..... Vậy lợi &iacute;ch thật sự m&agrave; hải sản mang lại cho sức khỏe l&agrave; g&igrave;?<br /><br /><strong>1. Hải Sản Gi&uacute;p Ngăn Ngừa Bệnh Trầm Cảm</strong><br /><br />Hầu hết mọi người đều c&oacute; khả năng bị bệnh trầm cảm do stress k&eacute;o d&agrave;i. Trầm cảm c&oacute; li&ecirc;n quan đến h&agrave;m lượng axit b&eacute;o omega 3 trong cơ thể thấp. Trong khi đ&oacute;, hải sản chứa c&aacute;c hợp chất gi&uacute;p giảm nguy cơ bị mất tr&iacute; nhớ,<a href="http://afamily.vn/suc-khoe/vitamin-b-kim-ham-tien-trien-cua-benh-alzheimer-20100912075853805.chn" target="_blank">Alzheimer</a>&nbsp;v&agrave; trầm cảm ở mức độ n&agrave;o đ&oacute;.&nbsp;<strong>Hải sản&nbsp;</strong>l&agrave;m tăng lượng axit b&eacute;o omega3 (đặc biệt l&agrave; DHA) cho cơ thể. Ch&iacute;nh v&igrave; thế n&oacute; c&oacute; thể l&agrave;m giảm c&aacute;c dấu hiệu trầm cảm v&agrave; chống lại chứng trầm cảm kinh ni&ecirc;n.<br /><strong><br />2. Hải Sản Gi&uacute;p Cải Thiện Thị Gi&aacute;c</strong><br /><br />Trong c&aacute;c loại<strong>&nbsp;hải sản</strong>, đặc biệt l&agrave; c&aacute;c loại c&aacute; b&eacute;o rất gi&agrave;u axit b&eacute;o omega 3. Ch&iacute;nh v&igrave; vậy, nếu bạn thường xuy&ecirc;n ăn thủy hải sản sản sẽ rất tốt cho thị lực của mắt. Trong c&aacute;c loại t&ocirc;m, cua, rất gi&agrave;u vitamin A, c&oacute; t&aacute;c dụng cải thiện tầm nh&igrave;n. Một người ăn hải sản thường xuy&ecirc;n cũng c&oacute; thể cải thiện được t&igrave;nh trạng tho&aacute;i h&oacute;a điểm v&agrave;ng của mắt khi về gi&agrave;.<br /><br /><strong>3. Hải Sản Rất Tốt Cho Phổi, Cải Thiện Bệnh Hen Suyễn</strong><br /><br />
<p>Trong nhiều c&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu, c&aacute; được chứng minh l&agrave; một loại thực phẩm gi&uacute;p bảo vệ phổi. Trong c&aacute; c&oacute; nhiều vitamin D. Khi thiếu hụt loại vitamin n&agrave;y sẽ l&agrave;m giảm chức năng phổi một c&aacute;ch trầm trọng. C&aacute; b&eacute;o v&agrave; dầu c&aacute; l&agrave; hai nguồn cung cấp dồi d&agrave;o loại vitamin n&agrave;y. V&igrave; vậy n&oacute; rất tốt cho những người c&oacute; tiền sử bị bệnh về phổi, đặc biệt l&agrave; hen suyễn.</p>
<div>Ngo&agrave;i ra, c&aacute; c&ograve;n gi&agrave;u axit b&eacute;o omega-3, rất tốt cho sức khỏe của to&agrave;n bộ cơ thể, trong đ&oacute; c&oacute; cả phổi<br /><br /><strong>4. Hải Sản Gi&uacute;p l&agrave;n Da S&aacute;ng V&agrave; Khỏe Mạnh</strong><br /><br />Dầu c&aacute; hoặc c&aacute; tươi rất gi&agrave;u omega 3 axit b&eacute;o v&agrave; protein. Protein tự nhi&ecirc;n gi&uacute;p l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a ở phụ nữ. N&oacute; cũng th&uacute;c đẩy qu&aacute; tr&igrave;nh sản sinh ra collagen trong cơ thể. Như vậy axit b&eacute;o Omega 3 trong&nbsp;<strong>hải sản&nbsp;</strong>gi&uacute;p bạn duy tr&igrave; một l&agrave;n da tươi trẻ. Bổ sung thường xuy&ecirc;n c&aacute;c loại hải sản kh&aacute;c nhau v&agrave;o chế độ ăn uống của m&igrave;nh, bạn sẽ duy tr&igrave; được một l&agrave;n da s&aacute;ng v&agrave; khỏe mạnh<br /><br /><strong>5. Hải Sản Tốt Cho Tim Mạch</strong><br /><br />Lượng axit b&eacute;o omega 3 c&oacute; trong<strong>&nbsp;hải sản&nbsp;</strong>gi&uacute;p ngăn ngừa nguy cơ mắc bệnh tim mạch. l&agrave;m giảm h&agrave;m lượng chất b&eacute;o triglyceride trong m&aacute;u, giảm mức độ cholesterol xấu trong cơ thể. V&igrave; vậy, để đảm bảo sức khỏe tim mạch, bạn h&atilde;y ăn c&aacute;c loại hải sản &iacute;t nhất 2 lần/tuần<br /><br /><strong>6. Hải Sản Tốt Cho Bệnh Thiếu M&aacute;u</strong><br /><br />Hải sản rất gi&agrave;u sắt v&agrave; kẽm, đ&oacute; l&agrave; những dưỡng chất rất tốt để cải thiện c&aacute;c vấn đề xấu của bệnh thiếu m&aacute;u. Việc bạn thường xuy&ecirc;n ăn hải sản sẽ gi&uacute;p tăng mức độ hemoglobin của cơ thể. B&ecirc;n cạnh đ&oacute;, trong hải sản gi&agrave;u kẽm, cũng gi&uacute;p cho m&aacute;i t&oacute;c của bạn th&ecirc;m khỏe, đẹp<br /><br />
<p><strong>7. Hải Sản Gi&uacute;p Duy Tr&igrave; Độ Chắc Khỏe Cho Xương</strong><br /><br />Trong&nbsp;<strong>hải sản</strong>&nbsp;gi&agrave;u h&agrave;m lượng canxi, rất tốt việc đảm bảo sức khỏe của hệ xương. Trong thực tế, nếu bạn coi hải sản l&agrave; nguồn thực phẩm thường xuy&ecirc;n trong chế độ ăn uống của m&igrave;nh, n&oacute; sẽ gi&uacute;p cơ thể bạn giảm nhẹ c&aacute;c vấn đề li&ecirc;n quan đến đau khớp,&nbsp;<a href="http://afamily.vn/suc-khoe/dung-de-benh-khop-la-noi-lo-cua-ban-20100723052650400.chn">vi&ecirc;m khớp.</a></p>
<div>B&ecirc;n cạnh đ&oacute;, protein trong c&aacute; c&ograve;n c&oacute; t&aacute;c dụng gi&uacute;p bạn củng cố cơ bắp sau những giờ luyện tập thể thao<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/H%E1%BA%A3i%20s%E1%BA%A3n.jpg?1471409661893" alt="" width="600" /></div>
</div>', 0, CAST(N'2016-10-20 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (19, N'BÀO NGƯ XÀO NẤM ĐÔNG CÔ - NGỌT THƠM KHÓ CƯỠNG', N'Bào Ngư là loại hải sản quý hiếm, giàu dinh dưỡng, thịt giòn dai hấp dẫn. Bào Ngư có khả năng bổ âm, tăng khí, hạ nhiệt, tăng cường sinh lực cho nam giới, giúp sáng mắt, trị ho, khó tiêu', N'images/1936182_499482076843249_1667447404869295854_n.jpg', N'<span><strong>B&agrave;o Ngư</strong>&nbsp;l&agrave; loại hải sản qu&yacute; hiếm, gi&agrave;u dinh dưỡng, thịt gi&ograve;n dai hấp dẫn.&nbsp;<strong>B&agrave;o Ngư</strong>&nbsp;c&oacute; khả năng bổ &acirc;m, tăng kh&iacute;, hạ nhiệt, tăng cường sinh lực cho nam giới, gi&uacute;p s&aacute;ng mắt, trị ho, kh&oacute; ti&ecirc;u. Một trong c&aacute;c m&oacute;n ăn ngon từ B&agrave;o Ngư phải kể đến đ&oacute; l&agrave;&nbsp;<strong>B&agrave;o Ngư X&agrave;o Nấm Đ&ocirc;ng C&ocirc;</strong>. Vị ngọt thơm từ nấm đ&ocirc;ng c&ocirc; v&agrave; cải th&igrave;a h&ograve;a quyện c&ugrave;ng vị gi&ograve;n sật của&nbsp;<strong>B&agrave;o Ngư</strong>&nbsp;sẽ l&agrave;m bạn cứ muốn thưởng thức th&ecirc;m<br /><br /><br /><strong>NGUY&Ecirc;N LIỆU</strong><br /><br />-&nbsp;200 gram b&agrave;o ngư tươi<br />- 150g cải th&igrave;a</span><br /><span>- 10 nấm đ&ocirc;ng c&ocirc;</span><br /><span>- 1 củ h&agrave;nh t&iacute;m</span><br /><span>- 1 củ gừng vắt lấy nước cốt&nbsp;</span><br /><span>- Gia vị: dầu ăn, dầu m&egrave;, nước tương, đường, muối<br /><span><br /><strong>THỰC HIỆN</strong><br /><br />- Cải th&igrave;a rửa sạch, xẻ l&agrave;m hai, trụng qua nước s&ocirc;i, vớt ra cho v&agrave;o chậu nước lạnh để rau được xanh<br /></span><br /><span>- Nấm đ&ocirc;ng c&ocirc; ng&acirc;m nước cho mềm,&nbsp; cắt bỏ phần cuống<br /></span><br /><span>- B&agrave;o Ngư mua từ Hasasa.vn về, r&atilde; đ&ocirc;ng ở nhiệt độ thường khoảng 20 - 30 ph&uacute;t. Sau đ&oacute; d&ugrave;ng b&agrave;n chải đ&aacute;nh răng sạch ch&agrave; 2 m&eacute;p viền đen v&agrave; bề mặt của b&agrave;o ngư. Tiếp đến, c&aacute;c bạn d&ugrave;ng mũi dao nhọn nạy phần thịt b&agrave;o ngư l&ecirc;n, cắt bỏ phần nội tạng m&agrave;u đen ph&iacute;a b&ecirc;n dưới của n&oacute; v&agrave; ch&agrave; sạch lu&ocirc;n bề mặt b&agrave;o ngư, rửa sạch, để nguy&ecirc;n con hoặc th&aacute;i mỏng t&ugrave;y th&iacute;ch<br /></span><br /><span>- Phi thơm h&agrave;nh t&iacute;m, cho b&agrave;o ngư v&agrave;o x&agrave;o,&nbsp; n&ecirc;m dầu ăn, nước tương, đường, muối cho vừa miệng. Tr&uacute;t nấm đ&ocirc;ng c&ocirc; v&agrave;o x&agrave;o tiếp, khi nấm mềm th&igrave; cho cải th&igrave;a v&agrave;o đảo nhanh tay. Sau c&ugrave;ng cho dầu m&egrave;, nước cốt gừng, b&agrave;y ra đĩa tr&ograve;n, dọn d&ugrave;ng n&oacute;ng<br /><br /></span><strong>Hasasa.vn ch&uacute;c bạn thực hiện th&agrave;nh c&ocirc;ng m&oacute;n ăn n&agrave;y!<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/1936182_499482076843249_1667447404869295854_n.jpg?1471337830241" alt="" width="600" /></strong></span>
            </div>', 0, CAST(N'2016-10-20 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (22, N'CƠM CHIÊN CUA VÀ BẮP - ĐẬM ĐÀ NGON MIỆNG', N'Cơm Chiên là một món ngon dễ ăn, dễ chế biến nên rất phù hợp đưa vào thực đơn bữa cơm gia đình', N'images/Cơm chiên cua.jpg', N'<p>Cơm Chi&ecirc;n l&agrave; một m&oacute;n ngon dễ ăn, dễ chế biến n&ecirc;n rất ph&ugrave; hợp đưa v&agrave;o thực đơn bữa cơm gia đ&igrave;nh. Tận dụng cơm nguội bạn c&oacute; thể l&agrave;m ngay m&oacute;n <strong>CƠM&nbsp;CHI&Ecirc;N CUA V&Agrave; BẮP</strong>&nbsp;hấp dẫn, hạt cơm rang săn lại, kết hợp c&ugrave;ng vị ngọt đậm đ&agrave; từ thịt cua v&agrave; vị ngọt lịm từ ng&ocirc; ăn rất ghiền.<br /><br /><br /><strong>NGUY&Ecirc;N LIỆU</strong><br /><br /><span>- 1 con cua lớn</span><br /><span>- 1 quả ng&ocirc; nếp hay ng&ocirc; hạt v&agrave;ng, bạn c&oacute; thể th&ecirc;m đậu H&agrave; Lan t&ugrave;y theo sở th&iacute;ch của bạn</span><br /><span>- 1 l&ograve;ng đỏ trứng vịt muối</span><br /><span>- 1-2 quả trứng g&agrave;</span><br /><span>- 1 b&aacute;t cơm nguội lớn</span><br /><span>- Muối, hạt n&ecirc;m, h&agrave;nh kh&ocirc;, h&agrave;nh l&aacute;, hạt ti&ecirc;u, nước mắm v&agrave; dầu điều<br /><br /></span><strong>THỰC HIỆN</strong><br /><br /></p>
<p><span>- Cua rửa sạch dưới v&ograve;i nước lạnh, cho cua v&agrave;o nồi, đậy k&iacute;n nắp nồi, đun lửa nhỏ đến khi cua ch&iacute;n. Vớt cua ra để v&agrave;o đĩa để cua nguội, t&aacute;ch bỏ lấy thịt cua ra ri&ecirc;ng v&agrave; gạch cua để ra ri&ecirc;ng<br /></span><br /><span>- Đun n&oacute;ng dầu điều, phi h&agrave;nh kh&ocirc; thơm, đổ gạch cua v&agrave;o x&agrave;o sơ, th&ecirc;m thịt cua v&agrave;o đảo đều, n&ecirc;m v&agrave;o một th&igrave;a nhỏ nước mắm, một th&igrave;a nhỏ muối, một &iacute;t hạt ti&ecirc;u, đảo đều<br /></span><br /><span>- Tiếp theo cho ng&ocirc; v&agrave; l&ograve;ng đỏ trứng vịt muối v&agrave;o đảo c&ugrave;ng đến khi ăn thử hạt ng&ocirc; ch&iacute;n mềm<br /><br /></span>- Sau đ&oacute; cho cơm v&agrave;o d&ugrave;ng mu&ocirc;i lớn trộn đều để thịt cua, trứng vịt muối trộn đều với cơm<br /><br />- Đ&aacute;nh tan trứng g&agrave;, rưới từ từ v&agrave;o chảo cơm rang, đảo đều, n&ecirc;m th&ecirc;m gia vị cho vừa ăn<br /><br /><span>- Bạn n&ecirc;n rang lửa nhỏ để hạt cơm săn lại v&agrave; kh&ocirc;, n&ecirc;m nếm khẩu vị vừa ăn, tắt bếp th&ecirc;m h&agrave;nh l&aacute; th&aacute;i nhỏ v&agrave;o, m&uacute;c ra đĩa rắc một &iacute;t hạt ti&ecirc;u l&ecirc;n bề mặt.</span></p>
<p class="Normal"><br /><strong>Hasasa.vn ch&uacute;c bạn thực hiện th&agrave;nh c&ocirc;ng m&oacute;n ăn n&agrave;y!<br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/C%C6%A1m%20chi%C3%AAn%20cua.jpg?1471335970011" alt="" width="600" /><br /></strong></p>
<p class="Normal">&nbsp;</p>
<div>&nbsp;</div>
<br />
<table class="showborder" style="margin: 0px auto 10px; padding: 0px; max-width: 100%; min-width: 1px; font-family: arial;" cellspacing="0" cellpadding="3">
<tbody style="margin: 0px; padding: 0px;">
<tr style="margin: 0px; padding: 0px;">
<td style="margin: 0px; padding: 0px; vertical-align: middle;">
<p class="Folder" style="margin-bottom: 1em; padding-top: 0px; padding-bottom: 0px; font-stretch: normal; line-height: 18px; font-family: arial;">Bước 3:</p>
- Tiếp theo cho ng&ocirc; v&agrave; l&ograve;ng đỏ trứng vịt muối v&agrave;o đảo c&ugrave;ng đến khi ăn thử hạt ng&ocirc; ch&iacute;n mềm.</td>
</tr>
</tbody>
</table>
            </div>
        </div>
        ', 1, CAST(N'2016-10-20 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (25, N'MỰC XÀO CÀ RI - GIÒN CAY THƠM NỨC MŨI', N'NULLMực Xào Cà Ri là một món ăn khá hấp dẫn, bạn có thể bổ sung vào thực đơn cơm trưa hoặc cơm chiều cho gia đình.', N'images/Mực_ống_xào_ca_ri.jpg', N' <p><strong>Mực X&agrave;o C&agrave; Ri</strong>&nbsp;l&agrave; một m&oacute;n ăn kh&aacute; hấp dẫn, bạn c&oacute; thể bổ sung v&agrave;o thực đơn cơm trưa hoặc cơm chiều cho gia đ&igrave;nh. M&oacute;n n&agrave;y sẽ l&agrave;m h&agrave;i l&ograve;ng bạn bởi mực x&agrave;o gi&ograve;n m&agrave; kh&ocirc;ng bị dai, quyện với m&ugrave;i sả v&agrave; c&agrave; ri thơm nức, d&ugrave;ng l&agrave;m m&oacute;n nh&acirc;m nhi cuối ng&agrave;y hoặc ăn c&ugrave;ng cơm thật ngon miệng.<br /><br /></p>
<p><br /><strong>NGUY&Ecirc;N LIỆU</strong><br /><br /><span>- 5 con mực ống</span><br /><span>- 2 th&igrave;a canh c&agrave; ri dầu Ấn Độ</span><br /><span>- 2 t&eacute;p sả bằm</span><br /><span>- 1 củ h&agrave;nh t&iacute;m</span><br /><span>- 3 t&eacute;p tỏi</span><br /><span>- 3 quả ớt (t&ugrave;y bạn ăn cay hay kh&ocirc;ng)</span><br /><span>- Hạt n&ecirc;m, nước mắm, đường, dầu ăn.<br /><br /></span><strong>THỰC HIỆN</strong><br /><br /></p>
<p class="Normal">- Mực l&agrave;m sạch lột bỏ da, khứa vảy rồng cắt miếng vừa ăn hoặc cắt khoanh tr&ograve;n tuỳ th&iacute;ch.</p>
<p class="Normal">- Ướp mực với 2 th&igrave;a canh c&agrave; ri, h&agrave;nh t&iacute;m băm nhỏ c&ugrave;ng với ch&uacute;t hạt n&ecirc;m v&agrave; đường, để khoảng 15 ph&uacute;t cho mực thấm gia vị.</p>
<p class="Normal">- L&agrave;m n&oacute;ng chảo với 2 th&igrave;a canh dầu ăn, cho tỏi băm nhỏ v&agrave;o phi thơm. Cho tiếp sả v&agrave; ớt băm v&agrave;o đảo c&ugrave;ng. Khi thấy sả đ&atilde; v&agrave;ng v&agrave; dậy m&ugrave;i th&igrave; cho mực đ&atilde; ướp v&agrave;o x&agrave;o chung v&agrave; đảo li&ecirc;n tục cho đến khi mực ch&iacute;n. N&ecirc;m lại mực với &iacute;t nước mắm cho vừa miệng. M&uacute;c ra đĩa d&ugrave;ng n&oacute;ng.<br /><br /><strong>Hasasa.vn ch&uacute;c bạn thực hiện th&agrave;nh c&ocirc;ng m&oacute;n ăn n&agrave;y!</strong><br /><br /><br /><br /><img style="display: block; margin-left: auto; margin-right: auto;" src="http://hasasa.vn/images/companies/2/Ngao/M%E1%BB%B1c%20%E1%BB%91ng%20x%C3%A0o%20ca%20ri.jpg?1471245585782" alt="" width="600" /></p>
<p class="Normal">&nbsp;</p>', 0, CAST(N'2016-10-20 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tbl_news] ([id], [TieuDe], [TomTat], [UrlHinh], [NoiDung], [LuotXem], [NgayCapNhat], [status]) VALUES (26, N'â', N'<p>dsa</p>', N'785053aef_44636d82dd784e1a9afc43bd83618fc5.png', N'<p>dsa</p>', NULL, CAST(N'2016-10-23 20:40:53.787' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tbl_news] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product] ON 

INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (1, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(652500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 29, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 13, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (2, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(750000 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 51, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (3, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(690000 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 47, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 8, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (4, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(652500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 9, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 2, CAST(750000 AS Decimal(18, 0)), 13, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (5, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(750000 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 1, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 2, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (6, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(675000 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 3, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 2, CAST(750000 AS Decimal(18, 0)), 10, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (7, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(712500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 10, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 2, CAST(750000 AS Decimal(18, 0)), 5, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (8, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(750000 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 2, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (9, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(652500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 0, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 13, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (10, N'Cua Huỳnh Đế (Hoàng Đế)', N'51242mun-148.jpg', CAST(650001 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br />-&nbsp;Size 400 gram trở l&ecirc;n : 700,000 vnđ/kg<br />-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br />CUA HUỲNH ĐẾ TƯƠI<br />- Size 400 gram trở l&ecirc;n : 650,000 vnđ/kg<br />- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul>
<li>Xuất xứ: Quy Nhơn (B&igrave;nh Định), Ph&uacute; Y&ecirc;n, Tuy Phong (B&igrave;nh Thuận), Cam Ranh (Kh&aacute;nh H&ograve;a)</li>
<li>Sống ở v&ugrave;ng nước s&acirc;u nơi c&oacute; c&aacute;t v&agrave;ng c&aacute;ch mặt nước biển 20m- 40m kh&oacute; đ&aacute;nh bắt v&agrave; trữ sống.</li>
</ul>
<ul>
<li>Được đ&aacute;nh gi&aacute; l&agrave; Vua của c&aacute;c lo&agrave;i cua v&agrave; d&ugrave;ng để ngự d&acirc;ng cho c&aacute;c vua ch&uacute;a ng&agrave;y xưa</li>
<li>Thịt cua chắc, gạch thơm v&agrave; b&eacute;o ngậy hơn hẳn c&aacute;c loại cua ghẹ kh&aacute;c</li>
<li>Độ đạm cao, gi&agrave;u chất dinh dưỡng, gi&uacute;p tăng sinh lực ở nam giới</li>
</ul>', N'<div>
<div>CUA HUỲNH ĐẾ SỐNG<br />-&nbsp;Size 400 gram trở l&ecirc;n : 700,000 vnđ/kg<br />-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br />CUA HUỲNH ĐẾ TƯƠI<br />- Size 400 gram trở l&ecirc;n : 650,000 vnđ/kg<br />- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul>
<li>Xuất xứ: Quy Nhơn (B&igrave;nh Định), Ph&uacute; Y&ecirc;n, Tuy Phong (B&igrave;nh Thuận), Cam Ranh (Kh&aacute;nh H&ograve;a)</li>
<li>Sống ở v&ugrave;ng nước s&acirc;u nơi c&oacute; c&aacute;t v&agrave;ng c&aacute;ch mặt nước biển 20m- 40m kh&oacute; đ&aacute;nh bắt v&agrave; trữ sống.</li>
</ul>
<ul>
<li>Được đ&aacute;nh gi&aacute; l&agrave; Vua của c&aacute;c lo&agrave;i cua v&agrave; d&ugrave;ng để ngự d&acirc;ng cho c&aacute;c vua ch&uacute;a ng&agrave;y xưa</li>
<li>Thịt cua chắc, gạch thơm v&agrave; b&eacute;o ngậy hơn hẳn c&aacute;c loại cua ghẹ kh&aacute;c</li>
<li>Độ đạm cao, gi&agrave;u chất dinh dưỡng, gi&uacute;p tăng sinh lực ở nam giới</li>
</ul>
</div>', 10, 0, 5, CAST(N'2016-10-24 23:36:25.200' AS DateTime), 1, 2, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (11, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 4, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (12, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 8, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (13, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 2, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (14, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 0, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (15, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 0, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (16, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(652500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 0, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 13, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (17, N'Tôm Mũ Ni Sống (size 5 - 6 con)', N'images/^308B24528787CA23E0B18E5B52CA2421A54944158785DA02F3^pimgpsh_fullsize_distr(1).jpg', CAST(652500 AS Decimal(18, 0)), N'	<ul>
<li>Size 3 - 4 con/kg : 690,000 vnđ/kg</li>
<li>Size 5 - 6 con/kg : 650,000 vnđ/kg</li>
<li>Xuất xứ: Cam Ranh - Khánh Hòa, Phan Thiết</li>
<li>Thịt tôm ngon, ngọt dai như thịt tôm hùm,&nbsp;gạch cực thơm và béo</li>
<li>Hàng sống giao tận tay Khách</li>
<li>Hàng về tùy thời điểm, liên hệ HOTLINE&nbsp;để biết thông tin chi tiết</li>
</ul>', N'<div>Tôm Mũ Ni hay còn gọi là Tôm Vỗ. Hình dạng khá ngộ nghĩnh, trông giống như cái "mũ che tai". Chúng sống ở vùng nước ấm, nơi có nhiều san hô<br><br>Là đặc sản khá nổi tiếng của vùng biển Nha Trang, Phan Thiết, Vũng Tàu. Thịt tôm trắng tinh, mềm, ngọt, thơm, rất bổ dưỡng, dù có ăn nhiều bạn cũng không cảm thấy bị ngấy. Do vậy, tôm mũ ni được đánh giá là đẳng cấp hải vị trên bàn tiệc, được các đầu bếp danh tiếng trổ tài để thể hiện tài năng<br><br><span>Không chỉ ngon Tôm Mũ Ni còn rất giàu dinh dưỡng. Mỗi 100 gram thịt tôm mũ ni có 95 calories, 121mg cholesterol, 185g sodium, 0,8g tổng chất béo (36% chất béo bão hòa), 39mg omega-3, 49mg EPA, 45mg omega-6, AA. Do đó Tôm Mũ Ni có tác dụng tăng cường hoạt động của tế bào miễn dịch, phòng chống tế bào ung thư và bảo vệ gan hiệu quả<br><br></span>Tôm Mũ Ni được chế biến thành nhiều món ăn ngon và hấp dẫn như :&nbsp;<span>hấp tuyết nhỉ, hấp bia, hấp nước dừa, nướng sả ớt, nướng mọi, nướng bơ tỏi, nướng phô mai......<br></span><br><br><strong>MỘT SỐ HÌNH ẢNH VỀ TÔM MŨ NI<br></strong><br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh1.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Hấp Bia<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh2.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Phô Mai<br></strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh3.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Phô Mai</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13266121_503227119880579_4198280592556394225_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Rang Me</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/13165861_1810565965847137_6977335565569175486_n.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Cháy Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh4.jpg" alt="" width="600"></div>
<div style="text-align: center;"><strong><br>Tôm Mũ Ni Nướng Bơ Tỏi</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Đúc Lò</strong></div>
<br>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="/images/hinh5.jpg" alt="" width="600"></div>
<br>
<div style="text-align: center;"><strong>Tôm Mũ Ni Nướng Mọi</strong></div></div>', 10, 0, 2, CAST(N'1894-06-26 00:00:00.000' AS DateTime), 1, 1, CAST(750000 AS Decimal(18, 0)), 13, NULL)
INSERT [dbo].[tbl_Product] ([ID], [TenSP], [UrlHinh], [GiaHienTai], [MoTa], [MoTaCT], [SoLuongTon], [SLDaBan], [LuotXem], [NgayCapNhat], [Status], [IDLoaiSP], [GiaCu], [KhuyenMai], [CaTuoiMoiNgay]) VALUES (18, N'Cua Huỳnh Đế (Hoàng Đế)', N'images/1484176_993872464039739_7061766636485875711_n(1).jpg', CAST(750000 AS Decimal(18, 0)), N'<div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div>
<ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul>
<ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul>', N'<div><div>CUA HUỲNH ĐẾ SỐNG<br>-&nbsp;Size 400 gram trở lên : 700,000 vnđ/kg<br>-&nbsp;Size 3 - 4&nbsp;con/kg&nbsp;: 640,000 vnđ/kg<br>CUA HUỲNH ĐẾ TƯƠI<br>- Size 400 gram trở lên : 650,000 vnđ/kg<br>- Size 3 - 4 con/kg : 590,000 vnđ/kg</div><ul> <li>Xuất xứ: Quy Nhơn (Bình Định), Phú Yên, Tuy Phong (Bình Thuận), Cam Ranh (Khánh Hòa)</li><li>Sống ở vùng nước sâu nơi có cát vàng cách mặt nước biển 20m-  40m khó đánh bắt và trữ sống.</li></ul><ul><li>Được đánh giá là Vua của các loài cua và dùng để ngự dâng cho các vua chúa ngày xưa</li><li>Thịt cua chắc, gạch thơm và béo ngậy hơn hẳn các loại cua ghẹ khác</li><li>Độ đạm cao, giàu chất dinh dưỡng, giúp tăng sinh lực ở nam giới</li></ul></div>', 10, 0, 0, CAST(N'1905-06-23 00:00:00.000' AS DateTime), 1, 3, CAST(750000 AS Decimal(18, 0)), 0, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Product] OFF
SET IDENTITY_INSERT [dbo].[tbl_product_types] ON 

INSERT [dbo].[tbl_product_types] ([ID], [TenLoaiSP], [Status]) VALUES (1, N'Tươi sống', 1)
INSERT [dbo].[tbl_product_types] ([ID], [TenLoaiSP], [Status]) VALUES (2, N'Khô', 1)
INSERT [dbo].[tbl_product_types] ([ID], [TenLoaiSP], [Status]) VALUES (3, N'Đông lạnh', 1)
INSERT [dbo].[tbl_product_types] ([ID], [TenLoaiSP], [Status]) VALUES (5, N'danh muc ban khoi', 0)
SET IDENTITY_INSERT [dbo].[tbl_product_types] OFF
SET IDENTITY_INSERT [dbo].[tbl_shop] ON 

INSERT [dbo].[tbl_shop] ([id], [tenshop], [emailshop], [phoneshop1], [thoigianlamviec1], [masodoanhnghiep], [addressshop], [thoigianlamviec2], [phoneshop2], [longtitude], [lattitude]) VALUES (1, N'Thủy hải sản cà mau', N'hotro@hasasa.vn', N'1900.636.045 ', N'<strong style="font-size: 16px;font-family:''Open Sans''; color:#fafafa;font-weight:600">Thứ 2-6</strong><br />
Sáng: 08:00-12:00<br />
Chiều: 13:00-21:00
', N' 0312953791 do Sở Kế Hoạch Và Đầu Tư Tp.HCM cấp ngày 02/10/2014', N'21 Tự Lập, P.4, Q Tân Bình, TP.HCM', N'<strong style="font-size: 16px;font-family:''Open Sans''; color:#fafafa;font-weight:600">Thứ 7, Chủ Nhật</strong><br />
Sáng: 08:00-12:00<br />
Chiều: 13:00-21:00
Nghỉ Lễ, Tết
', N'091.3456.991', '10.7826337','106.6936984')
GO
UPDATE [dbo].[tbl_product_types]
   SET alias = ''
GO
UPDATE [dbo].[tbl_information]
   SET [GioiThieu] = 1, [alias] = ''
GO
UPDATE [dbo].[tbl_shop]
   SET [title] = '', [description] = '', [keyword] = ''
GO
UPDATE [dbo].[tbl_Product]
   SET [title] = '', [description] = '', [keyword] = '', [alias] = '',[CaTuoiMoiNgay] = 1
GO
UPDATE [dbo].[tbl_news]
   SET [title] = '', [description] = '', [keyword] = '', [alias] = ''
GO
SET IDENTITY_INSERT [dbo].[tbl_shop] OFF
USE [master]
GO
ALTER DATABASE [database] SET  READ_WRITE 
GO
