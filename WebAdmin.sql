USE WebBanDongHoCasio
GO
-----------------------------------TRANG QUẢN TRỊ------------------------------------------
-------------------------------------------------------------------------------------------
----------------------Sản phẩm(getAll, getbyID, THÊM, SỬA, XÓA)----------------------------
CREATE PROCEDURE sp_sanpham_get_all_admin(@page_index int, 
									      @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY s.MaSP DESC)) AS RowNumber, 
                               s.MaSP, s.TenSP, s.AnhDaiDien, s.MoTa, s.NgayTao, s.MaDSP, d.TenDSP, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam 
                        INTO #Results1
                        FROM SanPham s	INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
										LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
										LEFT JOIN GiamGia gg ON s.MaSP = gg.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY s.MaSP DESC)) AS RowNumber, 
                                s.MaSP, s.TenSP, s.AnhDaiDien, s.MoTa, s.NgayTao, s.MaDSP, d.TenDSP, gsp.GiaBan, IIF(gg.PhanTram is null, 0, gg.PhanTram) AS PhanTram, IIF(gg.PhanTram is null, gsp.GiaBan, gsp.GiaBan * (100 - gg.PhanTram) / 100) AS GiaSauKhiGiam 
                        INTO #Results2
                        FROM SanPham s	INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
										LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
										LEFT JOIN GiamGia gg ON s.MaSP = gg.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;  
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-------------------------------------------------------
CREATE PROCEDURE sp_sanpham_get_by_id_admin(@MaSP int)
AS
    BEGIN
        SELECT  s.MaSP, s.TenSP, s.AnhDaiDien, s.MoTa, s.NgayTao, s.MaDSP, d.TenDSP,
		(
			SELECT cta.* FROM CTAnhSanPham cta
			WHERE cta.MaSP = s.MaSP FOR JSON PATH
		) AS listjson_chitietanhsanpham,
		(
			SELECT ts.* FROM ThongSoKyThuat ts
			WHERE ts.MaSP = s.MaSP FOR JSON PATH
		) AS listjson_thongsokythuat

		FROM SanPham s	INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP

		WHERE  s.MaSP = @MaSP 
    END;
GO
EXEC sp_sanpham_get_by_id_admin 7;
GO
--------------------------------------
CREATE PROCEDURE sp_sanpham_create
(@TenSP	nvarchar(50),
 @AnhDaiDien	varchar(max),
 @MoTa	nvarchar(max),
 @NgayTao	datetime,
 @MaDSP	int,
 @listthongsokythuat nvarchar(max)
)
AS
    BEGIN
		INSERT INTO SanPham
                (TenSP,
				 AnhDaiDien,
				 MoTa,
				 NgayTao,
				 MaDSP
                )
                VALUES
                (@TenSP,
				 @AnhDaiDien,
				 @MoTa,
				 GETDATE(),
				 @MaDSP
                );

		IF(@listthongsokythuat IS NOT NULL)---Không nhập chi tiết thì không thêm, còn có nhập thì thực hiện IF
		BEGIN
			INSERT INTO ThongSoKyThuat(TenTS, MoTa, MaSP)
			SELECT 		
				JSON_VALUE(t.value, '$.tenTS'),
				JSON_VALUE(t.value, '$.moTa'), 
				IDENT_CURRENT('SanPham')
			FROM OPENJSON(@listthongsokythuat) AS t;
		END;

        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_sanpham_update
(
 @MaSP	int, 
 @TenSP	nvarchar(50),
 @AnhDaiDien	varchar(max),
 @MoTa	nvarchar(max),
 @NgayTao	datetime,
 @MaDSP	int,
 @listthongsokythuat nvarchar(max)
)
AS
    BEGIN
		Update  SanPham
		set  
			TenSP = IIF(@TenSP is null, TenSP, @TenSP),
			AnhDaiDien = IIF(@AnhDaiDien is null, AnhDaiDien, @AnhDaiDien),
			MoTa = IIF(@MoTa is null, MoTa, @MoTa),
			NgayTao = IIF(@NgayTao is null, NgayTao, @NgayTao),
			MaDSP = IIF(@MaDSP is null, MaDSP, @MaDSP)
		Where MaSP = @MaSP
    
		---------------------------------------------------
		IF(@listthongsokythuat IS NOT NULL)
		BEGIN
			Delete from ThongSoKyThuat WHERE MaSP = @MaSP; --xóa đi chi tiết cũ và add chi tiết mới vào

			INSERT INTO ThongSoKyThuat(TenTS, MoTa, MaSP)
			SELECT 		
				JSON_VALUE(t.value, '$.tenTS'),
				JSON_VALUE(t.value, '$.moTa'), 
				@MaSP
			FROM OPENJSON(@listthongsokythuat) AS t;
		END;
      
	  SELECT '';
    END;
GO
-------------------------------------------
CREATE PROCEDURE sp_sanpham_delete(@MaSP int)
AS
	BEGIN
		Delete CTAnhSanPham WHERE MaSP = @MaSP
		Delete ThongSoKyThuat WHERE MaSP = @MaSP
		Delete SanPham WHERE MaSP = @MaSP
	END;
GO

