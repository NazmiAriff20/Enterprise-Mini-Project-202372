<%@page import="java.util.List"%>
<%@page import="main.helper"%>
<%@ page import="main.Product" %>

<jsp:include page="header.jsp">
	<jsp:param value="Home" name="Title"/>
</jsp:include>


<!-- Modal -->
<div class="modal fade" id="CheckOutModal" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-right"><i class="fa fa-times close" data-dismiss="modal"></i></div>
                   <div class="mt-4 mx-4">
                   <h3 class="logo text-center mb-4 mt-1">Buy Now</h3>
                       <table class="table table-bordered table-responsive">
	                       <tbody>
	                       <tr>
	                       		<th>Name: </th>
	                       		<td id="Prod_Name"></td>
	                       </tr>
	                       <tr>
	                       		<th>Detail: </th>
	                       		<td id="Prod_Detail"></td>
	                       </tr>
	                       <tr>
	                       		<th>Price: </th>
	                       		<td id="Prod_Price"></td>
	                       </tr>
	                       </tbody>
                       </table>
                       	   <form action="checkout.jsp">
                           		<input type="hidden" name="id" id="Prod_Id">
                           		<div class="px-5 pay"><button class="btn btn-success btn-block">Checkout</button></div>
                           </form>
                   </div>
               </div>
            </div>
        </div>
    </div>



<div class="container">
<h1 style="font-size:xxx-large;" class="text-center logo mt-5">Products</h1>
  <div class="row">
  
<% 
try{
 List<Product> products = helper.GetProducts();
 if(products.size() > 0)
  for (final Product prod : products) {
%>
	 <div class="mt-5 col-12 col-sm-8 col-md-6 col-lg-4">
      <div id="<%= prod.getId() %>" class="card">
        <img class="card-img" src="https://via.placeholder.com/350x250" alt="Vans">
        <div class="card-body">
          <h4 class="card-title"><%= prod.getName() %></h4>
          <p class="card-text"><%= prod.getDescription() %></p>
          <div class="buy d-flex justify-content-between align-items-center">
            <div class="price text-success"><h5 class="mt-4"><%= prod.getPrice() %></h5></div>
             <button data-productId="<%= prod.getId() %>" data-toggle="modal" onClick="UpdateModal(this)" data-target="#CheckOutModal" class="btn btn-danger mt-3"><i class="fas fa-shopping-cart"></i> Buy Now</button>
          </div>
        </div>
      </div>
    </div>	      
<%
	}
}catch(Exception e){}
%>
    
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>