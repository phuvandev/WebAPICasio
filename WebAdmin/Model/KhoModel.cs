using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class KhoModel
    {
        public int MaKho { get; set; }
        public string? TenKho { get; set; }
        public string ?DiaChi { get; set; }
        public List<CTKhoModel>? listjson_chitietkho { get; set; }
      
    }
    public class CTKhoModel
    {
        public int MaCTK { get; set; }
        public int? SoLuong { get; set; }
        public int? MaSP { get; set; }
        public string? TenSP { get; set; }
        public string? AnhDaiDien { get; set; }
    }
}
