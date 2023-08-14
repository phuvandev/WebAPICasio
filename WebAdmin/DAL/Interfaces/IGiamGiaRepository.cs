using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IGiamGiaRepository
    {
        List<GiamGiaModel> GiamGiaGetAll(int pageIndex, int pageSize, out long total);
        GiamGiaModel GiamGiaGetbyID(int id);
        bool Create(GiamGiaModel model);
        bool Update(GiamGiaModel model);
        bool Delete(int id);
    }
}
