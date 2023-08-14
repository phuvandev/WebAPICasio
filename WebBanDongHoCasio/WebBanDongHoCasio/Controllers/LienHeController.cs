using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LienHeController : ControllerBase
    {
        private ILienHeBusiness _lienheBusiness;
        public LienHeController(ILienHeBusiness lienheBusiness)
        {
            _lienheBusiness = lienheBusiness;
        }

        [Route("lienhe-get-all")]
        [HttpGet]
        public IEnumerable<LienHeModel> LienHeGetAll()
        {
            return _lienheBusiness.LienHeGetAll();
        }

    }
}
