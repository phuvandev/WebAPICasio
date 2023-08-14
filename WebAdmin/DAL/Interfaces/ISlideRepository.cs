﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISlideRepository
    {
        List<SlideModel> SlideGetAll(int pageIndex, int pageSize, out long total);
        SlideModel SlideGetbyID(int id);
        bool Create(SlideModel model);
        bool Update(SlideModel model);
        bool Delete(int id);
    }
}
