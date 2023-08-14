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
    public class LienHeBusiness : ILienHeBusiness
    {
        private ILienHeRepository _res;
        public LienHeBusiness(ILienHeRepository res)
        {
            _res = res;
        }

        public List<LienHeModel> LienHeGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.LienHeGetAll(pageIndex, pageSize, out total);
        }

        public LienHeModel LienHeGetbyID(int id)
        {
            return _res.LienHeGetbyID(id);
        }

        public bool Create(LienHeModel model)
        {
            return _res.Create(model);
        }

        public bool Update(LienHeModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
