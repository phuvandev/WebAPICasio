var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdDonHangCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy Đơn hàng
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadDonHang = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/DonHang/donhang-get-all',
        }).then(function (response) {	
            $scope.listDonHang = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listDonHang.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadDonHang();
    };    
    $scope.LoadDonHang();

/*--------Hiển thị*/
    
    $scope.Detail = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/DonHang/donhang-get-by-id/' + id,
            
        }).then(function (response) {
            let ctdonhang = response.data;

            $scope.tongTien = ctdonhang.tongTien;

            $scope.listCTDonHang = ctdonhang.listjson_chitietdonhang;

        });
    } 
});