var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdLienHeCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;


    //Lấy liên hệ
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadLienHe = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/LienHe/lienhe-get-all',
        }).then(function (response) {	
            $scope.listLienHe = response.data.data;
            
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listLienHe.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadLienHe();
    };
    $scope.LoadLienHe();


    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.tieuDe = "";
        $scope.tieuMuc = "";
        $scope.anh = "";
        $scope.moTa = "";
    }

    
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/LienHe/lienhe-get-by-id/' + id,
        }).then(function (response) {
            let lienhe = response.data;
            $scope.maLH = lienhe.maLH;
            $scope.tieuDe = lienhe.tieuDe;
            $scope.tieuMuc = lienhe.tieuMuc;
            $scope.anh = lienhe.anh;
            $scope.moTa = lienhe.moTa;
            console.log(lienhe);
        });
    }

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maLH = $scope.maLH;
        obj.tieuDe = $scope.tieuDe;
        obj.tieuMuc = $scope.tieuMuc;
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
                url: ad_current_url + '/LienHe/file-upload',
            }).then(function (res) {

                obj.anh = res.data.filePath;

                if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/LienHe/lienhe-create',
                    }).then(function (response) {
                        $scope.LoadLienHe();
                        alert('Thêm thành công !');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/LienHe/lienhe-update',
                    }).then(function (response) {
                        $scope.LoadLienHe();
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
                        url: ad_current_url + '/LienHe/lienhe-create',
                    }).then(function (response) {
                        $scope.LoadLienHe();
                        alert('Thêm thành công!');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/LienHe/lienhe-update',
                    }).then(function (response) {
                        $scope.LoadLienHe();
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
                url: ad_current_url + '/LienHe/lienhe-delete/' + id,
            }).then(function (response) {
                $scope.LoadLienHe();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };


});