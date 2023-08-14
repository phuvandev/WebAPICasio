var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdHoaDonNhapCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;


    //Lấy hóa đơn nhập + pagi
    $scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.LoadHoaDonNhap = function () {	  
        let obj =  {};
        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/HoaDonNhap/hoadonnhap-get-all',
        }).then(function (response) {	
            $scope.listHoaDonNhap = response.data.data;
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listHoaDonNhap.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadHoaDonNhap();
    };    
    $scope.LoadHoaDonNhap();

/*--------------Chi tiết hóa đơn nhập---------------------*/
    $scope.Detail = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/HoaDonNhap/hoadonnhap-get-by-id/' + id,
            
        }).then(function (response) {
            let cthoadonnhap = response.data;

            $scope.listCTHoaDonNhap = cthoadonnhap.listjson_chitiethoadonnhap;
        });
    } 
/*-==================Lấy ra dữ liệu đổ vào ô/select===========================*/
//Lấy người dùng
    $scope.maND = _user.mand;
    console.log($scope.maND);

//Lấy nhà cung cấp
    $scope.listNhaCungCap; 
    $scope.LoadNhaCungCap = function () {	  
        let obj =  {
            page : "1",
            pageSize : "100" 
        };
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/NhaCungCap/nhacungcap-get-all',
        }).then(function (response) {	
            $scope.listNhaCungCap = response.data.data;
        });
    };  
    $scope.LoadNhaCungCap();
//Lấy sản phẩm
    $scope.listSanPham; 
    $scope.LoadSanPham = function () {	  
        let obj =  {
            page : "1",
            pageSize : "100" 
        };
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/SanPham/sanpham-get-all',
        }).then(function (response) {	
            $scope.listSanPham = response.data.data;
        });
    };  
    $scope.LoadSanPham();
/*-=========================================================*/

    $scope.Create = function (){
        $scope.maNCC = "";
        $scope.listCTHoaDonNhap = "";
        sessionStorage.removeItem('listjson_chitiethoadonnhap');
        $scope.LoadCTHoaDonNhap();
    }

/*-----------------------------------------------------------*/
//Hiển thị bảng chi tiết hóa đơn nhập
    $scope.listCTHoaDonNhap;
    $scope.LoadCTHoaDonNhap = function (){
        $scope.listCTHoaDonNhap = [];
        let list = JSON.parse(sessionStorage.getItem('listjson_chitiethoadonnhap'));

        if(list != null){ //tồn tại 1 list
            for(var i = 0; i < list.length; i++) {
                $scope.listCTHoaDonNhap.push({
                    soLuong: list[i].soLuong,
                    donGiaNhap: list[i].donGiaNhap,
                    maSP:list[i].maSP
                })
            }
        }
    }
    $scope.LoadCTHoaDonNhap();

//Tạo mới chi tiết hóa đơn nhập
    $scope.CreateCTHDN = function (){
        //tạo đối tượng cthoadonnhap
        var CTHoaDonNhap = {
            soLuong: $scope.soLuong,
            donGiaNhap: $scope.donGiaNhap,
            maSP: $scope.maSP
        }
        //tạo sessionStorage
        var list = sessionStorage.getItem('listjson_chitiethoadonnhap');
        if (list == null) { //chưa tồn tại -> thêm vào đầu tiên
            list = [CTHoaDonNhap];
        } else {
            list = JSON.parse(list) || [];
            list.push(CTHoaDonNhap);
        }
        sessionStorage.setItem('listjson_chitiethoadonnhap', JSON.stringify(list));

        $scope.maSP = '';
        $scope.donGiaNhap = '';
        $scope.soLuong = '';
        $scope.LoadCTHoaDonNhap();
    }

//Ấn xóa chi tiết hóa đơn nhập
    $scope.DeleteCTHDN = function (maSP){
        var list = JSON.parse(sessionStorage.getItem('listjson_chitiethoadonnhap')) || [];
        for (var i = 0; i < list.length; i++) {
            if(list[i].maSP == maSP){
                list.splice(i, 1); //xóa 1 phần tử thứ i
            }
        }
        sessionStorage.setItem('listjson_chitiethoadonnhap', JSON.stringify(list));
        $scope.LoadCTHoaDonNhap();
    }

//Thực thi tạo mới
    $scope.Save = function () {
        let obj = {};
        obj.maHDN = $scope.maHDN;
        obj.maND = _user.mand;
        obj.maNCC = $scope.maNCC;

        obj.listjson_chitiethoadonnhap = $scope.listCTHoaDonNhap; //giống giao diện

        $http({
            method: 'POST',
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj,
            url: ad_current_url + '/HoaDonNhap/hoadonnhap-create',
        }).then(function (response) {
            $scope.LoadHoaDonNhap();
            alert('Thêm thành công!');
        });

        $("#exampleModalCreate").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/HoaDonNhap/hoadonnhap-delete/' + id,
            }).then(function (response) {
                $scope.LoadHoaDonNhap();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };
});