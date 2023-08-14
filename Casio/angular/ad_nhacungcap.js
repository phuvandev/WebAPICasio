var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdNhaCungCapCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;

    
    //Lấy nhà cung cấp
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadNhaCungCap = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/NhaCungCap/nhacungcap-get-all',
        }).then(function (response) {	
            $scope.listNhaCungCap = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listNhaCungCap.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadNhaCungCap();
    };
    $scope.LoadNhaCungCap();

/*--------Hiển thị*/
    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.tenNCC = "";
        $scope.diaChi = "";
        $scope.sdt = "";
    }
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/NhaCungCap/nhacungcap-get-by-id/' + id,
        }).then(function (response) {
            let nhacungcap = response.data;
            $scope.maNCC = nhacungcap.maNCC;
            $scope.tenNCC = nhacungcap.tenNCC;
            $scope.diaChi = nhacungcap.diaChi;
            $scope.sdt = nhacungcap.sdt;
            
        });
    }
/*----------------*/

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maNCC = $scope.maNCC;
        obj.tenNCC = $scope.tenNCC;
        obj.diaChi = $scope.diaChi;
        obj.sdt = $scope.sdt;

        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/NhaCungCap/nhacungcap-create',
            }).then(function (response) {
                $scope.LoadNhaCungCap();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/NhaCungCap/nhacungcap-update',
            }).then(function (response) {
                $scope.LoadNhaCungCap();
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
                url: ad_current_url + '/NhaCungCap/nhacungcap-delete/' + id,
            }).then(function (response) {
                $scope.LoadNhaCungCap();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    $scope.tenND = _user.hoten;
    
});