using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IKhoBusiness
    {
        List<KhoModel> KhoGetAll(int pageIndex, int pageSize, out long total);
        KhoModel KhoGetbyID(int id);
        bool Create(KhoModel model);
        bool Update(KhoModel model);
        bool Delete(int id);
    }
}
