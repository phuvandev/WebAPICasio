
//slideshow
var i = 1;
var N = 5;

function next(){
	if(i<N){
		i += 1;
	}
	else
		i = 1;
	document.getElementById("slider").setAttribute("src","cus_images/slide/slideshow"+i+".png")	
}

function autoPlay(){
	setInterval(next,3000)
}


// //Thêm vào sessionStorage
// $(document).ready(function(){
// 	var cart = sessionStorage.getItem("cart");
// 	var order = "["+cart+"]";
// 	var data = JSON.parse(order);
// 	$("#soluong").text(data.length);
					
// 	var content = "";
				
// 	$(".btn-muangay").click(function(){
// 		var soluong = Number(sessionStorage.getItem("soluong"));
// 		if (soluong!=null)
// 			soluong +=1;
// 		else
// 			soluong = 1;
							
// 		$("#soluong").text(soluong);
// 		sessionStorage.setItem("soluong",soluong);

// 		var Img = $(this).parent().find(".anh-sp").attr("src");
// 		var Name = $(this).parent().find(".sp-name").text();
// 		var Price = $(this).parent().find(".sp-new-price").text();
						
// 		var sanpham = {
// 			"anh":Img,
// 			"ten":Name,
// 			"gia":Price,
// 		};
						
// 		var cart = sessionStorage.getItem("cart");
// 		var ds_sanpham = "";
					
// 		if(cart!=null){
// 			ds_sanpham = cart +","+JSON.stringify(sanpham);
// 		}
// 		else{
// 			ds_sanpham = JSON.stringify(sanpham);
// 		}
// 		sessionStorage.setItem("cart", ds_sanpham);	
						
// 		alert("Sản phẩm đã dược thêm vào giỏ hàng");
// 	});
//});

