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
        public DongSanPhamModel DongSanPhamGetbyID(int id)
        {
            return _res.DongSanPhamGetbyID(id);
        }
        public List<DongSanPhamModel> DongSanPhamGetbySL(int sl)
        {
            return _res.DongSanPhamGetbySL(sl);
        }
    }
}
