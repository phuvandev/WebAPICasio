using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DonHangController : ControllerBase
    {
        private IDonHangBusiness _donhangBusiness;
        public DonHangController(IDonHangBusiness donhangBusiness)
        {
            _donhangBusiness = donhangBusiness;
        }

        [Route("donhang-create")]
        [HttpPost]
        public DonHangModel Create([FromBody] DonHangModel model)
        {
            _donhangBusiness.Create(model);
            return model;
        }
        
    }
}
