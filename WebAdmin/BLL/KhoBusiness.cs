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
    public class KhoBusiness : IKhoBusiness
    {
        private IKhoRepository _res;
        public KhoBusiness(IKhoRepository res)
        {
            _res = res;
        }

        public List<KhoModel> KhoGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.KhoGetAll(pageIndex, pageSize, out total);
        }

        public KhoModel KhoGetbyID(int id)
        {
            return _res.KhoGetbyID(id);
        }

        public bool Create(KhoModel model)
        {
            return _res.Create(model);
        }

        public bool Update(KhoModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
