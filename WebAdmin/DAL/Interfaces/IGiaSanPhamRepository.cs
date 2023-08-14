using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IGiaSanPhamRepository
    {
        List<GiaSanPhamModel> GiaSanPhamGetAll(int pageIndex, int pageSize, out long total);
        GiaSanPhamModel GiaSanPhamGetbyID(int id);
        bool Create(GiaSanPhamModel model);
        bool Update(GiaSanPhamModel model);
        bool Delete(int id);
    }
}
