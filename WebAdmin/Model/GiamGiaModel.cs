using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class GiamGiaModel
    {
        public int MaGG { get; set; }
        public int? PhanTram { get; set; }
        public DateTime? ThoiGianBD { get; set; }
        public DateTime? ThoiGianKT { get; set; }
        public bool? TrangThai { get; set; }
        public int? MaSP { get; set; }
        public string? TenSP { get; set; }
        public string? AnhDaiDien { get; set; }
    }
}
