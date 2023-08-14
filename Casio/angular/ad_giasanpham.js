var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdGiaSanPhamCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy GiaSanPham
    $scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.LoadGiaSanPham = function () {	  
        let obj =  {};
        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/GiaSanPham/giasanpham-get-all',
        }).then(function (response) {	
            $scope.listGiaSanPham = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listGiaSanPham.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadGiaSanPham();
    };    
    $scope.LoadGiaSanPham();

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
        $scope.btnText = "Thêm"
        // $scope.ngayBD = moment().format('YYYY-MM-DD');
        $scope.ngayBD = "";
        $scope.ngayKT = "";
        $scope.giaBan = "";
        $scope.maSP = ""; 
        
    }

    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/GiaSanPham/giasanpham-get-by-id/' + id,
        }).then(function (response) {
            let giasanpham = response.data;
            $scope.maGSP = giasanpham.maGSP;
            $scope.ngayBD = giasanpham.ngayBD;
            $scope.ngayKT = giasanpham.ngayKT;
            $scope.giaBan = giasanpham.giaBan;
            $scope.maSP = giasanpham.maSP;
        });
    }
/*----------------*/

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maGSP = $scope.maGSP;
        obj.ngayBD = $scope.ngayBD;
        obj.ngayKT = $scope.ngayKT;
        obj.giaBan = $scope.giaBan;
        obj.maSP = $scope.maSP;

        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/GiaSanPham/giasanpham-create',
            }).then(function (response) {
                $scope.LoadGiaSanPham();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/GiaSanPham/giasanpham-update',
            }).then(function (response) {
                $scope.LoadGiaSanPham();
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
                url: ad_current_url + '/GiaSanPham/giasanpham-delete/' + id,
            }).then(function (response) {
                $scope.LoadGiaSanPham();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

});