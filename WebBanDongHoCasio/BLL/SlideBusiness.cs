using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SlideBusiness : ISlideBusiness
    {
        private ISlideRepository _res;
        public SlideBusiness(ISlideRepository res)
        {
            _res = res;
        }
        public List<SlideModel> SlideGetAll()
        {
            return _res.SlideGetAll();
        }
    }
}
