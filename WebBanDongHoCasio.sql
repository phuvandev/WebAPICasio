CREATE DATABASE WebBanDongHoCasio
GO
USE WebBanDongHoCasio
GO
CREATE TABLE Menu
(
	MaMenu int IDENTITY(1,1) primary key,
	TenMenu nvarchar(200) not null,
	STT int,
	Link varchar(max),
	TrangThai bit
)

CREATE TABLE Slide
(
	MaSlide int IDENTITY(1,1) primary key,
	Anh varchar(max),
	Link varchar(max)
)
GO
CREATE TABLE GioiThieu
(
	MaGT int IDENTITY(1,1) primary key,
	TieuDe nvarchar(200),
	Anh varchar(max),
	MoTa nvarchar(max)
)
GO
CREATE TABLE LienHe
(
	MaLH int IDENTITY(1,1) primary key,
	TieuDe nvarchar(max),
	TieuMuc nvarchar(max),
	Anh varchar(max),
	MoTa nvarchar(max)
)
GO
CREATE TABLE KhachHang
(
	MaKH int IDENTITY(1,1) primary key,
	TenKH nvarchar(50) not null,
	DiaChi nvarchar(200) not null,
	SDT varchar(10) ,
	Email varchar(100) 
)
GO
CREATE TABLE NhaCungCap
(
	MaNCC int IDENTITY(1,1) primary key,
	TenNCC nvarchar(50) not null,
	DiaChi nvarchar(200) not null,
	SDT varchar(10) 
)
GO
CREATE TABLE DongSanPham
(
	MaDSP int IDENTITY(1,1) primary key,
	TenDSP nvarchar(200) not null,
	AnhDaiDien varchar(max),
	MoTa nvarchar(max),
	MaMenu int foreign key references Menu(MaMenu) on delete cascade on update cascade
)
CREATE TABLE CTAnhDongSanPham
(
	MaCTADSP int IDENTITY(1,1) primary key,
	Anh varchar(max),
	MaDSP int foreign key references DongSanPham(MaDSP) on delete cascade on update cascade
)
CREATE TABLE SanPham
(
	MaSP int IDENTITY(1,1) primary key,
	TenSP nvarchar(50) not null,
	AnhDaiDien varchar(max),
	MoTa nvarchar(max),
	NgayTao datetime,
	MaDSP int foreign key references DongSanPham(MaDSP) on delete cascade on update cascade
)
GO
CREATE TABLE CTAnhSanPham 
(
	MaCTASP int IDENTITY(1,1) primary key,
	Anh varchar(max),
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
GO

CREATE TABLE GiaSanPham 
(
	MaGSP int IDENTITY(1,1) primary key,
	NgayBD datetime,
	NgayKT datetime,
	GiaBan int,
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
GO

CREATE TABLE ThongSoKyThuat 
(
	MaTS int IDENTITY(1,1) primary key,
	TenTS nvarchar(50),
	MoTa nvarchar(max),
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
GO
CREATE TABLE Kho 
(
	MaKho int IDENTITY(1,1) primary key,
	TenKho nvarchar(100),
	DiaChi nvarchar(200)
)
CREATE TABLE CTKho 
(
	MaCTK int IDENTITY(1,1) primary key,
	SoLuong int,
	MaKho int foreign key references Kho(MaKho) on delete cascade on update cascade,
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
CREATE TABLE NguoiDung
(
	MaND int IDENTITY(1,1) primary key,
	TaiKhoan varchar(50),
	Email varchar(100) ,
	MatKhau varchar(100),
	HoTen nvarchar(50) ,
	NgaySinh datetime ,
	DiaChi nvarchar(200) ,
	SDT varchar(10) ,
	LoaiQuyen nvarchar(50),
	TrangThai bit
)
GO
CREATE TABLE TinTuc
(
	MaTT int IDENTITY(1,1) primary key,
	AnhDaiDien varchar(max),
	TieuDe nvarchar(max),
	MoTa nvarchar(max),
	NgayDang datetime,
	MaND int foreign key references NguoiDung(MaND) on delete cascade on update cascade
)
GO
CREATE TABLE CTTinTuc
(
	MaCTTT int IDENTITY(1,1) primary key,
	Anh varchar(max),
	NoiDung nvarchar(max),
	MaTT int foreign key references TinTuc(MaTT) on delete cascade on update cascade
)
GO
CREATE TABLE GiamGia 
(
	MaGG int IDENTITY(1,1) primary key,
	PhanTram int,
	ThoiGianBD datetime,
	ThoiGianKT datetime,
	TrangThai bit,
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
CREATE TABLE HoaDonNhap
(
	MaHDN int IDENTITY(1,1) primary key,
	NgayNhap datetime,
	MaND int foreign key references NguoiDung(MaND) on delete cascade on update cascade,
	MaNCC int foreign key references NhaCungCap(MaNCC) on delete cascade on update cascade
)
GO
CREATE TABLE CTHoaDonNhap
(
	MaCTHDN int IDENTITY(1,1) primary key,
	SoLuong int,
	DonGiaNhap int,
	MaHDN int foreign key references HoaDonNhap(MaHDN) on delete cascade on update cascade,
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
GO
CREATE TABLE DonHang
(
	MaDH int IDENTITY (1, 1) primary key,
	NgayDat datetime,
	TrangThai bit,
	MaKH int foreign key references KhachHang(MaKH) on delete cascade on update cascade
)
GO
CREATE TABLE CTDonHang
(
	MaCTDH int IDENTITY(1,1) primary key,
	SoLuong int,
	GiaMua int,
	MaDH int foreign key references DonHang(MaDH) on delete cascade on update cascade,
	MaSP int foreign key references SanPham(MaSP) on delete cascade on update cascade
)
GO

------------------------------Thêm dữ liệu vào 22 bảng:------------------------------------------------
--Menu Slide GioiThieu LienHe KhachHang NhaCungCap DongSanPham CTAnhDongSanPham 
--SanPham CTAnhSanPham GiaSanPham ThongSoKyThuat Kho CTKho NguoiDung TinTuc CTTinTuc 
--GiamGia HoaDonNhap CTHoaDonNhap DonHang CTDonHang
insert into Menu values(N'DANH MỤC SẢN PHẨM', 1, '', 1)
insert into Menu values(N'TRANG CHỦ', 2, 'index.html', 1)
insert into Menu values(N'GIỚI THIỆU', 3, 'gioithieu.html', 1 )
insert into Menu values(N'TIN TỨC', 4, 'tintuc.html', 1 )
insert into Menu values(N'LIÊN HỆ', 5, 'lienhe.html', 1 )

insert into Slide values('slideshow1.png', 'abc')
insert into Slide values('slideshow2.png', 'abc')
insert into Slide values('slideshow3.png', 'abc')
insert into Slide values('slideshow4.png', 'abc')
insert into Slide values('slideshow5.png', 'abc')

insert into GioiThieu values(N'GIỚI THIỆU', '', N'Công ty Cổ phần Văn Phú Watch - thành viên của Tập đoàn BITEX - là nhà phân phối duy nhất và bảo hành chính thức sản phẩm đồng hồ CASIO - NHẬT BẢN của công ty CASIO COMPUTER CO., LTD Tokyo, Japan tại thị trường Việt Nam trong hơn 23 năm qua.')
insert into GioiThieu values(N'', 'service-center.png', N'Thương hiệu CASIO đã có mặt trên thị trường thế giới hơn 50 năm với nhiều sản phẩm điện tử nổi tiếng và điều đó là bảo chứng về chất lượng sản phẩm mà chúng tôi đang cung cấp.')
insert into GioiThieu values(N'', '', N'Trong vai trò nhà phân phối chính thức và duy nhất đồng hồ CASIO tại thị trường Việt Nam, Công ty Cổ Phần Văn Phú Watch luôn cố gắng đưa sản phẩm đến tay người tiêu dùng ở mức giá cạnh tranh và hợp lý nhất. Ngoài những chương trình khuyến mãi hấp dẫn, chúng tôi còn đặc biệt chú trọng đến trải nghiệm khách hàng về tính năng sản phẩm và dịch vụ bảo hành chính hãng.')
insert into GioiThieu values(N'', '', N'Với hệ thống hơn 70 cửa hàng và 300 đại lý trải dài khắp các tỉnh thành trong cả nước, Công ty Cổ Phần Văn Phú Watch mong muốn đem Thương hiệu quốc tế đến gần hơn với người dùng Việt Nam.')
insert into GioiThieu values(N'', '', N'Bên cạnh hoạt động kinh doanh bán lẻ, chúng tôi còn cung cấp số lượng lớn sản phẩm cho các công ty để làm chương trình khuyến mãi hoặc làm quà tặng với chính sách chiết khấu đặc biệt. Chúng tôi còn có thể in logo công ty quý khách lên mặt đồng hồ và đây là một phương thức quảng cáo hữu hiệu nhất cho thương hiệu của quý khách trên đồng hồ CASIO.')
insert into GioiThieu values(N'', '', N'Với thế mạnh về chất lượng sản phẩm, dịch vụ và uy tín thương hiệu, Văn Phú Watch cam kết sẽ khiến Quý Công ty hài lòng với mọi sản phẩm và dịch vụ trải nghiệm mà chúng tôi mang lại!')

---Tiêu đề, tiêu mục, ảnh, mô tả
insert into LienHe values(N'NHỮNG ĐIỀU CẦN BIẾT VỀ TRUNG TÂM BẢO HÀNH ĐỒNG HỒ CASIO CHÍNH HÃNG', '', '', N'Casio có hệ thống bảo hành quốc tế cho các dòng sản phẩm như đồng hồ G-Shock, đồng hồ Baby-G, đồng hồ Edifice. Vậy Trung tâm bảo hành của Casio tại Việt Nam ở đâu, có bao nhiêu điểm bảo hành Casio chính hãng và quy trình tiếp nhận bảo hành như thế nào? Hãy cùng tìm hiểu qua bài viết sau đây!')
insert into LienHe values(N'', N'THẾ NÀO LÀ BẢO HÀNH CHÍNH HÃNG?', '', 
N'Bảo hành chính hãng là dịch vụ bảo hành của nhà sản xuất dành cho các sản phẩm của họ được phân phối và bán trên thị trường. Bảo hành chính hãng áp dụng cho những sản phẩm được nhập khẩu chính hãng, có đầy đủ giấy tờ bảo hành của hãng hoặc của các đơn vị phân phối, đại lý...
Trung tâm bảo hành chính hãng đồng hồ Casio tại Việt Nam
Bảo hành chính hãng được dùng để phân biệt với bảo hành tại công ty, cửa hàng. Bảo hành tại công ty là chính sách bảo hành của điểm bán sản phẩm, không liên quan đến hãng sản xuất. Nhiều điểm bán chỉ có bảo hành công ty/cửa hàng mà không có bảo hành chính hãng là do sản phẩm của họ không phải là sản phẩm chính hãng, hoặc là sản phẩm được làm giả/nhái. Vì thế, khách hàng cần kiểm tra chế độ bảo hành của sản phẩm chính hãng trước khi mua để tránh mua phải hàng không chính hãng và không được bảo trợ từ nhà sản xuất.')
insert into LienHe values(N'',N'VÌ SAO NÊN SỬ DỤNG DỊCH VỤ BẢO HÀNH CHÍNH HÃNG?', '',
N'- Thứ nhất, bảo hành chính hãng mang lại sự an tâm cho người sử dụng. Khách hàng sẽ không phải lo lắng sản phẩm của mình có bị tráo đổi linh kiện hay bị giảm chất lượng sau khi sửa chữa hay không. Vì hãng chính là nơi chịu trách nhiệm cao nhất cho chất lượng của sản phẩm chính hãng trên thị trường.
- Thứ hai, bảo hành chính hãng sử dụng các linh kiện chính hãng từ nhà sản xuất. Thậm chí, nhiều linh kiện không thể tìm thấy ở bất kỳ nơi nào khác trên thị trường. Điều này nhằm đảm bảo chất lượng và tuổi thọ của sản phẩm chính hãng sau khi bảo hành, vì nếu sử dụng các linh kiện thay thế kém chất lượng sẽ khiến sản phẩm chính hãng nhanh hư, hoạt động không tốt như trước. 
- Thứ ba, trong trường hợp không may, khách hàng mua phải sản phẩm bị lỗi kỹ thuật không thể khắc phục được, nếu có bảo hành chính hãng thì khách hàng sẽ được đổi sản phẩm mới.
- Thứ tư, các hạng mục bảo hành miễn phí/tính phí luôn được niêm yết rõ ràng theo giá từ hãng nên khách hàng hoàn toàn yên tâm sẽ không bị “hét giá”. Bảo hành chính hãng phụ trách chăm sóc sản phẩm trọn đời.')
insert into LienHe values(N'', N'TRUNG TÂM BẢO HÀNH ĐỒNG HỒ CASIO TẠI VIỆT NAM', 'service-center.png',
N'Tuy không có chi nhánh hay công ty con tại Việt Nam, song Casio vẫn có Trung tâm bảo hành tiếp nhận bảo hành và sửa chữa đồng hồ Casio chính hãng cho khách hàng trong nước và quốc tế. Các Trung tâm bảo hành đồng hồ Casio chính hãng này được thành lập và quản lý bởi đại diện phân phối ủy quyền chính thức của Casio tại Việt Nam là Công ty Cổ phần Anh Khuê Watch. Tất cả các hoạt động, sự kiện của Casio tại Việt Nam cũng được thực hiện thông qua Văn Phú Watch.')
insert into LienHe values(N'', N'MÁY ĐO NĂNG LƯỢNG PIN VÀ IC WITSCHI.', '',
N'+ Kính hiển vi: Những chi tiết hư hỏng nhẹ cũng có thể ảnh hưởng đến hoạt động của bộ máy đồng hồ, đó là lý do vì sao kính hiển vi thường được các Trung tâm sửa chữa đồng hồ chuyên nghiệp sử dụng.
+ Máy vệ sinh đồng hồ: Loại máy này giúp làm sạch bụi bẩn và những vết gỉ sét bám trên đồng hồ, trả lại sản phẩm một diện mạo như mới.
+ Máy điều áp chân không: Một trong những tính năng độc đáo của đồng hồ Casio đó chính là khả năng chống nước (Water Resistance),nhiều dòng sản phẩm còn có chỉ số chống nước tới 20ATM (tương đương 200 mét). Sau khi đồng hồ Casio được tháo rời để sửa chữa hoặc thay pin, vệ sinh, chúng cần được kiểm tra lại khả năng chống nước. Việc này sẽ được thực hiện bằng cách sử dụng máy điều áp chân không. Loại máy này sẽ tạo ra một mức áp suất để kiểm tra khả năng chống nước của đồng hồ đạt đến mức độ nào. Tất cả đồng hồ Casio được mang đến bảo hành đều phải trải qua kiểm nghiệm này trước khi bàn giao lại cho khách hàng.')
insert into LienHe values(N'', N'MỘT SỐ THIẾT BỊ TẠI TRUNG TÂM BẢO HÀNH ĐỒNG HỒ CASIO.', '',
N'+ Bên cạnh những thiết bị chính này thì Trung tâm bảo hành đồng hồ Casio chính hãng còn được trang bị nhiều bộ dụng cụ và thiết bị chuyên nghiệp để phục vụ cho nhu cầu bảo hành, sửa chữa đồng hồ Casio tại Việt Nam.
- Đội ngũ kỹ thuật viên giỏi: Đồng hành với các trang thiết bị hiện đại chính là đội ngũ kỹ thuật viên sửa chữa đồng hồ chuyên nghiệp, tận tâm. Các nhân viên Trung tâm bảo hành Casio cũng thường xuyên được tham gia các lớp tập huấn về sản phẩm và đào tạo nâng cao tay nghề, nhằm mang lại sự hài lòng và đưa Trung tâm trở thành sự lựa chọn đáng tin cậy dành cho các khách hàng Casio trên cả nước, ngay cả khi đồng hồ đã hết thời gian bảo hành.
- Dịch vụ thân thiện: Trung tâm bảo hành Casio lấy sự hài lòng của khách hàng làm thước đo tiêu chuẩn và đánh giá nhân viên. Chính vì thế, hầu hết các khách hàng đều bày tỏ sự hài lòng sau khi sử dụng dịch vụ. Phương châm của Trung tâm chính là: Không để khách chờ lâu, Tư vấn dịch vụ rõ ràng, thái độ đúng chuẩn mực và Phục vụ bằng sự chân thành. Hotline 0916 12 17 19 luôn sẵn sàng tiếp nhận mọi khiếu nại, phàn nàn từ khách hàng để có biện pháp xử lý sớm nhất.')
insert into LienHe values(N'', N'BÊN TRONG PHÒNG LÀM VIỆC CỦA MỘT TTBH CASIO.', '',
N'- Linh kiện thay thế chính hãng: Tất cả các linh kiện thay thế cho đồng hồ Casio đều được nhập khẩu trực tiếp từ nhà sản xuất Casio. Những linh kiện này không được bán công khai trên thị trường. Nên để đảm bảo đồng hồ chính hãng được thay đúng linh kiện chính hãng, bạn cần phải đem đồng hồ đến các Trung tâm bảo hành Casio Văn Phú Watch.')
insert into LienHe values(N'', N'QUY ĐỊNH VỀ THỜI GIAN VÀ ĐIỀU KIỆN BẢO HÀNH', '',
N'Tùy theo từng dòng sản phẩm mà thời gian bảo hành đồng hồ Casio cũng khác nhau:
- Đồng hồ G-Shock và Baby-G: Bảo hành 5 năm cho cả máy và pin.
- Đồng hồ Casio các dòng còn lại: Bảo hành 12 tháng cho máy và 18 tháng cho pin. Riêng đồng hồ để bàn và đồng hồ treo tường chỉ bảo hành máy, không bảo hành pin.')
insert into LienHe values(N'', N'ĐIỀU KIỆN BẢO HÀNH: ', '',
N'- Bảo hành không tính phí:
+ Sản phẩm còn trong thời gian bảo hành. Thời gian bảo hành sẽ được tính từ ngày mua được ghi trên phiếu bảo hành.
+ Sản phẩm bảo hành phải có đầy đủ giấy tờ bảo hành, nguyên vẹn và không được tẩy xóa.
Đối với các sản phẩm vẫn còn trong thời hạn bảo hành Nếu khách gửi bảo hành/sửa chữa tại cửa hàng thì các chi phí vận chuyển từ cửa hàng => TTBH và ngược lại thì công ty chịu phí.
Trong thời gian bảo hành chi phí vận chuyển từ TTBH => nhà khách hàng và ngược lại thì công ty chịu phí.
- Bảo hành có tính phí:
+ Đồng hồ Casio chính hãng hết thời hạn bảo hành theo quy định.
+ Đồng hồ Casio chính hãng của khách hàng là người nước ngoài.
+ Đồng hồ còn đang trong thời gian bảo hành nhưng bị hư hỏng do các nguyên nhân như sử dụng sai hướng dẫn, bấm nút điều chỉnh đồng hồ trong môi trường nước, trầy xước mặt kính, vỏ, khóa, dây đeo xỉn màu,…
+ Mọi hư hỏng của đồng hồ do tự ý sửa chửa hoặc do sửa chửa không đúng cách từ các dịch vụ khác không phải do TTBH chính hãng cũng bị tính phí.
Mức phí sửa chửa và giá các linh kiện thay thế sẽ được thông báo cho khách hàng trước khi tiến hành sửa chửa, thay thế.
- Đồng hồng Casio giả, nhái không được bảo hành.
Đối với các sản phẩm KHÔNG còn trong thời hạn bảo hành khách gửi bảo hành/sửa chữa tại cửa hàng thì khách hàng chịu phí.')
insert into LienHe values(N'', N'DANH SÁCH TRUNG TÂM BẢO HÀNH ĐỒNG HỒ CASIO CHÍNH HÃNG TRÊN TOÀN QUỐC', '',
N'Mọi thông tin liên hệ Phòng bảo hành đồng hồ Casio chính hãng:
- Hotline Phòng Bảo Hành: 1900.866.858 (Phím 4)
- Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Hà Nội:
+ Trung tâm bảo hành Casio số 1: Số 15 Ô Chợ Dừa, P. Ô Chợ Dừa, Quận Đống Đa
Điện thoại: (024) 3223 2229
+ Trung tâm bảo hành Casio số 2: 128 Bạch Mai, P. Cầu Dền, Quận Hai Bà Trưng, TP Hà Nội
Điện thoại: (0243) 624 5647
Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Hà Nội
- Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Đà Nẵng:
+ Trung tâm bảo hành Casio số 1: Số 140 Nguyễn Văn Linh, Quận Hải Châu, TP. Đà Nẵng
Điện thoại: (0236) 366 4789
Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Đà Nẵng
- Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại TP. Hồ Chí Minh:
+ Trung tâm bảo hành Casio số 1: Số 437 Lý Thái Tổ, Phường 9, Quận 10
Điện thoại: (028) 3927 3778 - (028) 3927 3779
+ Trung tâm bảo hành Casio số 2: Số 295 Trần Hưng Đạo, P. Cô Giang, Quận 1
Điện thoại: (028) 3836 1562
+ Trung tâm bảo hành Casio số 3: Lầu 2, Số 20 đường Ba Tháng Hai, P. 12, Quận 10
Điện thoại: (028) 3927 0317 - (028) 3927 3517
Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại TP. Hồ Chí Minh
- Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Cần Thơ:
+ Trung tâm bảo hành Casio số 1: Số 56 Trần Văn Khéo, Phường Cái Khế, Quận Ninh Kiều
Điện thoại: (0292) 3760 630
Phòng bảo hành làm việc vào giờ hành chính: Thứ 2 – Thứ 6 (8h00 – 17h00) và thứ 7 (8h00 – 12h00).
Hệ thống trung tâm bảo hành đồng hồ Casio chính hãng tại Cần Thơ')
insert into LienHe values(N'', N'QUY TRÌNH TIẾP NHẬN VÀ BÀN GIAO SẢN PHẨM BẢO HÀNH', '',
N'- Đối với khách hàng đến bảo hành trực tiếp tại TTBH Casio:
+ Khách hàng mang đồng hồ Casio cần được bảo hành cùng phiếu bảo hành (nếu đang trong thời gian bảo hành) đến các địa điểm trung tâm bảo hành gần nhất.
+ Bộ phận lễ tân sẽ tiếp nhận, kiểm tra giấy tờ và ghi nhận vấn đề cần bảo hành sau đó chuyển đến các kỹ thuật viên kiểm tra.
+ Sau khi kiểm tra xong, khách hàng sẽ nhận được thông báo chi tiết về tình trạng của đồng hồ và báo giá (nếu có tính phí). Khách hàng đồng ý sửa chữa thì TTBH sẽ tiếp nhận và bắt đầu tiến hành sửa chữa.
Tùy theo thời gian sửa chữa mà khách hàng sẽ được thông báo đợi lấy đồng hồ hoặc có giấy hẹn ghi thời gian cụ thể để lên nhận lại sản phẩm. Với các trường hợp bảo hành như thay pin hay đánh bóng thì khách hàng chỉ cần đợi khoảng 30 phút.
Khách hàng có thể đến bảo hành đến trực tiếp hoặc thông qua cửa hàng Casio Văn Phú.
- Đối với khách hàng ở xa:
+ Khách hàng sẽ có 2 cách gửi sản phẩm cần bảo hành đến TTBH Casio:
1. Mang ra cửa hàng Văn Phú Watch gần nhất (nếu mua ở đại lý thì mang đến đại lý),nhân viên bán hàng sẽ ghi nhận và gửi sản phẩm cần bảo hành về TTBH Casio.
2. Gửi trực tiếp qua đường bưu điện về địa chỉ TTBH Casio gần nhất, kèm với phiếu bảo hành sản phẩm.
+ Sau khi nhận được sản phẩm cần bảo hành, nhân viên TTBH Casio sẽ liên hệ trực tiếp với khách hàng.
+ Sản phẩm được bảo hành xong sẽ gửi trả khách hàng theo đường bưu điện hoặc cửa hàng mà khách gửi.
Mọi thắc mắc, vấn đề cần tư vấn, khách hàng có thể liên hệ trực tiếp thông qua số điện thoại của các Trung tâm bảo hành đồng hồ Casio ở trên hoặc qua Hotline Phòng Bảo Hành: 1900.866.858 (Phím 4).')

insert into KhachHang values(N'Nguyễn Văn Cường', N'Thái Bình', '0357258373', 'cuongtb1@gmail.com')
insert into KhachHang values(N'Lê Thị Lý', N'Hưng Yên', '0358258373', 'lyhy1@gmail.com')
insert into KhachHang values(N'Hoàng Văn Vũ', N'Sơn La', '0359258373', 'vusl1@gmail.com')
insert into KhachHang values(N'Vũ Viết Đạt', N'Hải Dương', '0356258373', 'dathd1@gmail.com')
insert into KhachHang values(N'Trần Thị Bích Ngọc', N'Đà Nẵng', '0355258373', 'ngocdn1@gmail.com')
insert into KhachHang values(N'Nguyễn Thị Lan', N'Thái Bình', '0357258373', 'lantb1@gmail.com')
insert into KhachHang values(N'Lê Văn Kiên', N'Hưng Yên', '0358258373', 'kienhy1@gmail.com')
insert into KhachHang values(N'Vũ Văn Dương', N'Sơn La', '0359258373', 'duongsl1@gmail.com')
insert into KhachHang values(N'Trần Thiện', N'Hải Dương', '0356258373', 'thienhd1@gmail.com')
insert into KhachHang values(N'Phạm Trà My', N'Đà Nẵng', '0355258373', 'mydn1@gmail.com')

insert into NhaCungCap values(N'Phạm Quang Hải', N'Hà Nội',N'0354472583')
insert into NhaCungCap values(N'Nguyễn Việt Trung', N'TP Hồ CHí Minh',N'0354473456')
insert into NhaCungCap values(N'Lê Việt Thái', N'Đà Nẵng',N'0357872583')

insert into DongSanPham values(N'G-SHOCK', 'G-Shock.png', N'Kể từ khi chiếc DW-5000C đầu tiên được bán trở lại vào năm 1983, G-SHOCK vẫn luôn không ngừng vượt qua các giới hạn mới về độ bền đồng hồ hiển thị giờ hiện hành, đồng thời tạo ra các thiết kế mới lạ và độc đáo. Những mẫu mới này thể hiện những nỗ lực đó trong hình dáng mỏng đầy cuốn hút.
Những mẫu mới này thừa hưởng kiểu dáng bát giác cũng được dùng cho mẫu DW-5000C nguyên bản. Chiếc đồng hồ hiển thị giờ hiện hành kết hợp kim và số gói gọn trong một thiết kế đơn giản hữu dụng mà vẫn giữ được độ bền ngang bằng G-SHOCK.
Chất liệu nhựa vô cùng mạnh mẽ còn được gia cố sợi cacbon giúp tạo nên lớp vỏ chỉ dày 11,8 mm. Đây là lớp vỏ mỏng nhất trong số các mẫu kết hợp của đồng hồ Casio G-Shock.
Neobrite: Dành riêng cho GA-2100-1A, GA-2100-4A
Cấu trúc bảo vệ lõi cacbon
Cấu trúc bảo vệ lõi cacbon mới bảo vệ mô-đun bằng cách bao kín mô-đun trong lớp vỏ cacbon. Lớp vỏ làm bằng nhựa mịn pha lẫn sợi cacbon có độ bền và sức chịu nứt vỡ vượt trội.', 1)
insert into DongSanPham values(N'BABY-G', 'Baby-G.png', N'Cùng chiêm ngưỡng những mẫu đồng hồ Casio Baby-G mới đầy ấn tượng với thiết kế đơn giản và thanh lịch của BABY-G G-MS, dòng sản phẩm dành cho những người phụ nữ hiện đại năng động và sành điệu.
Phần viền mỏng và sắc nét, vạch chỉ giờ hình tam giác, nút điều chỉnh bát giác cùng nhiều chi tiết khác, tất cả đã tạo nên một kiệt tác hiện đại không thể cưỡng lại. Quai đeo được chế tạo từ chất liệu nhựa tổng hợp vừa đậm chất thể thao, vừa mang phong cách thời trang thường nhật, trưởng thành.
Mẫu đồng hồ sở hữu thiết kế vỏ mỏng phù hợp với mọi hoàn cảnh, ba kim chỉ thời gian và hiển thị ngày, hoạt động bằng năng lượng mặt trời và khả năng chống nước tới 100m.
Đây chắc chắn là sự lựa chọn hoàn hảo cho công việc, giải trí hay bất cứ hoạt động nào khác của bạn.', 1)
insert into DongSanPham values(N'EDIFICE', 'Edifice.png', N'Mẫu đồng hồ Edifice mới siêu mỏng có thông số kỹ thuật cao với khả năng kết nối với điện thoại này là mẫu mới nhất bổ sung dòng sản phẩm đồng hồ ghi thời gian bằng kim loại EDIFICE sở hữu nhiều chức năng và luôn vượt qua các giới hạn của đồng hồ hiển thị giờ hiện hành.
Tất cả các tính năng Kết nối điện thoại thông minh qua Bluetooth®, hệ thống năng lượng Tough Solar khiến đồng hồ có thể sạc khi tiếp xúc với ánh sáng huỳnh quang và tính năng hiển thị giờ hiện hành của bộ ghi thời gian nhiều kim được gói gọn trong lớp vỏ chỉ dày 8,9 mm.
Công nghệ gắn kết mới kết hợp với các đổi mới về chi tiết và cấu trúc giúp tạo ra lớp vỏ mỏng hơn khoảng 30% so với mô-đun EDIFICE EQB-800 Kết nối với điện thoại.', 1)
insert into DongSanPham values(N'SHEEN', 'Sheen.png', N'Casio Sheen là dòng đồng hồ thanh lịch, sang trọng được thiết kế dành riêng cho phái đẹp của thương hiệu Casio. Với sự kết hợp hài hòa giữa phong cách cổ điển và hiện đại. Sheen thể hiện về một dòng sản phẩm đồng hồ đeo tay nữ đậm chất cá tính, vừa mạnh mẻ, vừa dịu dàng, đằm thắm. Đối tượng mà Casio Sheen hướng tới là những chị em có độ tuổi từ 25 trở lên, chín chắn, có kinh nghiệm sống, có bản lãnh, sẵn sàng đương đầu với thử thách.', 1)
insert into DongSanPham values(N'GENERAL', 'General.png', N'Đồng hồ Casio thiết kế đa dạng, độ bền cao với nhiều dòng khác nhau, đa dạng mẫu mã. Những mẫu đồng hồ phổ biến nhất với thiết kế đồng hồ kim và cả các thiết kế màn hình điện tử dành cho cả nam và nữ. Bảo hành chính hãng tại Casio Anh Khuê - Nhà phân phối và bảo hành chính thức đồng hồ Casio tại Việt Nam. Đồng hồ Casio được biết đến là thương hiệu đồng hồ lâu đời trong ngành công nghiệp đồng hồ tại Nhật Bản. Những mẫu đồng hồ Casio nam và đồng hồ Casio nữ được yêu thích bởi thiết kế đơn giản, được trang bị đầy đủ các công nghệ mới nhất và có giá bán cực kỳ rẻ. Ngoài ra, đồng hồ Casio chính hãng còn nổi bật với chức năng đa dạng giúp ích cho người dùng vào những hoạt động đời sống thường ngày.', 1)
insert into DongSanPham values(N'PRO TREK', '', N'Casio ProTrek là dòng đồng hồ leo núi thông minhchính hãng Casio dành cho nam với tích hợp bộ ba cảm biến (phương vị, độ cao/áp suất khí quyển, nhiệt độ). Đây là dòng sản phẩm đặc biệt với nhiều công nghệ hiện đại được thiết kế để chịu được sự khắc nghiệt của thời tiết, hoat động bền bỉ nhờ sử công nghệ năng lượng mặt trời để vận hành toàn bộ hệ thống, kết hợp với pin có khả năng sạc lại được, đảm bảo đồng hồ hoạt động liên tục cho cuộc hành trình thám hiểm của bạn.', 1)

insert into CTAnhDongSanPham values('G-Shock_large.png', 1)
insert into CTAnhDongSanPham values('Baby-G_large.png', 2)
insert into CTAnhDongSanPham values('Edifice_large.png', 3)
insert into CTAnhDongSanPham values('Sheen_large.png', 4)
insert into CTAnhDongSanPham values('General_large.png', 5)
insert into CTAnhDongSanPham values('ProTrek_large.png', 6)

--tên, ảnh đại diện, ảnh bán chạy, mô tả, ngày tạo, mã DSP
-------------------------------------G-SHOCK-3---------------------------------------------------------------------------
insert into SanPham values('GM-2140GEM-2ADR','GM-2140GEM-2ADR.png', N'Các mẫu G-SHOCK Adventurer’s Stone mới này sử dụng các họa tiết của đá khoáng chất, làm điểm đánh dấu dẫn đường từ thời trung cổ.
Mỗi thiết kế đều kết hợp tinh thần của G-SHOCK, nhằm hỗ trợ và hướng dẫn cho những người thích mạo hiểm và các nhà thám hiểm trên toàn thế giới. Dựa trên các mẫu được phủ kim loại, những chiếc đồng hồ mới này sử dụng kỹ thuật rèn và mạ ion tiên tiến (IP) để tạo ra các thiết kế tái tạo kết cấu thô và độ sáng nhiều màu của khoáng quặng.
Kết quả là một bộ sưu tập các mẫu đặc biệt nắm bắt được tinh thần của quá khứ và những thách thức trong tương lai, thành một phiên bản kỷ niệm ý nghĩa
Các bezels phủ kim loại được tạo ra bằng cách rèn đặc biệt và đúc bằng khuôn đặc biệt. Toàn bộ bề mặt của tất cả các bezels có bề mặt gồ ghề giống như quặng khoáng sản. Nhưng vẫn được mãi dũa để có lớp hoàn thiện bóng loáng, mặt trên và các mặt của khung bezel được đánh bóng hoàn hảo sáng bóng đến từng chi tiết nhỏ nhất. 

Thành phẩm tạo ra từ quy trình sử dụng công nghệ gia công kim loại tái tạo trung thực hình thức, kết cấu, và độ sáng chói của từng loại quặng khoáng sản.
Nắp sau của các mẫu này được khắc chữ G-SHOCK
Logo kỷ niệm 40 năm. Vòng dây cho GM-2140GEM, GM5640GEM và GM-114GEM là khắc laser với bốn ngôi sao và các chữ TỪ 1983.

Hộp thiết kế đặc biệt theo kiểu chữ cái G, vật liệu thân thiện với môi trường tái chế vật liệu.'
, '2023/1/1', 1)
insert into SanPham values('GM-114GEM-1A9DR','GM-114GEM-1A9DR.png', N'Các mẫu G-SHOCK Adventurer’s Stone mới này sử dụng các họa tiết của đá khoáng chất, làm điểm đánh dấu dẫn đường từ thời trung cổ.
Mỗi thiết kế đều kết hợp tinh thần của G-SHOCK, nhằm hỗ trợ và hướng dẫn cho những người thích mạo hiểm và các nhà thám hiểm trên toàn thế giới. Dựa trên các mẫu được phủ kim loại, những chiếc đồng hồ mới này sử dụng kỹ thuật rèn và mạ ion tiên tiến (IP) để tạo ra các thiết kế tái tạo kết cấu thô và độ sáng nhiều màu của khoáng quặng.
Kết quả là một bộ sưu tập các mẫu đặc biệt nắm bắt được tinh thần của quá khứ và những thách thức trong tương lai, thành một phiên bản kỷ niệm ý nghĩa
Các bezels phủ kim loại được tạo ra bằng cách rèn đặc biệt và đúc bằng khuôn đặc biệt. Toàn bộ bề mặt của tất cả các bezels có bề mặt gồ ghề giống như quặng khoáng sản. Nhưng vẫn được mãi dũa để có lớp hoàn thiện bóng loáng, mặt trên và các mặt của khung bezel được đánh bóng hoàn hảo sáng bóng đến từng chi tiết nhỏ nhất. 

Thành phẩm tạo ra từ quy trình sử dụng công nghệ gia công kim loại tái tạo trung thực hình thức, kết cấu, và độ sáng chói của từng loại quặng khoáng sản.
Nắp sau của các mẫu này được khắc chữ G-SHOCK
Logo kỷ niệm 40 năm. Vòng dây cho GM-2140GEM, GM-5640GEM và GM-114GEM là khắc laser với bốn ngôi sao và các chữ TỪ 1983.
Hộp thiết kế đặc biệt theo kiểu chữ cái G, vật liệu thân thiện với môi trường tái chế vật liệu.'
, '2023/1/2', 1)
insert into SanPham values('GG-B100Y-1ADR','GG-B100Y-1ADR.png', N'Vỏ của mẫu GG-B100Y MUDMASTER được chế tạo bằng vật liệu cacbon có độ cứng cao có thể chịu được biến dạng và chống hư hỏng, ngoài ra còn có độ kín khí cao và chống va đập. Mẫu đồng hồ này còn được tích hợp bộ lọc để ngăn chặn bùn tràn vào bên trong vỏ, một bảng điều khiển phía sau bằng thép không gỉ và nắp lưng được làm bằng nhựa cao cấp pha sợi thủy tinh chống sốc. Vòng mặt số cũng được tạo hình từ ba lớp nhựa cao cấp pha sợi cacbon.
Đèn LED đôi: gồm 1 đèn LED dành cho mặt đồng hồ tự động và đèn nền LED chiếu sáng cực mạnh dành cho màn hình số. Cả 2 đen đều chiếu sáng cực mạnh, thời lượng chiếu sáng có thể chọn 1,5 giây hoặc 3 giây 
Chống nước độ sâu 200m ; Công cụ tìm điện thoại
Liên kết điện thoại thông minh (Kết nối không dây với thiết bị Bluetooth).  Yêu cầu cài đặt ứng dụng trên điện thoại của bạn.
Hiển thị giờ mặt trời mọc, mặt trời lặn Giờ mặt trời mọc và mặt trời lặn cho ngày cụ thể
5 chế độ báo thức hằng ngày và cập nhật lịch hoàn toàn tự động đến 2099 vô cùng tiện nghi khi sử dụng. Chức năng bấm giờ G7'
, '2023/1/3', 1)
-------------------------------------BABY-G--6--------------------------------------------------------------------------
insert into SanPham values('BGD-565XG-2','BGD-565XG-2.png', N'Đừng bỏ lỡ phong cách đường phố phù hợp với những cô gái cá tính. BABY-G và X-girl hợp tác tạo nên chiếc đồng hồ đơn giản vô cùng phù hợp với những cô gái năng động. BABY-G và X-girl là hai thương hiệu mang phong cách đường phố đích thực dành cho những cô gái sinh ra vào thời kỳ đỉnh cao của thời trang đường phố năm 1994. Họ đã trở lại với phong cách ảnh chế theo trào lưu vaporwave vào đầu những năm 2010 trong mẫu đồng hồ BGD-565 màu neon phân cực đặc trưng, tạo nên một cảm giác hư ảo và cổ điển. Dây đeo màu xanh lam nhạt mờ được hoàn thiện bằng lớp phủ ngọc trai màu tím, kết hợp với mặt đồng hồ phân cực với màu sắc óng ánh theo từng cử động nghiêng cổ tay. X-girl luôn đi đầu và là trung tâm của những điểm nhấn thiết kế đặc biệt. Logo X-girl được in trên vòng dây và xuất hiện trên màn hình khi bạn nhấn nút đèn. Ngoài ra còn có logo khuôn mặt nổi tiếng của thương hiệu do Mike Mills thiết kế được khắc trên phần lưng vỏ. Khi phong cách vaporwave không phù hợp với bầu không khí, chúng tôi có ngay dây đeo và gờ bằng nhựa màu đen có thể thay thế để đưa bạn đến bất cứ đâu. Chỉ cần trượt cần gạt trên lưng vỏ để dễ dàng hoán đổi dây đeo và khoác lên mình phong cách bạn muốn. Bao bì được thiết kế đặc biệt nhằm hoàn thiện trải nghiệm X-girl. Phong cách đường phố X-girl dành cho những cô gái cá tính. X-girl cung cấp “Trang phục cho những cô gái cá tính” lấy cảm hứng từ âm nhạc, văn hóa, thể thao và nhiều yếu tố khung cảnh đường phố khác đi trước thời đại.'
, '2023/1/4', 2)
insert into SanPham values('BG-169HRB-7','BG-169HRB-7.png', N'BABY-G, dòng đồng hồ đơn giản dành cho giới nữ năng động, đã phát triển mẫu đồng hồ mới được hợp tác sản xuất cùng với thương hiệu HARIBO, nhà sản xuất kẹo dẻo nổi tiếng của Đức. Mọi yếu tố trong phong cách thiết kế của chiếc đồng hồ này đều vui nhộn và phá cách, hoàn toàn phù hợp với thế giới HARIBO. Chất liệu trong mờ màu trắng cơ bản của mẫu đồng hồ được tạo thêm điểm nhấn với màu sắc của những chiếc kẹo Goldbears phổ biến. Mẫu cơ sở là chiếc đồng hồ BABY-G BG-169 nhỏ nhắn. Các nút và mặt đồng hồ được trang trí với màu sắc lấy cảm hứng từ HARIBO Goldbears. Toàn bộ phần mặt đồng hồ đều được trang trí hình HARIBO Goldbears đặc trưng, mô phỏng hương vị của kẹo mâm xôi, chanh, táo và cam. Khi bật đèn nền EL của đồng hồ cũng sẽ thấy được hoa văn HARIBO Goldbears sắp xếp theo mẫu cố định trên mặt đồng hồ. Dây đeo và vỏ của mẫu đồng hồ này được làm bằng nhựa trong mờ, tạo cảm giác giống như kẹo dẻo và tô điểm cho màu sắc tươi sáng của thiết kế. Biểu tượng Goldbears màu vàng được in trên vòng dây đeo, trong khi nắp sau của đồng hồ được khắc biểu tượng Goldbears và HARIBO quen thuộc. Bao bì của mẫu đồng hồ này cũng được thiết kế nhằm gợi lên mô-típ kẹo dẻo. Mọi chi tiết trong thiết kế dễ thương của mẫu hợp tác đặc biệt này khiến nó trở thành một biểu tượng đại chúng. HARIBO TM &  2022 HARIBO Holding GmbH & Co. KG. Mọi quyền được bảo lưu.'
, '2023/1/5', 2)
insert into SanPham values('BA-110XRG-4A','BA-110XRG-4A.png', N'Hãy đeo lên tay chiếc đồng hồ bắt mắt với màu sắc tươi tắn, thanh lịch, lấy cảm hứng từ thiết kế G-SHOCK GA-110 nổi tiếng. Sự kết hợp tinh xảo giữa mặt số, vạch chỉ giờ và các bộ phận khác tạo nên hình ảnh thiết bị cơ khí với điểm nhấn sắc nét tràn đầy năng lượng. Mẫu đồng hồ BABY-G mang phong cách thời trang đường phố nổi trội và có nhiều chức năng. Trải nghiệm các chức năng tiện dụng, đáng tin cậy như đèn LED và đồng hồ bấm giờ, bên cạnh khả năng chống va đập và chống nước.'
, '2023/1/6', 2)
-------------------------------------EDIFICE---9-------------------------------------------------------------------------
insert into SanPham values('ECB-950MP-1ADF','ECB-950MP-1ADF.png', N'Bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Mặt sau của đồng hồ được mạ ion màu đen , gờ được làm từ thép không gỉ và mạ inon màu đen tăng độ bền cũng như sự sang trọng cho chiếc đồng hồ . Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth để sử dụng trọn vẹn mọi tính năng  trong tầm tay nhằm hỗ trợ các đội đua. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức và hẹn giờ, công cụ tìm điện thoại bằng cách nhấn vào nút đồng hồ để điện thoại đổ chuông ( nằm trong phạm vi Bluetooth ) và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1/1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
Mẫu ECB-950MP và ECB-900MP còn được trang bị hệ thống pin năng lượng mặt trời có thể sạc bằng đèn huỳnh quang hoặc ánh sáng mặt trời. Thời gian pin sạ 6 tháng với điều kiện ánh sáng bình thường không tiếp xúc với ánh sáng khi sạc và 19 tháng trong bóng tối. Điều này có nghĩa là bạn cứ tự tin đeo đồng hồ ở mọi lúc mọi nơi mà không cần quan tâm đến việc hết pin và giúp tiết kiệm năng lượng sau khi pin đã được sạc đầy. Ngoài ra thì có thêm các chức năng khác như đèn LED kép chiếu sáng cực mạng( gồm 1 đền LED cho mặt đồng hồ, 1 đền LED màn hình kĩ thuật số) dễ dàng xem giờ trong bóng tối.'
, '2023/1/7', 3)
insert into SanPham values('ECB-900MP-1ADF','ECB-900MP-1ADF.png', N'Bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Mặt sau của đồng hồ được mạ ion màu đen , gờ được làm từ thép không gỉ và mạ inon màu đen tăng độ bền cũng như sự sang trọng cho chiếc đồng hồ . Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth để sử dụng trọn vẹn mọi tính năng  trong tầm tay nhằm hỗ trợ các đội đua. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức và hẹn giờ, công cụ tìm điện thoại bằng cách nhấn vào nút đồng hồ để điện thoại đổ chuông ( nằm trong phạm vi Bluetooth ) và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1/1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
Mẫu ECB-950MP và ECB-900MP còn được trang bị hệ thống pin năng lượng mặt trời có thể sạc bằng đèn huỳnh quang hoặc ánh sáng mặt trời. Thời gian pin sạ 6 tháng với điều kiện ánh sáng bình thường không tiếp xúc với ánh sáng khi sạc và 19 tháng trong bóng tối. Điều này có nghĩa là bạn cứ tự tin đeo đồng hồ ở mọi lúc mọi nơi mà không cần quan tâm đến việc hết pin và giúp tiết kiệm năng lượng sau khi pin đã được sạc đầy. Ngoài ra thì có thêm các chức năng khác như đèn LED kép chiếu sáng cực mạng( gồm 1 đền LED cho mặt đồng hồ, 1 đền LED màn hình kĩ thuật số) dễ dàng xem giờ trong bóng tối.'
, '2023/1/8', 3)
insert into SanPham values('ECB-2000MFG-1A','ECB-2000MFG-1A.png', N'Xin giới thiệu mẫu đồng hồ ECB-2000MFG đua xe thể thao có một không hai, hiệu suất cao. Hãng EDIFICE hợp tác với họa sĩ Shuichi Shigeno tạo nên mẫu thiết kế vô cùng đặc biệt. Ông là họa sĩ chấp bút cho hai bộ truyện manga chủ đề đua xe thể thao nổi tiếng: Initial D và MF GHOST. Tác phẩm Initial D nổi tiếng với các cuộc đua băng qua đèo dốc. Tác phẩm được xuất bản từ năm 1995 đến năm 2013 trên Tạp chí Young của nhà xuất bản Kodansha Ltd. và được người hâm mộ vô cùng yêu thích với hơn 56 triệu bản được bán ra. MF GHOST là bộ manga đua xe lấy bối cảnh đường phố của Shigeno. Tác phẩm xuất hiện trên cùng một tạp chí từ năm 2017, cùng một loạt anime truyền hình dự kiến ra mắt vào năm 2023. Mẫu hợp tác trong mơ này mô phỏng thế giới của hai bộ truyện Initial D và MF GHOST. Các chi tiết trong cả hai bộ truyện đều được đưa vào mẫu thiết kế đồng hồ dành riêng cho người chiến thắng này. Thiết kế màu đỏ và đen dựa trên chiếc Toyota GT86 do nhân vật chính Kanata Rivington trong bộ truyện MF GHOST điều khiển. Phần đế của mặt số và mặt dưới của dây da đều được đóng dấu ký tự Gyaaa (tiếng lốp xe rít trên đường) cắt ngang các trang sách của hai bộ truyện Initial D và MF GHOST. Mặt dưới của dây đeo cũng có dòng chữ “Cửa hàng đậu phụ Fujiwara (Xe của gia đình),” dòng chữ quen thuộc ở bên hông xe Toyota AE86 của Takumi Fujiwara, nhân vật chính trong truyện Initial D. Với tính năng kết nối với điện thoại thông minh qua Bluetooth giúp bạn thao tác dễ dàng và hệ thống sạc Tough Solar cung cấp năng lượng, chiếc đồng hồ hiệu suất cao này giúp bạn tự do tập trung vào con đường phía trước.'
, '2023/1/9', 3)
-------------------------------------SHEEN---10- 12-------------------------------------------------------------------------
insert into SanPham values('SHE-4554PGL-8AUDF','SHE-4554PGL-8AUDF.png', N'Bộ vỏ bát giác thời trang của bộ sưu tập đồng hồ SHEEN mới lần này được hoàn thiện bằng cách tạo nên một vẻ ngoài sang trọng quý phái. Bề mặt trên cùng của vòng mặt số phẳng được xử lý đánh bóng xước tạo điểm độc đáo và lấp lánh cho chiếc đồng hồ. Bề mặt dốc của vỏ được xử lý đánh bóng tráng gương. Bộ vỏ và vòng mặt số đa diệm kết hợp với vật liệu kim loại có lớp phủ bóng đã tạo nên một thiết kế đẹp tuyệt vời và làm cho mẫu đồng hồ trông giống như một phụ kiện thời trang đẳng cấp. Casio đã ứng dụng kĩ thuật tiên tiến thiết kế cho toàn bộ vỏ mỏng hơn chỉ còn 7.5 mm giúp cho người đeo cảm giác nhẹ nhàng khi đeo.  
SHE-4554PGL: Bộ vỏ mạ ion (IP) màu vàng hồng kết hợp hoàn hảo với màu đen của mặt số. Dây đeo dạng lưới nhuyễn mang đến cảm giác thoải mái khi đeo và giúp chiếc đồng hồ trở thành một phụ kiện thời trang trên cổ tay.
Các tính năng khác của những mã đồng hồ này bao gồm mặt kính saphia chống trầy, đi cùng với khả năng chống nươc đến 50 mét.'
, '2023/1/10', 4)
insert into SanPham values('SHE-4541G-9A','SHE-4541G-9A.png', N'Bổ sung phiên bản đồng hồ mang màu sắc dịu nhẹ, lung linh vào bộ sưu tập bảng màu của bạn. Chiếc đồng hồ đơn giản có diện mạo cổ điển với kim giờ, phút và giây nay trông rực rỡ hơn với đường gờ và dây đeo phủ lớp tráng gương lấp lánh. Mặt kính saphia chống xước và khả năng chống nước ở độ sâu lên đến 50 mét giúp bạn không phải lo lắng, trong khi màn hình hiển thị ngày dễ đọc và các chức năng tiện dụng khác mang đến cho bạn cuộc sống dễ dàng hơn. Kết hợp cả phong cách lẫn tính thực tiễn, đây là món phụ kiện tuyệt đẹp mà cổ tay bạn đang còn thiếu.'
, '2023/1/11', 4)
insert into SanPham values('SHE-4539FPL-7A','SHE-4539FPL-7A.png', N'Trải nghiệm phong cách có đôi chút khác thường và lãng mạn với chiếc đồng hồ lấy cảm hứng từ những vòng hoa. Vòng hoa không có điểm kết thúc tượng trưng cho tình yêu vĩnh cửu và may mắn – những cảm xúc dường như bừng nở từ thiết kế vòng hoa của những chiếc đồng hồ này.

Lớp hoàn thiện một tông màu kết hợp hài hòa với màu sắc của mặt số, cùng viên pha lê duy nhất lấp lánh đầy tinh tế ở vị trí 7 giờ.

Vỏ và dây đeo đều được mạ ion cùng tông màu với mặt số, tạo nên diện mạo đơn sắc vô cùng tinh tế. Với mặt kính saphia chống xước và khả năng chống nước ở độ sâu lên đến 50 mét, những chiếc đồng hồ tuyệt đẹp mà vẫn đầy đủ chức năng này mang đến cho bạn niềm vui trong cuộc sống năng động.'
, '2023/1/12', 4)
-------------------------------------GENERAL---13-15-------------------------------------------------------------------------
insert into SanPham values('MQ-24S-8B','MQ-24S-8B.png', N'Mẫu đồng hồ MQ-24 bán chạy nhất đã quay trở lại với phong cách thiết kế trong mờ rực rỡ! Những chiếc đồng hồ này có vỏ kim loại, mặt số mang ánh mặt trời và dây đeo kết hợp nhiều màu đơn sắc hài hòa. Mẫu đồng hồ tiện dụng, tạo cảm giác vừa vặn, thoải mái có trọng lượng nhẹ và thiết kế đơn giản với kim giờ, phút, giây và chế độ chống nước sử dụng hằng ngày.'
, '2023/1/13', 5)
insert into SanPham values('LF-10WH-1','LF-10WH-1.png', N'"Những chiếc đồng hồ kỹ thuật số nhỏ gọn và nhẹ này được tạo ra bằng cách sử dụng nhựa sinh khối.( nhựa sinh khối là những loại vật liệu sinh học có nguồn gốc từ sinh vật, thực vật như phế phẩm từ nông nghiệp, lâm nghiệp (Rơm, bã cây, lá khô, vụn gỗ, giấy vụn,... ). Thiết kế đơn sắc liền khối giữa mặt số và dây đeo tăng thêm sự rắn chắc mạnh mẽ dù SP rất mỏng nhẹ
Dây urethane (Urethane là một nhóm các chất hữu cơ được sử dụng nhiều trong sản xuất công nghiệp hiện nay, rất nhẹ ) được làm bằng nhựa sinh khối thân thiện với môi trường giúp giảm bớt tác động môi trường bằng cách sử dụng hữu cơ tái tạo.  Những SP này giúp nâng cao lối sống có ý thức về giữ gìn sinh thái và bảo vệ môi trường tự nhiên.Các chức năng hữu ích bao gồm báo thức, đồng hồ bấm giờ và lịch tự động đầy đủ cùng với đèn nền LED để dễ đọc ngay cả trong
tối.  SP này an toàn khi đeo trong mưa"'
, '2023/1/14', 5)
insert into SanPham values('WS-1500H-5AV','WS-1500H-5AV.png', N'Thoả mãn con người phong cách và thực tiễn trong bạn với chiếc đồng hồ số đa năng mang thiết kế táo bạo, to bản và dễ đọc. Hoàn chỉnh với tuổi thọ pin 10 năm, khả năng chống nước lên đến 100 mét, đèn LED và chế độ hiển thị giờ kép, mẫu đồng hồ này luôn sẵn sàng cho bạn. Chỉ báo mực nước câu cá và tuần trăng chính là những gì bạn cần khi ra khơi.'
, '2023/1/15', 5)
-------------------------------------PRO TREK-----16-18-----------------------------------------------------------------------
insert into SanPham values('PRG-340-3DR','PRG-340-3DR.png', N'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRG-340 kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.'
,'2023/1/16', 6)
insert into SanPham values('PRG-30B-4','PRG-30B-4.png', N'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRG-30B kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.'
, '2023/1/17', 6)
insert into SanPham values('PRT-B70BE-1','PRT-B70BE-1.png', N'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRT-B70BE kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.'
, '2023/1/18', 6)

-------------------------------------ĐỒNG HỒ TRẺ EM----19-21------------------------------------------------------------
insert into SanPham values('F-94WA-9DG','F-94WA-9DG.png', N'Giá thành hợp lý, phù hợp cho đối tượng các em học sinh. Ba mẹ có thể yên tâm mua các sản phẩm bên shop cho con em mình để trải nghiệm cảm giác có 1 không 2 từ giá trị mà sản phẩm bên shop đem lại... '
, '2023/1/28', 5)
insert into SanPham values('F-200W-1ADF','F-200W-1ADF.png', N'Giá thành hợp lý, phù hợp cho đối tượng các em học sinh. Ba mẹ có thể yên tâm mua các sản phẩm bên shop cho con em mình để trải nghiệm cảm giác có 1 không 2 từ giá trị mà sản phẩm bên shop đem lại... '
, '2023/1/29', 5)
insert into SanPham values('F-91WS-7DF','F-91WS-7DF.png', N'Giá thành hợp lý, phù hợp cho đối tượng các em học sinh. Ba mẹ có thể yên tâm mua các sản phẩm bên shop cho con em mình để trải nghiệm cảm giác có 1 không 2 từ giá trị mà sản phẩm bên shop đem lại... '
, '2023/1/30', 5)


--CTAnhSanPham: mã, ảnh, mã sp
insert into CTAnhSanPham values('GM-2140GEM-2ADR_1.png', 1)
insert into CTAnhSanPham values('GM-2140GEM-2ADR_2.png', 1)
insert into CTAnhSanPham values('GM-114GEM-1A9DR_1.png', 2)
insert into CTAnhSanPham values('GM-114GEM-1A9DR_2.png', 2)
insert into CTAnhSanPham values('GG-B100Y-1ADR_1.png', 3)
insert into CTAnhSanPham values('GG-B100Y-1ADR_2.png', 3)

insert into CTAnhSanPham values('BGD-565XG-2_1.png', 4)
insert into CTAnhSanPham values('BGD-565XG-2_2.png', 4)
insert into CTAnhSanPham values('BG-169HRB-7_1.png', 5)
insert into CTAnhSanPham values('BG-169HRB-7_2.png', 5)
insert into CTAnhSanPham values('BA-110XRG-4A_1.png', 6)
insert into CTAnhSanPham values('BA-110XRG-4A_2.png', 6)

insert into CTAnhSanPham values('ECB-950MP-1ADF_1.png', 7)
insert into CTAnhSanPham values('ECB-950MP-1ADF_2.png', 7)
insert into CTAnhSanPham values('ECB-900MP-1ADF_1.png', 8)
insert into CTAnhSanPham values('ECB-900MP-1ADF_2.png', 8)
insert into CTAnhSanPham values('ECB-2000MFG-1A_1.png', 9)
insert into CTAnhSanPham values('ECB-2000MFG-1A_2.png', 9)

insert into CTAnhSanPham values('SHE-4554PGL-8AUDF_1.png', 10)
insert into CTAnhSanPham values('SHE-4554PGL-8AUDF_2.png', 10)
insert into CTAnhSanPham values('SHE-4541G-9A_1.png', 11)
insert into CTAnhSanPham values('SHE-4541G-9A_2.png', 11)
insert into CTAnhSanPham values('SHE-4539FPL-7A_1.png', 12)
insert into CTAnhSanPham values('SHE-4539FPL-7A_2.png', 12)

insert into CTAnhSanPham values('MQ-24S-8B_1.png', 13)
insert into CTAnhSanPham values('MQ-24S-8B_2.png', 13)
insert into CTAnhSanPham values('LF-10WH-1_1.png', 14)
insert into CTAnhSanPham values('LF-10WH-1_2.png', 14)
insert into CTAnhSanPham values('WS-1500H-5AV_1.png', 15)
insert into CTAnhSanPham values('WS-1500H-5AV_2.png', 15)

insert into CTAnhSanPham values('PRG-340-3DR_1.png', 16)
insert into CTAnhSanPham values('PRG-340-3DR_2.png', 16)
insert into CTAnhSanPham values('PRG-30B-4_1.png', 17)
insert into CTAnhSanPham values('PRG-30B-4_2.png', 17)
insert into CTAnhSanPham values('PRT-B70BE-1_1.png', 18)
insert into CTAnhSanPham values('PRT-B70BE-1_2.png', 18)

insert into CTAnhSanPham values('F-94WA-9DG_1.png', 19)
insert into CTAnhSanPham values('F-200W-1ADF_1.png', 20)
insert into CTAnhSanPham values('F-91WS-7DF_1.png', 21)


--GiaSanPham: mã, ngày bđ, ngày kt, giá, mã SP
insert into GiaSanPham values('2023/1/1', '2023/6/1', 9500000, 1)
insert into GiaSanPham values('2023/1/2', '2023/6/2', 10117000, 2)
insert into GiaSanPham values('2023/1/3', '2023/6/3', 12363000, 3)

insert into GiaSanPham values('2023/1/4', '2023/6/4', 4072000, 4)
insert into GiaSanPham values('2023/1/5', '2023/6/5', 4145000, 5)
insert into GiaSanPham values('2023/1/6', '2023/6/6', 4343000, 6)

insert into GiaSanPham values('2023/1/7', '2023/6/7', 6909000, 7)
insert into GiaSanPham values('2023/1/8', '2023/6/8', 6909000, 8)
insert into GiaSanPham values('2023/1/9', '2023/6/9', 15545000, 9)

insert into GiaSanPham values('2023/1/10', '2023/6/10', 3973000, 10)
insert into GiaSanPham values('2023/1/11', '2023/6/11', 6564000, 11)
insert into GiaSanPham values('2023/1/12', '2023/6/12', 3973000, 12)

insert into GiaSanPham values('2023/1/13', '2023/6/13', 914000, 13)
insert into GiaSanPham values('2023/1/14', '2023/6/14', 1062000, 14)
insert into GiaSanPham values('2023/1/15', '2023/6/15', 1259000, 15)

insert into GiaSanPham values('2023/1/16', '2023/6/16', 7353000, 16)
insert into GiaSanPham values('2023/1/17', '2023/6/17', 7353000, 17)
insert into GiaSanPham values('2023/1/18', '2023/6/18', 8636000, 18)

insert into GiaSanPham values('2023/1/28', '2023/6/28', 492000, 19)
insert into GiaSanPham values('2023/1/29', '2023/6/29', 466000, 20)
insert into GiaSanPham values('2023/1/30', '2023/6/30', 907000, 21)

--ThongSoKyThuat: mã, tên ts-mô tả(loại máy, đk mặt, đr dây, cl dây, chống nc, đối tượng sd),mã SP
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 1)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm', 1)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 1)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 1)
insert into ThongSoKyThuat values(N'Chống nước', N'20ATM (200 mét)', 1)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 1)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 2)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm', 2)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 2)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 2)
insert into ThongSoKyThuat values(N'Chống nước', N'20ATM (200 mét)', 2)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 2)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 3)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm', 3)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 3)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 3)
insert into ThongSoKyThuat values(N'Chống nước', N'20ATM (200 mét)', 3)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 3)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 4)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'37.9 mm', 4)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'125 đến 180 mm', 4)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 4)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 4)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 4)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 5)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'37.9 mm', 5)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'125 đến 180 mm', 5)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 5)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 5)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 5)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 6)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'37.9 mm', 6)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'125 đến 180 mm', 6)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 6)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 6)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 6)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Tough Solar', 7)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm',7)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 7)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 7)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 7)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 7)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Tough Solar', 8)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm',8)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 8)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 8)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 8)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 8)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Tough Solar', 9)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm',9)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'57.5 mm', 9)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 9)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 9)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 9)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 10)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm',10)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'135 mm', 10)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng da', 10)
insert into ThongSoKyThuat values(N'Chống nước', N'5ATM (50 mét)', 10)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 10)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 11)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm',11)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'135 mm', 11)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng thép không gỉ', 11)
insert into ThongSoKyThuat values(N'Chống nước', N'5ATM (50 mét)', 11)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 11)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 12)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm',12)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'135 mm', 12)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng da thật', 12)
insert into ThongSoKyThuat values(N'Chống nước', N'5ATM (50 mét)', 12)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 12)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 13)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm',13)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'135 mm', 13)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 13)
insert into ThongSoKyThuat values(N'Chống nước', N'5ATM (50 mét)', 13)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 13)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 14)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm',14)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'135 mm', 14)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 14)
insert into ThongSoKyThuat values(N'Chống nước', N'5ATM (50 mét)', 14)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nữ', 14)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 15)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm',15)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'58.5 mm', 15)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 15)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 15)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 15)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Pin năng lượng mặt trời', 16)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'53.4 mm',16)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'145 đến 215 mm', 16)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng uretan mềm (nhựa sinh học)', 16)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 16)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 16)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Pin năng lượng mặt trời', 17)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'45.2 mm', 17)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'145 đến 215 mm', 17)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng vải', 17)
insert into ThongSoKyThuat values(N'Chống nước', N'20ATM (200 mét)', 17)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 17)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 18)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'50.8 mm', 18)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'145 đến 215 mm', 18)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 18)
insert into ThongSoKyThuat values(N'Chống nước', N'20ATM (200 mét)', 18)
insert into ThongSoKyThuat values(N'Đối tượng sử dụng', N'Nam', 18)--*****************************

insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 19)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm', 19)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'45 mm', 19)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 19)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 19)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 20)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm', 20)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'45 mm', 20)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 20)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 20)--*****************************
insert into ThongSoKyThuat values(N'Loại máy', N'Quartz', 21)
insert into ThongSoKyThuat values(N'Đường kính mặt', N'38 mm', 21)
insert into ThongSoKyThuat values(N'Độ rộng dây', N'45 mm', 21)
insert into ThongSoKyThuat values(N'Chất liệu dây', N'Dây đeo bằng nhựa', 21)
insert into ThongSoKyThuat values(N'Chống nước', N'10ATM (100 mét)', 21)--*****************************

--Kho: mã, tên kho, địa chỉ
insert into Kho values(N'Kho Hà Nội', N'Hà Nội')
insert into Kho values(N'Kho Hưng Yên', N'Hưng Yên')
insert into Kho values(N'Kho Đà Nẵng', N'Đà Nẵng')
insert into Kho values(N'Kho Bình Dương', N'Bình Dương')

--CTKho: mã, số lượng, mã kho, mã sp
insert into CTKho values(10, 1, 1)
insert into CTKho values(20, 2, 1)
insert into CTKho values(4, 3, 1)
insert into CTKho values(5, 4, 1)--------------
insert into CTKho values(20, 1, 2)
insert into CTKho values(30, 2, 2)
insert into CTKho values(6, 3, 2)--------------
insert into CTKho values(12, 3, 3)
insert into CTKho values(13, 4, 3)--------------
insert into CTKho values(30, 2, 4)
insert into CTKho values(31, 3, 4)--------------
insert into CTKho values(16, 1, 5)
insert into CTKho values(19, 2, 5)
insert into CTKho values(16, 3, 5)
insert into CTKho values(19, 4, 5)--------------
insert into CTKho values(30, 1, 6)
insert into CTKho values(26, 2, 6)--------------
insert into CTKho values(10, 1, 7)
insert into CTKho values(42, 2, 7)--------------
insert into CTKho values(30, 1, 8)
insert into CTKho values(31, 2, 8)--------------
insert into CTKho values(30, 1, 9)
insert into CTKho values(32, 2, 9)--------------
insert into CTKho values(30, 1, 10)
insert into CTKho values(33, 2, 10)-------------
insert into CTKho values(30, 1, 11)
insert into CTKho values(34, 2, 11)-------------
insert into CTKho values(30, 1, 12)
insert into CTKho values(23, 2, 12)-------------
insert into CTKho values(18, 1, 13)
insert into CTKho values(23, 2, 13)-------------
insert into CTKho values(30, 3, 14)
insert into CTKho values(23, 4, 14)-------------
insert into CTKho values(30, 1, 15)
insert into CTKho values(36, 2, 15)-------------
insert into CTKho values(33, 2, 16)
insert into CTKho values(23, 3, 16)-------------
insert into CTKho values(26, 1, 17)
insert into CTKho values(23, 4, 17)-------------
insert into CTKho values(30, 2, 18)
insert into CTKho values(23, 4, 18)-------------

