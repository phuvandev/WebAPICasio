using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface INhaCungCapBusiness
    {
        List<NhaCungCapModel> NhaCungCapGetAll(int pageIndex, int pageSize, out long total);
        NhaCungCapModel NhaCungCapGetbyID(int id);
        bool Create(NhaCungCapModel model);
        bool Update(NhaCungCapModel model);
        bool Delete(int id);
    }
}
