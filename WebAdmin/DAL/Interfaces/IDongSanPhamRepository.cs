using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IDongSanPhamRepository
    {
        List<DongSanPhamModel> DongSanPhamGetAll(int pageIndex, int pageSize, out long total);
        DongSanPhamModel DongSanPhamGetbyID(int id);
        bool Create(DongSanPhamModel model);
        bool Update(DongSanPhamModel model);
        bool Delete(int id);
    }
}
