using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace WebBanDongHoCasio.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        private ISlideBusiness _slideBusiness;
        private ISanPhamBusiness _sanphamBusiness;
        public HomeController(ISlideBusiness slideBusiness, ISanPhamBusiness sanphamBusiness)
        {
            _slideBusiness = slideBusiness;
            _sanphamBusiness = sanphamBusiness;
        }

        [Route("slide-get-all")]
        [HttpGet]
        public IEnumerable<SlideModel> SlideGetAll()
        {
            return _slideBusiness.SlideGetAll();
        }

        [Route("sanpham-get-top-hot")]
        [HttpGet]
        public SanPhamModel SanPhamGetTopHot()
        {
            return _sanphamBusiness.SanPhamGetTopHot();
        }

        [Route("sanpham-get-new/{sl}")]
        [HttpGet]
        public IEnumerable<SanPhamModel> SanPhamGetNew(int sl)
        {
            return _sanphamBusiness.SanPhamGetNew(sl);
        }

        [Route("sanpham-get-hot/{sl}")]
        [HttpGet]
        public IEnumerable<SanPhamModel> SanPhamGetHot(int sl)
        {
            return _sanphamBusiness.SanPhamGetHot(sl);
        }

        [Route("sanpham-get-sale/{sl}")]
        [HttpGet]
        public IEnumerable<SanPhamModel> SanPhamGetSale(int sl)
        {
            return _sanphamBusiness.SanPhamGetSale(sl);
        }

        [Route("sanpham-search")]
        [HttpPost]
        public PhanTrangModel Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new PhanTrangModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                int? MaSP = null;
                if (formData.Keys.Contains("maSP") && !string.IsNullOrEmpty(Convert.ToString(formData["maSP"]))) { MaSP = int.Parse(formData["maSP"].ToString()); }

                string TenSP = "";
                if (formData.Keys.Contains("tenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSP"]))) { TenSP = Convert.ToString(formData["tenSP"]); }

                int? MinGia = null;
                if (formData.Keys.Contains("minGia") && !string.IsNullOrEmpty(Convert.ToString(formData["minGia"]))) { MinGia = int.Parse(formData["minGia"].ToString()); }

                int? MaxGia = null;
                if (formData.Keys.Contains("maxGia") && !string.IsNullOrEmpty(Convert.ToString(formData["maxGia"]))) { MaxGia = int.Parse(formData["maxGia"].ToString()); }

                int? MaDSP = null;
                if (formData.Keys.Contains("maDSP") && !string.IsNullOrEmpty(Convert.ToString(formData["maDSP"]))) { MaDSP = int.Parse(formData["maDSP"].ToString()); }

                string TenDSP = "";
                if (formData.Keys.Contains("tenDSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenDSP"]))) { TenDSP = Convert.ToString(formData["tenDSP"]); }

                long total = 0;
                var data = _sanphamBusiness.Search(page, pageSize, out total, MaSP, TenSP, MinGia, MaxGia, MaDSP, TenDSP);
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
    }
}
