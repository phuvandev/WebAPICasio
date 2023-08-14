using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface INguoiDungRepository
    {
        List<NguoiDungModel> NguoiDungGetAll(int pageIndex, int pageSize, out long total);
        NguoiDungModel NguoiDungGetbyID(int id);
        bool Create(NguoiDungModel model);
        bool Update(NguoiDungModel model);
        bool Delete(int id);

        NguoiDungModel Login(string TaiKhoan, string MatKhau);
    }
}
