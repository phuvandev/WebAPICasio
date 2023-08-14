var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdNguoiDungCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy dữ liệu người dùng + pagi
    $scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.LoadNguoiDung = function () {	  
        let obj =  {};
        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/NguoiDung/nguoidung-get-all',
        }).then(function (response) {	
            $scope.listNguoiDung = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listNguoiDung.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadNguoiDung();
    };    
    $scope.LoadNguoiDung();

/*--------------Chi tiết khách hàng---------------------*/
    $scope.Detail = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/NguoiDung/nguoidung-get-by-id/' + id,
        }).then(function (response) {
            let nguoidung = response.data;
            $scope.taiKhoan = nguoidung.taiKhoan;
            $scope.email = nguoidung.email;
            $scope.matKhau = nguoidung.matKhau;
            $scope.hoTen = nguoidung.hoTen;
            $scope.ngaySinh = nguoidung.ngaySinh;
            $scope.diaChi = nguoidung.diaChi;
            $scope.sdt = nguoidung.sdt;
            $scope.loaiQuyen = nguoidung.loaiQuyen;
            
        });
    } 
/*-==============================================*/

/*--------Hiển thị*/
    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.taiKhoan = "";
        $scope.email = "";
        $scope.matKhau = "";
        $scope.hoTen = ""; 
        $scope.ngaySinh = "";
        $scope.diaChi = "";
        $scope.sdt = "";
        $scope.loaiQuyen = "Nhân viên";
        $scope.trangThai = "0";
    }

    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/NguoiDung/nguoidung-get-by-id/' + id,
        }).then(function (response) {
            let nguoidung = response.data;
            $scope.maND = nguoidung.maND;
            $scope.taiKhoan = nguoidung.taiKhoan;
            $scope.email = nguoidung.email;
            $scope.matKhau = nguoidung.matKhau;
            $scope.hoTen = nguoidung.hoTen;
            $scope.ngaySinh = nguoidung.ngaySinh;
            $scope.diaChi = nguoidung.diaChi;
            $scope.sdt = nguoidung.sdt;
            $scope.loaiQuyen = nguoidung.loaiQuyen;
            if (nguoidung.trangThai == "0") {
                $scope.trangThai = "0";
            }
            else {
                $scope.trangThai = "1";
            }
        });
    }
// /*----------------*/

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maND = $scope.maND;
        obj.taiKhoan = $scope.taiKhoan;
        obj.email = $scope.email;
        obj.matKhau = $scope.matKhau;
        obj.hoTen = $scope.hoTen;
        obj.ngaySinh = $scope.ngaySinh;
        obj.diaChi = $scope.diaChi;
        obj.sdt = $scope.sdt;
        obj.loaiQuyen = $scope.loaiQuyen;
        obj.trangThai = ($scope.trangThai == "1") ? true : false;

        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/NguoiDung/nguoidung-create',
            }).then(function (response) {
                $scope.LoadNguoiDung();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/NguoiDung/nguoidung-update',
            }).then(function (response) {
                $scope.LoadNguoiDung();
                alert('Cập nhật thành công!');
            });
        }
        $("#exampleModalCreateUpdate").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/NguoiDung/nguoidung-delete/' + id,
            }).then(function (response) {
                $scope.LoadNguoiDung();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    
});