using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ILienHeRepository
    {
        List<LienHeModel> LienHeGetAll(int pageIndex, int pageSize, out long total);
        LienHeModel LienHeGetbyID(int id);
        bool Create(LienHeModel model);
        bool Update(LienHeModel model);
        bool Delete(int id);
    }
}
