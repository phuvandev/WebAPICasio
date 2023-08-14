var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdSlideCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy slide
	$scope.pageSize = 10; 
    $scope.currentPage = 1;
    $scope.totalPages = 1;

    $scope.LoadSlide = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();
        obj.pageSize = $scope.pageSize.toString();

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/Slide/slide-get-all',
        }).then(function (response) {	
            $scope.listSlide = response.data.data;
            
            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  
    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listSlide.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadSlide();
    };    
    $scope.LoadSlide();


    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.anh = "";
        $scope.link = "";
    }

    
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/Slide/slide-get-by-id/' + id,
        }).then(function (response) {
            let slide = response.data;
            $scope.maSlide = slide.maSlide;
            $scope.anh = slide.anh;
            $scope.link = slide.link;
            console.log(slide);
        });
    }

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maSlide = $scope.maSlide;
        obj.link = $scope.link;

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
                url: ad_current_url + '/Slide/file-upload',
            }).then(function (res) {

                obj.anh = res.data.filePath;

                if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/Slide/slide-create',
                    }).then(function (response) {
                        $scope.LoadSlide();
                        alert('Thêm thành công !');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/Slide/slide-update',
                    }).then(function (response) {
                        $scope.LoadSlide();
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
                        url: ad_current_url + '/Slide/slide-create',
                    }).then(function (response) {
                        $scope.LoadSlide();
                        alert('Thêm thành công!');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/Slide/slide-update',
                    }).then(function (response) {
                        $scope.LoadSlide();
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
                url: ad_current_url + '/Slide/slide-delete/' + id,
            }).then(function (response) {
                $scope.LoadSlide();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };
    
});