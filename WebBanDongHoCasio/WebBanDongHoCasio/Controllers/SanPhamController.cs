using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness sanphamBusiness)
        {
            _sanphamBusiness = sanphamBusiness;
        }

        [Route("sanpham-get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel SanPhamGetbyID(int id)
        {
            return _sanphamBusiness.SanPhamGetbyID(id);
        }

        

    }
}
