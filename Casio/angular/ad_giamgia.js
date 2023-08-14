var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdGiamGiaCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy giảm giá
    $scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.LoadGiamGia = function () {	  
        let obj =  {};
        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/GiamGia/giamgia-get-all',
        }).then(function (response) {	
            $scope.listGiamGia = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listGiamGia.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadGiamGia();
    };    
    $scope.LoadGiamGia();

/*-------------------Lấy ra sản phẩm đổ vào ô select---------*/
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


/*--------Hiển thị*/
    $scope.Create = function (){
        $scope.btnText = "Thêm";
        $scope.phanTram = "";
        // $scope.thoiGianBD = moment().format('YYYY-MM-DD');
        $scope.thoiGianBD = "";
        $scope.thoiGianKT = "";
        $scope.trangThai = "0";
        $scope.maSP = ""; 
        
    }

    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/GiamGia/giamgia-get-by-id/' + id,
        }).then(function (response) {
            let giamgia = response.data;
            $scope.maGG = giamgia.maGG;
            $scope.phanTram = giamgia.phanTram;
            $scope.thoiGianBD = giamgia.thoiGianBD;
            $scope.thoiGianKT = giamgia.thoiGianKT;
            if (giamgia.trangThai == "0") {
                $scope.trangThai = "0";
            }
            else {
                $scope.trangThai = "1";
            }
            $scope.maSP = giamgia.maSP;
        });
    }
/*----------------*/

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maGG = $scope.maGG;
        obj.phanTram = $scope.phanTram;
        obj.thoiGianBD = $scope.thoiGianBD;
        obj.thoiGianKT = $scope.thoiGianKT;
        obj.trangThai = ($scope.trangThai == "1") ? true : false;
        obj.maSP = $scope.maSP;
        
        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/GiamGia/giamgia-create',
            }).then(function (response) {
                $scope.LoadGiamGia();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/GiamGia/giamgia-update',
            }).then(function (response) {
                $scope.LoadGiamGia();
                alert('Cập nhật thành công!');
            });
        }
        $("#exampleModalTaoSua").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/GiamGia/giamgia-delete/' + id,
            }).then(function (response) {
                $scope.LoadGiamGia();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    
});