------------------------------------------------------------------------------------
-----------------CT Ảnh SP(getAll, getbyID, THÊM, SỬA, XÓA)------------------
CREATE PROCEDURE sp_ctanhsanpham_get_all_admin(@page_index int, 
												@page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaCTASP DESC)) AS RowNumber, 
                               MaCTASP, cta.Anh, cta.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results1
                        FROM CTAnhSanPham cta INNER JOIN SanPham s ON cta.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaCTASP DESC)) AS RowNumber, 
                               MaCTASP, cta.Anh, cta.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results2
                        FROM CTAnhSanPham cta INNER JOIN SanPham s ON cta.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;  
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-----------------------------------------------
CREATE PROCEDURE sp_ctanhsanpham_get_by_id_admin(@MaCTASP int)
AS
    BEGIN
        SELECT * FROM CTAnhSanPham
		WHERE  MaCTASP = @MaCTASP
    END;
GO
EXEC sp_ctanhsanpham_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_ctanhsanpham_create
(@Anh	varchar(max),
 @MaSP	int
)
AS
    BEGIN
      INSERT INTO CTAnhSanPham
                (Anh,
				 MaSP
                )
                VALUES
                (@Anh,
				 @MaSP
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_ctanhsanpham_update
(
 @MaCTASP	int, 
 @Anh	varchar(max),
 @MaSP	int
)
AS
    BEGIN
		Update  CTAnhSanPham
		set  
			Anh = IIF(@Anh is null, Anh, @Anh),
			MaSP = IIF(@MaSP is null, MaSP, @MaSP)
		Where MaCTASP = @MaCTASP
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_ctanhsanpham_delete(@MaCTASP int)
AS
	BEGIN
		Delete CTAnhSanPham
		WHERE MaCTASP = @MaCTASP
	END;
GO

-----------------------------------------------------------------------------------
-----------------------Menu(getAll, getbyID, THÊM, SỬA, XÓA)-----------------------
CREATE PROCEDURE sp_menu_get_all_admin(@page_index int, 
									   @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaMenu DESC)) AS RowNumber, 
                               MaMenu, TenMenu, STT, Link, TrangThai
                        INTO #Results1
                        FROM Menu
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaMenu DESC)) AS RowNumber, 
                               MaMenu, TenMenu, STT, Link, TrangThai
                        INTO #Results2
                        FROM Menu 
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;  
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-----------------------------------------------
CREATE PROCEDURE sp_menu_get_by_id_admin(@MaMenu int)
AS
    BEGIN
        SELECT * FROM Menu
		WHERE  MaMenu = @MaMenu
    END;
GO
EXEC sp_menu_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_menu_create
(@TenMenu	nvarchar(200),
 @STT int,
 @Link	varchar(max),
 @TrangThai bit
)
AS
    BEGIN
      INSERT INTO Menu
                (TenMenu,
				 STT,
				 Link,
				 TrangThai
                )
                VALUES
                (@TenMenu,
				 @STT,
				 @Link,
				 @TrangThai
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_menu_update
(
 @MaMenu	int, 
 @TenMenu	nvarchar(200),
 @STT int,
 @Link	varchar(max),
 @TrangThai bit
)
AS
    BEGIN
		Update  Menu
		set  
			TenMenu = IIF(@TenMenu is null, TenMenu, @TenMenu),
			STT = IIF(@STT is null, STT, @STT),
			Link = IIF(@Link is null, Link, @Link),
			TrangThai = IIF(@TrangThai is null, TrangThai, @TrangThai)
		Where MaMenu= @MaMenu
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_menu_delete(@MaMenu int)
AS
	BEGIN
		Delete Menu
		WHERE MaMenu = @MaMenu
	END;
GO
------------------------------------------------------------------------------------
-----------------Slide(getAll, getbyID, THÊM, SỬA, XÓA)------------------
CREATE PROCEDURE sp_slide_get_all_admin(@page_index int, 
										@page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaSlide DESC)) AS RowNumber, 
                               MaSlide, Anh, Link
                        INTO #Results1
                        FROM Slide
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaSlide DESC)) AS RowNumber, 
                               MaSlide, Anh, Link
                        INTO #Results2
                        FROM Slide
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;  
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-----------------------------------------------
CREATE PROCEDURE sp_slide_get_by_id_admin(@MaSlide int)
AS
    BEGIN
        SELECT * FROM Slide
		WHERE  MaSlide = @MaSlide
    END;
GO
EXEC sp_slide_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_slide_create
(@Anh	varchar(max),
 @Link	varchar(max)
)
AS
    BEGIN
      INSERT INTO Slide
                (Anh,
				 Link
                )
                VALUES
                (@Anh,
				 @Link
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_slide_update
(
 @MaSlide	int, 
 @Anh	varchar(max),
 @Link	varchar(max)
)
AS
    BEGIN
		Update  Slide
		set  
			Anh = IIF(@Anh is null, Anh, @Anh),
			Link = IIF(@Link is null, Link, @Link)
		Where MaSlide = @MaSlide
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_slide_delete(@MaSlide int)
AS
	BEGIN
		Delete Slide
		WHERE MaSlide = @MaSlide
	END;
GO
--------------------------------------------------------------------------------------
-----------------------GIỚI THIỆU(getAll, getbyID, THÊM, SỬA, XÓA)----------------------------
CREATE PROCEDURE sp_gioithieu_get_all_admin(@page_index int, 
											@page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGT DESC)) AS RowNumber, 
                               MaGT, TieuDe, Anh, MoTa
                        INTO #Results1
                        FROM GioiThieu 
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGT DESC)) AS RowNumber, 
                               MaGT, TieuDe, Anh, MoTa
                        INTO #Results2
                        FROM GioiThieu 
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
---------------------------------------------------
CREATE PROCEDURE sp_gioithieu_get_by_id_admin(@MaGT int)
AS
    BEGIN
        SELECT * FROM GioiThieu 
		WHERE  MaGT = @MaGT
    END;
