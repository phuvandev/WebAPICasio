using BLL.Interfaces;
using BLL;
using DAL.Helper.Interfaces;
using DAL.Helper;
using DAL.Interfaces;
using DAL;

var builder = WebApplication.CreateBuilder(args);


// Add services to the container.
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();

builder.Services.AddTransient<IMenuRepository, MenuRepository>();
builder.Services.AddTransient<IMenuBusiness, MenuBusiness>();

builder.Services.AddTransient<IGioiThieuRepository, GioiThieuRepository>();
builder.Services.AddTransient<IGioiThieuBusiness, GioiThieuBusiness>();

builder.Services.AddTransient<ILienHeRepository, LienHeRepository>();
builder.Services.AddTransient<ILienHeBusiness, LienHeBusiness>();

builder.Services.AddTransient<ISlideRepository, SlideRepository>();
builder.Services.AddTransient<ISlideBusiness, SlideBusiness>();

builder.Services.AddTransient<IDongSanPhamRepository, DongSanPhamRepository>();
builder.Services.AddTransient<IDongSanPhamBusiness, DongSanPhamBusiness>();

builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
builder.Services.AddTransient<ISanPhamBusiness, SanPhamBusiness>();

builder.Services.AddTransient<ITinTucRepository, TinTucRepository>();
builder.Services.AddTransient<ITinTucBusiness, TinTucBusiness>();

builder.Services.AddTransient<IDonHangRepository, DonHangRepository>();
builder.Services.AddTransient<IDonHangBusiness, DonHangBusiness>();



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

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseRouting();
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
