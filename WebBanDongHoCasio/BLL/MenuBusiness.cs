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
    public class MenuBusiness : IMenuBusiness
    {
        private IMenuRepository _res;
        public MenuBusiness(IMenuRepository res)
        {
            _res = res;
        }
        public List<MenuModel> MenuGetAll()
        {
            return _res.MenuGetAll();
        }
    }
}
