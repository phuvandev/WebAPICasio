using Model;
using DAL.Helper;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Helper.Interfaces;

namespace DAL
{
    public partial class SanPhamRepository : ISanPhamRepository
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public SanPhamModel SanPhamGetbyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_by_id",
                     "@MaSP", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SanPhamModel SanPhamGetTopHot()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_top_hot");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> SanPhamGetNew(int sl)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_new", 
                    "@SoLuong", sl);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> SanPhamGetHot(int sl)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_hot",
                    "@SoLuong", sl);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> SanPhamGetSale(int sl)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_sale",
                    "@SoLuong", sl);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, int? MaSP, string TenSP,int? MinGia, int? MaxGia, int? MaDSP, string TenDSP)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@MaSP", MaSP,
                    "@TenSP", TenSP,
                    "@MinGia", MinGia,
                    "@MaxGia", MaxGia,
                    "@MaDSP", MaDSP,
                    "@TenDSP", TenDSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
										
    }
}















//public List<SanPhamModel> GetDataAll()
//{
//    string msgError = "";
//    try
//    {
//        var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_get_all");
//        if (!string.IsNullOrEmpty(msgError))
//            throw new Exception(msgError);
//        return dt.ConvertTo<SanPhamModel>().ToList();
//    }
//    catch (Exception ex)
//    {
//        throw ex;
//    }
//}
//public bool Create(SanPhamModel model)
//{
//    string msgError = "";
//    try
//    {
//        var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_sanpham_create",
//        "@TenSanPham", model.TenSP,
//        "@Anh", model.Anh,
//        "@AnhChiTiet1", model.AnhChiTiet1,
//        "@MoTa", model.MoTa,
//        "@ThongTinThem", model.ThongTinThem,
//        "@GiaMoi", model.GiaMoi,
//        "@GiaCu", model.GiaCu,
//        "@SoLuong", model.SoLuong,
//        "@MaTH", model.MaTH,
//        "@MaLSP", model.MaLSP);
//        if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//        {
//            throw new Exception(Convert.ToString(result) + msgError);
//        }
//        return true;
//    }
//    catch (Exception ex)
//    {
//        throw ex;
//    }
//}

//public bool Update(SanPhamModel model)
//{
//    string msgError = "";
//    try
//    {
//        var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_sanpham_update",
//        "@MaSP", model.MaSP,
//        "@TenSanPham", model.TenSP,
//        "@Anh", model.Anh,
//        "@AnhChiTiet1", model.AnhChiTiet1,
//        "@MoTa", model.MoTa,
//        "@ThongTinThem", model.ThongTinThem,
//        "@GiaMoi", model.GiaMoi,
//        "@GiaCu", model.GiaCu,
//        "@SoLuong", model.SoLuong,
//        "@MaTH", model.MaTH,
//        "@MaLSP", model.MaLSP);
//        if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//        {
//            throw new Exception(Convert.ToString(result) + msgError);
//        }
//        return true;
//    }
//    catch (Exception ex)
//    {
//        throw ex;
//    }
//}
//public bool Delete(int id)
//{
//    string msgError = "";
//    try
//    {
//        var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_sanpham_delete", "@MaSP", id);
//        if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//        {
//            throw new Exception(Convert.ToString(result) + msgError);
//        }
//        return true;
//    }
//    catch (Exception ex)
//    {
//        throw ex;
//    }
//}

