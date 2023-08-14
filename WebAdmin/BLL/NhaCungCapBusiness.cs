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
    public class NhaCungCapBusiness : INhaCungCapBusiness
    {
        private INhaCungCapRepository _res;
        public NhaCungCapBusiness(INhaCungCapRepository res)
        {
            _res = res;
        }

        public List<NhaCungCapModel> NhaCungCapGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.NhaCungCapGetAll(pageIndex, pageSize, out total);
        }

        public NhaCungCapModel NhaCungCapGetbyID(int id)
        {
            return _res.NhaCungCapGetbyID(id);
        }

        public bool Create(NhaCungCapModel model)
        {
            return _res.Create(model);
        }

        public bool Update(NhaCungCapModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
