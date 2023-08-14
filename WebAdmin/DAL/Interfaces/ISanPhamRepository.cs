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
        List<SanPhamModel> SanPhamGetAll(int pageIndex, int pageSize, out long total);
        SanPhamModel SanPhamGetbyID(int id);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(int id);

    }
}
