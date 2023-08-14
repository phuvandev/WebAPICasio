using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class ResponseModel
    {
        public long TotalItems { get; set; } //tổng sản phẩm tìm thấy
        public int Page { get; set; } //trang thứ...
        public int PageSize { get; set; } //số lượng sp / trang
        //đối tượng thuộc kiểu dynamic sẽ không xác định được kiểu cho đến khi chương trình được thực thi.
        //trình biên dịch sẽ bỏ qua tất cả lỗi về cú pháp
        public dynamic Data { get; set; } //lưu các sp
    }
}
