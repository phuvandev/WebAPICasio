var app = angular.module('AppBanDongHoCasio', []);
app.controller("IntroCtrl", function ($scope, $http) {
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
/*----------------------------------------------------------------------------------------*/ 
/*----------------------------------GIỚI THIỆU--------------------------------------------*/ 
/*----------------------------------------------------------------------------------------*/ 
    $scope.listGioiThieu;
    $scope.LoadGioiThieu = function () {
        $http({
            method: 'GET',
            url: current_url + '/GioiThieu/gioithieu-get-all', 
        }).then(function (response) {
            $scope.listGioiThieu = response.data;       
        });
    };
    $scope.LoadGioiThieu(); 
    
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});