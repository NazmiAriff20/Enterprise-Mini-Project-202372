/**
 * Modal Update For New Product
 */

 function UpdateModal(that){
	 let currentProduct = $(`#${$(that).data("productid")}`);
	 let ProductName = $(currentProduct).find(".card-title").text();
	 let ProductDescription = $(currentProduct).find(".card-text").text();
	 let ProductPrice = $(currentProduct).find(".price h5").text();
	 $("#Prod_Name").text(ProductName);
	 $("#Prod_Detail").text(ProductDescription);
	 $("#Prod_Price").text(ProductPrice);
	 $("#Prod_Id").val(btoa($(that).data("productid")));
 }
 
 function OTPInput() {
        const inputs = document.querySelectorAll("#otp > *[id]");
        for (let i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener("keydown", function (event) {
                if (event.key === "Backspace") {
                    inputs[i].value = "";
                    if (i !== 0) inputs[i - 1].focus();
                } else {
                    if (i === inputs.length - 1 && inputs[i].value !== "") {
                        return true;
                    } else if (event.keyCode > 47 && event.keyCode < 58) {
                        inputs[i].value = event.key;
                        if (i !== inputs.length - 1) inputs[i + 1].focus();
                        event.preventDefault();
                    } else if (event.keyCode > 64 && event.keyCode < 91) {
                        inputs[i].value = String.fromCharCode(event.keyCode);
                        if (i !== inputs.length - 1) inputs[i + 1].focus();
                        event.preventDefault();
                    }
                }
            });
        }
    }
 
 function HideEmail(email) {
  var hiddenEmail = "";
  for (i = 0; i < email.length; i++) {
    if (i > 2 && i< email.indexOf("@") ) {
      hiddenEmail += "*";
    } else {
      hiddenEmail += email[i];
    }
  }
  return hiddenEmail;
}
 
 $(function(){
	 $("#FRM_CHECKOUT").on("submit",function(event){
		 event.preventDefault();
		 	let Total = 0;
			$("[id='Prod_Price']").each(function(){
			    Total = Total + parseFloat($(this).text())
			});
			$(this).find("#TotalPrice").val(Total);
		 $.ajax({
			 method:"POST",
			 url:"http://localhost:8080/Banking/Api",
			 data:$(this).serialize()+"&Method=CheckOut",
			 beforeSend:function(){
				 $("#CheckoutBTN").addClass("disabled");
				 $("i.loading").css("display","inline-block");
			 },
			 success:function(result){
				 let res = JSON.parse(result);
				 if(res.status == "1"){
					 $("#CheckOutModal").find("input[name='name']").val(res.Name);
					 $("#CheckOutModal").find("input[name='accNo']").val(res.AccNo);
					 $("#CheckOutModal").find("input[name='pinNo']").val(res.PinNo);
					 $("#CheckOutModal").find("input[name='TotalPrice']").val(res.TotalPrice);
					 $("#HiddenEmail").html(HideEmail(res.Email));
					 $("#CheckOutModal").modal("show");
				 }
				 else if(res.status == "-1"){
					 alert("Account No OR Pin Is Incorrect");
				 }
				 else if(res.status == "-2"){
					 alert("Insufficent Balance In Account");
				 }
				 else{
					 alert("There Is Some Error Right Now Please Try Later");
				 }
			 },
			 error:function(err){
				 alert("There Is Some Error Right Now Please Try Later");
			 },
			 complete:function(){
				 $("#CheckoutBTN").removeClass("disabled");
				 $("i.loading").hide();
			 }
		 })
	 });
	 
	 $("#OTP_VERIFY").on("submit",function(event){
		event.preventDefault(); 
		let Otp = "";
		$(this).find("#otp").find("input").each(function(){
		  Otp += $(this).val();
		});
		$("#CheckOutModal").find("input[name='OTP']").val(Otp);
		$.ajax({
			url:"http://localhost:8080/Banking/Api",
			method:"POST",
			data:$(this).serialize()+"&Method=CheckOut",
			beforeSend:function(){
				$(this).find("#submit").addClass("disabled");
				$(this).find("i.loading").css("display","inline-block");
			},
			success:function(result){
				let res = JSON.parse(result);
				if(res.status == "2"){
					 $("#CheckOutModal").modal("hide");
					 $(`<a href="#"></a>`)[0].click();
					 $(".alert-dismissible").remove();
					 $(`<div class="alert alert-dismissible alert-success">Payment Successfull RM ${res.Deduted} Has Been Deducted From Your Account.</div>`).prependTo(".row")
					 setTimeout(function(){
						 window.location = "./home.jsp"
					 },5000)
				 }
				 if(res.status == "0"){
					 alert("Invalid OTP Please Try Again")
				 }
			},
			error:function(err){
				 alert("There Is Some Error Right Now Please Try Later");
				 console.log(err)
			 },
			 complete:function(){
				 $("#CheckoutBTN").removeClass("disabled");
				 $("i.loading").hide();
			 }
		})
	});
	 
    OTPInput();
	 
 })
