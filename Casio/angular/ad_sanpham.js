var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanDongHoCasio', []);
app.controller("AdSanPhamCtrl", function ($scope, $http) {

    $scope.tenND = _user.hoten;
    
    $scope.loaiQuyen = _user.loaiquyen;

    //Lấy sản phẩm
    $scope.pageSize = 10;  
    $scope.currentPage = 1;//phân trang
    $scope.totalPages = 1;//tổng số trang

    $scope.LoadSanPham = function () {	  
        let obj =  {};

        obj.page = $scope.currentPage.toString();//phân trang
        obj.pageSize = $scope.pageSize.toString();//phân trang

        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/SanPham/sanpham-get-all',
        }).then(function (response) {	
            $scope.listSanPham = response.data.data;

            $scope.tongSanPham = response.data.totalItems;

            $scope.totalPages = Math.ceil(response.data.totalItems / $scope.pageSize);
        });
    };  

    $scope.setPage = function (page) {
        if (page < 1 || page > $scope.totalPages) {
            return;
        }
        $scope.currentPage = page;
        if ($scope.currentPage === $scope.totalPages && $scope.listSanPham.length === 0) {
            $scope.currentPage = 1;
        }
        $scope.LoadSanPham();
    };    

    $scope.LoadSanPham();

    /*--------------Chi tiết ảnh sản phẩm---------------------*/
    $scope.DetailCTA = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/SanPham/sanpham-get-by-id/' + id,
        }).then(function (response) {
            let chitietanhsanpham = response.data;
            $scope.listCTAnhSanPham = chitietanhsanpham.listjson_chitietanhsanpham;
            
        });
    } 
    /*--------------Chi tiết thông số kỹ thuật---------------------*/
    $scope.DetailTSKT = function (id){
        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/SanPham/sanpham-get-by-id/' + id,
        }).then(function (response) {
            let thongsokythuat = response.data;
            $scope.listThongSoKyThuat = thongsokythuat.listjson_thongsokythuat;
        });
    } 
/*-============================================================*/
/*-============================================================*/
//Lấy dòng sản phẩm đổ vào ô select
    $scope.listDongSanPham; 
    $scope.LoadDongSanPham = function () {	  
        let obj =  {
            page : "1",
            pageSize : "100" 
        };
        $http({
            method: 'POST', 
            headers: { "Authorization": 'Bearer ' + _user.token },
            data: obj, 
            url: ad_current_url + '/DongSanPham/dongsanpham-get-all',
        }).then(function (response) {	
            $scope.listDongSanPham = response.data.data;
        });
    };  
    $scope.LoadDongSanPham();

/*--------Hiển thị------------------*/
    $scope.Create = function (){
        $scope.btnText = "Thêm";
        $scope.btnTextTSKT = "Thêm TSKT";
        $scope.tenSP = "";
        $scope.anhDaiDien = "";
        $scope.moTa = "";

        $scope.maDSP = "";

        $scope.listThongSoKyThuat = "";
        sessionStorage.removeItem('listjson_thongsokythuat');
        $scope.LoadThongSoKyThuat();
    }

    $scope.Update = function (id){
        $scope.btnText = "Sửa";
        $scope.btnTextTSKT = "Sửa TSKT";
        sessionStorage.removeItem('listjson_thongsokythuat');
        $scope.LoadThongSoKyThuat();

        $http({
            method: 'GET',
            headers: { "Authorization": 'Bearer ' + _user.token },
            url: ad_current_url + '/SanPham/sanpham-get-by-id/' + id,
        }).then(function (response) {
            let sanpham = response.data;
            $scope.maSP = sanpham.maSP;
            $scope.tenSP = sanpham.tenSP;
            $scope.anhDaiDien = sanpham.anhDaiDien;
            $scope.moTa = sanpham.moTa;
            $scope.maDSP = sanpham.maDSP;

            $scope.listThongSoKyThuat = sanpham.listjson_thongsokythuat;

            console.log(sanpham);
            for(var i = 0; i < $scope.listThongSoKyThuat.length; i++)
            {
                //thêm vào session để thao tác
                var list = sessionStorage.getItem('listjson_thongsokythuat'); 
                if (list == null) {
                    list = [$scope.listThongSoKyThuat[i]];
                } else {
                    list = JSON.parse(list) || [];
                    list.push($scope.listThongSoKyThuat[i]);
                }
                sessionStorage.setItem('listjson_thongsokythuat', JSON.stringify(list));
            }
        });
    }

