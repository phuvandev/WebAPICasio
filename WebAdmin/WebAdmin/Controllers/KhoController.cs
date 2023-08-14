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
    public class KhoController : ControllerBase
    {
        private IKhoBusiness _khoBusiness;
        public KhoController(IKhoBusiness khoBusiness)
        {
            _khoBusiness = khoBusiness;
        }

        [Route("kho-get-all")]
        [HttpPost]
        public ResponseModel KhoGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _khoBusiness.KhoGetAll(page, pageSize, out total);
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

        [Route("kho-get-by-id/{id}")]
        [HttpGet]
        public KhoModel KhoGetbyID(int id)
        {
            return _khoBusiness.KhoGetbyID(id);
        }

        [Route("kho-create")]
        [HttpPost]
        public KhoModel Create([FromBody] KhoModel model)
        {
            _khoBusiness.Create(model);
            return model;
        }

        [Route("kho-update")]
        [HttpPut]
        public KhoModel Update([FromBody] KhoModel model)
        {
            _khoBusiness.Update(model);
            return model;
        }

        [Route("kho-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _khoBusiness.Delete(id);
        }
    }
}
