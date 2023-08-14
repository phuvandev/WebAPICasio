//Kiểm tra đăng nhập----------------------------------------------------------
if (!localStorage.getItem('user')) {
    window.location.replace('ad_login.html');
}

function Logout() {
    localStorage.removeItem("user");
    window.location.replace('ad_login.html');
}