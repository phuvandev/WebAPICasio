var app = angular.module('AppBanDongHoCasio', []);
app.controller("PaymentCtrl", function ($scope, $http) {
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

/*-------------------------------------------------------------------------*/
/*----------------------Tính tổng tiền-------------------------------------*/
    $scope.totalPayment = function(){
        var list = JSON.parse(localStorage.getItem('cart')) || [];
        $scope.tongtien = 0;

        for (var i = 0; i < list.length; i++) {
            var tongtien1sp = list[i].giaMua * list[i].soLuong;
            $scope.tongtien += tongtien1sp;
            console.log($scope.tongtien);
        }
    }
    $scope.totalPayment();



/*-------------------------------------------------------------------------*/
/*----------------------KIỂM TRA THÔNG TIN--------------------------------*/
    $scope.checkInfo = function() {
        if($scope.name == null || $scope.address == null || 
            $scope.phone == null || $scope.email == null || 
            $scope.name == '' || $scope.address == '' || 
            $scope.phone == '' || $scope.email == '')
        {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return false;
        }
        else{
            if($scope.checkbox == true) {
                // alert("Ô sờ kê!");
                return true;
            }
            else {
                alert("Vui lòng tích chọn thông tin nhập là chính xác!");
                return false;
            }
            
        }

    };



/*-------------------------------------------------------------------------*/
/*----------------------TIẾN HÀNH THANH TOÁN--------------------------------*/
    $scope.payMent = function() {
        
        if($scope.checkInfo() == true) {
            var obj = {};
            obj.objectjson_khachhang = {};
            obj.objectjson_khachhang.TenKH = $scope.name,
            obj.objectjson_khachhang.Diachi = $scope.address,
            obj.objectjson_khachhang.SDT = $scope.phone,
            obj.objectjson_khachhang.Email = $scope.email
            
            obj.listjson_chitietdonhang = [];
            let list = JSON.parse(localStorage.getItem('cart'));
            for(var i = 0; i < list.length; i++) {
                obj.listjson_chitietdonhang.push({
                    MaSP: list[i].maSP, 
                    TenSP: list[i].tenSP,
                    SoLuong: list[i].soLuong,
                    GiaMua: list[i].giaMua
                }) 
            }

            $http({
                method: 'POST', 
                data: obj, 
                url: current_url + '/DonHang/donhang-create',
            }).then(function (response) {	
                alert('Thanh toán thành công, cảm ơn quý khách đã sử dụng dịch vụ!');
                localStorage.removeItem('cart');
                window.location.href = 'index.html';
            });
            
        };

    };
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});
