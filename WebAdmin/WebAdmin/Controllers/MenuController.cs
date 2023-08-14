using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebAdmin.Controllers
{
    [Authorize] //xác thực
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
        [HttpPost]
        public ResponseModel MenuGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _menuBusiness.MenuGetAll(page, pageSize, out total);
                response.TotalItems = total;
                response.Data = data;
                response.Page = page;
                response.PageSize = pageSize;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return response;
        }

        [Route("menu-get-by-id/{id}")]
        [HttpGet]
        public MenuModel MenuGetbyID(int id)
        {
            return _menuBusiness.MenuGetbyID(id);
        }

        [Route("menu-create")]
        [HttpPost]
        public MenuModel Create([FromBody] MenuModel model)
        {
            _menuBusiness.Create(model);
            return model;
        }

        [Route("menu-update")]
        [HttpPut]
        public MenuModel Update([FromBody] MenuModel model)
        {
            _menuBusiness.Update(model);
            return model;
        }

        [Route("menu-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _menuBusiness.Delete(id);
        }
    }
}
