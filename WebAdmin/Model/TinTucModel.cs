using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class TinTucModel
    {
        public int MaTT { get; set; }
        public string? AnhDaiDien { get; set; }
        public string? TieuDe { get; set; }
        public string? MoTa { get; set; }
        public DateTime? NgayDang { get; set; }
        public int? MaND { get; set; }
        public string? HoTen { get; set; }

        public List<CTTinTucModel>? listjson_chitiettintuc { get; set; }
    }
    public class CTTinTucModel
    {
        public int? MaCTTT { get; set; }
        public string? Anh { get; set; }
        public string? NoiDung { get; set; }

    }
}
