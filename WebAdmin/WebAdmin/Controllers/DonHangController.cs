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
    public class DonHangController : ControllerBase
    {
        private IDonHangBusiness _donhangBusiness;
        public DonHangController(IDonHangBusiness donhangBusiness)
        {
            _donhangBusiness = donhangBusiness;
        }

        [Route("donhang-get-all")]
        [HttpPost]
        public ResponseModel DonHangGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _donhangBusiness.DonHangGetAll(page, pageSize, out total);
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

        [Route("donhang-get-by-id/{id}")]
        [HttpGet]
        public DonHangModel DonHangGetbyID(int id)
        {
            return _donhangBusiness.DonHangGetbyID(id);
        }

        
    }
}
