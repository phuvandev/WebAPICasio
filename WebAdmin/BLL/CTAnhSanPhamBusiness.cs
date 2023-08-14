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
    public class CTAnhSanPhamBusiness : ICTAnhSanPhamBusiness
    {
        private ICTAnhSanPhamRepository _res;
        public CTAnhSanPhamBusiness(ICTAnhSanPhamRepository res)
        {
            _res = res;
        }

        public List<CTAnhSanPhamModel> CTAnhSanPhamGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.CTAnhSanPhamGetAll(pageIndex, pageSize, out total);
        }

        public CTAnhSanPhamModel CTAnhSanPhamGetbyID(int id)
        {
            return _res.CTAnhSanPhamGetbyID(id);
        }

        public bool Create(CTAnhSanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(CTAnhSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
