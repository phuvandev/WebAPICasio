var app = angular.module('AppBanDongHoCasio', []);
app.controller("ContactCtrl", function ($scope, $http) {
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
            console.log($scope.listMenu);
        });
    };
    $scope.LoadMenu(); 
//----------------------------------------------------------------------------------------
//----------------------------------LIÊN HỆ--------------------------------------------
//--------------------------------------------------------------------------------------- 
    $scope.listLienHe;
    $scope.LoadLienHe = function () {
        $http({
            method: 'GET',
            url: current_url + '/LienHe/lienhe-get-all', 
        }).then(function (response) {
            $scope.listLienHe = response.data;     
            console.log($scope.listLienHe);  
        });
    };
    $scope.LoadLienHe(); 
    /*--------------------TÌM KIẾM-----------------------------------------*/
    /*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});

