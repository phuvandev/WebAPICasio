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
        public List<LienHeModel> LienHeGetAll()
        {
            return _res.LienHeGetAll();
        }
    }
}
