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

        public List<MenuModel> MenuGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.MenuGetAll(pageIndex, pageSize, out total);
        }

        public MenuModel MenuGetbyID(int id)
        {
            return _res.MenuGetbyID(id);
        }

        public bool Create(MenuModel model)
        {
            return _res.Create(model);
        }

        public bool Update(MenuModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
