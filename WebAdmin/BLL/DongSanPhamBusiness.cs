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
    public class DongSanPhamBusiness : IDongSanPhamBusiness
    {
        private IDongSanPhamRepository _res;
        public DongSanPhamBusiness(IDongSanPhamRepository res)
        {
            _res = res;
        }

        public List<DongSanPhamModel> DongSanPhamGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.DongSanPhamGetAll(pageIndex, pageSize, out total);
        }

        public DongSanPhamModel DongSanPhamGetbyID(int id)
        {
            return _res.DongSanPhamGetbyID(id);
        }

        public bool Create(DongSanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(DongSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
