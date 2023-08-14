using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class DongSanPhamModel
    {
        public int MaDSP { get; set; }
        public string TenDSP { get; set; }
        public string AnhDaiDien { get; set; }
        public string MoTa { get; set; }
        public List<CTAnhDongSanPhamModel> objectjson_ctanhdongsanpham { get; set; }
    }
    public class CTAnhDongSanPhamModel
    {
        public int MaCTADSP { get; set; }
        public string Anh { get; set; }
    }
}
