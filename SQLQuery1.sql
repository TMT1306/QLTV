﻿CREATE DATABASE QLTV
ON( NAME = 'QLTV_data', FILENAME = 'D:\QLThuVien\QLTV.MDF')
LOG ON (NAME = 'QLTV_log', FILENAME = 'D:\QLThuVien\QLTV.LDF')

GO

USE QLTV
GO

CREATE TABLE LOAITHE(
	MaLT char(5) primary key,
	TenLT nvarchar(30) NOT NULL,
	TichDiem varchar(9)
)
go

create TABLE DOCGIA(
	MaDG CHAR(10) PRIMARY KEY,
	TenDG nvarchar(30) NOT NULL,
	NgaySinh datetime,
	GioiTinh nvarchar(4) check (GioiTinh like 'Nam' or GioiTinh like 'Nữ'),
	SDT char(10) check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
						or SDT is null),
	DiaChi nvarchar(40)
)
go
CREATE TABLE THETV(
	MaTV char(5) primary key,
	HanDung datetime,
	NgayLap datetime,
	MaDG CHAR(10) FOREIGN KEY REFERENCES DOCGIA(MaDG),
	MaLT CHAR(5) FOREIGN KEY REFERENCES LOAITHE(MaLT)
)
go
CREATE TABLE NHANVIEN(
	MaNV CHAR(10) PRIMARY KEY,
	TenNV NVARCHAR(30) NOT NULL, 
	NgaySinh datetime,
	GioiTinh varchar(4) check (GioiTinh like 'Nam' or GioiTinh like 'Nữ'),
	SDT char(10) check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
						or SDT is null),
	DiaChi NVARCHAR(40)

)
go
CREATE TABLE PHIEUMUONSACH(
	MaPMS	CHAR(5) PRIMARY KEY,
	NGAYLAP DATETIME,
	NGAYTRA DATETIME,
	MaNV CHAR(10) FOREIGN KEY REFERENCES NHANVIEN(MaNV),
	MaDG CHAR(10) FOREIGN KEY REFERENCES DOCGIA(MaDG)

)

go

CREATE TABLE NHAXUATBAN(
	MaNXB char(5) primary key,
	TenNXB NVARCHAR(30),
	SDT char(10) check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
						or SDT is null),
	DiaChi NVARCHAR(40)
)

GO

CREATE TABLE PHIEUNHAPSACH(
	MaNS CHAR(5) PRIMARY KEY,
	NGAYLAP DATETIME,
	MaNV CHAR(10) FOREIGN KEY REFERENCES NHANVIEN(MaNV),
	MaNXB CHAR(5) FOREIGN KEY REFERENCES NHAXUATBAN(MaNXB)

)

GO

CREATE TABLE DAUSACH(
	MaDS CHAR(5) PRIMARY KEY,
	TenSach NVARCHAR(50),
	SL TINYINT,
	TINHTRANG NVARCHAR(10),
	MaNXB CHAR(5) FOREIGN KEY REFERENCES NHAXUATBAN(MaNXB)
)

GO

CREATE TABLE CTPHIEUMUON(
	MaPMS char(5) FOREIGN KEY REFERENCES PHIEUMUONSACH(MaPMS),
	MaDS char(5)FOREIGN KEY REFERENCES DAUSACH(MaDS),
	PRIMARY KEY(MaPMS, MaDS),
	SL TINYINT
)

GO

CREATE TABLE PHIEUPHAT(
	MaPP CHAR(5) PRIMARY KEY,
	NgayPhat DATETIME,
	LiDo NVARCHAR(10),
	ChiPhi MONEY,
	MaNV CHAR(10) FOREIGN KEY REFERENCES NHANVIEN(MaNV),
	MaDS char(5)FOREIGN KEY REFERENCES DAUSACH(MaDS),
	MaPMS char(5) FOREIGN KEY REFERENCES PHIEUMUONSACH(MaPMS)

)

GO 
CREATE TABLE LOAICA(
	MaLC CHAR(5) primary key,
	TenLC NVARCHAR(5),
	GioLam varchar(8)
)

go
CREATE TABLE LICH(
	MaLich CHAR(5) PRIMARY KEY,
	NgayLam datetime,
	MaLC CHAR(5) FOREIGN KEY REFERENCES LOAICA(MaLC),
	MaNV CHAR(10) FOREIGN KEY REFERENCES NHANVIEN(MaNV)


)


select NV.MaNV ,NV.TenNV
from NHANVIEN NV, LICH L
WHERE NV.MaNV = L.MaNV AND L.MaLich = '10001'


insert into NHANVIEN values ('1306200207', 'Trần Văn B', '0978111111', 'Thành phố Hồ Chí Minh')

delete NHANVIEN
WHERE MaNV = '1306200207'