using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebAdmin.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GiamGiaController : ControllerBase
    {
        private IGiamGiaBusiness _giamgiaBusiness;
        public GiamGiaController(IGiamGiaBusiness giamgiaBusiness)
        {
            _giamgiaBusiness = giamgiaBusiness;
        }

        [Route("giamgia-get-all")]
        [HttpPost]
        public ResponseModel GiamGiaGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _giamgiaBusiness.GiamGiaGetAll(page, pageSize, out total);
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

        [Route("giamgia-get-by-id/{id}")]
        [HttpGet]
        public GiamGiaModel GiamGiaGetbyID(int id)
        {
            return _giamgiaBusiness.GiamGiaGetbyID(id);
        }

        [Route("giamgia-create")]
        [HttpPost]
        public GiamGiaModel Create([FromBody] GiamGiaModel model)
        {
            _giamgiaBusiness.Create(model);
            return model;
        }

        [Route("giamgia-update")]
        [HttpPut]
        public GiamGiaModel Update([FromBody] GiamGiaModel model)
        {
            _giamgiaBusiness.Update(model);
            return model;
        }

        [Route("giamgia-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _giamgiaBusiness.Delete(id);
        }
    }
}
