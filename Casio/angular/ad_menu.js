var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdMenuCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;

    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy menu
	$scope.listMenu; 
    $scope.pageSize = "10";   
    $scope.LoadMenu = function () {	  
        let obj =  {};
        obj.page = "1";
        obj.pageSize = $scope.pageSize;
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/Menu/menu-get-all',
        }).then(function (response) {	
            $scope.listMenu = response.data.data;

            console.log($scope.listMenu);
        });
    };  
    $scope.LoadMenu();

/*--------Hiển thị*/
    $scope.Create = function (){
        $scope.btnText = "Thêm"
        $scope.tenMenu = "";
        $scope.stt = "";
        $scope.link = "";
        $scope.trangThai = "0"; // giá trị mặc định
    }
    $scope.Update = function (id){
        $scope.btnText = "Sửa"
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/Menu/menu-get-by-id/' + id,
        }).then(function (response) {
            let menu = response.data;
            $scope.maMenu = menu.maMenu;
            $scope.tenMenu = menu.tenMenu;
            $scope.stt = menu.stt;
            $scope.link = menu.link;
            if (menu.trangThai == "0") {
                $scope.trangThai = "0";
            }
            else {
                $scope.trangThai = "1";
            }
        });
    }
/*----------------*/

    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maMenu = $scope.maMenu;
        obj.tenMenu = $scope.tenMenu;
        obj.stt = $scope.stt;
        obj.link = $scope.link;
        obj.trangThai = ($scope.trangThai == "1") ? true : false;

        if($scope.btnText == "Thêm")
        {
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/Menu/menu-create',
            }).then(function (response) {
                $scope.LoadMenu();
                alert('Thêm thành công!');
            });
        }
        else
        {
            $http({
                method: 'PUT',
                headers: { "Authorization": 'Bearer ' + _user.token },
                data: obj,
                url: ad_current_url + '/Menu/menu-update',
            }).then(function (response) {
                $scope.LoadMenu();
                alert('Cập nhật thành công!');
            });
        }
        $("#exampleModalTaoSua").modal("hide");
    }

    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/Menu/menu-delete/' + id,
            }).then(function (response) {
                $scope.LoadMenu();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };

    
    
});