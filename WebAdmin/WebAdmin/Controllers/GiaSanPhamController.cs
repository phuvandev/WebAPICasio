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
    public class GiaSanPhamController : ControllerBase
    {
        private IGiaSanPhamBusiness _giasanphamBusiness;
        public GiaSanPhamController(IGiaSanPhamBusiness giasanphamBusiness)
        {
            _giasanphamBusiness = giasanphamBusiness;
        }

        [Route("giasanpham-get-all")]
        [HttpPost]
        public ResponseModel GiaSanPhamGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _giasanphamBusiness.GiaSanPhamGetAll(page, pageSize, out total);
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


        [Route("giasanpham-get-by-id/{id}")]
        [HttpGet]
        public GiaSanPhamModel GiaSanPhamGetbyID(int id)
        {
            return _giasanphamBusiness.GiaSanPhamGetbyID(id);
        }

        [Route("giasanpham-create")]
        [HttpPost]
        public GiaSanPhamModel Create([FromBody] GiaSanPhamModel model)
        {
            _giasanphamBusiness.Create(model);
            return model;
        }

        [Route("giasanpham-update")]
        [HttpPut]
        public GiaSanPhamModel Update([FromBody] GiaSanPhamModel model)
        {
            _giasanphamBusiness.Update(model);
            return model;
        }

        [Route("giasanpham-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _giasanphamBusiness.Delete(id);
        }
    }
}
