using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IUpFileBusiness //tiện ích
    {
        string UpFile(string file, string path);//truyền tên file và đường dẫn ảnh
    }
}
