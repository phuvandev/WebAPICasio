using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TinTucController : ControllerBase
    {
        private ITinTucBusiness _tintucBusiness;
        public TinTucController(ITinTucBusiness tintucBusiness)
        {
            _tintucBusiness = tintucBusiness;
        }

        [Route("tintuc-get-by-id/{id}")]
        [HttpGet]
        public TinTucModel TinTucGetbyID(int id)
        {
            return _tintucBusiness.TinTucGetbyID(id);
        }

        [Route("tintuc-get-all")]
        [HttpPost]
        public PhanTrangModel Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new PhanTrangModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                long total = 0;
                var data = _tintucBusiness.TinTucGetAll(page, pageSize, out total);
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
    }
}
