using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class DonHangModel
    {
        public int MaDH { get; set; }
        public DateTime NgayDat { get; set; }
        public bool TrangThai { get; set; }

        public int MaKH { get; set; }

        public string TenKH { get; set; }
        public string DiaChi { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }

        public int TongTien { get; set; }
        public List<CTDonHangModel> listjson_chitietdonhang { get; set; }
    }
    public class CTDonHangModel
    {
        public int MaCTDH { get; set; }
        public int SoLuong { get; set; }
        public int GiaMua { get; set; }

        public int ThanhTien { get; set; }

        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public string AnhDaiDien { get; set; }
    }
}
