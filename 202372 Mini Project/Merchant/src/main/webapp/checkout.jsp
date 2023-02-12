<%@page import="main.*"%>
<%@page import="java.util.Base64"%>
<jsp:include page="header.jsp">
	<jsp:param value="Checkout" name="Title"/>
</jsp:include>

<%
	Product prod = new Product();
	if(request.getParameter("id") != null){
		String ProdId = new String(Base64.getDecoder().decode((String)request.getParameter("id")));
		prod = helper.GetProductById(ProdId);
	}
%>

<div class="container mt-5 mb-5">
<h2 class="logo text-center mb-5" style="font-size:xxx-large;">Checkout</h2>
	<div class="row">
	<div class="col-xs-12 col-md-8 col-sm-8 border-rounded border-primary border border-5 shadow">
	<h2 class="logo text-center mt-4">Your Cart</h2>
	<table class="mt-5 table table-bordered table-responsive">
            <tbody>
            <tr>
            		<th>Name: </th>
            		<td id="Prod_Name"><%= prod.getName() %></td>
            </tr>
            <tr>
            		<th>Detail: </th>
            		<td id="Prod_Detail"><%= prod.getDescription() %></td>
            </tr>
            <tr>
            		<th>Price: </th>
            		<td id="Prod_Price"><%= prod.getPrice() %></td>
            </tr>
            </tbody>
           </table>
           <!-- <h2>Total: <%= prod.getPrice() %></h2>-->
   </div>
   
   	<div class="col-xs-12 col-md-4 col-sm-4 border-rounded border-primary border border-5 shadow">
   	<h2 class="logo text-center mt-4">Payment Info</h2>
	<div class="form mt-3">
	<form id="FRM_CHECKOUT">
         <input type="hidden" name="TotalPrice" id="TotalPrice" required />
         <input type="text" name="name" class="form-control" required="required" placeholder="Account Holder Name"/>
         <input type="number" name="accNo" class="form-control" required="required" placeholder="Account Number"/>
         <input type="password" name="pinNo" class="form-control" placeholder="Pin Number" required="required" />
         <div class="px-5 pay">
         <button id="CheckoutBTN" type="submit" class="btn btn-success btn-block">Proceed <i class="loading fa fa-spinner fa-spin"></i></button></div>
	</form>
                   </div>
   </div>
   
</div>
</div>


<!-- Modal -->
<div class="modal fade" id="CheckOutModal" data-bs-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-right"><i class="fa fa-times close" data-dismiss="modal"></i></div>
                   <div class="mt-4 mx-4">
                   <h3 class="logo text-center mb-4 mt-1">Verify Account</h3>
                      <div class="container height-100 d-flex justify-content-center align-items-center">
					    <div class="position-relative">
					        <div class="card p-2 text-center border-0">
					            <h6>Please enter the one time password <br> to verify your account</h6>
					            <div> <span>A code has been sent to</span> <small id="HiddenEmail"></small> </div>
					            <form id="OTP_VERIFY">
									 <input type="hidden" name="TotalPrice" id="TotalPrice" required />
							         <input type="hidden" name="name" />
							         <input type="hidden" name="accNo" />
							         <input type="hidden" name="pinNo" />
							         <input type="hidden" name="OTP" />
						            <div id="otp" class="inputs d-flex flex-row justify-content-center mt-2">
						            	<input class="m-2 text-center form-control rounded" type="text" id="first" maxlength="1">
						                <input class="m-2 text-center form-control rounded" type="text" id="second" maxlength="1"> 
						                <input class="m-2 text-center form-control rounded" type="text" id="third" maxlength="1">
						                <input class="m-2 text-center form-control rounded" type="text" id="fourth" maxlength="1"> 
						                <input class="m-2 text-center form-control rounded" type="text" id="fifth" maxlength="1">
						                <input class="m-2 text-center form-control rounded" type="text" id="sixth" maxlength="1"> 
						            </div>
					            <div class="mt-4"> <button type="submit" id="submit" class="btn btn-danger px-4 validate">Pay Now <i class="loading fa fa-spinner fa-spin"></i></button> </div>
					            </form>
					        </div>
					    </div>
					</div>
                   </div>
               </div>
            </div>
        </div>
    </div>


<jsp:include page="footer.jsp"/>