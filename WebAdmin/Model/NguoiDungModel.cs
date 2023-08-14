using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class NguoiDungModel
    {
        public int? MaND { get; set; }
        public string TaiKhoan { get; set; }
        public string? Email { get; set; }
        public string MatKhau { get; set; }
        public string? HoTen { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string? DiaChi { get; set; }
        public string? SDT { get; set; }
        public string? LoaiQuyen { get; set; }
        public bool? TrangThai { get; set; }

        public string? token { get; set; }
    }
}
