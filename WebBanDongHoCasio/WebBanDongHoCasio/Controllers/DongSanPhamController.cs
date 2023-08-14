using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DongSanPhamController : ControllerBase
    {
        private IDongSanPhamBusiness _dongsanphamBusiness;
        public DongSanPhamController(IDongSanPhamBusiness dongsanphamBusiness)
        {
            _dongsanphamBusiness = dongsanphamBusiness;
        }

        [Route("dongsanpham-get-by-id/{id}")]
        [HttpGet]
        public DongSanPhamModel DongSanPhamGetbyID(int id)
        {
            return _dongsanphamBusiness.DongSanPhamGetbyID(id);
        }

        [Route("dongsanpham-get-by-sl/{sl}")]
        [HttpGet]
        public IEnumerable<DongSanPhamModel> DongSanPhamGetbySL(int sl)
        {
            return _dongsanphamBusiness.DongSanPhamGetbySL(sl);
        }
    }
}
