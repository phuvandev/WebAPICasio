﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IDongSanPhamRepository
    {
        DongSanPhamModel DongSanPhamGetbyID(int id);
        List<DongSanPhamModel> DongSanPhamGetbySL(int sl);
    }
}