insert into CTKho values(37, 1, 19)
insert into CTKho values(23, 2, 19)-------------
insert into CTKho values(3, 1, 20)
insert into CTKho values(23, 2, 20)-------------
insert into CTKho values(59, 1, 21)


--NguoiDung: mã, tài khoản, Email, MatKhau, HoTen, NgaySinh, DiaChi ,SDT , LoaiQuyen, TrangThai 
insert into NguoiDung values('admin', 'phuphamvan411@gmail.com', '123', N'Phạm Phú', '2002/11/24', N'Hải Dương', 0357717404, N'Quản trị', 1)

insert into NguoiDung values('huonghn1' ,'nhanvien1@gmail.com', '1', N'Trần Hương', '2002/1/2', N'Hà Nội', 0355555555, N'Nhân viên', 1)
insert into NguoiDung values('hung333', 'nhanvien2@gmail.com', '1', N'Vũ Hùng', '2002/12/13', N'Hưng Yên', 0357777777, N'Nhân viên', 1)
insert into NguoiDung values('dungdinh09', 'nhanvien3@gmail.com', '1', N'Đinh Dũng', '2002/5/6', N'Thái Bình', 0356666666, N'Nhân viên', 1)

insert into NguoiDung values('trungth1', 'nguyentrung1@gmail.com', 'trung12', N'Nguyễn Trung', '2002/2/2', N'Hải Dương', 0333333333, N'Khách hàng', 1)
insert into NguoiDung values('hoanghd45', 'phamhoang1@gmail.com', 'hoangab11', N'Phạm Hoàng', '2002/11/18', N'Hải Dương', 0351111111, N'Khách hàng', 1)
insert into NguoiDung values('trangnemo1', 'trangkk@gmail.com', 'trang123', N'Lê Trang', '2002/6/8', N'Sa Pa', 0352222222, N'Khách hàng', 1)

