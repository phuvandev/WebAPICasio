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
    public class GioiThieuBusiness : IGioiThieuBusiness
    {
        private IGioiThieuRepository _res;
        public GioiThieuBusiness(IGioiThieuRepository res)
        {
            _res = res;
        }
        public List<GioiThieuModel> GioiThieuGetAll()
        {
            return _res.GioiThieuGetAll();
        }
    }
}
