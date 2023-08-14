using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }

        public SanPhamModel SanPhamGetbyID(int id)
        {
            return _res.SanPhamGetbyID(id);
        }

        public SanPhamModel SanPhamGetTopHot()
        {
            return _res.SanPhamGetTopHot();
        }

        public List<SanPhamModel> SanPhamGetNew(int sl)
        {
            return _res.SanPhamGetNew(sl);
        }

        public List<SanPhamModel> SanPhamGetHot(int sl)
        {
            return _res.SanPhamGetHot(sl);
        }

        public List<SanPhamModel> SanPhamGetSale(int sl)
        {
            return _res.SanPhamGetSale(sl);
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, int? MaSP, string TenSP, int? MinGia, int? MaxGia, int? MaDSP, string TenDSP)
        {
            return _res.Search(pageIndex, pageSize, out total, MaSP, TenSP, MinGia, MaxGia, MaDSP, TenDSP);
        }
    }
}
