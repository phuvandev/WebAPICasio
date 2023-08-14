using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IGioiThieuRepository
    {
        List<GioiThieuModel> GioiThieuGetAll(int pageIndex, int pageSize, out long total);
        GioiThieuModel GioiThieuGetbyID(int id);
        bool Create(GioiThieuModel model);
        bool Update(GioiThieuModel model);
        bool Delete(int id);
    }
}
