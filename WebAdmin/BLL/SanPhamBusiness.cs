using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }

        public List<SanPhamModel> SanPhamGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.SanPhamGetAll(pageIndex, pageSize, out total);
        }

        public SanPhamModel SanPhamGetbyID(int id)
        {
            return _res.SanPhamGetbyID(id);
        }

        public bool Create(SanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(SanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
