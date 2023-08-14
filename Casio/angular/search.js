var app = angular.module('AppBanDongHoCasio', []);
app.controller("SearchCtrl", function ($scope, $http) {

/*------------------------------------------------------------------------------*/
/*---------------------ĐẾM SL HIỂN THỊ -----------------------------------------*/
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

/*------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------*/
    $scope.listProductSearch; //lưu trữ dssp tk
    $scope.pageSize = "10";
    $scope.LoadProductSearch = function () { 
        var urlParams = new URLSearchParams(window.location.search);
        var tensp = urlParams.get('tensp'); //truy xuất tham số trên url

        let obj =  {};
        obj.page = "1";
        obj.pageSize = $scope.pageSize;
        
        //không nhập->undefined
        if(tensp == 'undefined' || tensp == ""){
            window.location.href = 'error.html';
        }

        else if(tensp != 'undefined'){
            $scope.keySearch = tensp; //gán gtri của tensp vào keysearch
            console.log($scope.keySearch);
            obj.tenSP = tensp; //thêm tensp vào obj để gửi y/c tk
        }
        
        
        $scope.khongTimThay;
        $http({
            method: 'POST',
            data: obj,
            url: current_url + '/Home/sanpham-search',
        }).then(function (response) {
            $scope.listProductSearch = response.data.data;
            console.log($scope.listProductSearch);

            console.log($scope.listProductSearch.length);
            if($scope.listProductSearch.length == 0) {

                $scope.khongTimThay = "Không tìm thấy sản phẩm nào!";
            }
            else {
                $scope.khongTimThay = "";
            }
        });
    };
    $scope.LoadProductSearch(); 
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;//gán tensp
        
    };
});

