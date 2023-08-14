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

        public List<GioiThieuModel> GioiThieuGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.GioiThieuGetAll(pageIndex, pageSize, out total);
        }

        public GioiThieuModel GioiThieuGetbyID(int id)
        {
            return _res.GioiThieuGetbyID(id);
        }

        public bool Create(GioiThieuModel model)
        {
            return _res.Create(model);
        }

        public bool Update(GioiThieuModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
