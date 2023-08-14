﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IDonHangBusiness
    {
        List<DonHangModel> DonHangGetAll(int pageIndex, int pageSize, out long total);
        DonHangModel DonHangGetbyID(int id);

        
    }
}
