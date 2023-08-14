var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdKhoCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;
    
    //Lấy kho
    $scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.LoadKho = function () {	  
        let obj =  {};
        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/Kho/kho-get-all',
        }).then(function (response) {	
            $scope.listKho = response.data.data;
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listKho.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadKho();
    };    
    $scope.LoadKho();

/*--------------Chi tiết kho---------------------*/
    $scope.Detail = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/Kho/kho-get-by-id/' + id,
            
        }).then(function (response) {
            let ctkho = response.data;
            $scope.listCTKho = ctkho.listjson_chitietkho;

        });
    } 
/*-==============================================*/
/*-------------------Lấy ra sản phẩm đổ vào ô select---------*/
    //Lấy sản phẩm
	$scope.listSanPham; 
    $scope.LoadSanPham = function () {	  
        let obj =  {
            page : "1",
            pageSize : "100" 
        };
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/SanPham/sanpham-get-all',
        }).then(function (response) {	
            $scope.listSanPham = response.data.data;
        });
    };  
    $scope.LoadSanPham();

/*--------Hiển thị------------------*/
    $scope.Create = function (){
        $scope.btnText = "Thêm";
        $scope.btnTextCTK = "Thêm CTK";
        $scope.tenKho = "";
        $scope.diaChi = "";
        $scope.listCTKho = "";
        sessionStorage.removeItem('listjson_chitietkho');
        $scope.LoadCTKho();
    }

    $scope.Update = function (id){
        $scope.btnText = "Sửa";
        $scope.btnTextCTK = "Sửa CTK";
        sessionStorage.removeItem('listjson_chitietkho');
        $scope.LoadCTKho();


        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/Kho/kho-get-by-id/' + id,
        }).then(function (response) {
            let kho = response.data;
            $scope.maKho = kho.maKho;
            $scope.tenKho = kho.tenKho;
            $scope.diaChi = kho.diaChi;

            $scope.listCTKho = kho.listjson_chitietkho;
            for(var i = 0; i < $scope.listCTKho.length; i++)
            {
                //thêm vào session để thao tác
                var list = sessionStorage.getItem('listjson_chitietkho'); 
                if (list == null) {
                    list = [$scope.listCTKho[i]];
                } else {
                    list = JSON.parse(list) || [];
                    list.push($scope.listCTKho[i]);
                }
                sessionStorage.setItem('listjson_chitietkho', JSON.stringify(list));
            }
        });
    }
/*-----------------------------------------------------------*/
//Hiển thị bảng chi tiết kho
    $scope.listCTKho;
    $scope.LoadCTKho = function (){
        $scope.listCTKho = [];
        let list = JSON.parse(sessionStorage.getItem('listjson_chitietkho'));

        if(list != null){ //tồn tại 1 list
            for(var i = 0; i < list.length; i++) {
                $scope.listCTKho.push({
                    soLuong: list[i].soLuong,
                    maSP:list[i].maSP
                })
            }
        }
    }
    $scope.LoadCTKho();
//Tạo mới chi tiết kho
    $scope.CreateCTK = function (){
        //tạo đối tượng ctkho
        var CTKho = {
            soLuong: $scope.soLuong,
            maSP: $scope.maSP
        }
        //tạo sessionStorage
        var list = sessionStorage.getItem('listjson_chitietkho');
        if (list == null) { //chưa tồn tại -> thêm vào đầu tiên
            list = [CTKho];
        } else {
            list = JSON.parse(list) || [];
            list.push(CTKho);
        }
        sessionStorage.setItem('listjson_chitietkho', JSON.stringify(list));

        $scope.maSP = '';
        $scope.soLuong = '';
        $scope.LoadCTKho();
    }
//Ấn xóa chi tiết kho
    $scope.DeleteCTK = function (maSP){
        var list = JSON.parse(sessionStorage.getItem('listjson_chitietkho')) || [];
        for (var i = 0; i < list.length; i++) {
            if(list[i].maSP == maSP){
                list.splice(i, 1); //xóa 1 phần tử thứ i
            }
        }
        sessionStorage.setItem('listjson_chitietkho', JSON.stringify(list));
        $scope.LoadCTKho();
    }



    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maKho = $scope.maKho;
        obj.tenKho = $scope.tenKho;
        obj.diaChi = $scope.diaChi;

        obj.listjson_chitietkho = $scope.listCTKho; //giống giao diện

        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/Kho/kho-create',
            }).then(function (response) {
                $scope.LoadKho();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/Kho/kho-update',
            }).then(function (response) {
                $scope.LoadKho();
                alert('Cập nhật thành công!');
            });
        }
        $("#exampleModalCreateUpdate").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/Kho/kho-delete/' + id,
            }).then(function (response) {
                $scope.LoadKho();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };
});