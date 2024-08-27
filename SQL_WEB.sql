---Xoa CSDL QLBansach neu da co
use master
Drop Database QLNuocGK
-----Tao CSDL QLBansach
create database QLNuocGK
GO
use QLNuocGK
GO
CREATE TABLE KHACHHANG
(
	MaKH INT IDENTITY(1,1),
	HoTen nVarchar(50) NOT NULL,
	Taikhoan nVarchar(50) UNIQUE,
	Matkhau nVarchar(50) NOT NULL,
	Email nVarchar(100) UNIQUE,
	DiachiKH nVarchar(200),
	DienthoaiKH Varchar(50),
	Ngaysinh DATETIME
	CONSTRAINT PK_Khachhang PRIMARY KEY(MaKH)
)
go
Create Table Category
(
    MaCate    Int    Identity(1,1),
    TenHangMuc    Nvarchar(50)    Not Null,
	ghichu nvarchar(100),
    Constraint Pk_Category Primary Key(MaCate)
)
go

Create Table NHASANXUAT
(
	MaNXB int identity(1,1),
	TenNXB nvarchar(50) NOT NULL,
	Diachi NVARCHAR(200),
	DienThoai nVARCHAR(50),
	CONSTRAINT PK_NhaSanXuat PRIMARY KEY(MaNXB)
)
go
Create Table SanPham
(
    MaSP    Int    Identity(1,1),
    TenSP     Nvarchar(100)    Not Null,
	AnhBia    nVarchar(100),
    GiaBan    Decimal(18,0)    Check(GiaBan>=0),
    MoTa    Nvarchar(Max),
    NgayCapNhat    DateTime,
    SoLuongTon    Int,
    MaCate  Int,
    MaNXB   Int,
    Constraint    Pk_SanPham    Primary Key(MaSP),
    Constraint    Fk_Category   Foreign Key(MaCate) References Category(MaCate),
	Constraint FK_NhaXB Foreign Key(MaNXB)References NHASANXUAT(MANXB)
)

GO
CREATE TABLE DONDATHANG
(
	MaDonHang INT IDENTITY(1,1),
	Dathanhtoan bit,
	Tinhtranggiaohang bit,
	Ngaydat Datetime,
	Ngaygiao Datetime,
	MaKH INT,
	Constraint FK_Khachhang FOREIGN KEY (MaKH) REFERENCES Khachhang(MaKH),
	CONSTRAINT PK_DonDatHang  Primary Key (MaDonHang)
)
Go
CREATE TABLE CHITIETDONTHANG
(
	MaDonHang INT,
	MaSP INT,
	Soluong Int Check(Soluong>0),
	Dongia Decimal(18,0) Check(Dongia>=0),
	CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,MaSP),
	CONSTRAINT FK_Donhang FOREIGN KEY (MaDonHang) REFERENCES DONDATHANG(MaDonHang),
	CONSTRAINT FK_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
)
ALTER TABLE SanPham
ADD NgaySanXuat DATE,
    HanSuDung DATE;
go
Create table Admin 
(
	ID INT PRIMARY KEY IDENTITY(1,1),
	UserAdmin nvarchar(30),
	PassAdmin nvarchar(30) not null,
)
go
create table NewsPost(
    PostID int identity(1,1),
    PostName nvarchar(50),
    PostImg nvarchar(50),
    PostDesc nvarchar(max),
    dayUpdated date,
    Constraint    Pk_NewsPost  primary key(PostID),
)
go

INSERT INTO Admin (UserAdmin, PassAdmin)
VALUES 
    ('admin', 'admin');