GO
EXEC sp_gioithieu_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_gioithieu_create
(@TieuDe	nvarchar(200),
 @Anh	varchar(max),
 @MoTa	nvarchar(max) 
)
AS
    BEGIN
      INSERT INTO GioiThieu
                (TieuDe,
				 Anh,
				 MoTa
                )
                VALUES
                (@TieuDe,
				 @Anh,
				 @MoTa
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_gioithieu_update
(
 @MaGT	int, 
 @TieuDe	nvarchar(200),
 @Anh	varchar(max),
 @MoTa	nvarchar(max) 
)
AS
    BEGIN
		Update  GioiThieu
		set  
			TieuDe = IIF(@TieuDe is null, TieuDe, @TieuDe),
			Anh = IIF(@Anh is null, Anh, @Anh),
			MoTa = IIF(@MoTa is Null, MoTa, @MoTa)
		Where MaGT = @MaGT
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_gioithieu_delete(@MaGT int)
AS
	BEGIN
		Delete GioiThieu
		WHERE MaGT = @MaGT
	END;
GO
--------------------------------------------------------------------------------------
-----------------------LIÊN HỆ(getAll, getbyID, THÊM, SỬA, XÓA)-------------------------------
CREATE PROCEDURE sp_lienhe_get_all_admin(@page_index int, 
										 @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaLH DESC)) AS RowNumber, 
                               MaLH, TieuDe, TieuMuc, Anh, MoTa
                        INTO #Results1
                        FROM LienHe
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaLH DESC)) AS RowNumber, 
                               MaLH, TieuDe, TieuMuc, Anh, MoTa
                        INTO #Results2
                        FROM LienHe
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
----------------------------------------------------------------
CREATE PROCEDURE sp_lienhe_get_by_id_admin(@MaLH int)
AS
    BEGIN
        SELECT * FROM LienHe 
		WHERE  MaLH = @MaLH
    END;
GO
EXEC sp_lienhe_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_lienhe_create
(@TieuDe	nvarchar(max),
 @TieuMuc	nvarchar(max),
 @Anh	varchar(max),
 @MoTa	nvarchar(max) 
)
AS
    BEGIN
      INSERT INTO LienHe
                (TieuDe,
				 TieuMuc,
				 Anh,
				 MoTa
                )
                VALUES
                (@TieuDe,
				 @TieuMuc,
				 @Anh,
				 @MoTa
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_lienhe_update
(
 @MaLH	int, 
 @TieuDe	nvarchar(max),
 @TieuMuc	nvarchar(max),
 @Anh	varchar(max),
 @MoTa	nvarchar(max) 
)
AS
    BEGIN
		Update  LienHe
		set  
			TieuDe = IIF(@TieuDe is null, TieuDe, @TieuDe),
			TieuMuc = IIF(@TieuMuc is null, TieuMuc, @TieuMuc),
			Anh = IIF(@Anh is null, Anh, @Anh),
			MoTa = IIF(@MoTa is Null, MoTa, @MoTa)
		Where MaLH = @MaLH
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_lienhe_delete(@MaLH int)
AS
	BEGIN
		Delete LienHe
		WHERE MaLH = @MaLH
	END;
GO
--------------------------------------------------------------------------------------
-----------------------Nhà cung cấp(getAll, getbyID, THÊM, SỬA, XÓA)------------------
CREATE PROCEDURE sp_nhacungcap_get_all_admin(@page_index int, 
											 @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaNCC DESC)) AS RowNumber, 
                               MaNCC, TenNCC, DiaChi, SDT
                        INTO #Results1
                        FROM NhaCungCap
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaNCC DESC)) AS RowNumber, 
                               MaNCC, TenNCC, DiaChi, SDT
                        INTO #Results2
                        FROM NhaCungCap
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-----------------------------------------------------
CREATE PROCEDURE sp_nhacungcap_get_by_id_admin(@MaNCC int)
AS
    BEGIN
        SELECT * FROM NhaCungCap
		WHERE  MaNCC = @MaNCC
    END;
