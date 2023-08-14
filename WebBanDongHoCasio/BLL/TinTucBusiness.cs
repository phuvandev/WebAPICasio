﻿using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class TinTucBusiness : ITinTucBusiness
    {
        private ITinTucRepository _res;
        public TinTucBusiness(ITinTucRepository res)
        {
            _res = res;
        }
        public TinTucModel TinTucGetbyID(int id)
        {
            return _res.TinTucGetbyID(id);
        }
        public List<TinTucModel> TinTucGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.TinTucGetAll(pageIndex, pageSize, out total);
        }
    }
}
