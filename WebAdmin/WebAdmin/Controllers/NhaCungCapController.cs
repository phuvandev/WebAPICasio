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
    public class NhaCungCapController : ControllerBase
    {
        private INhaCungCapBusiness _nhacungcapBusiness;
        public NhaCungCapController(INhaCungCapBusiness nhacungcapBusiness)
        {
            _nhacungcapBusiness = nhacungcapBusiness;
        }

        [Route("nhacungcap-get-all")]
        [HttpPost]
        public ResponseModel NhaCungCapGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _nhacungcapBusiness.NhaCungCapGetAll(page, pageSize, out total);
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

        [Route("nhacungcap-get-by-id/{id}")]
        [HttpGet]
        public NhaCungCapModel NhaCungCapGetbyID(int id)
        {
            return _nhacungcapBusiness.NhaCungCapGetbyID(id);
        }

        [Route("nhacungcap-create")]
        [HttpPost]
        public NhaCungCapModel Create([FromBody] NhaCungCapModel model)
        {
            _nhacungcapBusiness.Create(model);
            return model;
        }

        [Route("nhacungcap-update")]
        [HttpPut]
        public NhaCungCapModel Update([FromBody] NhaCungCapModel model)
        {
            _nhacungcapBusiness.Update(model);
            return model;
        }

        [Route("nhacungcap-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _nhacungcapBusiness.Delete(id);
        }
    }
}
