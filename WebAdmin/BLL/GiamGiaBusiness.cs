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
    public class GiamGiaBusiness : IGiamGiaBusiness
    {
        private IGiamGiaRepository _res;
        public GiamGiaBusiness(IGiamGiaRepository res)
        {
            _res = res;
        }

        public List<GiamGiaModel> GiamGiaGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.GiamGiaGetAll(pageIndex, pageSize, out total);
        }

        public GiamGiaModel GiamGiaGetbyID(int id)
        {
            return _res.GiamGiaGetbyID(id);
        }

        public bool Create(GiamGiaModel model)
        {
            return _res.Create(model);
        }

        public bool Update(GiamGiaModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
