var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdGioiThieuCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;


    //Lấy giới thiệu
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    
    
    $scope.LoadGioiThieu = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/GioiThieu/gioithieu-get-all',
        }).then(function (response) {	
            $scope.listGioiThieu = response.data.data;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listGioiThieu.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadGioiThieu();
    };    
    $scope.LoadGioiThieu();


    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.tieuDe = '';
        $scope.anh = '';
        $scope.moTa = "";
    }

    
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/GioiThieu/gioithieu-get-by-id/' + id,
        }).then(function (response) {
            let gioithieu = response.data;
            $scope.maGT = gioithieu.maGT;
            $scope.tieuDe = gioithieu.tieuDe;
            $scope.anh = gioithieu.anh;
            $scope.moTa = gioithieu.moTa;
            console.log(gioithieu);
        });
    }

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maGT = $scope.maGT;
        obj.tieuDe = $scope.tieuDe;
        obj.moTa = $scope.moTa;

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
                url: ad_current_url + '/GioiThieu/file-upload',
            }).then(function (res) {

                obj.anh = res.data.filePath;

                if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/GioiThieu/gioithieu-create',
                    }).then(function (response) {
                        $scope.LoadGioiThieu();
                        alert('Thêm thành công !');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/GioiThieu/gioithieu-update',
                    }).then(function (response) {
                        $scope.LoadGioiThieu();
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
                        url: ad_current_url + '/GioiThieu/gioithieu-create',
                    }).then(function (response) {
                        $scope.LoadGioiThieu();
                        alert('Thêm thành công!');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/GioiThieu/gioithieu-update',
                    }).then(function (response) {
                        $scope.LoadGioiThieu();
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
                url: ad_current_url + '/GioiThieu/gioithieu-delete/' + id,
            }).then(function (response) {
                $scope.LoadGioiThieu();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    
});