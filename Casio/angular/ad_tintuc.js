var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdTinTucCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;


    //Lấy tin tức
	$scope.pageSize = 6; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadTinTuc = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/TinTuc/tintuc-get-all',
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

    /*--------------Chi tiết tin tức---------------------*/
    $scope.Detail = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/TinTuc/tintuc-get-by-id/' + id,
        }).then(function (response) {
            let cttintuc = response.data;
            $scope.listCTTinTuc = cttintuc.listjson_chitiettintuc;
            console.log(cttintuc);
        });
    } 
    /*-==============================================*/

// /*----------------------Lấy ra menu đổ vào ô select---------*/
//     //Lấy menu
// 	$scope.listMenu; 
//     $scope.pageSize = "20";   
//     $scope.LoadMenu = function () {	  
//         let obj =  {};
//         obj.page = "1";
//         obj.pageSize = $scope.pageSize;
//         $http({
//             method: 'POST', 
//             headers: { "Authorization": 'Bearer ' + _user.token },
//             data: obj, 
//             url: ad_current_url + '/Menu/menu-get-all',
//         }).then(function (response) {	
//             $scope.listMenu = response.data.data;
//             console.log($scope.listMenu);
//         });
//     };  
//     $scope.LoadMenu();
    
// /*=================================================================*/

//     $scope.Create = function (){
//         $scope.btnText = "Thêm"
//         $scope.tenDSP = "";
//         $scope.anhDaiDien = "";
//         $scope.moTa = "";
//         $scope.maMenu = "";
        
//     }

    
//     $scope.Update = function (id){
//         $scope.btnText = "Sửa"
//         $http({
//             method: 'GET',
//             headers: { "Authorization": 'Bearer ' + _user.token },
//             url: ad_current_url + '/DongSanPham/dongsanpham-get-by-id/' + id,
//         }).then(function (response) {
//             let dongsanpham = response.data;
//             $scope.maDSP = dongsanpham.maSlide;
//             $scope.tenDSP = dongsanpham.tenDSP;
//             $scope.anhDaiDien = dongsanpham.anhDaiDien;
//             $scope.moTa = dongsanpham.moTa;
//             $scope.maMenu = dongsanpham.maMenu;
//         });
//     }
        
//     $scope.CreateUpdate = function () {
//         let obj = {};
//         obj.maDSP = $scope.maDSP;
//         obj.tenDSP = $scope.tenDSP;
//         obj.moTa = $scope.moTa;
//         obj.maMenu = $scope.maMenu;

//         var file = document.getElementById('file').files[0];

//         //nếu thêm file ảnh
//         if(file)
//         {
//             const formData = new FormData();
//             formData.append('file', file);

//             $http({
//                 method: 'POST',
//                 headers: {
//                     "Authorization": 'Bearer ' + _user.token,
//                     'Content-Type': undefined
//                 },
//                 data: formData,
//                 url: ad_current_url + '/DongSanPham/file-upload',
//             }).then(function (res) {

//                 obj.anhDaiDien = res.data.filePath;

//                 if($scope.btnText == "Thêm")
//                 {
//                     $http({
//                         method: 'POST',
//                         headers: { "Authorization": 'Bearer ' + _user.token },
//                         data: obj,
//                         url: ad_current_url + '/DongSanPham/dongsanpham-create',
//                     }).then(function (response) {
//                         $scope.LoadDongSanPham();
//                         alert('Thêm thành công !');
//                     });
//                 }
//                 else
//                 {
//                     $http({
//                         method: 'PUT',
//                         headers: { "Authorization": 'Bearer ' + _user.token },
//                         data: obj,
//                         url: ad_current_url + '/DongSanPham/dongsanpham-update',
//                     }).then(function (response) {
//                         $scope.LoadDongSanPham();
//                         alert('Cập nhật thành công!');
//                     });
//                 }
//             });
//         }
//         else
//         {
//             obj.anhDaiDien = $scope.anhDaiDien;

//             if($scope.btnText == "Thêm")
//                 {
//                     $http({
//                         method: 'POST',
//                         headers: { "Authorization": 'Bearer ' + _user.token },
//                         data: obj,
//                         url: ad_current_url + '/DongSanPham/dongsanpham-create',
//                     }).then(function (response) {
//                         $scope.LoadDongSanPham();
//                         alert('Thêm thành công!');
//                     });
//                 }
//                 else
//                 {
//                     $http({
//                         method: 'PUT',
//                         headers: { "Authorization": 'Bearer ' + _user.token },
//                         data: obj,
//                         url: ad_current_url + '/DongSanPham/gioithieu-update',
//                     }).then(function (response) {
//                         $scope.LoadDongSanPham();
//                         alert('Cập nhật thành công!');
//                     });
//                 }
//         }
//         $("#exampleModalTaoSua").modal("hide");
//     }
    
    
    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/TinTuc/tintuc-delete/' + id,
            }).then(function (response) {
                $scope.LoadTinTuc();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    $scope.tenND = _user.hoten;
    
});

