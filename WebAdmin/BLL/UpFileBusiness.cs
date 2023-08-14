using BLL.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class UpFileBusiness : IUpFileBusiness
    {
        private IUpFileRepository _res;

        public UpFileBusiness(IUpFileRepository res)
        {
            _res = res;
        }
        public string UpFile(string file, string path)
        {
            return _res.UpFile(file, path);
        }
    }
}
