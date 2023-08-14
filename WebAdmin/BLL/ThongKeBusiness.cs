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
    public class ThongKeBusiness : IThongKeBusiness
    {
        private IThongKeRepository _res;
        public ThongKeBusiness(IThongKeRepository res)
        {
            _res = res;
        }
        public List<ThongKeModel> TKDoanhThuThang()
        {
            return _res.TKDoanhThuThang();
        }
    }
}
