use master 
if exists(select* from sysdatabases where name='QuanLyDichVuNganHang')
	drop database QuanLyDichVuNganHang
go
-- Tạo cơ sở dữ liệu
create database QuanLyDichVuNganHang 
go
use QuanLyDichVuNganHang
go
-- Tạo các bảng
create table NganHang (
	manganhang char(10) not null,
	tennganhang nvarchar(50) not null,
	primary key(manganhang)
)

create table ChiNhanh (
	machinhanh char(10) not null,
	tenchinhanh nvarchar(50) not null,
	manganhang char(10) not null,
	primary key(machinhanh),
	constraint ChiNhanh_fk_manganhang foreign key(manganhang) references NganHang(manganhang)
)

create table ATM (
	maATM char(10) not null,
	tinhtranghd nvarchar(20) not null,
	tinh nvarchar(20) not null,
	huyen nvarchar(20) not null,
	machinhanh char(10) not null,
	primary key(maATM),
	constraint ATM_fk_machinhanh foreign key(machinhanh) references ChiNhanh(machinhanh)
)

create table KhachHang (
	cccd char(12) not null,
	ho nvarchar(20) not null,
	ten nvarchar(20) not null,
	diachi nvarchar(50) not null,
	sdt char(12) not null,
	primary key(cccd)
)

create table TaiKhoan (
	mataikhoan char(10) not null,
	tentaikhoan nvarchar(50) not null,
	manganhang char(10) not null,
	cccd char(12) not null,
	primary key(mataikhoan),
	constraint TaiKhoan_fk_manganhang foreign key(manganhang) references NganHang(manganhang),
	constraint TaiKhoan_fk_cccd foreign key(cccd) references KhachHang(cccd)
)

create table tkkhongtralai (
	mataikhoan char(10) not null,
	sodu int not null check(sodu >= 0),
	ngaymo date,
	primary key(mataikhoan),
	constraint tkkhongtralai_fk_mataikhoan foreign key(mataikhoan) references TaiKhoan(mataikhoan)
)

create table tktietkiem (
	mataikhoan char(10) not null,
	sodu int not null check(sodu >= 0),
	ngaymo date,
	laisuat float not null check (laisuat > 0),
	primary key(mataikhoan),
	constraint tktietkiem_fk_mataikhoan foreign key(mataikhoan) references TaiKhoan(mataikhoan)
)

create table tkchovay (
	mataikhoan char(10) not null,
	ngayvay date,
	khoanvay int not null check (khoanvay >= 0),
	laisuat int,
	primary key(mataikhoan),
	constraint tkchovay_fk_mataikhoan foreign key(mataikhoan) references TaiKhoan(mataikhoan)
)

create table giadinh (
	cccd char(12) not null,
	soluongtv int not null check (soluongtv >= 1),
	tinhtranghonnhan nvarchar(20) not null check (tinhtranghonnhan in (N'Đã kết hôn', N'Độc thân')),
	primary key(cccd),
	constraint giadinh_fk_ccd foreign key(cccd) references KhachHang(cccd)
)

-- Thêm dữ liệu
--- Bảng Ngân Hàng
insert into NganHang values('NH001', N'VietComBank')
insert into NganHang values('NH002', N'Aribank')
insert into NganHang values('NH003', N'VietTinBank')
insert into NganHang values('NH004', N'TP')
insert into NganHang values('NH005', N'ACB')

--- Bảng Chi Nhánh
insert into ChiNhanh values('CN001', N'Nam Sài Gòn', 'NH001')
insert into ChiNhanh values('CN002', N'Bến Tre', 'NH002')
insert into ChiNhanh values('CN003', N'Bình Dương', 'NH003')
insert into ChiNhanh values('CN004', N'Thủ Đức', 'NH004')
insert into ChiNhanh values('CN005', N'Long An', 'NH005')
insert into ChiNhanh values('CN006', N'Thủ Đức', 'NH001')
insert into ChiNhanh values('CN007', N'Thủ Dầu Một', 'NH002')
insert into ChiNhanh values('CN008', N'Bình Phước', 'NH003')
insert into ChiNhanh values('CN009', N'Cần Thơ', 'NH004')
insert into ChiNhanh values('CN0010', N'Cà Mau', 'NH005')

