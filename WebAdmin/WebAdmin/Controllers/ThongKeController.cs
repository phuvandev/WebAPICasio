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
    public class ThongKeController : ControllerBase
    {
        private IThongKeBusiness _thongkeBusiness;
        public ThongKeController(IThongKeBusiness thongkeBusiness)
        {
            _thongkeBusiness = thongkeBusiness;
        }

        [Route("tk-doanhthu-thang")]
        [HttpPost]
        public IEnumerable<ThongKeModel> TKDoanhThuThang()
        {
            return _thongkeBusiness.TKDoanhThuThang();
        }
    }
}
