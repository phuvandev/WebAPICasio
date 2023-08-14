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
    public class HoaDonNhapController : ControllerBase
    {
        private IHoaDonNhapBusiness _hoadonnhapBusiness;

        public HoaDonNhapController(IHoaDonNhapBusiness hoadonnhapBusiness)
        {
            _hoadonnhapBusiness = hoadonnhapBusiness;
        }

        [Route("hoadonnhap-get-all")]
        [HttpPost]
        public ResponseModel HoaDonNhapGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _hoadonnhapBusiness.HoaDonNhapGetAll(page, pageSize, out total);
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

        [Route("hoadonnhap-get-by-id/{id}")]
        [HttpGet]
        public HoaDonNhapModel HoaDonNhapGetbyID(int id)
        {
            return _hoadonnhapBusiness.HoaDonNhapGetbyID(id);
        }

        [Route("hoadonnhap-create")]
        [HttpPost]
        public HoaDonNhapModel Create([FromBody] HoaDonNhapModel model)
        {
            _hoadonnhapBusiness.Create(model);
            return model;
        }

        [Route("hoadonnhap-update")]
        [HttpPut]
        public HoaDonNhapModel Update([FromBody] HoaDonNhapModel model)
        {
            _hoadonnhapBusiness.Update(model);
            return model;
        }

        [Route("hoadonnhap-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _hoadonnhapBusiness.Delete(id);
        }
    }
}