GO
EXEC sp_nhacungcap_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_nhacungcap_create
(@TenNCC	nvarchar(50),
 @DiaChi	nvarchar(200),
 @SDT	varchar(10)
)
AS
    BEGIN
      INSERT INTO NhaCungCap
                (TenNCC,
				 DiaChi,
				 SDT
                )
                VALUES
                (@TenNCC,
				 @DiaChi,
				 @SDT
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_nhacungcap_update
(
 @MaNCC	int, 
 @TenNCC	nvarchar(50),
 @DiaChi	nvarchar(200),
 @SDT	varchar(10)
)
AS
    BEGIN
		Update  NhaCungCap
		set  
			TenNCC = IIF(@TenNCC is null, TenNCC, @TenNCC),
			DiaChi = IIF(@DiaChi is null, DiaChi, @DiaChi),
			SDT = IIF(@SDT is null, SDT, @SDT)
		Where MaNCC = @MaNCC
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_nhacungcap_delete(@MaNCC int)
AS
	BEGIN
		Delete NhaCungCap
		WHERE MaNCC = @MaNCC
	END;
GO
--------------------------------------------------------------------------------------
---------------------DÒNG SẢN PHẨM(getAll,THÊM, SỬA, XÓA)-----------------------------
CREATE PROCEDURE sp_dongsanpham_get_all_admin(@page_index int, 
											  @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaDSP DESC)) AS RowNumber, 
                               d.*, TenMenu
                        INTO #Results1
                        FROM DongSanPham d INNER JOIN Menu m ON d.MaMenu = m.MaMenu
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaDSP DESC)) AS RowNumber, 
                               d.*, TenMenu
                        INTO #Results2
                        FROM DongSanPham d INNER JOIN Menu m ON d.MaMenu = m.MaMenu
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
--------------------------------------------------------
CREATE PROCEDURE sp_dongsanpham_get_by_id_admin(@MaDSP int)
AS
    BEGIN
        SELECT d.*, m.TenMenu
		FROM DongSanPham d INNER JOIN Menu m ON d.MaMenu = m.MaMenu
		WHERE @MaDSP = MaDSP
    END;
GO
EXEC sp_dongsanpham_get_by_id_admin 1;
GO
-------------------------------------------
CREATE PROCEDURE sp_dongsanpham_create
(@TenDSP	nvarchar(200),
 @AnhDaiDien	varchar(max),
 @AnhChiTiet	varchar(max),
 @MoTa	nvarchar(max),
 @MaMenu int
)
AS
    BEGIN
      INSERT INTO DongSanPham
                (TenDSP,
				 AnhDaiDien,
				 MoTa,
				 MaMenu
                )
                VALUES
                (@TenDSP,
				 @AnhDaiDien,
				 @MoTa,
				 @MaMenu
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_dongsanpham_update
(
 @MaDSP	int, 
 @TenDSP	nvarchar(200),
 @AnhDaiDien	varchar(max),
 @MoTa	nvarchar(max),
 @MaMenu int
)
AS
    BEGIN
		Update  DongSanPham
		set  
			TenDSP = IIF(@TenDSP is null, TenDSP, @TenDSP),
			AnhDaiDien = IIF(@AnhDaiDien is null, AnhDaiDien, @AnhDaiDien),
			MoTa = IIF(@MoTa is Null, MoTa, @MoTa),
			MaMenu = IIF(@MaMenu is Null, MaMenu, @MaMenu)
		Where MaDSP = @MaDSP
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_dongsanpham_delete(@MaDSP int)
AS
	BEGIN
		Delete CTAnhDongSanPham WHERE MaDSP = @MaDSP
		Delete DongSanPham WHERE MaDSP = @MaDSP
	END;
GO
--------------------------------------------------------------------------------------
-----------------------Giảm giá(getAll, getbyID, THÊM, SỬA, XÓA)----------------------
CREATE PROCEDURE sp_giamgia_get_all_admin(@page_index int, 
										  @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGG DESC)) AS RowNumber, 
                               gg.MaGG, gg.PhanTram, gg.ThoiGianBD, gg.ThoiGianKT, gg.TrangThai, gg.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results1
                        FROM GiamGia gg INNER JOIN SanPham s ON gg.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGG DESC)) AS RowNumber, 
                                gg.MaGG, gg.PhanTram, gg.ThoiGianBD, gg.ThoiGianKT, gg.TrangThai, gg.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results2
                        FROM GiamGia gg INNER JOIN SanPham s ON gg.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
-----------------------------------------------------
CREATE PROCEDURE sp_giamgia_get_by_id_admin(@MaGG int)
AS
    BEGIN
        SELECT * FROM GiamGia
		WHERE  MaGG = @MaGG
    END;
