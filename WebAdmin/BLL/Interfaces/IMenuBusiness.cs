using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IMenuBusiness
    {
        List<MenuModel> MenuGetAll(int pageIndex, int pageSize, out long total);
        MenuModel MenuGetbyID(int id);
        bool Create(MenuModel model);
        bool Update(MenuModel model);
        bool Delete(int id);
    }
}
