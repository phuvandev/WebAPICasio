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
    public class NguoiDungController : ControllerBase
    {
        private INguoiDungBusiness _nguoidungBusiness;
        public NguoiDungController(INguoiDungBusiness nguoidungBusiness)
        {
            _nguoidungBusiness = nguoidungBusiness;
        }

        [Route("nguoidung-get-all")]
        [HttpPost]
        public ResponseModel NguoiDungGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _nguoidungBusiness.NguoiDungGetAll(page, pageSize, out total);
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


        [Route("nguoidung-get-by-id/{id}")]
        [HttpGet]
        public NguoiDungModel NguoiDungGetbyID(int id)
        {
            return _nguoidungBusiness.NguoiDungGetbyID(id);
        }

        [Route("nguoidung-create")]
        [HttpPost]
        public NguoiDungModel Create([FromBody] NguoiDungModel model)
        {
            _nguoidungBusiness.Create(model);
            return model;
        }

        [Route("nguoidung-update")]
        [HttpPut]
        public NguoiDungModel Update([FromBody] NguoiDungModel model)
        {
            _nguoidungBusiness.Update(model);
            return model;
        }

        [Route("nguoidung-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _nguoidungBusiness.Delete(id);
        }

        [AllowAnonymous] //không cần xác thực
        [HttpPost("nguoidung-login")]
        public IActionResult Login([FromBody] NguoiDungModel model)
        {
            var nguoidung = _nguoidungBusiness.Login(model.TaiKhoan, model.MatKhau);

            if (nguoidung == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không chính xác" });
            return Ok(new { mand = nguoidung.MaND, hoten = nguoidung.HoTen, taikhoan = nguoidung.TaiKhoan, loaiquyen = nguoidung.LoaiQuyen, token = nguoidung.token });
        }
    }
}