--- Bảng ATM
insert into ATM values('ATM001', N'Bình thường', N'Bình Dương', N'Bến Cát', 'CN003')
insert into ATM values('ATM002', N'Bình thường', N'Bình Dương', N'Dĩ An', 'CN003')
insert into ATM values('ATM003', N'Bình thường', N'Bình Dương', N'Thuận An', 'CN003')
insert into ATM values('ATM004', N'Bình thường', N'Bình Phước', N'Hớn Quản', 'CN008')
insert into ATM values('ATM005', N'Bình thường', N'Bình Phước', N'Lộc Ninh', 'CN008')
insert into ATM values('ATM006', N'Bình thường', N'Bến Tre', N'Châu Thành', 'CN002')
insert into ATM values('ATM007', N'Bình thường', N'Long An', N'Bến Lức', 'CN005')
insert into ATM values('ATM008', N'Bình thường', N'Cần Thơ', N'Cờ Đỏ', 'CN003')
insert into ATM values('ATM009', N'Bình thường', N'Cà Mau', N'Phú Tân', 'CN003')

--- Bảng Khách Hàng
insert into KhachHang values('070303000412', N'Lê Thị Phi', N'Du', N'Bến Tre 001', '0918477203')
insert into KhachHang values('070303000782', N'Lê Thị Bích', N'Ngọc', N'Long An 001', '0987213775')
insert into KhachHang values('070303000991', N'Nguyễn Cẩm', N'Tú', N'Bình Phước 001', '0872146973')
insert into KhachHang values('070303000223', N'Châu Thị Tuyết', N'Mai', N'Bến Tre 001', '0333098142')
insert into KhachHang values('070303000410', N'Huỳnh Đức', N'Hòa', N'Bình Phước 002', '0743114873')
insert into KhachHang values('070303000001', N'Bùi Đại Phú', N'Quí', N'Cà Mau 001', '0983112203')

--- Bảng Tài Khoản
insert into TaiKhoan values('TK001', N'lê Thị Phi Du', 'NH001', '070303000412')
insert into TaiKhoan values('TK002', N'lê Thị Bích Ngọc', 'NH003', '070303000782')
insert into TaiKhoan values('TK003', N'Nguyễn Cẩm Tú', 'NH001', '070303000991')
insert into TaiKhoan values('TK004', N'Châu Thị Tuyết Mai', 'NH002', '070303000223')
insert into TaiKhoan values('TK005', N'Huỳnh Đức Hòa', 'NH005', '070303000410')
insert into TaiKhoan values('TK006', N'Bùi Đại Phú Quí', 'NH004', '070303000001')

--- Bảng Tài Khoản Không Trả Lãi
insert into tkkhongtralai values('TK001', 50000000, '1/1/2018')
insert into tkkhongtralai values('TK002', 1000000, '5/3/2018')

--- Bảng Tài Khoản Tiết Kiệm
insert into tktietkiem values('TK003', 25000000, '9/5/2014', 0.01)
insert into tktietkiem values('TK004', 10000000, '12/5/2016', 0.01)

--- Bảng Tải Khoản Cho Vay
insert into tkchovay values('TK005', '11/4/2014', 5000000, 0.025)
insert into tkchovay values('TK006', '9/7/2012', 70000000, 0.025)

--- Bảng Gia Đình
insert into giadinh values('070303000412', 3, N'Độc thân')
insert into giadinh values('070303000782', 4, N'Độc thân')
insert into giadinh values('070303000991', 5, N'Độc thân')
insert into giadinh values('070303000223', 3, N'Đã kết hôn')
insert into giadinh values('070303000410', 5, N'Độc thân')
insert into giadinh values('070303000001', 3, N'Đã kết hôn')


-- Tạo mã tự động
--- Mã tự động cho bảng TaiKhoan
CREATE FUNCTION AUTO_MaTK_TaiKhoan()
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @ID CHAR(10)
	DECLARE @a CHAR(10)
	IF (SELECT COUNT(mataikhoan) FROM TaiKhoan) = 0
		SET @ID = '0'
	ELSE
		SELECT top 1 @ID = mataikhoan FROM TaiKhoan order by mataikhoan desc
		set @a = SUBSTRING(@ID, 4, len(@ID))
		if 
			@a >= 0 and @a < 9 SET @ID = 'TK00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
		else 
			set @ID = 'TK00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
	RETURN @ID
END		
go
create procedure add_TK  @mataikhoan char(10), 
						 @tentaikhoan nvarchar(50), 
						 @manganhang char(10),
						 @cccd char(12)
as 
begin
	insert into TaiKhoan
	values (dbo.AUTO_MaTK_TaiKhoan(), @mataikhoan, @tentaikhoan, @manganhang, @cccd)
end

--- Mã tự động cho bảng NganHang
CREATE FUNCTION AUTO_MaNH_NganHang()
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @ID CHAR(10)
	DECLARE @a CHAR(10)
	IF (SELECT COUNT(manganhang) FROM NganHang) = 0
		SET @ID = '0'
	ELSE
		SELECT top 1 @ID = manganhang FROM NganHang order by manganhang desc
		set @a = SUBSTRING(@ID, 4, len(@ID))
		if 
			@a >= 0 and @a < 9 SET @ID = 'NH00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
		else 
			set @ID = 'NH00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
	RETURN @ID
