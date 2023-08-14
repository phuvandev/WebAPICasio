var app = angular.module('AppBanDongHoCasio', []);
app.controller("ProductDetailCtrl", function ($scope, $http) {
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


    
//-----------------------HIỂN THỊ ẢNH CT SẢN PHẨM-------------------------------
    $scope.showProduct = function(segment) {
        $scope.selectedImage = segment.anh;
    };

      
//------------------------------------------------------------------------------
    $scope.dataProductDetail;
    $scope.dataProductPicDetail;
    $scope.dataSpecification; //Thông số kỹ thuật
    $scope.LoadDataProductDetail = function () {
        var key = 'id';
		var value = window.location.search.substring(window.location.search.indexOf(key)+key.length+1);
        $http({
            method: 'GET',
            url: current_url + '/SanPham/sanpham-get-by-id/'+value,
        }).then(function (response) {
            $scope.dataProductDetail = response.data;

            $scope.dataProductPicDetail = response.data.objectjson_ctanhsanpham;

            if ($scope.dataProductPicDetail && $scope.dataProductPicDetail[0].anh != null) {
                $scope.selectedImage = $scope.dataProductPicDetail[0].anh; // Biến lưu đường dẫn ảnh tương ứng
            }

            $scope.dataSpecification = response.data.objectjson_thongsokythuat;
            console.log($scope.dataSpecification);
        });
    };
    $scope.LoadDataProductDetail();
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
/*---------------------------------------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.SL = 1;
    $scope.buyProduct = function (s, SL) {
        if(SL != null) {
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
            products.soLuong = SL;       
            var list;
            if (localStorage.getItem('cart') == null) {
                list = [products];
            } 
            else {
                list = JSON.parse(localStorage.getItem('cart')) || [];
                let ok = true; //sản phẩm được "chọn mua" chưa tồn tại
                for (let x of list) {
                    if (x.maSP == products.maSP) {
                        x.soLuong += SL;
                        ok = false; 
                        break;
                    }
                }
                if (ok) { 
                    list.push(products);
                }
            }
            localStorage.setItem('cart', JSON.stringify(list));
            alert("Đã thêm vào giỏ hàng thành công! Số lượng là: " + SL + " sản phẩm!");
            $scope.demsl();
            console.log(products);
        }
        else {
            alert("Vui lòng chọn số lượng sản phẩm hợp lệ!");
        }
    };
/*--------------------TÌM KIẾM-----------------------------------------*/
/*---------------------------------------------------------------------*/
    $scope.Search = function(nhap){
        window.location.href = 'search.html?tensp='+nhap;
        
    };
});