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
    public class DonHangBusiness : IDonHangBusiness
    {
        private IDonHangRepository _res;
        public DonHangBusiness(IDonHangRepository res)
        {
            _res = res;
        }

        public List<DonHangModel> DonHangGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.DonHangGetAll(pageIndex, pageSize, out total);
        }

        public DonHangModel DonHangGetbyID(int id)
        {
            return _res.DonHangGetbyID(id);
        }

        
    }
}