END		
go
create procedure add_NH  @manganhang char(10), 
						 @tennganhang nvarchar(50)
as 
begin
	insert into TaiKhoan
	values (dbo.AUTO_MaTK_TaiKhoan(), @manganhang, @tennganhang)
end

--- Mã tự động cho bảng ChiNhanh
CREATE FUNCTION AUTO_MaCN_ChiNhanh()
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @ID CHAR(10)
	DECLARE @a CHAR(10)
	IF (SELECT COUNT(machinhanh) FROM ChiNhanh) = 0
		SET @ID = '0'
	ELSE
		SELECT top 1 @ID = machinhanh FROM ChiNhanh order by machinhanh desc
		set @a = SUBSTRING(@ID, 4, len(@ID))
		if 
			@a >= 0 and @a < 9 SET @ID = 'CN00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
		else 
			set @ID = 'CN00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
	RETURN @ID
END		
go
create procedure add_CN  @machinhanh char(10), 
						 @tenchinhanh nvarchar(50),
						 @manganhang char(10)
as 
begin
	insert into TaiKhoan
	values (dbo.AUTO_MaCN_ChiNhanh(), @machinhanh, @tenchinhanh, @manganhang)
end

--- Mã tự động cho bảng ATM
CREATE FUNCTION AUTO_MaATM_ATM()
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @ID CHAR(10)
	DECLARE @a CHAR(10)
	IF (SELECT COUNT(maATM) FROM ATM) = 0
		SET @ID = '0'
	ELSE
		SELECT top 1 @ID = maATM FROM ATM order by maATM desc
		set @a = SUBSTRING(@ID, 5, len(@ID))
		if 
			@a >= 0 and @a < 9 SET @ID = 'ATM00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
		else 
			set @ID = 'ATM00' + CONVERT(CHAR, CONVERT(INT, @a) + 1)
	RETURN @ID
END		
go
create procedure add_ATM  @maATM char(10), 
						  @tinhtranhd nvarchar(50),
						  @tinh nvarchar(20),
						  @huyen nvarchar(20),
						  @machinhanh char(10)
as 
begin
	insert into TaiKhoan
	values (dbo.AUTO_MaATM_ATM(), @maATM, @tinhtranhd, @tinh, @huyen, @machinhanh)
end

-- Tạo trigger
--- Trigger cho tkkhongtralai
CREATE TRIGGER khoangoai_tkktl ON tkkhongtralai instead of INSERT
AS
IF EXISTS(SELECT inserted.mataikhoan FROM TaiKhoan INNER JOIN inserted ON TaiKhoan.mataikhoan = inserted.mataikhoan WHERE inserted.sodu < 0)
	begin
		print (N'Số dư ra không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.mataikhoan from inserted where inserted.mataikhoan not in (select mataikhoan from TaiKhoan))
	begin
		print (N'Mã tài khoản không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.ngaymo from inserted where inserted.ngaymo >  getdate())
	begin
		print (N'Ngày mở không hợp lệ')
		rollback Tran
	end

--- Trigger cho tktietkiem
CREATE TRIGGER khoangoai_tktk ON tktietkiem instead of INSERT
AS
IF EXISTS(SELECT inserted.mataikhoan FROM TaiKhoan INNER JOIN inserted ON TaiKhoan.mataikhoan = inserted.mataikhoan WHERE inserted.sodu < 0)
	begin
		print (N'Số dư ra không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.mataikhoan from inserted where inserted.mataikhoan not in (select mataikhoan from TaiKhoan))
	begin
		print (N'Mã tài khoản không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.ngaymo from inserted where inserted.ngaymo >  getdate())
	begin
		print (N'Ngày mở không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.laisuat from inserted where inserted.laisuat < 0)
	begin
		print (N'Lãi suất ra không hợp lệ')
		rollback Tran
	end

--- Trigger cho tkchovay
CREATE TRIGGER khoangoai_tkchovay ON tkchovay instead of INSERT
AS
IF EXISTS(SELECT inserted.mataikhoan FROM TaiKhoan INNER JOIN inserted ON TaiKhoan.mataikhoan = inserted.mataikhoan WHERE inserted.khoanvay < 0)
	begin
		print (N'Khoảng vay ra không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.mataikhoan from inserted where inserted.mataikhoan not in (select mataikhoan from TaiKhoan))
	begin
		print (N'Mã tài khoản không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.ngayvay from inserted where inserted.ngayvay >  getdate())
	begin
		print (N'Ngày vay không hợp lệ')
		rollback Tran
	end
else if exists(select inserted.laisuat from inserted where inserted.laisuat < 0)
	begin
		print (N'Lãi suất ra không hợp lệ')
		rollback Tran
	end