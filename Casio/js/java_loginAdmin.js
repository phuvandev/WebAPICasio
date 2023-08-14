function Login() {		
	var user = {};
    user.taiKhoan = $("#taikhoan").val();
    user.matKhau = $("#matkhau").val();
	console.log(user);

	$.ajax({
		type: "POST",
		url: "https://localhost:44365/NguoiDung/nguoidung-login",
		dataType: "json",
		contentType: 'application/json',
		data: JSON.stringify(user)
	}).done(function (data) {         
		localStorage.setItem("user", JSON.stringify(data));
		alert('Chào mừng bạn đã quay trở lại!')
		window.location.href = "ad_index.html";   
	}).fail(function() {
	  alert('Tài khoản hoặc mật khẩu không chính xác');
	});
};