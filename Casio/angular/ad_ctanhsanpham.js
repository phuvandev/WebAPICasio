var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdCTAnhSanPhamCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy chi tiết ảnh sp
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadCTAnhSanPham = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-get-all',
        }).then(function (response) {	
            $scope.listCTAnhSanPham = response.data.data;
            console.log($scope.listCTAnhSanPham );
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listCTAnhSanPham.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadCTAnhSanPham();
    };    
    $scope.LoadCTAnhSanPham();

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



    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.anh = "";
        $scope.MaSP = "";
    }

    
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-get-by-id/' + id,
        }).then(function (response) {
            let ctanhsanpham = response.data;
            $scope.maCTASP = ctanhsanpham.maCTASP;
            $scope.anh = ctanhsanpham.anh;
            $scope.maSP = ctanhsanpham.maSP;

        });
    }

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maCTASP = $scope.maCTASP;
        obj.maSP = $scope.maSP;

        var file = document.getElementById('file').files[0];

        //nếu thêm file ảnh
        if(file)
        {
            const formData = new FormData();
            formData.append('file', file);

            $http({
                method: 'POST',
                headers: {
                    "Authorization": 'Bearer ' + _user.token,
                    'Content-Type': undefined
                },
                data: formData,
                url: ad_current_url + '/CTAnhSanPham/file-upload',
            }).then(function (res) {

                obj.anh = res.data.filePath;

                if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-create',
                    }).then(function (response) {
                        $scope.LoadCTAnhSanPham();
                        alert('Thêm thành công !');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-update',
                    }).then(function (response) {
                        $scope.LoadCTAnhSanPham();
                        alert('Cập nhật thành công!');
                    });
                }
            });
        }
        else
        {
            obj.anh = $scope.anh;

            if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-create',
                    }).then(function (response) {
                        $scope.LoadCTAnhSanPham();
                        alert('Thêm thành công!');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-update',
                    }).then(function (response) {
                        $scope.LoadCTAnhSanPham();
                        alert('Cập nhật thành công!');
                    });
                }
        }
        $("#exampleModalTaoSua").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/CTAnhSanPham/ctanhsanpham-delete/' + id,
            }).then(function (response) {
                $scope.LoadCTAnhSanPham();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };
    
});