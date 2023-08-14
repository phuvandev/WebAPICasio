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
        public string? TenSP { get; set; }
        public string? AnhDaiDien { get; set; }

        public string? MoTa { get; set; }
        public DateTime? NgayTao { get; set; }
        public int? MaDSP { get; set; }
        public string? TenDSP { get; set; }

        public int? GiaBan { get; set; }
        public int? GiaSauKhiGiam { get; set; }

        public List<CTAnhSanPhamModel>? listjson_chitietanhsanpham { get; set; }
        public List<ThongSoKyThuatModel>? listjson_thongsokythuat { get; set; }
    }

    public class ThongSoKyThuatModel
    {
        public int MaTS { get; set; }
        public string? TenTS { get; set; }
        public string? MoTa { get; set; }
    }
}
