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
    public class GioiThieuController : ControllerBase
    {
        private IGioiThieuBusiness _gioithieuBusiness;

        private IUpFileBusiness _upfileBusiness;
        private string _path;

        public GioiThieuController(IGioiThieuBusiness gioithieuBusiness, IConfiguration configuration, IUpFileBusiness upfileBusiness)
        {
            _gioithieuBusiness = gioithieuBusiness;
            _upfileBusiness = upfileBusiness;
            _path = configuration["AppSettings:PATH_GTLH"];
        }

        [Route("gioithieu-get-all")]
        [HttpPost]
        public ResponseModel GioiThieuGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                
                long total = 0;
                var data = _gioithieuBusiness.GioiThieuGetAll(page, pageSize, out total);
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

        [Route("gioithieu-get-by-id/{id}")]
        [HttpGet]
        public GioiThieuModel GioiThieuGetbyID(int id)
        {
            return _gioithieuBusiness.GioiThieuGetbyID(id);
        }

        [Route("gioithieu-create")]
        [HttpPost]
        public GioiThieuModel Create([FromBody] GioiThieuModel model)
        {
            _gioithieuBusiness.Create(model);
            return model;
        }

        [Route("gioithieu-update")]
        [HttpPut]
        public GioiThieuModel Update([FromBody] GioiThieuModel model)
        {
            if (model.Anh != null)
            {
                var arrData = model.Anh.Split(';');
                if (arrData.Length == 3)
                {
                    var savePath = $@"{arrData[0]}";
                    model.Anh = $"{savePath}";
                    SaveFileFromBase64String(savePath, arrData[2]);
                }
            }
            _gioithieuBusiness.Update(model);
            return model;
        }

        [Route("gioithieu-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _gioithieuBusiness.Delete(id);
        }

        //File -------------------------------------------------------
        [Route("file-upload")]
        [HttpPost, DisableRequestSizeLimit] //Vô hiệu hóa giới hạn kích thước
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"{file.FileName.Replace("-", "_").Replace("%", "")}";
                    var fullPath = _upfileBusiness.UpFile(filePath, _path);
                    using (var fileStream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    return Ok(new { filePath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Không tìm thây");
            }
        }

        [NonAction]
        public string SaveFileFromBase64String(string RelativePathFileName, string dataFromBase64String)
        {
            if (dataFromBase64String.Contains("base64,"))
            {
                dataFromBase64String = dataFromBase64String.Substring(dataFromBase64String.IndexOf("base64,", 0) + 7);
            }
            return WriteFileToAuthAccessFolder(RelativePathFileName, dataFromBase64String);
        }

        [NonAction]
        public string WriteFileToAuthAccessFolder(string RelativePathFileName, string base64StringData)
        {
            try
            {
                string result = "";
                string serverRootPathFolder = _path;
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                System.IO.File.WriteAllBytes(fullPathFile, Convert.FromBase64String(base64StringData));
                return result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
