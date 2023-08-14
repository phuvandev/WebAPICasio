using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ITinTucRepository
    {
        List<TinTucModel> TinTucGetAll(int pageIndex, int pageSize, out long total);
        TinTucModel TinTucGetbyID(int id);
        bool Create(TinTucModel model);
        bool Update(TinTucModel model);
        bool Delete(int id);
    }
}
