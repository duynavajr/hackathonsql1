CREATE DATABASE QUANLYSINHVIEN;
USE QUANLYSINHVIEN;


CREATE TABLE dmkhoa (
    makhoa VARCHAR(20) PRIMARY KEY,
    tenkhoa VARCHAR(255)
);


CREATE TABLE dmnganh (
    manganh INT PRIMARY KEY,
    tennganh VARCHAR(255),
    makhoa VARCHAR(20),
    FOREIGN KEY (makhoa) REFERENCES dmkhoa(makhoa)
);


CREATE TABLE dmlop (
    malop VARCHAR(20) PRIMARY KEY,
    tenlop VARCHAR(255),
    manganh INT,
    khoahoc INT,
    hedt VARCHAR(255),
    namnhaphoc INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);

CREATE TABLE sinhvien (
    masv INT PRIMARY KEY,
    hoten VARCHAR(255),
    malop VARCHAR(20),
    gioitinh TINYINT(1),
    ngaysinh DATE,
    diachi VARCHAR(255),
    FOREIGN KEY (malop) REFERENCES dmlop(malop)
);


CREATE TABLE dmhocphan (
    mahp INT PRIMARY KEY,
    tenhp VARCHAR(255),
    sodvht INT,
    manganh INT,
    hocky INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);


CREATE TABLE diemhp (
    masv INT,
    mahp INT,
    diemhp FLOAT,
    foreign key(masv) references sinhvien(masv),
    FOREIGN KEY (mahp) REFERENCES dmhocphan(mahp)
);


-- THÊM DỮ LIỆU VÀO CÁC BẢNG 
insert into dmkhoa (makhoa,tenkhoa) values
 ('CNTT','CÔNG NGHỆ THÔNG TIN'),
 ('KT','KẾ TOÁN'),
 ('SP','SƯ PHẠM');
 
 -- Thêm dữ liệu vào bảng dmnganh
insert into dmnganh (manganh, tennganh, makhoa)
values
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmlop
insert into dmlop (malop, tenlop, manganh, khoahoc, hedt, namnhaphoc)
values
    ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
    ('CT12', 'cao đẳng tin học', 480202, 12, 'CĐ', 2013),
    ('CT13', 'cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng dmhocphan
insert into dmhocphan (mahp, tenhp, sodvht, manganh, hocky) values
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

-- Thêm dữ liệu vào bảng sinhvien
insert into sinhvien (masv, hoten, malop, gioitinh, ngaysinh, diachi) values
(1, 'Phan Thanh', 'CT12', 0, '1999-09-12', 'Tuy Phước'),
(2, 'Nguyên Thị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
(3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
(4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
(5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
(6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
(7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phủ Mỹ'),
(8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
(9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- Thêm dữ liệu vào bảng diemhp
insert into diemhp (masv, mahp, diemhp) values
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);

-- THỰC HIỆN CÁC CÂU TRUY VẤN 

-- 1 hiển thị danh sách gồm masv,hoten,malop,diemhp,mahp
-- của những sinh viên có điểm hp >=5
select sv.masv, sv.hoten, sv.malop, dhp.diemhp, dhp.mahp
from sinhvien sv
join diemhp dhp on sv.masv = dhp.masv
where dhp.diemhp >= 5;

-- 2 hiển thị danh sách masv,hoten,malop,mahp,diemhp,mahp
-- được sắp xếp theo ưu tiên malop,hoten tăng dần 
select sv.masv, sv.hoten, sv.malop, dhp.mahp, dhp.diemhp
from sinhvien sv
join diemhp dhp ON sv.masv = dhp.masv
order by sv.malop ASC, sv.hoten ASC;
-- 3 hiển thị danh sách gồm masv,hoten,malop,diemhp,hocky 
-- của những sinh viên có diemhp từ 5 đến 7 ở học kỳ 1

select sv.masv, sv.hoten, sv.malop, dhp.diemhp, hp.hocky
from sinhvien sv
join diemhp dhp ON sv.masv = dhp.masv
join dmhocphan hp ON dhp.mahp = hp.mahp
where dhp.diemhp BETWEEN 5 AND 7 AND hp.hocky = 1;

-- 4 hiển thị danh sách sinh viên gồm
-- masv,hoten,malop,tenlop,makhoa của khoa có mã CNTT
select sv.masv, sv.hoten, sv.malop, dl.tenlop, dk.makhoa
from sinhvien sv
join dmlop dl ON sv.malop = dl.malop
join dmnganh dn ON dl.manganh = dn.manganh
join dmkhoa dk ON dn.makhoa = dk.makhoa
where dk.makhoa = 'CNTT';

-- 5 cho biết malop,tenlop tổng số sinh viên của mỗi lớp (siso)
select sv.MaLop, TenLop,count(*)
from sinhvien sv 
join dmlop lp on sv.MaLop = lp.MaLop
group by MaLop;


-- 6. 
select HocKy, hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV
order by hp.MaSV;

-- 7.
select sv.MaLop,lop.TenLop,
case
	when sv.GioiTinh = 0 then "Nam"
	when sv.GioiTinh = 1 then "Nữ"
end 'GioiTinh',
case
	when sv.GioiTinh = 0 then count(sv.MaSV)
	when sv.GioiTinh = 1 then count(sv.MaSV)
end 'SoLuong' from sinhvien sv
join dmlop lop on sv.MaLop = lop.MaLop
group by sv.MaLop,sv.GioiTinh;

-- 8
select  hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV;

-- 9
select sv.MaSV, HoTen,count(diemHP < 5) SLuong from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by MaSV;

-- 10
select MaHP, count(diemHP)  SL_SV_Thieu from diemhp 
where diemHP < 5
group by diemhp.MaHP;

-- 11.
 select sv.MaSV,HoTen, sum(Sodvht) Tongdvht from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
 join dmhocphan dmhp on dmhp.MaHP = hp.MaHP
 where diemHP < 5
 group by sv.MaSV
 order by sv.MaSV;
                    
-- 12. 
select sv.MaLop, TenLop,count(MaSV) from dmlop lp join sinhvien sv on lp.MaLop = sv.MaLop
group by sv.MaLop
having count(MaSV) > 2;

-- 13.
select sv.MaSV, HoTen, count(diemHP) from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by sv.MaSV
having count(diemHP) >= 2;

-- 14. 
select HoTen, count(*) Soluong from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where hp.MaHP IN (1, 2, 3) 
group by sv.HoTen
having count(hp.MaHP) >= 3;









