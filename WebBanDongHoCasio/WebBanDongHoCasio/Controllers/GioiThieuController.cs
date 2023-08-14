using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GioiThieuController : ControllerBase
    {
        private IGioiThieuBusiness _gioithieuBusiness;
        public GioiThieuController(IGioiThieuBusiness gioithieuBusiness)
        {
            _gioithieuBusiness = gioithieuBusiness;
        }
        
        [Route("gioithieu-get-all")]
        [HttpGet]
        public IEnumerable<GioiThieuModel> GioiThieuGetAll()
        {
            return _gioithieuBusiness.GioiThieuGetAll();
        }
    }
}
