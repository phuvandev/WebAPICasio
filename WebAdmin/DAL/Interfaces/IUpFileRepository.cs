using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IUpFileRepository //tiện ích
    {
        //upload ảnh vào thư mục
        string UpFile(string file, string path);//truyền tên file và đường dẫn ảnh
    }
}
