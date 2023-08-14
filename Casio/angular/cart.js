var app = angular.module('AppBanDongHoCasio', []);
app.controller("CartCtrl", function ($scope, $http) {
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

//-----------------------------------------------------------------------
//-----------------------LOAD GIỎ HÀNG----------------------------------
    $scope.LoadCart = function () {
        $scope.listcart = JSON.parse(localStorage.getItem('cart'));
        console.log($scope.listcart);
    };
    $scope.LoadCart();

//-----------------------------------------------------------------------
//-----------------------TĂNG SỐ LƯỢNG----------------------------------    
    $scope.tangsl = function (a) {
        list = JSON.parse(localStorage.getItem('cart')) || []; 
        for (let x of list) {
            if(x.maSP == a.maSP) {
                if(x.soLuong < a.tongSL) {
                    x.soLuong += 1;
                    break;
                } 
                else {
                    alert("Đã MAX Số lượng sản phẩm trong kho: " + a.tongSL + " sản phẩm!");
                }   
            }
        }
        localStorage.setItem('cart', JSON.stringify(list));
        $scope.LoadCart();
        $scope.demsl();
    };
//-----------------------------------------------------------------------
//-----------------------GIẢM SỐ LƯỢNG----------------------------------    
    $scope.giamsl = function (a) {
        list = JSON.parse(localStorage.getItem('cart')) || []; 
        for (var i=0; i<list.length; i++) {
            if(list[i].maSP == a.maSP) {
                list[i].soLuong -= 1;
                if(list[i].soLuong == 0) { //giảm xuống 0 thì xóa hàng
                    list.splice(i, 1);   //xóa 1 phần tử thứ i khỏi hàng
                }     
            }
        }
        localStorage.setItem('cart', JSON.stringify(list));
        $scope.LoadCart();
        $scope.demsl();
    };

//-----------------------------------------------------------------------
//-----------------------XÓA 1 SẢN PHẨM--------------------------------   
    $scope.deleteItem = function(a) {
        list = JSON.parse(localStorage.getItem('cart')) || []; 
        for (var i=0; i<list.length; i++) {
            if(list[i].maSP == a.maSP) {
                list.splice(i, 1);   //xóa 1 phần tử thứ i khỏi hàng   
            }
        }
        localStorage.setItem('cart', JSON.stringify(list));
        $scope.LoadCart();
        $scope.demsl();
    };

//-----------------------------------------------------------------------
//-----------------------XÓA HẾT SỐ LƯỢNG--------------------------------   
    $scope.deleteAll = function() {
        localStorage.removeItem('cart');
        $scope.LoadCart();
        $scope.demsl();
    };

//-----------------------------------------------------------------------
//-----------------------SANG TRANG THANH TOÁN-------------------------------   
    $scope.goToPayMent = function() {
        if($scope.soluong == 0)  {
            alert("Chưa có sản phẩm nào trong giỏ hàng! Vui lòng chọn mua sản phẩm")
        }
        else {
            window.location.href = "thanhtoan.html";
        }
    };
    /*--------------------TÌM KIẾM-----------------------------------------*/
    /*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});