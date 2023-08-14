using BLL.Interfaces;
using DAL.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Model;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class NguoiDungBusiness : INguoiDungBusiness
    {
        private INguoiDungRepository _res;
        private string Secret;

        public NguoiDungBusiness(INguoiDungRepository res, IConfiguration configuration)
        {
            _res = res;
            Secret = configuration["AppSettings:Secret"];
        }

        public List<NguoiDungModel> NguoiDungGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.NguoiDungGetAll(pageIndex, pageSize, out total);
        }

        public NguoiDungModel NguoiDungGetbyID(int id)
        {
            return _res.NguoiDungGetbyID(id);
        }

        public bool Create(NguoiDungModel model)
        {
            return _res.Create(model);
        }

        public bool Update(NguoiDungModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public NguoiDungModel Login(string TaiKhoan, string MatKhau)
        {
            var nguoidung = _res.Login(TaiKhoan, MatKhau);

            if (nguoidung == null)
                return null;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, nguoidung.HoTen.ToString()),
                    new Claim(ClaimTypes.StreetAddress, nguoidung.DiaChi.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            nguoidung.token = tokenHandler.WriteToken(token);

            return nguoidung;
        }
    }
}