-----Thêm dữ liệu cho bảng khách hàng---	
INSERT INTO KHACHHANG (HoTen, Taikhoan, Matkhau, Email, DiachiKH, DienthoaiKH, Ngaysinh) VALUES (1, N'Nguyen Van A', N'userA', N'passwordA', N'userA@email.com', N'123 Street, City', N'123456789', N'1990-01-01 00:00:00')
INSERT INTO KHACHHANG (HoTen, Taikhoan, Matkhau, Email, DiachiKH, DienthoaiKH, Ngaysinh) VALUES (2, N'Tran Thi B', N'userB', N'passwordB', N'userB@email.com', N'456 Street, City', N'987654321', N'1995-05-15 00:00:00')
INSERT INTO KHACHHANG (HoTen, Taikhoan, Matkhau, Email, DiachiKH, DienthoaiKH, Ngaysinh) VALUES (1002, N'dương thanh tung', N'31321', N'123123', N'tungduong14092003@gmail.com', N'đồng nai', N'09512354123', N'2024-01-23 00:00:00')
----Thêm dữ liệu cho bảng nhà sản xuất---
INSERT INTO NHASANXUAT (TenNXB, Diachi, DienThoai) VALUES (1, N'Coca-Cola', N'456 Manufacturer St', N'0964835917')
INSERT INTO NHASANXUAT (TenNXB, Diachi, DienThoai) VALUES (2, N'PepsiCo', N'789 Producer St', N'123456789')
INSERT INTO NHASANXUAT (TenNXB, Diachi, DienThoai) VALUES (1002, N'Red Bull GmbH', N'N313 London StULL', N'3332114124')
INSERT INTO NHASANXUAT (TenNXB, Diachi, DienThoai) VALUES (1003, N'Tân Hiệp Phát', N'1 HoChiMinh St', N'123456789')
INSERT INTO NHASANXUAT (TenNXB, Diachi, DienThoai) VALUES (1004, N'Công ty TNHH URC', N'2 HaNoi St', N'312313211')

