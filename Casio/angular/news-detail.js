var app = angular.module('AppBanDongHoCasio', []);
app.controller("NewsDetailCtrl", function ($scope, $http) {
/*-------------------------------------------------------------------------------------*/
/*-----------------------HIỂN THỊ SỐ LƯỢNG TRÊN GIỎ------------------------------------*/
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

/*---------------------CHI TIẾT TIN TỨC---------------------------------*/
    $scope.listNews;
    $scope.dataNewsDetail;
    $scope.LoadNewsDetail = function () {
        var key = 'id';
		var value = window.location.search.substring(window.location.search.indexOf(key)+key.length+1);
        $http({
            method: 'GET',
            url: current_url + '/TinTuc/tintuc-get-by-id/'+value,
        }).then(function (response) {
            $scope.listNews = response.data;
            console.log($scope.listNews);

            $scope.dataNewsDetail = response.data.objectjson_cttintuc;
            console.log($scope.dataNewsDetail);
        });
    };
    $scope.LoadNewsDetail(); 


//------------------------------------------------------------------------------
    $scope.listTinTuc;
    $scope.pageSize = "4";
    $scope.LoadTinTuc = function () {
        var obj = {};
        obj.page = "1";
        obj.pageSize = $scope.pageSize;
        $http({
            method: 'POST',
            data: obj,
            url: current_url + '/TinTuc/tintuc-get-all',
        }).then(function (response) {
            $scope.listTinTuc = response.data.data;
            console.log($scope.listTinTuc);
        });
    };
    $scope.LoadTinTuc(); 
    /*--------------------TÌM KIẾM-----------------------------------------*/
    /*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});