GO
EXEC sp_giamgia_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_giamgia_create
(@PhanTram	float,
 @ThoiGianBD	datetime,
 @ThoiGianKT	datetime,
 @TrangThai		bit,
 @MaSP	int
)
AS
    BEGIN
      INSERT INTO GiamGia
                (PhanTram,
				 ThoiGianBD,
				 ThoiGianKT,
				 TrangThai,
				 MaSP
                )
                VALUES
                (@PhanTram,
				 @ThoiGianBD,
				 @ThoiGianKT,
				 @TrangThai,
				 @MaSP
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_giamgia_update
(
 @MaGG	int, 
 @PhanTram	float,
 @ThoiGianBD	datetime,
 @ThoiGianKT	datetime,
 @TrangThai		bit,
 @MaSP	int
)
AS
    BEGIN
		Update  GiamGia
		set  
			PhanTram = IIF(@PhanTram is null, PhanTram, @PhanTram),
			ThoiGianBD = IIF(@ThoiGianBD is null, ThoiGianBD, @ThoiGianBD),
			ThoiGianKT = IIF(@ThoiGianKT is null, ThoiGianKT, @ThoiGianKT),
			TrangThai = IIF(@TrangThai is null, TrangThai , @TrangThai ),
			MaSP = IIF(@MaSP is null, MaSP, @MaSP)
		Where MaGG = @MaGG
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_giamgia_delete(@MaGG int)
AS
	BEGIN
		Delete GiamGia
		WHERE MaGG = @MaGG
	END;
GO
--------------------------------------------------------------------------------------
-------------------Giá sản phẩm(getAll, getbyID, THÊM, SỬA, XÓA)------------------------------
CREATE PROCEDURE sp_giasanpham_get_all_admin(@page_index int, 
											 @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGSP DESC)) AS RowNumber, 
                               g.MaGSP, g.NgayBD, g.NgayKT, g.GiaBan, g.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results1
                        FROM GiaSanPham g INNER JOIN SanPham s ON g.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaGSP DESC)) AS RowNumber, 
                               g.MaGSP, g.NgayBD, g.NgayKT, g.GiaBan, g.MaSP, s.TenSP, s.AnhDaiDien
                        INTO #Results2
                        FROM GiaSanPham g INNER JOIN SanPham s ON g.MaSP = s.MaSP
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
----------------------------------------------------------
CREATE PROCEDURE sp_giasanpham_get_by_id_admin(@MaGSP int)
AS
    BEGIN
        SELECT * FROM GiaSanPham
		WHERE  MaGSP = @MaGSP
    END;
GO
EXEC sp_giasanpham_get_by_id_admin 1;
GO
--------------------------------------
CREATE PROCEDURE sp_giasanpham_create
(@NgayBD	datetime,
 @NgayKT	datetime,
 @GiaBan	int,
 @MaSP	int
)
AS
    BEGIN
      INSERT INTO GiaSanPham
                (NgayBD,
				 NgayKT,
				 GiaBan,
				 MaSP
                )
                VALUES
                (@NgayBD,
				 @NgayKT,
				 @GiaBan,
				 @MaSP
                );
        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_giasanpham_update
(
 @MaGSP	int, 
 @NgayBD	datetime,
 @NgayKT	datetime,
 @GiaBan	int,
 @MaSP	int
)
AS
    BEGIN
		Update  GiaSanPham
		set  
			NgayBD = IIF(@NgayBD is null, NgayBD, @NgayBD),
			NgayKT = IIF(@NgayKT is null, NgayKT, @NgayKT),
			GiaBan = IIF(@GiaBan is null, GiaBan, @GiaBan),
			MaSP = IIF(@MaSP is null, MaSP, @MaSP)
		Where MaGSP = @MaGSP
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_giasanpham_delete(@MaGSP int)
AS
	BEGIN
		Delete GiaSanPham
		WHERE MaGSP = @MaGSP
	END;
GO
--------------------------------------------------------------------------------------
----------------------Tin tức(getAll, getbyID,THÊM, SỬA, XÓA)-------------------------
CREATE PROCEDURE sp_tintuc_get_all_admin(@page_index int, 
										 @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaTT DESC)) AS RowNumber, 
                               t.*, n.HoTen
                        INTO #Results1
                        FROM TinTuc t INNER JOIN NguoiDung n ON t.MaND = n.MaND
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaTT DESC)) AS RowNumber, 
                               t.*, n.HoTen
                        INTO #Results2
                        FROM TinTuc t INNER JOIN NguoiDung n ON t.MaND = n.MaND
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
---------------------------------------------------------
CREATE PROCEDURE sp_tintuc_get_by_id_admin(@MaTT int)
AS
    BEGIN
        SELECT t.MaTT, t.AnhDaiDien, t.TieuDe, t.MoTa, t.NgayDang, t.MaND, n.HoTen,
		(
			SELECT c.* FROM CTTinTuc c
			WHERE c.MaTT = t.MaTT FOR JSON PATH
		) AS listjson_chitiettintuc

		FROM TinTuc t INNER JOIN NguoiDung n ON t.MaND = n.MaND
		WHERE  t.MaTT = @MaTT
		GROUP BY t.MaTT, t.AnhDaiDien, t.TieuDe, t.MoTa, t.NgayDang, t.MaND, n.HoTen
    END;
GO
EXEC sp_tintuc_get_by_id_admin 1;
GO

--------------------------------------
CREATE PROCEDURE sp_tintuc_create
(@AnhDaiDien	varchar(max),
 @TieuDe	nvarchar(max),
 @MoTa	nvarchar(max),
 @NgayDang	datetime,
 @MaND	int,
 @listchitiettintuc varchar(max)
)
AS
    BEGIN
		INSERT INTO TinTuc
                (AnhDaiDien,
				 TieuDe,
				 MoTa,
				 NgayDang,
				 MaND
                )
                VALUES
                (@AnhDaiDien,
				 @TieuDe,
				 @MoTa,
				 GETDATE(),
				 @MaND
                );
		IF(@listchitiettintuc IS NOT NULL)---Không nhập chi tiết thì không thêm, còn có nhập thì thực hiện IF
		BEGIN
			INSERT INTO CTTinTuc(Anh, NoiDung, MaTT)
			SELECT 		
				JSON_VALUE(p.value, '$.anh'), 
				JSON_VALUE(p.value, '$.noiDung'),
				IDENT_CURRENT('TinTuc')
			FROM OPENJSON(@listchitiettintuc) AS p;
		END;

        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_tintuc_update
