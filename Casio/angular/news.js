var app = angular.module('AppBanDongHoCasio', []);
app.controller("NewsCtrl", function ($scope, $http) {
/*---------------------------------------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.demsl = function() {
        $scope.soluong = 0;
        list = JSON.parse(localStorage.getItem('cart')) || [];
        for (let x of list) {
            $scope.soluong += x.soLuong; //hiển thị số lượng
        }
    };
    $scope.demsl();
/*----------------------------------------------------------------------------------------*/
/*------------------------------MENU(get all)---------------------------------------------*/ 
/*----------------------------------------------------------------------------------------*/
    $scope.listMenu;
    $scope.LoadMenu = function () {
        $http({
            method: 'GET',
            url: current_url + '/Menu/menu-get-all',
        }).then(function (response) {
            $scope.listMenu = response.data;
        });
    };
    $scope.LoadMenu(); 

//------------------------------------------------------------------------------
    //lấy danh sách tin tức
    $scope.pageSize = 4;  
    $scope.currentPage = 1;//phân trang
    $scope.totalPages = 1;//phân trang

    $scope.LoadTinTuc = function () {
        var obj = {};

        obj.page = $scope.currentPage.toString();//phân trang
        obj.pageSize = $scope.pageSize.toString();//phân trang
        
        $http({
            method: 'POST',
            data: obj,
            url: current_url + '/TinTuc/tintuc-get-all',
        }).then(function (response) {
            $scope.listTinTuc = response.data.data;
            
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };

    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listTinTuc.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadTinTuc();
    };    

    $scope.LoadTinTuc(); 
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});
