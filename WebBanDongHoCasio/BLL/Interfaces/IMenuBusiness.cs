﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IMenuBusiness
    {
        List<MenuModel> MenuGetAll();
    }
}