(
 @MaTT	int, 
 @AnhDaiDien	varchar(max),
 @TieuDe	nvarchar(max),
 @MoTa	nvarchar(max),
 @NgayDang	datetime,
 @MaND	int,
 @listchitiettintuc varchar(max)
)
AS
    BEGIN
		Update  TinTuc
		set  
			AnhDaiDien = IIF(@AnhDaiDien is null, AnhDaiDien, @AnhDaiDien),
			TieuDe = IIF(@TieuDe is null, TieuDe, @TieuDe),
			MoTa = IIF(@MoTa is null, MoTa, @MoTa),
			NgayDang = IIF(@NgayDang is null, NgayDang, @NgayDang),
			MaND = IIF(@MaND is null, MaND, @MaND)
		Where MaTT = @MaTT
    
		IF(@listchitiettintuc IS NOT NULL)
		BEGIN
			Delete from CTTinTuc WHERE MaTT = @MaTT; --xóa đi chi tiết cũ và add chi tiết mới vào

			INSERT INTO CTTinTuc(Anh, NoiDung, MaTT)
			SELECT 
				JSON_VALUE(p.value, '$.anh'), 
				JSON_VALUE(p.value, '$.noiDung'),
				@MaTT
			FROM OPENJSON(@listchitiettintuc) AS p;
		END;
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_tintuc_delete(@MaTT int)
AS
	BEGIN
		Delete CTTinTuc WHERE MaTT = @MaTT
		Delete TinTuc WHERE MaTT = @MaTT
	END;
GO
--------------------------------------------------------------------------------------
------------Người dùng(getAll, getbyID, kiểm tra login, THÊM, SỬA, XÓA)---------------
CREATE PROCEDURE sp_nguoidung_get_all_admin(@page_index int, 
										    @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaND DESC)) AS RowNumber, 
                               MaND, TaiKhoan, Email, MatKhau, HoTen, NgaySinh, DiaChi, SDT, LoaiQuyen, TrangThai
                        INTO #Results1
                        FROM NguoiDung
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaND DESC)) AS RowNumber, 
                               MaND, TaiKhoan, Email, MatKhau, HoTen, NgaySinh, DiaChi, SDT, LoaiQuyen, TrangThai
                        INTO #Results2
                        FROM NguoiDung
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
--------------------------------------------------
CREATE PROCEDURE sp_nguoidung_get_by_id_admin(@MaND int)
AS
	BEGIN 
		SELECT * FROM NguoiDung WHERE MaND = @MaND
    END;
GO
EXEC sp_nguoidung_get_by_id_admin 1;
GO
----------------Đăng nhập Admin-----------------
CREATE PROCEDURE sp_nguoidung_login(@TaiKhoan varchar(50), @MatKhau varchar(100))
AS
	BEGIN
		SELECT * FROM NguoiDung 
		WHERE TaiKhoan = @TaiKhoan AND MatKhau = @MatKhau
	END;
GO
---------------Tạo mới người dùng----------------
CREATE PROCEDURE sp_nguoidung_create
(@TaiKhoan varchar(50),
 @Email	varchar(100),
 @MatKhau	varchar(100),
 @HoTen	nvarchar(50),
 @NgaySinh	datetime,
 @DiaChi	nvarchar(200),
 @SDT	varchar(10),
 @LoaiQuyen nvarchar(50),
 @TrangThai bit
)
AS
    BEGIN
		INSERT INTO NguoiDung
                (TaiKhoan,
				 Email,
				 MatKhau,
				 HoTen,
				 NgaySinh,
				 DiaChi,
				 SDT,
				 LoaiQuyen,
				 TrangThai
                )
                VALUES
                (@TaiKhoan,
				 @Email,
				 @MatKhau,
				 @HoTen,
				 @NgaySinh,
				 @DiaChi,
				 @SDT,
				 N'Nhân viên',
				 1
                );

        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_nguoidung_update
(
 @MaND	int, 
 @TaiKhoan varchar(50),
 @Email	varchar(100),
 @MatKhau	varchar(100),
 @HoTen	nvarchar(50),
 @NgaySinh	datetime,
 @DiaChi	nvarchar(200),
 @SDT	varchar(10),
 @LoaiQuyen nvarchar(50),
 @TrangThai bit
)
AS
    BEGIN
		Update  NguoiDung
		set  
			TaiKhoan = IIF(@TaiKhoan is null, TaiKhoan, @TaiKhoan),
			Email = IIF(@Email is null, Email, @Email),
			MatKhau = IIF(@MatKhau is null, MatKhau, @MatKhau),
			HoTen = IIF(@HoTen is null, HoTen, @HoTen),
			NgaySinh = IIF(@NgaySinh is null, NgaySinh, @NgaySinh),
			DiaChi = IIF(@DiaChi is null, DiaChi, @DiaChi),
			SDT = IIF(@SDT is null, SDT, @SDT),
			LoaiQuyen = IIF(@LoaiQuyen is null, LoaiQuyen, @LoaiQuyen),
			TrangThai = IIF(@TrangThai is null, TrangThai, @TrangThai)
		Where MaND = @MaND
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_nguoidung_delete(@MaND int)
AS
	BEGIN
		Delete NguoiDung WHERE MaND = @MaND
	END;
