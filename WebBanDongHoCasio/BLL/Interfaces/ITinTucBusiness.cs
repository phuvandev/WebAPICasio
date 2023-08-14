using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface ITinTucBusiness
    {
        TinTucModel TinTucGetbyID(int id);
        List<TinTucModel> TinTucGetAll(int pageIndex, int pageSize, out long total);
    }
}
