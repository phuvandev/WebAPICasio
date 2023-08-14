using BLL.Interfaces;
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

        public List<SlideModel> SlideGetAll(int pageIndex, int pageSize, out long total)
        {
            return _res.SlideGetAll(pageIndex, pageSize, out total);
        }

        public SlideModel SlideGetbyID(int id)
        {
            return _res.SlideGetbyID(id);
        }

        public bool Create(SlideModel model)
        {
            return _res.Create(model);
        }

        public bool Update(SlideModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
