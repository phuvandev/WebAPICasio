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
    public class HoaDonNhapBusiness : IHoaDonNhapBusiness
    {
        private IHoaDonNhapRepository _res;
        public HoaDonNhapBusiness(IHoaDonNhapRepository res)
        {
            _res = res;
        }

        public List<HoaDonNhapModel> HoaDonNhapGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.HoaDonNhapGetAll(pageIndex, pageSize, out total);
        }

        public HoaDonNhapModel HoaDonNhapGetbyID(int id)
        {
            return _res.HoaDonNhapGetbyID(id);
        }

        public bool Create(HoaDonNhapModel model)
        {
            return _res.Create(model);
        }

        public bool Update(HoaDonNhapModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
