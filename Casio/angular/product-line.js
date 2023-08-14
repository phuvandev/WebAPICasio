var app = angular.module('AppBanDongHoCasio', []);
app.controller("ProductLineCtrl", function ($scope, $http) {
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
    $scope.dataProductLine;
    $scope.dataAnhChiTiet;
    $scope.LoadProductLinebyID = function () {
        var key = 'id';
		var value = window.location.search.substring(window.location.search.indexOf(key)+key.length+1);
        $http({
            method: 'GET',
            url: current_url + '/DongSanPham/dongsanpham-get-by-id/'+value,
        }).then(function (response) {
            $scope.dataProductLine = response.data;

            $scope.dataAnhChiTiet = response.data.objectjson_ctanhdongsanpham;
        });
    };
    $scope.LoadProductLinebyID(); 
//------------------------------------------------------------------------------
    //lấy danh sách tin tức
    $scope.pageSize = 15;  
    $scope.currentPage = 1;//phân trang
    $scope.totalPages = 1;//phân trang

    $scope.LoadListProduct = function () {
        var key = 'id';
		var value = window.location.search.substring(window.location.search.indexOf(key)+key.length+1);
        var obj = {};
        
        obj.page = $scope.currentPage.toString();//phân trang
        obj.pageSize = $scope.pageSize.toString();//phân trang

        obj.maDSP = value;
        $http({
            method: 'POST',
            data: obj,
            url: current_url + '/Home/sanpham-search',
        }).then(function (response) {
            $scope.listProduct = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };

    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listProduct.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadListProduct();
    };    

    $scope.LoadListProduct(); 
/*---------------------------------------------------------------------*/
/*--------------------MUA HÀNG---------------------------------------*/
    $scope.buyProduct = function (s) {
        var products = {
            maSP: s.maSP,
            tenSP: s.tenSP,
            anhDaiDien: s.anhDaiDien,
            tongSL: s.tongSL
        }
        if (s.giaSauKhiGiam == 0) {
            products.giaMua = s.giaBan;
        }
        else {
            products.giaMua = s.giaSauKhiGiam;
        }
        
        var list = null; //lưu các sản phẩm đã mua
        products.soLuong = 1;       
        var list;
        if (localStorage.getItem('cart') == null) {
            list = [products];
        } 
        else {
            list = JSON.parse(localStorage.getItem('cart')) || [];
            let ok = true; //sản phẩm được "chọn mua" chưa tồn tại
            for (let x of list) {
                if (x.maSP == products.maSP) {
                    x.soLuong += 1;
                    ok = false; 
                    break;
                }
            }
            if (ok) { 
                list.push(products);
            }
        }
        localStorage.setItem('cart', JSON.stringify(list));
        alert("Đã thêm giỏ hàng thành công!");
        $scope.demsl();
        console.log(products);
    };
/*---------------------------------------------------------------------*/
/*---------------------ĐẾM SL HIỂN THỊ -----------------------------------------*/
    $scope.demsl = function() {
        $scope.soluong = 0;
        list = JSON.parse(localStorage.getItem('cart')) || [];
        for (let x of list) {
            $scope.soluong += x.soLuong; //hiển thị số lượng
        }
    };
    $scope.demsl();
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});
