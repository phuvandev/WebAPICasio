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
    public class GiaSanPhamBusiness : IGiaSanPhamBusiness
    {
        private IGiaSanPhamRepository _res;
        public GiaSanPhamBusiness(IGiaSanPhamRepository res)
        {
            _res = res;
        }

        public List<GiaSanPhamModel> GiaSanPhamGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.GiaSanPhamGetAll(pageIndex, pageSize, out total);
        }

        public GiaSanPhamModel GiaSanPhamGetbyID(int id)
        {
            return _res.GiaSanPhamGetbyID(id);
        }

        public bool Create(GiaSanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(GiaSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
