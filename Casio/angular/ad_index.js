var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdIndexCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    $scope.LoadThongKeDoanhThu = function () {	  
        let obj = {};
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/ThongKe/tk-doanhthu-thang',
        }).then(function (response) {	
            $scope.listThongKeDoanhThu = response.data;
            console.log($scope.listThongKeDoanhThu);


            // Tính tổng doanh thu
            $scope.tongDoanhThu = 0;
            for(var i = 0; i < $scope.listThongKeDoanhThu.length; i++) {
                $scope.tongDoanhThu += $scope.listThongKeDoanhThu[i].doanhThu;
            }
            console.log($scope.tongDoanhThu);
        });
        
    };  
    $scope.LoadThongKeDoanhThu();
    
    
});