--TinTuc: ảnh đại diện, tiêu đề, mô tả, ngày đăng, mã nd
insert into TinTuc values('TT1.png', N'Cận cảnh 03 mẫu đồng hồ Baby-G màu xanh bạc hà tuyệt đẹp', N'Màu sắc đẹp là một trong những lợi thế của đồng hồ Baby-G. Và trong hôm nay, hãy cùng Casio Anh Khuê tìm hiểu về những chiếc đồng hồ Baby-G có màu xanh bạc hà tuyệt đẹp và cực thích hợp cho những ngày hè nắng nóng. Cùng tham khảo và lựa chọn cho mình một item yêu thích các bạn gái nhé!', '2023/2/25', 2)
insert into TinTuc values('TT2.png', N'Nên chọn đồng hồ G-Shock mặt vuông hay mặt tròn?', N'Đồng hồ G-Shock có nhiều hình dạng khác nhau như mặt vuông, mặt tròn. Bạn đang phân vân không biết nên chọn loại sẽ phù hợp với bạn. Cùng Casio Anh Khuê tìm hiểu xem loại mặt nào sẽ đẹp và phù hợp hơn với bạn nhé.', '2023/2/24', 2)
insert into TinTuc values('TT3.png', N'03 mẫu đồng hồ G Shock thích hợp cho cả nam lẫn nữ', N'Đồng hồ G Shock thường được biết đến là dòng đồng hồ dành cho nam giới bởi thiết kế hầm hố, thể thao và cá tính. Tuy nhiên có một số mẫu đồng hồ G Shock có nhiều màu sắc đa dạng phù hợp với cả nam và nữ.', '2023/2/23', 3)
insert into TinTuc values('TT4.png', N'Văn Phú Watch tổ chức chương trình hội nghị trưng bày và giới thiệu sản phẩm mới tháng 2/2023', N'Ngày 17/02, Công ty cổ phần Anh Khuê Watch tổ chức chương trình “Hội nghị trưng bày và giới thiệu sản phẩm mới tháng 2/2023” nhằm giới thiệu các sản phẩm đồng hồ Casio mới đến quý đại lý.', '2023/2/22', 3)
insert into TinTuc values('TT5.png', N'Các tips mix đồng hồ Baby-G cho các cô nàng sành điệu', N'Đồng hồ không chỉ là một vật dụng dùng để xem giờ mà nó còn là món phụ kiện giúp làm nổi bật phong cách thời trang của các bạn nữ. Đó cũng là lý do vì sao đồng hồ Casio luôn thường xuyên cho ra mắt những mẫu mã khác nhau. Sau đây, hãy cùng chúng tôi tìm hiểu một số tips mix đồng hồ Casio Baby-G thật sành điệu nhé!', '2023/2/21', 4)
insert into TinTuc values('TT6.png', N'Khám phá đồng hồ G-Shock GW-B5600-2 - ấn tượng mạnh mẽ với mức giá hấp dẫn', N'Kể từ khi ra mắt vào đầu tháng 1 năm 2019, dòng đồng hồ Casio G-Shock GW-B5600-2 đã nhanh chóng trở thành mẫu đồng hồ được săn đón nhờ sự kết hợp của thiết kế đồng hồ đẹp mắt, tính năng ấn tượng và mức giá khá hấp dẫn. ', '2023/2/20', 4)

