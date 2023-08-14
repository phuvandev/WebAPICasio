﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IDongSanPhamBusiness
    {
        DongSanPhamModel DongSanPhamGetbyID(int id);
        List<DongSanPhamModel> DongSanPhamGetbySL(int sl);
    }
}