GO
-----------------------------------------------------------------------------------
-----------------------Kho(getAll, getbyID, THÊM, SỬA, XÓA)-------------------------------
CREATE PROCEDURE sp_kho_get_all_admin(@page_index int, 
									  @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaKho DESC)) AS RowNumber, 
                               MaKho, TenKho, DiaChi
                        INTO #Results1
                        FROM Kho
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaKho DESC)) AS RowNumber, 
                               MaKho, TenKho, DiaChi
                        INTO #Results2
                        FROM Kho
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
---------------------------------------------------------
CREATE PROCEDURE sp_kho_get_by_id_admin(@MaKho int)
AS
    BEGIN
        SELECT k.MaKho, k.TenKho, k.DiaChi,
		(
			SELECT 
				c.*,
				s.TenSP, s.AnhDaiDien
			FROM CTKho AS c INNER JOIN SanPham s on c.MaSP = s.MaSP
			WHERE c.MaKho = k.MaKho FOR JSON PATH
		) AS listjson_chitietkho
		FROM Kho k
		WHERE  k.MaKho = @MaKho
    END;
GO
EXEC sp_kho_get_by_id_admin 6;
GO
--------------------------------------
CREATE PROCEDURE sp_kho_create
(@TenKho nvarchar(100),
 @DiaChi nvarchar(200),
 @listchitietkho nvarchar(max)
)
AS
    BEGIN
		INSERT INTO Kho
                (TenKho,
				 DiaChi)
                VALUES
                (@TenKho,
				 @DiaChi);
		IF(@listchitietkho IS NOT NULL)---Không nhập chi tiết thì không thêm, còn có nhập thì thực hiện IF
		BEGIN
			INSERT INTO CTKho(SoLuong, MaKho, MaSP)
			SELECT 		
				JSON_VALUE(ctk.value, '$.soLuong'), 
				IDENT_CURRENT('Kho'),
				JSON_VALUE(ctk.value, '$.maSP')
			FROM OPENJSON(@listchitietkho) AS ctk;
		END;

        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_kho_update
(
 @MaKho	int, 
 @TenKho nvarchar(100),
 @DiaChi nvarchar(200),
 @listchitietkho nvarchar(max)
)
AS
    BEGIN
		Update  Kho
		set  
			TenKho = IIF(@TenKho is null, TenKho, @TenKho),
			DiaChi = IIF(@DiaChi is null, DiaChi, @DiaChi)
		Where MaKho = @MaKho
    
		IF(@listchitietkho IS NOT NULL)---Không sửa chi tiết thì không thực hiện, còn có sửa thì thực hiện IF
		BEGIN
			Delete from CTKho WHERE MaKho= @MaKho; --xóa đi chi tiết cũ và add chi tiết mới vào

			INSERT INTO CTKho(SoLuong, MaKho, MaSP)
			SELECT 		
				JSON_VALUE(ctk.value, '$.soLuong'), 
				@MaKho,
				JSON_VALUE(ctk.value, '$.maSP')
			FROM OPENJSON(@listchitietkho) AS ctk;
		END;
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_kho_delete(@MaKho int)
AS
	BEGIN
		Delete CTKho WHERE MaKho = @MaKho
		Delete Kho WHERE MaKho = @MaKho
	END;
GO
-----------------------------------------------------------------------------------
-----------------------Hóa đơn nhập(getAll, getbyID, THÊM, SỬA, XÓA)---------------
CREATE PROCEDURE sp_hoadonnhap_get_all_admin(@page_index int, 
									         @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaHDN DESC)) AS RowNumber, 
                               hdn.MaHDN, hdn.NgayNhap, hdn.MaND, hdn.MaNCC, nd.HoTen, ncc.TenNCC
                        INTO #Results1
                        FROM HoaDonNhap hdn INNER JOIN NguoiDung nd ON hdn.MaND = nd.MaND
											INNER JOIN NhaCungCap ncc ON hdn.MaNCC = ncc.MaNCC
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaHDN DESC)) AS RowNumber, 
                               hdn.MaHDN, hdn.NgayNhap, hdn.MaND, hdn.MaNCC, nd.HoTen, ncc.TenNCC
                        INTO #Results2
                        FROM HoaDonNhap hdn INNER JOIN NguoiDung nd ON hdn.MaND = nd.MaND
											INNER JOIN NhaCungCap ncc ON hdn.MaNCC = ncc.MaNCC
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
---------------------------------------------------------
CREATE PROCEDURE sp_hoadonnhap_get_by_id_admin(@MaHDN int)
AS
    BEGIN
		SELECT hdn.*,
		(
			SELECT 
				cthdn.*,
				s.TenSP,
				s.AnhDaiDien
			FROM CTHoaDonNhap cthdn INNER JOIN SanPham s on cthdn.MaSP = s.MaSP
			WHERE cthdn.MaHDN= hdn.MaHDN FOR JSON PATH
		) AS listjson_chitiethoadonnhap
		FROM HoaDonNhap hdn
		WHERE  MaHDN = @MaHDN
    END;
GO
EXEC sp_hoadonnhap_get_by_id_admin 3;
GO