--CTTinTuc: mã , ảnh, nội dung, mã tt
insert into CTTinTuc values('CTTT1_1.png', N'Đồng hồ Baby-G BGD-570BC-3
Model đầu tiên chính là một chiếc đồng hồ Baby-G điện tử có kiểu dáng độc đáo. Vỏ đồng hồ hình tròn và có kích thước nhỏ gọn, còn phần mặt số bên trong là hình vuông, có một màn hình LCD để hiển thị các thông tin cần thiết về giờ hiện hành, lịch, cũng như để sử dụng các chức năng. Toàn bộ mẫu đồng hồ Casio Baby-G này được bao phủ bởi tông màu xanh bạc hà tươi mát và trông rất đẹp mắt. Trên mặt đồng hồ có các họa tiết cây cọ, cánh buồm và con sóng màu hồng, tím. Tổng thể mang đến một chút hoài cổ nhưng cũng đầy lãng mạn, gợi nhớ đến những bãi biển mùa hè vào lúc hoàng hôn. Với item này, chắc chắn chuyến đi chơi biển vào mùa hè của bạn sẽ trở nên thú vị và sôi động hơn đấy nhé!'
, 1)
insert into CTTinTuc values('CTTT1_2.png', N'Đồng hồ Baby-G BGA-280-3A
Đây là mẫu đồng hồ Baby-G mới cho ra mắt trong thời gian gần đây. Toàn bộ đồng hồ được bao phủ bởi tông màu bạc hà nhẹ nhàng, không bóng. Ngay cả mặt số cũng có màu xanh lấp lánh rất đẹp mắt. Còn phần gờ đồng hồ là màu trắng, kết hợp hài hòa mang đến một diện mạo tươi mới và đầy dễ thương. Mẫu đồng hồ Baby-G này được Casio ra mắt lấy cảm hứng từ thời trang đường phố Los Angeles. Phần vỏ tròn và các vạch giờ bằng kim loại trông rất thể thao, thích hợp kết hợp cùng nhiều phong cách thời trang khác nhau. Trong mùa hè này, BGA-280-3A được dự đoán sẽ lên ngôi, và các cô nàng thời thượng đã bắt đầu săn hàng rồi đấy nhé!'
, 1)
insert into CTTinTuc values('CTTT1_3.png', N'Đồng hồ Baby-G BG-169R-3
BG-169R-3 là một chiếc đồng hồ Baby-G có giá thành tương đối rẻ vì thuộc dòng đồng hồ điện tử. Tuy nhiên, model này lại trở thành item bán chạy hàng đầu chính nhờ màu sắc siêu dễ thương cùng thiết kế gọn nhẹ, xinh xắn. Bộ vỏ được bao phủ bởi xanh bạc hà pastel, xen lẫn một số chi tiết màu trắng đơn giản cho nút bấm. Bên trên mặt đồng hồ còn có hai thanh kim loại bảo vệ bề mặt khỏi bị trầy xước khi va chạm. Về tính năng, mẫu đồng hồ Casio Baby-G này cũng giống như các model được giới thiệu ở trên. Chúng được trang bị đầy đủ các chức năng cơ bản của dòng Baby-G như đồng hồ bấm thời gian, đồng hồ đếm ngược, lịch tự động, giờ thế giới,... Đặc biệt, đồng hồ có đèn Led để xem thông tin dễ dàng trong bóng đêm. Khả năng chống nước ở mức 100M, đáp ứng nhu cầu sử dụng hàng ngày như tắm rửa hay bơi lội.'
, 1)
insert into CTTinTuc values('TT2.png', N'1. Thiết kế mặt đồng hồ
Hiện nay các hãng đồng hồ nổi tiếng trên thế giới có rất nhiều sản phẩm đồng hồ với kiểu dáng, mẫu mã đa dạng khác nhau. Tuy nhiên các mẫu đồng hồ được thiết chủ yếu là mặt vuông, mặt tròn, mặt oval, mặt hình chữ nhật. Trong số đó thì đồng hồ có kiểu dáng mặt vuông và mặt tròn là hai mẫu đồng hồ được người tiêu dùng ưa chuộng nhất bởi phong cách cổ điển, lịch lãm và sang trọng. Đồng hồ G-Shock của Casio với thiết kế hầu hết là mặt tròn và mặt vuông. Hai kiểu thiết kế này sẽ giúp bạn dễ dàng phối hợp cùng với nhiều loại trang phục trong nhiều hoàn cảnh khác nhau để bạn có thể thể hiện được cá tính riêng của mình.'
, 2)
insert into CTTinTuc values('CTTT2_1.png', N'2. Đồng hồ G-Shock mặt tròn

Vòng tròn từ xưa tới nay luôn được coi là biểu tượng cho tính tuần hoàn của thời gian. Người chọn mặt đồng hồ tròn là người có phong cách mang hơi hướng cổ điển. Đồng hồ G-Shock mặt tròn là thiết kế phổ biến và chiếm hơn 80% các mẫu đồng hồ thể thao của Casio. Tuy là dòng đồng hồ thể thao dành cho phái mạnh nhưng đồng hồ G-Shock được thiết kế với nhiều kích cỡ mặt khác nhau phù hợp với phái mạnh.

Đối với các bạn nam có cổ tay to nên chọn đồng hồ G-Shock mặt tròn có kích thước lớn từ 42mm trở lên. Mặt đồng hồ lớn kết hợp với dây đeo bằng nhựa hoặc bằng da ôm vừa vặn cổ tay sẽ giúp cho phái mạnh trông mạnh mẽ và cá tính hơn.
Mặc dù đồng hồ G-Shock là dòng đồng hồ thể thao dành cho phái mạnh nhưng các nhà thiết kế của Casio đã tạo ra những mẫu đồng hồ có kích thước mặt vừa phải phù hợp với các bạn nam có cổ tay nhỏ. Đối với các bạn có cổ tay nhỏ nên chọn đồng hồ có dây đeo mỏng nhẹ, kích thước mặt 36mm là lựa chọn tối ưu sẽ tạo cho bạn cảm giác thoải mái, vừa vặn với cổ tay, mà vẫn thể hiện được chất riêng của mình.'
, 2)
insert into CTTinTuc values('CTTT2_2.png', N'3. Đồng hồ G-Shock mặt vuông

Đồng hồ G-Shock mặt vuông đầu tiên được ra đời vào năm 1983. DW-5600E là mẫu thiết kế nguyên bản, đơn giản nhưng ấn tượng với những đường nét góc cạnh tạo cá tính mạnh mẽ. Khả năng chống sốc, chống va đập gần như tuyệt đối của đồng hồ G-Shock mà ở các hãng đồng hồ khác không có được. Điều này đã giúp cho chiếc đồng hồ G-Shock Casio ghi điểm trong lòng người đam mê đồng hồ.
Ngoài các thiết kế mặt vuông cổ điển, Casio cũng cho ra đời những mẫu đồng hồ G-Shock thiết kế phá cách dựa trên mẫu thiết kế nguyên bản. Mẫu tân cổ điển được phối hợp với vỏ kim loại vô cùng sang trọng, thiết kế hỗ trợ nhiều tính năng hơn cho người dùng và phù hợp với cả bạn nam có cổ tay to hoặc nhỏ.
Đồng hồ mặt tròn hay mặt vuông đều có những vẻ đẹp và sức hút riêng của nó. Mỗi loại đồng hồ phù hợp với những cá tính khác nhau. Việc lựa chọn hình dáng mặt đồng hồ cũng nói lên rất nhiều về phong cách thời trang của người đeo cũng như cá tính của họ.

Hãy lựa chọn cho mình những chiếc đồng hồ G-Shock thật phù hợp để thể hiện được “chất” riêng của mình, bạn nhé!'
, 2)
insert into CTTinTuc values('CTTT3_1.png', N'1. Đồng hồ G Shock DW-5600LS
DW-5600LS là phiên bản mới của mẫu đồng hồ G Shock mặt vuông cổ điển của thập niên 80. Với mẫu thiết kế làm từ vật liệu bán trong suốt với 2 phiên bản màu huỳnh quang xanh và trắng mang đến một màu sắc tươi mới trẻ trung phù hợp cho cả nam và nữ. Đây là một sự lựa chọn lý tưởng cho các cặp đôi khi kết hợp với trang phục mùa hè năng động.'
, 3)
insert into CTTinTuc values('CTTT3_2.png', N'2. Đồng hồ G Shock GA-2100

GA-2100 là mẫu đồng hồ G Shock được sử dụng cấu trúc lõi carbon. Lớp vỏ đồng hồ làm bằng nhựa mịn pha lẫn sợi carbon tạo nên độ bền vượt trội so với các dòng đồng hồ G Shock khác.
GA-2100 được thiết kế với gam màu trung tính là màu đen huyền bí và màu đỏ nổi bật nên chiếc đồng hồ G Shock này phù hợp với cả nam lẫn nữ. Kích thước mặt đồng hồ là 45,5mm khá lớn so với cổ tay của nữ. Tuy nhiên độ dày của mặt đồng hồ khá mỏng chỉ 11,8mm và trọng lượng chiếc đồng hồ G Shock này chỉ 51gram nên vẫn phù hợp với các bạn nữ có cổ tay to yêu thích sự cá tính mạnh mẽ.'
, 3)
insert into CTTinTuc values('TT3.png', N'3. Đồng hồ G Shock GAX-100

GAX-100 là mẫu đồng hồ G Shock được giới thiệu vào mùa hè 2018. Vẫn là mẫu đồng hồ thu hút giới trẻ với thiết kế cá tính mạnh mẽ với cùng với sự bền bỉ tuyệt đối, đây cũng là mẫu đồng hồ được yêu thích của nhiều vận động viên nổi tiếng trên thế giới. '
, 3)
insert into CTTinTuc values('TT4.png', N'Ngày 17/02, Công ty cổ phần Văn Phú Watch tổ chức chương trình “Hội nghị trưng bày và giới thiệu sản phẩm mới tháng 2/2023” nhằm giới thiệu các sản phẩm đồng hồ Casio mới đến quý đại lý.'
, 4)
insert into CTTinTuc values('CTTT4_1.png', N'Bên cạnh việc giới thiệu đến quý đại lý những dòng sản phẩm mới nhất, Văn Phú Watch còn chia sẻ thêm chính sách bán hàng đến quý đại lý. Chương trình là hoạt động thường niên nhằm kết nối, duy trì mối quan hệ hợp tác thân thiện giữa công ty và quý đại lý.'
, 4)
insert into CTTinTuc values('CTTT4_2.png', N'Cuối chương trình, công ty cũng đã có phần giải đáp thêm những thắc mắc đến quý đại lý để những thông tin về sản phẩm cũng như chính sách bán hàng được rõ ràng hơn, từ đó quý đại lý có thể tư vấn và hỗ trợ người tiêu dùng một cách đầy đủ, nhanh chóng.

Hi vọng với hoạt động giới thiệu sản phẩm mới thường xuyên cùng với các chính sách bán hàng hấp dẫn, Văn Phú Watch sẽ tiếp tục nhận được sự tin tưởng, đồng hành của quý đại lý và ngày càng thắt chặt hơn mối quan hệ hợp tác trong thời gian tới.'
, 4)
insert into CTTinTuc values('CTTT5_1.png', N'Đồng hồ không chỉ là một vật dụng dùng để xem giờ mà nó còn là món phụ kiện giúp làm nổi bật phong cách thời trang của các bạn nữ. Đó cũng là lý do vì sao đồng hồ Casio luôn thường xuyên cho ra mắt những mẫu mã khác nhau. Sau đây, hãy cùng chúng tôi tìm hiểu một số tips mix đồng hồ Casio Baby-G thật sành điệu nhé! '
, 5)
insert into CTTinTuc values('CTTT5_2.png', N'Bước 1: Phải chọn được một chiếc đồng hồ Baby-G phù hợp : 

Dòng đồng hồ Casio Baby-G có phong cách chung là trẻ trung, năng động, thích hợp cho giới trẻ. Tuy nhiên, Baby-G cũng có nhiều mẫu mã, kiểu dáng khác nhau như: đồng hồ mặt vuông, đồng hồ mặt tròn, đồng hồ điện tử, đồng hồ dây kim loại… Trước khi mix đồng hồ, bạn phải chọn được một chiếc Casio Baby-G phù hợp với mình. Phù hợp ở đây nghĩa là nó tạo sự thoải mái khi đeo, không quá lớn hoặc quá nhỏ với cổ tay. Màu sắc của đồng hồ cũng phải phù hợp với nước da… '
, 5)
insert into CTTinTuc values('CTTT5_3.png', N'Bước 2: Mix đồng hồ ton sur ton với trang phục :
Đồng hồ là một món phụ kiện, mà phụ kiện chỉ phát huy được vai trò của nó nếu như bạn áp dụng đúng quy tắc phối màu ton sur ton trong thời trang. Màu sắc của đồng hồ tương đồng với màu trang phục hoặc giày dép, thắt lưng, túi xách… Chẳng hạn, bạn có thể kết hợp một chiếc áo đỏ với đồng hồ Baby-G đỏ cùng giày và quần đen. Đồng hồ Baby-G màu hồng pastel sẽ thích hợp để đi cùng những trang phục màu trắng. Hoặc khi đi chơi, màu của đồng hồ tốt nhất nên cùng màu với túi xách hoặc giày nếu như bạn diện váy áo khác màu. Có một điểm chung giữa các món phụ kiện sẽ khiến tổng thể set đồ của bạn trông hài hòa và dễ chịu hơn. Bạn cũng sẽ ghi điểm và chứng tỏ là một người có gu thẩm mỹ trong mắt những người xung quanh. '
, 5)
insert into CTTinTuc values('TT5.png', N'Bước 3: Hãy mix đồng hồ Baby-G cùng vòng tay nếu muốn cá tính và sành điệu :
Hầu hết các mẫu đồng hồ Casio Baby-G đều được làm bằng nhựa cao cấp, vì thế nên bạn không cần quá lo lắng các mẫu vòng tay sẽ làm ảnh hưởng đến đồng hồ. Ngược lại, nếu biết cách chọn lựa vòng tay phù hợp thì sẽ khiến cho bạn trông sành điệu và cá tính hơn rất nhiều đấy!
Cách chọn vòng tay để mix với đồng hồ Baby G cũng dựa theo định luật màu sắc tương đồng như với trang phục, trừ khi bạn là một người “sành” mix đồ và muốn thử sức với những phong cách mới lạ. Vòng tay để mix cùng có thể lựa chọn nhiều mẫu khác nhau. 

Đồng hồ Casio Baby-G được thiết kế dành cho giới nữ với rất nhiều kiểu dáng và màu sắc phong phú. Đối tượng của Casio Baby-G cũng không giới hạn ở những cô nàng tuổi teen cá tính mà bất kỳ cô gái nào cũng có thể sử dụng. Hãy tự tạo cho mình một phong cách ấn tượng với những chiếc đồng hồ Baby-G cô gái nhé!'
, 5)
insert into CTTinTuc values('CTTT6_1.png', N'Không quá lời khi nói rằng G-Shock GW-B5600-2 khá rẻ, vì ngoài việc được trang bị các tính năng năng lượng mặt trời, dòng sản phẩm này còn đi kèm với các tính năng đa băng tần 6, liên kết di động (bluetooth) và cả tính năng tiết kiệm năng lượng. Xu hướng đồng hồ mạnh mẽ với giá cả phải chăng đang dần trở nên phổ biến hơn. '
, 6)
insert into CTTinTuc values('CTTT6_2.png', N'Chiếc đồng hồ này cung cấp khá nhiều tính năng cao cấp từ G-Shock như năng lượng mặt trời Tough Solar, đa băng tần và cả kết nối với điện thoại di động thông qua chức năng (bluetooth).

Đối với liên kết di động, trước tiên bạn phải cài đặt ứng dụng G-SHOCK CONNECTED trên điện thoại thông minh của mình (Android / iOS) và sau đó bạn có thể ghép nối (kết nối) với đồng hồ GW-B5600 qua bluetooth. Với ứng dụng này, bạn có thể thực hiện các điều chỉnh nhanh hơn và dễ dàng hơn thông qua điện thoại của mình. Một số chế độ mà bạn có thể truy cập như điều chỉnh thời gian, múi giờ, báo thức, hẹn giờ. '
, 6)
insert into CTTinTuc values('CTTT6_3.png', N'Dây đeo của GW-B5600-2 không có gì khác biệt với các dòng 5600 khác. Vẫn là dây đeo bằng nhựa và ôm trọn cổ tay của bạn. Với khả năng chống nước lên đến 200 mét, GW-B5600 an toàn cho những bạn yêu thích các hoạt động ngoài trời. Đừng quên rửa lại đồng hồ bằng nước sạch nếu bạn tiếp xúc với nước biển. 

Đồng hồ này sử dụng đèn LED và bạn có thể cài đặt để luôn sáng trong 2 hoặc 4 giây. Việc cài đặt 4 giây chắc chắn sẽ giúp bạn có nhiều thời gian hơn để xem dữ liệu trên đồng hồ, nhưng tác dụng phụ là nó sẽ nhanh hết pin. Nhưng đừng lo lắng vì dòng GW-B5600-2 đã được trang bị một tấm pin năng lượng mặt trời có thể sạc pin từ ánh sáng đến hàng giờ (năng lượng mặt trời tough solar).Trên thực tế là tất cả đồng hồ Casio có chức năng Tough Solar vẫn sử dụng pin sạc (có thể sạc lại) bằng các tấm pin mặt trời trên chiếc đồng hồ này. Vì vậy, bạn cũng cần phải thay pin nếu tuổi thọ sử dụng đã hết hoặc bị hỏng (trong khoảng từ 2-3 năm). 

Kích thước mặt đồng hồ là 42,8 mm, kích thước này lý tưởng cho những bạn có cổ tay nhỏ không tự tin đeo các dòng G-Shock có kích thước lớn khác. Giá bán lẻ của dòng GW-B5600 đắt hơn nếu so sánh với các dòng 5600 khác, nhưng so với sự chênh lệch về giá thì quả thật rất hợp lý. Tất cả các tính năng mà GW-B5600 mang lại đều thuộc các tính năng ở các dòng đồng hồ G-Shock cao cấp khác là tính năng năng lượng mặt trời, tough solar, liên kết di động (bluetooth) và đa băng tần 6. '
, 6)

