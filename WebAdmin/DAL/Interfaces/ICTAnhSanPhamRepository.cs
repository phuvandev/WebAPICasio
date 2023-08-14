using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ICTAnhSanPhamRepository
    {
        List<CTAnhSanPhamModel> CTAnhSanPhamGetAll(int pageIndex, int pageSize, out long total);
        CTAnhSanPhamModel CTAnhSanPhamGetbyID(int id);
        bool Create(CTAnhSanPhamModel model);
        bool Update(CTAnhSanPhamModel model);
        bool Delete(int id);
    }
}