----Thêm dữ liệu cho bảng sản phẩm---
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (2, N'Pepsi', N'pepsi.jpg', CAST(12000 AS Decimal(18, 0)), NULL, N'2024-01-25 21:00:30', 30, 1, 2)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (5, N'NumberOne', N'number1.jpg', CAST(12000 AS Decimal(18, 0)), N' Nước, đường, chất điều chỉnh độ acit (Acid citric (330), trinatri citrat (331 iii)), Taurine, Caffeine, Inositol, Vitamin PP, màu thực phẩm tartrazin (102), Sunset yellow (110), chất tạo ngọt tổng họp Aspartam (951), hương tổng hợp dùng trong thực phẩm.', N'2024-01-30 21:00:30', 50, 5, 1003)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (6, N'Mirinda ', N'nuoc-ngot-mirinda-huong-xa-xi.jpg', CAST(10000 AS Decimal(18, 0)), N'Nước Ngọt Mirinda có hương Soda kem thơm ngon, độc đáo, giúp bạn giải nhanh cơn khát, với vị gas nhẹ, là thức uống giải khát tuyệt vời dành cho mọi lứa tuổi.
Mirinda soda kem không chỉ giúp bạn xua tan cơn khát tức thì mà còn giúp kích thích vị giác, cho bữa ăn thêm ngon miệng. Đây là thức uống không thể thiếu trong các buổi tiệc, hoạt động ngoài trời, giúp bạn tràn đầy năng lượng, căng tràn sức sống hoạt động dưới thời tiết mùa hè đầy nắng nóng.
Thành phần: Nước bão hòa, CO2, đường mía, hương soda kem giống tự nhiên, chất điều chỉnh độ axit (330), muối ăn, chất bảo quản (211), màu tổng hợp.
Hướng dẫn sử dụng: Ngon hơn khi uống lạnh, không dùng sản phẩm quá hạn sử dụng.
Hướng dẫn bảo quản: Bảo quản nơi khô mát, tránh nắng, tránh mùi mạnh và tránh hóa chất. Giữ lạnh (4-8 độ C) sau khi mở nắp và sử dụng hết trong vòng 1 ngày. Ngon hơn khi uống lạnh.
Xuất xứ: Việt Nam.', N'2024-01-20 21:00:30', 40, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (7, N'Sting', N'sting-dau.jpg', CAST(10000 AS Decimal(18, 0)), N'Nước Tăng Lực Sting Dâu có hương vị tự nhiên của dâu tây đỏ kết hợp với những hương liệu phụ một cách hài hòa tạo nên sự thơm ngon, hấp dẫn.

Với taurine, inositol, vitamin B, kết hợp cùng nhân sâm, nước tăng lực Sting dâu tây đỏ mang đến nguồn năng lượng dồi dào cho cơ thể, giúp bạn luôn tràn đầy năng lượng, vượt qua mệt mỏi.

Nước tăng lực Sting dâu tây đỏ được sản xuất trên dây chuyền hiện đại theo công nghệ tiên tiến, dưới sự giám sát và kiểm tra nghiêm ngặt của các chuyên gia trong ngành công nghệ thực phẩm.

Thành phần: Nước, chất điều chỉnh độ axit, chất điện giải, đường mía, hương tự nhiên, hương dâu tây, caffein, nhân sâm… Hướng dẫn sử dụng và bảo quản: Dùng trực tiếp, ngon hơn khi ướp lạnh. Bảo quản nơi khô ráo, thoáng mát. Nơi sản xuất: Việt Nam.

', N'2024-01-10 21:00:30', 40, 5, 1003)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (8, N'Monster Energy', N'monster.jpg', CAST(24000 AS Decimal(18, 0)), N'Nước tăng lực Monster Energy là nước tăng lực hàng đầu tại Mỹ, là biểu tượng toàn cầu và có mặt trên 125 quốc gia. Monster thể hiện đẳng cấp, phong cách sống khác biệt, là hiện thân của sự mạnh mẽ, huyền bí và vui nhộn.

Monster là thức uống dành cho thế hệ trẻ dám sống khác biệt và đương đầu với thử thách mới. Monster luôn gắn kết với các hoạt động thể thao phiêu lưu mạo hiểm, những trò chơi trực tuyến và âm nhạc sôi động.

Sản phẩm có thành phần từ nước bão hòa CO2, Sucroza, chiết xuất đường nho, chiết xuất nhân sâm, ... mang đến một loại nước uống thơm ngon, hấp dẫn với hương vị đặc trưng.

Hướng dẫn sử dụng: Dùng để uống, ngon hơn khi uống lạnh. Bảo quản: Nơi thoáng mát, khô ráo. Nơi sản xuất: Việt Nam.', N'2002-01-11 04:00:00', 10, 5, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (9, N'Soda Schweppes', N'soda.jpg', CAST(10000 AS Decimal(18, 0)), N'Nước Soda Schweppes là nước có gas tự nhiên, được sản xuất trên quy trình công nghệ hiện đại, không chứa hóa chất độc hại, an toàn cho người sử dụng.

Sản phẩm cung cấp năng lượng cho cơ thể, bổ sung chất khoáng, cho bạn một ngày làm việc thật năng động và căng tràn sức sống.

Lon nhỏ dung tích 320 ml, tiện lợi khi mang đi du lịch, ăn tiệc hay bỏ vào ba lô, túi xách, thuận tiện trong pha chế.

Thành phần: Nước bão hòa CO2, chất điều chỉnh độ axit (500ii). Hướng dẫn sử dụng: Uống trực tiếp hoặc pha với chanh, đường. Bảo quản: Nơi khô ráo, thoáng mát, tránh ánh nắng trực tiếp. Xuất xứ: Việt Nam.', N'2024-01-10 21:00:30', 20, 1, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (10, N'Soda Sữa Milkis', N'nuoc-giai-khat-soda-sua-milkis.jpg', CAST(10000 AS Decimal(18, 0)), N'Nước Soda Sữa Milkis Sữa Chua 250ml là sản phẩm được pha chế với công thức riêng, độc đáo, được ưa chuộng tại Hàn Quốc. Hiện nay, Soda sữa được sử dụng khá phổ biến tại Việt Nam. Nước uống có ga mang vị ngọt dịu với hương sữa nhẹ nhàng, thỏa cơn khát giữa những ngày nóng bức.

Công dụng:

Là nước giải khát có ga hương vị sữa thơm ngon.
Giàu chất bổ dưỡng, giúp cơ thể khỏe mạnh.
Cung cấp nước và năng lượng cho các hoạt động hàng ngày, vận động thể thao, tập luyện…', N'2024-01-20 21:00:30', 10, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (11, N'Tăng Lực Rockstar', N'tang-luc-Rockstar.jpg', CAST(10000 AS Decimal(18, 0)), N'Nước Tăng Lực Rockstar đem lại cảm giác mãnh liệt nhưng có vị êm dịu dễ uống.

Với nước tăng lực Rockstar lon 250ml, bạn có thể sử dụng tiết kiệm và lâu dài hơn với giá tốt, đảm bảo cung cấp thường xuyên năng lượng giúp tỉnh táo sảng khoái hơn trong công việc và sinh hoạt hàng ngày...

Thành phần: Nước, đường, chất điều chỉnh độ acid (330, 331), Taurin, hương trái cây tổng hợp, chất bảo quản (202, 211), caffein (320mg/ lít), inositol, vitamin B3, chất chống oxi hóa (385), vitamin B6, chất tạo ngọt tổng hợp (sucralose, trichloro galacto sucrose) 955, acesulfame kali 950, bột chiết xuất nhân sâm (40mg/ lít), màu tổng hợp, (Tartrazin 102, allura red ac 129).

Hướng dẫn sử dụng: Lắc nhẹ trước khi uống, dùng ngay sau khi mở nắp. Ngon hơn khi uống lạnh. Bảo quản: Để nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp hoặc nơi có nhiệt độ cao. Sản xuất tại: Việt Nam.', N'2024-01-10 21:00:30', 20, 5, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (12, N'Tăng Lực Compact', N'nuoc-tang-luc-compact.jpg', CAST(11000 AS Decimal(18, 0)), N'Nước Tăng Lực Compact Vị Cherry chứa nhiều Taurine tốt cho trí não, giúp bạn có thêm nhiều ý tưởng sáng tạo. Dùng để giải khát, tăng lực và bổ sung vi chất dinh dưỡng

Có hàm lượng caffeine cao. Không sử dụng cho trẻ em và những người nhạy cảm với caffeine. Người trưởng thành sử dụng theo nhu cầu, khuyến nghị 1 chai/ngày

Thành phần: Nước, đường, chất điều chỉnh độ chua (296, 330, 331(iii)), hương liệu (hương mật hoa tự nhiên, hương cherry tổng hợp), taurine 3g/l, chất tạo màu, lysine, inositol, vitamin B3, vitamin B6, vitamin B12.

Hướng dẫn sử dụng: Dùng trực tiếp, ngon hơn khi uống lạnh. Bảo quản: Nơi khô ráo, thoáng mát, tránh ánh nắng trực tiếp. Hạn sử dụng: 9 tháng kể từ ngày sản xuất Nơi sản xuất: Việt Nam.', N'2024-01-17 00:00:00', 20, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (13, N' Tăng Lực Warrior', N'warrior-huong-dau.jpg', CAST(11000 AS Decimal(18, 0)), N'Nước Tăng Lực Warrior Hương Nho Lon 325ml với hương vị nho thơm ngon, ngọt dịu mà không gắt cổ, có chứa nhóm vitamin B (B3, B6, B12) giúp thúc đẩy quá trình trao đổi chất cho cơ thể.
Sản phẩm sở hữu thiết kế sang trọng dễ cầm, dễ ướp lạnh cùng hương vị nho thơm ngon, dễ uống và sản phẩm duy trì sự tỉnh táo cực đỉnh và cung cấp nguồn năng lượng tức thì cho bạn trong các hoạt động hằng ngày.
Sản phẩm được đóng lon rất tiện lợi và đẹp mắt, phù hợp cho những buổi liên hoan hoặc dùng làm quà tặng người thân, bạn bè vào những dịp đặc biệt.', N'2024-01-26 21:00:30', 20, 1, 2)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (14, N'Tăng Lực Vị Cà Phê Wake Up 247', N'wake-up-247.jpg', CAST(11000 AS Decimal(18, 0)), N'Nước Tăng Lực Vị Cà Phê Wake Up 247 đem lại cảm giác sảng khoái bừng tỉnh, xua tan ngay cơn buồn ngủ nhiều Taurine tốt cho trí não, giúp bạn có thêm nhiều ý tưởng sáng tạo. Dùng để giải khát, tăng lực, tỉnh táo. Ngon hơn khi uống với đá

Có hàm lượng caffeine cao. Không sử dụng cho trẻ em, phụ nữ mang thai hoặc đang cho con bú và những người nhạy cảm với caffeine. Không sử dụng chung với sản phẩm chứa cồn. Người trưởng thành sử dụng theo nhu cầu, khuyến nghị 1 chai/ngày

Thành phần: Nước, đường, dextroza, hương liệu tổng hợp (hương cà phê, hương vanilla), taurine (194,3-248,3 mg/l), chất tạo màu, caffeine, inositol, vitamin B3, vitamin B6, vitamin B12.

Hướng dẫn sử dụng: Dùng trực tiếp, ngon hơn khi uống lạnh. Bảo quản: Nơi khô ráo, thoáng mát, tránh ánh nắng trực tiếp. Hạn sử dụng: 9 tháng kể từ ngày sản xuất Nơi sản xuất: Việt Nam.', N'2024-01-20 21:00:30', 20, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (15, N'Tăng Lực Samurai', N'nuoc-tang-luc-samurai.jpg', CAST(11000 AS Decimal(18, 0)), N'Nước Tăng Lực Samurai vàng có thành phần tự nhiên, mùi vị thơm ngon, sảng khoái. Sản phẩm giúp cơ thể bù đắp nước, bổ sung năng lượng, vitamin C và E, giúp xua tan cơn khát và cảm giác mệt mỏi.

Sản phẩm được sản xuất trên quy trình công nghệ hiện đại, thông qua quy trình kiểm duyệt chặt chẽ, không có đường hóa học, không chứa hóa chất độc hại, đảm bảo an toàn cho người sử dụng.

Thành phần: Nước bão hòa CO2, đường HFCS, chất tạo độ chua, caffeine (99mg/330ml), inositol, màu thực phẩm tổng hợp.

Hướng dẫn sử dụng: Lắc nhẹ trước khi uống, dùng ngay sau khi mở nắp. Ngon hơn khi uống lạnh. Bảo quản: Để nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp hoặc nơi có nhiệt độ cao.', N'2024-01-19 21:00:30', 20, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (16, N'Cocoxim Coconut', N'Cocoxim-Coconut.jpg', CAST(12000 AS Decimal(18, 0)), N'Nước dừa đóng hộp Cocoxim xanh 330ml được làm từ các nguyên liệu hoàn toàn tự nhiên, không bổ sung đường tinh luyện, tốt hơn cho sức khỏe người tiêu dùng với nguồn dinh dưỡng lành mạnh.

Thành phần: Nước dừa tươi. Cùng với thiết kế chai dung tích 300ml mang đến trải nghiệm sảng khoái và tiện dụng.

Hướng dẫn sử dụng: Ngon hơn khi uống lạnh, sau khi mở hộp, bảo quản lạnh ở 4 độ C – 10 độ C và sử dụng hết trong vòng 3 ngày. Không nên uống trong 3 tháng đầu thai kỳ đối với phụ nữ mang thai. Tham khảo bác sĩ trước khi uống nếu bị huyết áp thấp.

Hướng dẫn bảo quản: Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng, mùi mạnh và các loại hóa chất. Hạn sử dụng: 15 tháng kể từ ngày sản xuất. Xuất xứ: Việt Nam.

', N'2024-01-20 21:00:30', 20, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (17, N'Nước Cam Có Tép Teppy Minute Maid ', N'nuoc-ep-teppy-pet.jpg', CAST(15000 AS Decimal(18, 0)), N'Nước Cam Có Tép Teppy Minute Maid được làm từ những thành phần tự nhiên, không chứa các hóa chất tạo mùi độc hại, đảm bảo mang lại chất lượng sản phẩm tốt nhất cho người tiêu dùng.

Công nghệ sản xuất hiện đại, sản phẩm đạt tiêu chuẩn vệ sinh an toàn thực phẩm, không gây ảnh hưởng đến sức khỏe của bạn. Được chiết xuất từ những trái cam tự nhiên, sản phẩm có mùi vị thơm ngon và giữ nguyên những tép cam hấp dẫn tự nhiên.

Ngoài ra, Nước cam có tép Teppy Minute Maid chứa nhiều vitamin C sẽ cung cấp năng lượng cho cơ thể trong một ngày dài hoạt động. Nước cam có tép Teppy Minute Maid thuộc thương hiệu Coca Cola có uy tín trên thị trường, mang đến cho bạn hương vị tự nhiên và thơm ngon nhất.

Thành phần: Nước, đường HFCS, nước cốt cam và tép cam (12.2%), hương cam tổng hợp, chất điều chỉnh độ axit (330, 331(iii)), Lactate Calcium (400 ppm), vitamin E (11 ppm) và màu thực phẩm (102, 110). Hướng dẫn sử dụng: Lắc đều trước khi sử dụng. Ngon hơn khi uống lạnh. Bảo quản: Để nơi khô ráo và thoáng mát, tránh ánh nắng trực tiếp hoặc nơi có nhiệt độ cao. Xuất xứ: Việt Nam.', N'2024-01-19 21:00:30', 20, 3, 1003)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (19, N'Nước Mận Xanh Woongjin', N'Woongjin.jpg', CAST(30000 AS Decimal(18, 0)), N'Dùng trực tiếp, ngon hơn khi uống lạnh

Bảo quản trong tủ lạnh sau khi mở chai. Hạn sử dụng: 1 năm từ ngày sản xuất

Cải thiện chức năng mắt, tăng cường hệ thống miễn dịch, ngăn ngừa viêm nhiễm, giúp giảm nguy cơ nhiễm trùng đường tiết niệu, tăng cường thị lực ban đêm, giảm mệt mỏi cho mắt

', N'2024-01-20 21:00:30', 20, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (21, N'Nước Tinh Khiết Satori', N'nuoc-Satori.jpg', CAST(6000 AS Decimal(18, 0)), N'Satori là nước uống tinh khiết với công nghệ hoàn lưu khoáng giữ lại một phần hàm lượng khoáng tự nhiên tốt cho cơ thể. Được xử lý bằng hệ thống thẩm thấu ngược RO từ Nhật, với màng siêu lọc UF, khử trùng bằng tia cực tím & Ozone

8 bước lọc sạch với màng UF (Ultra Filtration) nhỏ đến 0,01 micron, khử trùng bằng tia cực tím và Ozon. 9 bước chiết rót đóng chai với dây chuyền khép kín tiêu chuẩn Châu Âu và 14 bước súc rửa bình kỹ thuật cao.

Hướng dẫn sử dụng: Dùng trực tiếp.

Bảo quản: Để nơi khô ráo, thoáng mát, tránh ánh nắng trực tiếp.

', N'2024-01-10 21:00:30', 200, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (22, N'Nước Tinh Khiết Aquafina ', N'nuoc-tinh-khiet-aquafina.jpg', CAST(6000 AS Decimal(18, 0)), N'Nước Tinh Khiết Aquafina cung cấp nguồn nước hoàn toàn sạch, bổ sung lại lượng nước mà bạn bị mất do các vận động trong cả ngày dài.

Nước uống tinh khiết luôn rất cần thiết cho cơ thể mỗi người, vì vậy sản phẩm sẽ là sự lựa chọn hoàn hảo cho sức khỏe.

Sản phẩm được đóng gói tiện lợi, dễ dàng mang đi xa.', N'2024-01-10 21:00:30', 200, 1007, 1)
INSERT INTO SanPham (TenSP, AnhBia, GiaBan, MoTa, NgayCapNhat, SoLuongTon, MaCate, MaNXB) VALUES (23, N'Nước Khoáng Dasani', N'nuoc-tinh-khiet-dasani.jpg', CAST(6000 AS Decimal(18, 0)), N'Nước khoáng Dasani được sản xuất từ nguồn nước ngầm được xử lý qua hệ thống thẩm thấu ngược và thanh trùng bằng ozone mang đến một sản phẩm giải khát, thanh lọc cơ thể hoàn hảo và đảm bảo an toàn cho sức khỏe. Sản phẩm chứa hàm lượng vi chất, muối khoáng bền vững và ổn định rất tốt cho hệ tiêu hóa cũng như nội tiết. Hướng dẫn sử dụng: Dùng trực tiếp, ngon hơn khi uống lạnh. Hướng dẫn bảo quản: Nơi khô ráo, thoáng mát, tránh ánh nắng mặt trời. Xuất xứ: Việt Nam.', N'2024-01-10 21:00:30', 200, 1007, 1)

---thêm dữu liệu cho NewsPost ---
INSERT INTO NewsPost (PostName, PostImg, PostDesc, dayUpdated) VALUES (1, N'Latest News', N'news_image.jpg', N'Exciting news update', N'2024-01-09')
INSERT INTO NewsPost (PostName, PostImg, PostDesc, dayUpdated) VALUES (2, N'Tech Trends', N'tech_trends.jpg', N'Discover the latest technology trends', N'2024-01-09')

---thêm dữ liệu cho Category--
INSERT INTO Category(TenHangMuc, ghichu) VALUES (1, N'Nước Ngọt', N'Các sản phẩm có đường, tạo ra vị ngọt cho nước uống')
INSERT INTO Category(TenHangMuc, ghichu) VALUES (2, N'PepsiCo', N'Là một công ty lớn trên thế giới.')
INSERT INTO Category(TenHangMuc, ghichu) VALUES (3, N'Nươc trái cây', N'Mang hương vị trái cây')
INSERT INTO Category(TenHangMuc, ghichu) VALUES (4, N'Nước thể thao', N'Dùng trong thể thao')
INSERT INTO Category(TenHangMuc, ghichu) VALUES (5, N'Nước tăng lực', N'Giúp giữ tỉnh táo, xóa bỏ cảm giác mệt mỏi')
INSERT INTO Category(TenHangMuc, ghichu) VALUES (1007, N'Nước', N'Rất có lợi cho sức khỏe')