//Hiển thị bảng thông số sản phẩm khi ấn sửa
    $scope.listThongSoKyThuat;
    $scope.LoadThongSoKyThuat = function (){
        $scope.listThongSoKyThuat = [];
        let list = JSON.parse(sessionStorage.getItem('listjson_thongsokythuat'));

        if(list != null){ //tồn tại 1 list
            for(var i = 0; i < list.length; i++) {
                $scope.listThongSoKyThuat.push({
                    tenTS: list[i].tenTS,
                    moTa: list[i].moTa
                })
            }
        }
    }
    $scope.LoadThongSoKyThuat();

//Tạo mới thông số sản phẩm
    $scope.CreateTSKT = function (){
        //tạo đối tượng tskt
        var ThongSoKyThuat = {
            tenTS: $scope.tenTS,
            moTa: $scope.moTaTS
        }
        //tạo sessionStorage
        var list = sessionStorage.getItem('listjson_thongsokythuat');
        if (list == null) { //chưa tồn tại -> thêm vào đầu tiên
            list = [ThongSoKyThuat];
        } else {
            list = JSON.parse(list) || [];
            list.push(ThongSoKyThuat);
        }
        sessionStorage.setItem('listjson_thongsokythuat', JSON.stringify(list));

        $scope.tenTS = '';
        $scope.moTaTS = '';
        $scope.LoadThongSoKyThuat();
    }
//Ấn xóa thông số kỹ thuật
    $scope.DeleteTSKT = function (tenTS){
        var list = JSON.parse(sessionStorage.getItem('listjson_thongsokythuat')) || [];
        for (var i = 0; i < list.length; i++) {
            if(list[i].tenTS == tenTS){
                list.splice(i, 1); //xóa 1 phần tử thứ i
            }
        }
        sessionStorage.setItem('listjson_thongsokythuat', JSON.stringify(list));
        $scope.LoadThongSoKyThuat();
    }


    $scope.CreateUpdate = function () {
        let obj = {};
        obj.maSP = $scope.maSP;
        obj.tenSP = $scope.tenSP;
        obj.moTa = $scope.moTa;
        obj.maDSP = $scope.maDSP;

        obj.listjson_thongsokythuat = $scope.listThongSoKyThuat; //

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
                url: ad_current_url + '/SanPham/file-upload',
            }).then(function (res) {

                obj.anhDaiDien = res.data.filePath;

                if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/SanPham/sanpham-create',
                    }).then(function (response) {
                        $scope.LoadSanPham();
                        alert('Thêm thành công !');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/SanPham/sanpham-update',
                    }).then(function (response) {
                        $scope.LoadSanPham();
                        alert('Cập nhật thành công!');
                    });
                }
            });
        }
        else
        {
            obj.anhDaiDien = $scope.anhDaiDien;

            if($scope.btnText == "Thêm")
                {
                    $http({
                        method: 'POST',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/SanPham/sanpham-create',
                    }).then(function (response) {
                        $scope.LoadSanPham();
                        alert('Thêm thành công!');
                    });
                }
                else
                {
                    $http({
                        method: 'PUT',
                        headers: { "Authorization": 'Bearer ' + _user.token },
                        data: obj,
                        url: ad_current_url + '/SanPham/sanpham-update',
                    }).then(function (response) {
                        $scope.LoadSanPham();
                        alert('Cập nhật thành công!');
                    });
                }
        }
        $("#exampleModalCreateUpdate").modal("hide");
    }


    
    $scope.Delete = function (id) {
        if (confirm("Bạn có chắc chắn muốn xóa không?")) {
            $http({
                method: 'DELETE',                
                headers: { "Authorization": 'Bearer ' + _user.token },
                url: ad_current_url + '/SanPham/sanpham-delete/' + id,
            }).then(function (response) {
                $scope.LoadSanPham();
                alert('Bạn đã xóa thành công!');
            });
        } 
    };
    
});