--GiamGia: mã, phần trăm, thời gian bđ, thời gian kt, trạng thái, mã sp
insert into GiamGia values(20, '2023/1/1', '2023/6/1', 1, 1)
insert into GiamGia values(30, '2023/1/2', '2023/6/2', 1, 2)
insert into GiamGia values(35, '2023/1/3', '2023/6/3', 1, 3)
insert into GiamGia values(20, '2023/1/4', '2023/6/1', 1, 4)
insert into GiamGia values(30, '2023/1/5', '2023/6/2', 1, 5)
insert into GiamGia values(35, '2023/1/6', '2023/6/3', 1, 6)
insert into GiamGia values(15, '2023/1/7', '2023/6/4', 1, 10)
insert into GiamGia values(20, '2023/1/7', '2023/6/5', 1, 12)
insert into GiamGia values(30, '2023/1/8', '2023/6/6', 1, 16)
insert into GiamGia values(15, '2023/1/8', '2023/6/6', 1, 17)
insert into GiamGia values(20, '2023/1/8', '2023/6/6', 1, 18)
insert into GiamGia values(45, '2023/1/9', '2023/6/7', 1, 21)

--HoaDonNhap: mã, ngày nhập, mã ND, mã NCC
insert into HoaDonNhap values ('2023/1/1', 2, 1);
insert into HoaDonNhap values ('2023/1/2', 3, 2);
insert into HoaDonNhap values ('2023/1/2', 4, 3);

