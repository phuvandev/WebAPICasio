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
    public class LienHeController : ControllerBase
    {
        private ILienHeBusiness _lienheBusiness;

        private IUpFileBusiness _upfileBusiness;
        private string _path;

        public LienHeController(ILienHeBusiness lienheBusiness, IConfiguration configuration, IUpFileBusiness upfileBusiness)
        {
            _lienheBusiness = lienheBusiness;
            _upfileBusiness = upfileBusiness;
            _path = configuration["AppSettings:PATH_GTLH"];
        }

        [Route("lienhe-get-all")]
        [HttpPost]
        public ResponseModel LienHeGetAll([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());


                long total = 0;
                var data = _lienheBusiness.LienHeGetAll(page, pageSize, out total);
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

        [Route("lienhe-get-by-id/{id}")]
        [HttpGet]
        public LienHeModel LienHeGetbyID(int id)
        {
            return _lienheBusiness.LienHeGetbyID(id);
        }

        [Route("lienhe-create")]
        [HttpPost]
        public LienHeModel Create([FromBody] LienHeModel model)
        {
            _lienheBusiness.Create(model);
            return model;
        }

        [Route("lienhe-update")]
        [HttpPut]
        public LienHeModel Update([FromBody] LienHeModel model)
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
            _lienheBusiness.Update(model);
            return model;
        }

        [Route("lienhe-delete/{id}")]
        [HttpDelete]
        public bool Delete(int id)
        {
            return _lienheBusiness.Delete(id);
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
