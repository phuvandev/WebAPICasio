using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISanPhamRepository
    {
        

        SanPhamModel SanPhamGetbyID(int id);

        SanPhamModel SanPhamGetTopHot();

        List<SanPhamModel> SanPhamGetNew(int sl);

        List<SanPhamModel> SanPhamGetHot(int sl);

        List<SanPhamModel> SanPhamGetSale(int sl);

        List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, int? MaSP, string TenSP, int? MinGia, int? MaxGia, int? MaDSP, string TenDSP);
    }
}
//pt

