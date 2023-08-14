using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class SanPhamModel
    {
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public string AnhDaiDien { get; set; }
        public int TongSL { get; set; } 

        public int GiaBan { get; set; }
        public int PhanTram { get; set; }
        public int GiaSauKhiGiam { get; set; }
        public string MoTa { get; set; }

        public int MaDSP { get; set; }
        public string TenDSP { get; set; }

        public List<CTAnhSanPhamModel> objectjson_ctanhsanpham { get; set; }
        public List<ThongSoKyThuatModel> objectjson_thongsokythuat { get; set; }
    }
    public class CTAnhSanPhamModel
    {
        public int MaCTASP { get; set; }
        public string Anh { get; set; }
    }
    public class CTKhoModel
    {
        public int MaCTK { get; set; }
        public int SoLuong { get; set; }
        public int MaKho { get; set; }
    }
    public class GiaSanPhamModel
    {
        public int MaGSP { get; set; }
        public DateTime NgayBD { get; set; }
        public DateTime NgayKT { get; set; }
        public int GiaBan { get; set; }
    }
    public class ThongSoKyThuatModel
    {
        public int MaTS { get; set; }
        public string TenTS { get; set; }
        public string MoTa { get; set; }
    }
}
