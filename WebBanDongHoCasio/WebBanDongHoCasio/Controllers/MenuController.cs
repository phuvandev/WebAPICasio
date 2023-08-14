using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MenuController : ControllerBase
    {
        private IMenuBusiness _menuBusiness;
        public MenuController(IMenuBusiness menuBusiness)
        {
            _menuBusiness = menuBusiness;
        }
        [Route("menu-get-all")]
        [HttpGet]
        public IEnumerable<MenuModel> MenuGetAll()
        {
            return _menuBusiness.MenuGetAll();
        }
    }
}