--------------------------------------
CREATE PROCEDURE sp_hoadonnhap_create
(@NgayNhap datetime,
 @MaND int,
 @MaNCC int,
 @listchitiethoadonnhap nvarchar(max)
)
AS
    BEGIN
		INSERT INTO HoaDonNhap
                (NgayNhap,
				 MaND,
				 MaNCC)
                VALUES
                (getdate(),
				 @MaND,
				 @MaNCC);
		IF(@listchitiethoadonnhap IS NOT NULL)---Không nhập chi tiết thì không thêm, còn có nhập thì thực hiện IF
		BEGIN
			INSERT INTO CTHoaDonNhap(SoLuong, DonGiaNhap, MaHDN, MaSP)
			SELECT 		
				JSON_VALUE(ctk.value, '$.soLuong'), 
				JSON_VALUE(ctk.value, '$.donGiaNhap'), 
				IDENT_CURRENT('HoaDonNhap'),
				JSON_VALUE(ctk.value, '$.maSP')
			FROM OPENJSON(@listchitiethoadonnhap) AS ctk;
		END;

        SELECT '';
    END;
GO
--------------------------------------
CREATE PROCEDURE sp_hoadonnhap_update
(
 @MaHDN	int, 
 @NgayNhap datetime,
 @MaND int,
 @MaNCC int,
 @listchitiethoadonnhap nvarchar(max)
)
AS
    BEGIN
		Update  HoaDonNhap
		set  
			NgayNhap = IIF(@NgayNhap is null, NgayNhap, @NgayNhap),
			MaND = IIF(@MaND is null, MaND, @MaND)
		Where MaHDN = @MaHDN
    
		IF(@listchitiethoadonnhap IS NOT NULL)---Không sửa chi tiết thì không thực hiện, còn có sửa thì thực hiện IF
		BEGIN
			Delete from CTHoaDonNhap WHERE MaHDN = @MaHDN; --xóa đi chi tiết cũ và add chi tiết mới vào

			INSERT INTO CTHoaDonNhap(SoLuong, DonGiaNhap, MaHDN, MaSP)
			SELECT 		
				JSON_VALUE(ctk.value, '$.soLuong'), 
				JSON_VALUE(ctk.value, '$.donGiaNhap'), 
				@MaHDN,
				JSON_VALUE(ctk.value, '$.maSP')
			FROM OPENJSON(@listchitiethoadonnhap) AS ctk;
		END;
      
	  SELECT '';
    END;
GO
--------------------------------------------------
CREATE PROCEDURE sp_hoadonnhap_delete(@MaHDN int)
AS
	BEGIN
		Delete CTHoaDonNhap WHERE MaHDN = @MaHDN
		Delete HoaDonNhap WHERE MaHDN = @MaHDN
	END;
GO
-----------------------------------------------------------------------------------
---------------------------Đơn hàng(getAll)----------------------------------------
CREATE PROCEDURE sp_donhang_get_all_admin(@page_index int, 
									      @page_size int)
AS
	BEGIN
		DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaDH DESC)) AS RowNumber, 
                               d.MaDH, d.NgayDat, d.TrangThai, d.MaKH , k.TenKH, k.DiaChi, k.SDT, k.Email
                        INTO #Results1
                        FROM DonHang d INNER JOIN KhachHang k ON d.MaKH = k.MaKH
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1 OR @page_index = -1;

                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(ORDER BY MaDH DESC)) AS RowNumber, 
                               d.MaDH, d.NgayDat, d.TrangThai, d.MaKH ,  k.TenKH, k.DiaChi, k.SDT, k.Email
                        INTO #Results2
                        FROM DonHang d INNER JOIN KhachHang k ON d.MaKH = k.MaKH
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2; 
						
                        DROP TABLE #Results2; 
        END;
	END
GO
CREATE PROCEDURE sp_donhang_get_by_id_admin(@MaDH int)
AS
    BEGIN
        SELECT d.MaDH, SUM(c.GiaMua * c.SoLuong) AS TongTien,
			(
				SELECT 
					c.MaCTDH,
					c.MaSP,
					s.TenSP,
					s.AnhDaiDien,
					c.SoLuong,
					c.GiaMua,
					(c.GiaMua * c.SoLuong) AS ThanhTien
					
				FROM CTDonHang c INNER JOIN SanPham s on c.MaSP = s.MaSP
				WHERE c.MaDH = d.MaDH 
				FOR JSON PATH
			) AS listjson_chitietdonhang
        FROM DonHang d INNER JOIN CTDonHang c ON d.MaDH = c.MaDH
		where  d.MaDH = @MaDH
		GROUP BY d.MaDH
    END;
GO
EXEC sp_donhang_get_by_id_admin 4
GO

-----------------------------------------------------------------------------------
-------------------------------Thống kê--------------------------------------------
CREATE PROCEDURE sp_tk_doanhthuthang
AS
BEGIN
    SELECT --CONCAT: hàm kết hợp các chuỗi
        CONCAT(MONTH(d.NgayDat), '/', YEAR(d.NgayDat)) AS ThangNam, 
        SUM(ct.SoLuong * ct.GiaMua) AS DoanhThu
    FROM 
        DonHang d INNER JOIN CTDonHang ct ON d.MaDH = ct.MaDH
    GROUP BY MONTH(d.NgayDat), YEAR(d.NgayDat)
END