--CTHoaDonNhap: mã, số lượng, đơn giá nhập, mã HDN, mã SP
insert into CTHoaDonNhap values (5, 2000000, 1, 1);
insert into CTHoaDonNhap values (10, 3000000, 2, 2);
insert into CTHoaDonNhap values (15, 1000000, 3, 3);

--DonHang: mã, ngày đặt, địa chỉ giao hàng, trạng thái, mã kH
insert into DonHang values('2023/2/23', 1, 1)
insert into DonHang values('2023/2/24', 1, 2)
insert into DonHang values('2023/2/25', 1, 3)
insert into DonHang values('2023/2/26', 1, 4)
insert into DonHang values('2023/2/27', 1, 5)
insert into DonHang values('2023/2/23', 1, 6)
insert into DonHang values('2023/2/24', 1, 7)
insert into DonHang values('2023/2/25', 1, 8)
insert into DonHang values('2023/2/26', 1, 9)
insert into DonHang values('2023/2/27', 1, 10)

--CTDonHang: mã, số lượng, giá mua, mã DH, mã SP
insert into CTDonHang values(1, 6564000, 1, 11)
insert into CTDonHang values(3, 2742000, 1, 13)
insert into CTDonHang values(2, 2518000, 1, 15)

insert into CTDonHang values(3, 9535200, 2, 12)

insert into CTDonHang values(2, 2124000, 3, 14)
insert into CTDonHang values(2, 2518000, 3, 15)
insert into CTDonHang values(4, 19411920, 3, 16)

insert into CTDonHang values(1, 6564000, 4, 11)
insert into CTDonHang values(1, 3178400, 4, 12)
insert into CTDonHang values(1, 914000, 4, 13)
insert into CTDonHang values(1, 1062000, 4, 14)

insert into CTDonHang values(10, 86360000, 5, 18)

insert into CTDonHang values(2, 2124000, 6, 14)
insert into CTDonHang values(1, 914000, 6, 13)

insert into CTDonHang values(5, 32820000, 7, 11)
insert into CTDonHang values(5, 6295000, 7, 15)
insert into CTDonHang values(1, 7353000, 7, 17)

insert into CTDonHang values(10, 73530000, 8, 17)

insert into CTDonHang values(1, 3178400, 9, 12)
insert into CTDonHang values(1, 1062000, 9, 14)
insert into CTDonHang values(1, 4852980, 9, 16)

insert into CTDonHang values(3, 9535200, 10, 12)
GO
------------------------------------------------------------------
-----------------------THỦ TỤC ---------------------------------------
--------------------------------------------------------------------
------------------------ MENU ----------------------------------------
----------------------- getALL -------------------------------------
CREATE PROCEDURE sp_menu_get_all
AS
    BEGIN
        SELECT *                       
        FROM Menu
    END;
GO
EXEC sp_menu_get_all
GO

---------------------------------------------------------------------------
---------------------- GIỚI THIỆU -------------------------------------------
----------------------- getALL ---------------------------------------------
CREATE PROCEDURE sp_gioithieu_get_all
AS
    BEGIN
        SELECT *                       
        FROM GioiThieu
    END;
GO
EXEC sp_gioithieu_get_all
GO
---------------------------------------------------------------------------
---------------------- LIÊN HỆ -------------------------------------------
----------------------- getALL ---------------------------------------------
CREATE PROCEDURE sp_lienhe_get_all
AS
    BEGIN
        SELECT *                       
        FROM LienHe
    END;
GO
EXEC sp_lienhe_get_all
GO
---------------------------------------------------------------------------
---------------------- SLIDE ----------------------------------------------
----------------------- getALL ----------------------------------------
CREATE PROCEDURE sp_slide_get_all
AS
    BEGIN
        SELECT *                       
        FROM Slide
    END;
GO
EXEC sp_slide_get_all
GO

