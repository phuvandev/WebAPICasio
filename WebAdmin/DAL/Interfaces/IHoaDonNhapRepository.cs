using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IHoaDonNhapRepository
    {
        List<HoaDonNhapModel> HoaDonNhapGetAll(int pageIndex, int pageSize, out long total);
        HoaDonNhapModel HoaDonNhapGetbyID(int id);
        bool Create(HoaDonNhapModel model);
        bool Update(HoaDonNhapModel model);
        bool Delete(int id);
    }
}
