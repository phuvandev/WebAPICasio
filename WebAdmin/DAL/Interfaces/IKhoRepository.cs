using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IKhoRepository
    {
        List<KhoModel> KhoGetAll(int pageIndex, int pageSize, out long total);
        KhoModel KhoGetbyID(int id);
        bool Create(KhoModel model);
        bool Update(KhoModel model);
        bool Delete(int id);
    }
}