---------------------------------------------------------------------------
------- DÒNG SẢN PHẨM (getID, getALL, getSanphambyDongSanPham)-----------
-----------------------------------getID --------------------------------------------------------------------
CREATE PROCEDURE sp_dongsanpham_get_by_id(@MaDSP int)
AS
    BEGIN
        SELECT d.MaDSP, d.TenDSP, d.MoTa,
		(
			SELECT cta.MaCTADSP, cta.Anh 
			FROM CTAnhDongSanPham cta WHERE d.MaDSP = cta.MaDSP
			FOR JSON PATH
		) AS objectjson_ctanhdongsanpham
		FROM DongSanPham d 
		WHERE  d.MaDSP = @MaDSP
		GROUP BY d.MaDSP, d.TenDSP, d.MoTa
    END;
GO
EXEC sp_dongsanpham_get_by_id 3;
GO
-----------------------------------getbySL --------------------------------------------------------------------
CREATE PROCEDURE sp_dongsanpham_get_by_sl(@SoLuong int)
AS
    BEGIN
        SELECT TOP (@SoLuong) *                     
        FROM DongSanPham
    END;
GO
EXEC sp_dongsanpham_get_by_sl 5
GO

---------------------------------------------------------------------------
------- SẢN PHẨM (getID, getNew, getBestSelling, getByNhom , Search)-----------
-----------------------------------getID --------------------------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_by_id(@MaSP int)
AS
    BEGIN
        SELECT s.MaSP, s.TenSP, s.AnhDaiDien, SUM(ctk.SoLuong) AS TongSL ,gsp.GiaBan ,IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam, s.MoTa, s.MaDSP, d.TenDSP,
			(	
				SELECT cta.MaCTASP, cta.Anh
				FROM CTAnhSanPham cta WHERE s.MaSP = cta.MaSP
				FOR JSON PATH
			) AS objectjson_ctanhsanpham ,
			(
				SELECT t.MaTS, t.TenTS, t.MoTa
				FROM ThongSoKyThuat t WHERE s.MaSP = t.MaSP
				FOR JSON PATH 
			) AS objectjson_thongsokythuat 
        FROM SanPham s inner join CTKho		   ctk ON s.MaSP  = ctk.MaSP
					   inner join GiaSanPham   gsp ON s.MaSP  = gsp.MaSP
					   left join  GiamGia       gg  ON s.MaSP = gg.MaSP
					   inner join DongSanPham	 d ON s.MaDSP = d.MaDSP
		WHERE  s.MaSP = @MaSP
		GROUP BY s.MaSP, s.TenSP, s.AnhDaiDien, gsp.GiaBan, gg.PhanTram, s.MoTa, s.MaDSP, d.TenDSP
    END;
GO
EXEC sp_sanpham_get_by_id 31;
GO
------------------------------------ getNew -----------------------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_new(@SoLuong int)
AS
	BEGIN
		Select TOP (@SoLuong) s.MaSP, s.NgayTao, s.TenSP, s. AnhDaiDien, s.MoTa, SUM(c.SoLuong) AS TongSL, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam, s.MaDSP, d.TenDSP
		FROM SanPham s	inner join CTKho	    c ON s.MaSP  = c.MaSP
						left join GiamGia	   gg ON s.MaSP  = 	gg.MaSP
						inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP
						inner join DongSanPham  d ON s.MaDSP = d.MaDSP				
		 GROUP BY  s.MaSP, s.TenSP, s. AnhDaiDien, s.MoTa, s.MaDSP, gg.PhanTram, gsp.GiaBan, s.NgayTao, d.TenDSP
		 ORDER BY s.NgayTao DESC;
		 
	END
GO
EXEC sp_sanpham_get_new 10
GO
-------------------------------- getHOT -------------------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_hot(@SoLuong int)
AS
	BEGIN
		Select TOP (@SoLuong)  SUM(ctdh.SoLuong) AS TongSLMua, s.MaSP, s.TenSP, s.AnhDaiDien, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam , s.MaDSP, d.TenDSP
		FROM SanPham s	inner join CTDonHang ctdh ON s.MaSP  = ctdh.MaSP
						left join  GiamGia	   gg ON s.MaSP  = 	gg.MaSP
						inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP	
						inner join DongSanPham  d ON s.MaDSP = d.MaDSP
		 GROUP BY  s.MaSP, s.TenSP, s.AnhDaiDien, gg.PhanTram, gsp.GiaBan, s.MaDSP, d.TenDSP
		 ORDER BY SUM(ctdh.SoLuong) DESC;
	END
GO
EXEC sp_sanpham_get_hot 10
GO
-------------------------------- getTopHOT --------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_top_hot
AS
	BEGIN
		Select TOP 1  SUM(ctdh.SoLuong) AS TongSLMua, s.MaSP, s.TenSP, s.AnhDaiDien, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam , s.MaDSP, d.TenDSP
		FROM SanPham s	inner join CTDonHang ctdh ON s.MaSP  = ctdh.MaSP
						left join  GiamGia	   gg ON s.MaSP  = 	gg.MaSP
						inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP	
						inner join DongSanPham  d ON s.MaDSP = d.MaDSP
		 GROUP BY  s.MaSP, s.TenSP, s.AnhDaiDien, gg.PhanTram, gsp.GiaBan, s.MaDSP, d.TenDSP
		 ORDER BY SUM(ctdh.SoLuong) DESC; 
	END
GO
EXEC sp_sanpham_get_top_hot
GO
-------------------------------- getSale -------------------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_sale(@SoLuong int)
AS
	BEGIN
		Select TOP (@SoLuong) s.MaSP, s.NgayTao, s.TenSP, s.AnhDaiDien, SUM(c.SoLuong) AS TongSL, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam, s.MaDSP, d.TenDSP
		FROM SanPham s	inner join CTKho	    c ON s.MaSP  = c.MaSP
						left join GiamGia	   gg ON s.MaSP  = 	gg.MaSP
						inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP
						inner join DongSanPham  d ON s.MaDSP = d.MaDSP				
		 GROUP BY  s.MaSP, s.NgayTao, s.TenSP, s.AnhDaiDien, s.MoTa, s.MaDSP, gg.PhanTram, gsp.GiaBan, d.TenDSP
		 ORDER BY gg.PhanTram DESC;
	END
GO
EXEC sp_sanpham_get_sale 10
GO

----------------------------------------------------------------------------------------------------------------
EXEC sp_sanpham_search '1', '10', NULL, N'', 5000000, NULL, NULL, N''
GO
-------------------SEARCH (mã sp, tên sp, khoảng giá, tên dòng sp, tên nhóm sp) ------------------------------------------------------------------
CREATE PROCEDURE sp_sanpham_search	(	@page_index	int, --trang đầu
										@page_size	int, --số lượng sản phẩm/trang
										@MaSP	int,
										@TenSP	nvarchar(50),
										@MinGia int,
										@MaxGia int,
										@MaDSP int,
										@TenDSP	nvarchar(200)
									)
AS
    BEGIN
        DECLARE @RecordCount BIGINT; --đếm số lượng sp
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(ORDER BY s.NgayTao DESC))  AS RowNumber, --thứ tự sp
							s.MaSP,
							s.TenSP,
							s.AnhDaiDien,
							gsp.GiaBan,
							d.MaDSP,
							d.TenDSP,
							IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram,
							IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam							  
						INTO #Results1

                        FROM SanPham s	left join GiamGia	   gg ON s.MaSP  = 	gg.MaSP
										inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP
										inner join DongSanPham  d ON s.MaDSP = d.MaDSP
					    WHERE	(@MaSP is null or s.MaSP = @MaSP) AND
								(@TenSP = '' OR s.TenSP like N'%' + @TenSP + '%') AND
								(@MaDSP is null or d.MaDSP = @MaDSP) AND
								(@TenDSP = '' OR d.TenDSP like N'%' + @TenDSP + '%') AND
								(@MinGia IS NULL AND @MaxGia IS NULL)
                                    OR (@MinGia IS NOT NULL AND @MaxGia IS NULL)
                                       AND @MinGia >= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) - 500000)  
									   AND @MinGia <= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) + 500000)  
                                    OR (@MinGia IS NULL AND @MaxGia IS NOT NULL)
									   AND @MaxGia >= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) - 500000)  
									   AND @MaxGia <= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) + 500000) 
                                    OR (gsp.GiaBan BETWEEN @MinGia AND @MaxGia);
						                 
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(ORDER BY s.NgayTao DESC))  AS RowNumber, --thứ tự sp
							s.MaSP,
							s.TenSP,
							s.AnhDaiDien,
							gsp.GiaBan,
							d.MaDSP,
							d.TenDSP,
							IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram,
							IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam							  
						INTO #Results2

                        FROM SanPham s	left join GiamGia	   gg ON s.MaSP  = 	gg.MaSP
										inner join GiaSanPham gsp ON s.MaSP  = gsp.MaSP
										inner join DongSanPham  d ON s.MaDSP = d.MaDSP
					    WHERE	(@MaSP is null or s.MaSP = @MaSP) AND
								(@TenSP = '' OR s.TenSP like N'%' + @TenSP + '%') AND
								(@MaDSP is null or d.MaDSP = @MaDSP) AND
								(@TenDSP = '' OR d.TenDSP like N'%' + @TenDSP + '%') AND
								(@MinGia IS NULL AND @MaxGia IS NULL)
                                    OR (@MinGia IS NOT NULL AND @MaxGia IS NULL)
                                       AND @MinGia >= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) - 500000)  
									   AND @MinGia <= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) + 500000)  
                                    OR (@MinGia IS NULL AND @MaxGia IS NOT NULL)
									   AND @MaxGia >= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) - 500000)  
									   AND @MaxGia <= ((gsp.GiaBan * (100 - gg.PhanTram) / 100) + 500000) 
                                    OR (gsp.GiaBan BETWEEN @MinGia AND @MaxGia);
                                               
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO

---------------------------------------------------------------------------
------- TIN TỨC (getID, getALL + pagination)-----------
-----------------------------------getID --------------------------------------------------------------------
CREATE PROCEDURE sp_tintuc_get_by_id(@MaTT int)
AS
    BEGIN
        SELECT t.MaTT, t.AnhDaiDien, t.TieuDe, t.MoTa, t.NgayDang, n.HoTen,
			(	
				SELECT ct.MaCTTT, ct.Anh, ct.NoiDung
				FROM CTTinTuc ct WHERE t.MaTT = ct.MaTT
				FOR JSON PATH
			) AS objectjson_cttintuc
        FROM TinTuc t  inner join CTTinTuc	    ct ON t.MaTT  = ct.MaTT
					   inner join NguoiDung      n ON t.MaND  = n.MaND	
		
		WHERE  t.MaTT = @MaTT
		GROUP BY t.MaTT, t.AnhDaiDien, t.TieuDe, t.MoTa, t.NgayDang, n.HoTen
    END;
GO
EXEC sp_tintuc_get_by_id 5;
GO
------------------------------------ getALL + pagination -----------------------------------------------------------------
CREATE PROCEDURE sp_tintuc_get_all (@page_index int, @page_size int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT; --đếm số lượng tt
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(ORDER BY t.NgayDang DESC))  AS RowNumber, --thứ tự sp
							t.MaTT,
							t.AnhDaiDien,
							t.TieuDe,
							t.MoTa,
							t.NgayDang, 
							n.HoTen
						INTO #Results1

                        FROM TinTuc t inner join NguoiDung n ON t.MaND = n.MaND
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(ORDER BY t.NgayDang DESC))  AS RowNumber, --thứ tự sp
							t.MaTT,
							t.AnhDaiDien,
							t.TieuDe,
							t.MoTa,
							t.NgayDang, 
							n.HoTen
						INTO #Results2

                        FROM TinTuc t inner join NguoiDung n ON t.MaND = n.MaND
                                               
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO
EXEC sp_tintuc_get_all 1, 6
GO

---------------------------------------------------------------------------
---------------------- ĐƠN HÀNG -------------------------------------------
----------------------- getID ---------------------------------------------
CREATE PROCEDURE sp_donhang_get_by_id(@MaDH int)
AS
    BEGIN
        SELECT d.MaDH,
		d.NgayDat,
		d.TrangThai,
		k.TenKH,
		k.DiaChi,
		k.SDT,
		k.Email,
			   	(
					SELECT 
						c.MaSP,
						s.TenSP,
						c.SoLuong,
						c.GiaMua
					FROM CTDonHang AS c inner join SanPham s on c.MaSP = s.MaSP
					WHERE c.MaDH = d.MaDH FOR JSON PATH
				) AS listjson_chitietdonhang
        FROM DonHang d inner join KhachHang k on d.MaKH = k.MaKH
      where  d.MaDH = @MaDH;
    END;
GO
EXEC sp_donhang_get_by_id 4
GO

----------------------- Create (Thanh toán)-----------------------------------
CREATE PROCEDURE sp_donhang_create
(@khachhang		NVARCHAR(MAX),  
 @listchitietdonhang	NVARCHAR(MAX)
)
AS
    BEGIN
	 IF(@khachhang IS NOT NULL)
	 Begin
	   INSERT INTO KhachHang(TenKH, DiaChi, SDT,Email)
					SELECT JSON_VALUE(@khachhang, '$.tenKH'), 
					JSON_VALUE(@khachhang, '$.diaChi'), 
					JSON_VALUE(@khachhang, '$.sdt') ,
					JSON_VALUE(@khachhang, '$.email')    
	 end;
	 IF(@listchitietdonhang IS NOT NULL)
	 Begin
	    -- Thêm bảng đơn hàng
		INSERT INTO DonHang	(NgayDat, TrangThai, MaKH)
				VALUES(GETDATE(),
						1,
						IDENT_CURRENT('KhachHang')
						);
		-- Thêm bảng chi tiết đơn hàng
        INSERT INTO CTDonHang
                (   
					SoLuong, 
                    GiaMua,
					MaDH, 
                    MaSP                                         
                )
        SELECT 
			JSON_VALUE(l.value, '$.soLuong'), 
			JSON_VALUE(l.value, '$.giaMua'),
			IDENT_CURRENT('DonHang'),		
			JSON_VALUE(l.value, '$.maSP')
			    
        FROM OPENJSON(@listchitietdonhang) AS l;
	end;
    SELECT '';
   END;
GO