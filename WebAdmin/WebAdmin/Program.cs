using DAL.Helper.Interfaces;
using DAL.Helper;
using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using BLL;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);
//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

// configure strongly typed settings objects
var appSettingsSection = builder.Configuration.GetSection("AppSettings");
builder.Services.Configure<IAppSettings>(appSettingsSection);
// configure jwt authentication
var appSettings = appSettingsSection.Get<IAppSettings>();
var key = Encoding.ASCII.GetBytes(appSettings.Secret);
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});
//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

//dky, sd dich vu
// Add services to the container.
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();

builder.Services.AddTransient<IMenuRepository, MenuRepository>();
builder.Services.AddTransient<IMenuBusiness, MenuBusiness>();

builder.Services.AddTransient<ISlideRepository, SlideRepository>();
builder.Services.AddTransient<ISlideBusiness, SlideBusiness>();

builder.Services.AddTransient<IGioiThieuRepository, GioiThieuRepository>();
builder.Services.AddTransient<IGioiThieuBusiness, GioiThieuBusiness>();

builder.Services.AddTransient<ILienHeRepository, LienHeRepository>();
builder.Services.AddTransient<ILienHeBusiness, LienHeBusiness>();

builder.Services.AddTransient<INhaCungCapRepository, NhaCungCapRepository>();
builder.Services.AddTransient<INhaCungCapBusiness, NhaCungCapBusiness>();

builder.Services.AddTransient<IDongSanPhamRepository, DongSanPhamRepository>();
builder.Services.AddTransient<IDongSanPhamBusiness, DongSanPhamBusiness>();

builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
builder.Services.AddTransient<ISanPhamBusiness, SanPhamBusiness>();

builder.Services.AddTransient<ICTAnhSanPhamRepository, CTAnhSanPhamRepository>();
builder.Services.AddTransient<ICTAnhSanPhamBusiness, CTAnhSanPhamBusiness>();

builder.Services.AddTransient<IGiaSanPhamRepository, GiaSanPhamRepository>();
builder.Services.AddTransient<IGiaSanPhamBusiness, GiaSanPhamBusiness>();

builder.Services.AddTransient<IKhoRepository, KhoRepository>();
builder.Services.AddTransient<IKhoBusiness, KhoBusiness>();

builder.Services.AddTransient<INguoiDungRepository, NguoiDungRepository>();
builder.Services.AddTransient<INguoiDungBusiness, NguoiDungBusiness>();

builder.Services.AddTransient<IGiamGiaRepository, GiamGiaRepository>();
builder.Services.AddTransient<IGiamGiaBusiness, GiamGiaBusiness>();

builder.Services.AddTransient<ITinTucRepository, TinTucRepository>();
builder.Services.AddTransient<ITinTucBusiness, TinTucBusiness>();

builder.Services.AddTransient<IHoaDonNhapRepository, HoaDonNhapRepository>();
builder.Services.AddTransient<IHoaDonNhapBusiness, HoaDonNhapBusiness>();

builder.Services.AddTransient<IDonHangRepository, DonHangRepository>();
builder.Services.AddTransient<IDonHangBusiness, DonHangBusiness>();

builder.Services.AddTransient<IThongKeRepository, ThongKeRepository>();
builder.Services.AddTransient<IThongKeBusiness, ThongKeBusiness>();

builder.Services.AddTransient<IUpFileRepository, UpFileRepository>();
builder.Services.AddTransient<IUpFileBusiness, UpFileBusiness>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


var app = builder.Build();



// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//---------------------------------------------------
app.UseRouting(); // cau hinh dinh tuyen
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();
//---------------------------------------------------


app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
