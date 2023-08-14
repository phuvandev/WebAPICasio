var app = angular.module('AppBanDongHoCasio', []);
app.controller("HomeCtrl", function ($scope, $http) {
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
//---------------------ĐỔ DỮ LIỆU SẢN PHẨM BÁN CHẠY TOP 1---------------------------------------------
    $scope.dataProductTopSelling;
    $scope.LoadProductTopSelling = function () {
        $http({
            method: 'GET',
            url: current_url + '/Home/sanpham-get-top-hot',
        }).then(function (response) {
            $scope.dataProductTopSelling = response.data;
            console.log($scope.dataProductTopSelling);
        });
    };
    $scope.LoadProductTopSelling(); 
//---------------------ĐỔ DỮ LIỆU 5 DÒNG SẢN PHẨM-----------------------------------------------
    $scope.dataProductLine;
    $scope.LoadProductLinebyID = function () {
        $http({
            method: 'GET',
            url: current_url + '/DongSanPham/dongsanpham-get-by-sl/5',
        }).then(function (response) {
            $scope.dataProductLine = response.data;
        });
    };
    $scope.LoadProductLinebyID(); 
/*----------------------------------------------------------------------------------------*/
/*------------------------------SẢN PHẨM--------------------------------------------------*/ 
/*----------------------------------------------------------------------------------------*/ 
    $scope.listSanPhamMoi;
    $scope.LoadSanPhamMoi = function () {
        $http({
            method: 'GET',
            url: current_url + '/Home/sanpham-get-new/10',
        }).then(function (response) {
            $scope.listSanPhamMoi = response.data;
        });
    };
    $scope.LoadSanPhamMoi();  

/*----------------------------------------------------------------------------------------*/ 
    $scope.listSanPhamBanChay;
    $scope.LoadSanPhamBanChay = function () {
        $http({
            method: 'GET',
            url: current_url + '/Home/sanpham-get-hot/10',
        }).then(function (response) {
            $scope.listSanPhamBanChay = response.data;
        });
    };
    $scope.LoadSanPhamBanChay();

/*----------------------------------------------------------------------------------------*/ 
    $scope.listSanPhamGiamGia;
    $scope.LoadSanPhamGiamGia = function () {
        $http({
            method: 'GET',
            url: current_url + '/Home/sanpham-get-sale/10',
        }).then(function (response) {
            $scope.listSanPhamGiamGia = response.data;
        });
    };
    $scope.LoadSanPhamGiamGia();

/*---------------------------------------------------------------------*/
/*--------------------MUA HÀNG---------------------------------------*/
    $scope.demsl = function() {
        $scope.soluong = 0;
        list = JSON.parse(localStorage.getItem('cart')) || [];
        for (let x of list) {
            $scope.soluong += x.soLuong; //hiển thị số lượng
        }
    };
    $scope.demsl();

    $scope.buyProduct = function (s) {
        //truyền vào 1 sp
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
        
        products.soLuong = 1;       
        var list; //lưu các sản phẩm đã mua
        //cart ko tồn tại thì gán sp
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

    
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        //trang chỉ định
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});

