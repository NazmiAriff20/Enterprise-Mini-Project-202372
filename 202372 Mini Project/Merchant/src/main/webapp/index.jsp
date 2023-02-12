<jsp:include page="header.jsp">
	<jsp:param value="Login - SignUp" name="Title"/>
	<jsp:param value="True" name="NoSessionCheck"/>
	<jsp:param value="True" name="HideHeader"/>
</jsp:include>

<% 
	if(Auth.Authentication.SessionCheck(session)){
		session.setAttribute("msg", "Already Logged In");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}
	String Form = (String) session.getAttribute("Form");
	session.removeAttribute("Form");
%>

<div class="d-flex justify-content-center align-items-center mt-5">

    <div class="card login_card shadow p-3 mb-5 bg-white rounded border-primary">

        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item text-center">
              <a class="nav-link <%= Form != "2" ? "active" : "" %> btl" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Login</a>
            </li>
            <li class="nav-item text-center">
              <a class="nav-link <%= Form == "2" ? "active" : "" %> btr" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Signup</a>
            </li>
            
          </ul>
          <div class="tab-content" id="pills-tabContent">
          <%= request.getAttribute("Alert") %>
            <div class="tab-pane fade <%= Form != "2" ? "active show" : "" %>" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
              
              <div class="form px-4 pt-3">
				<h2 class="text-center pb-3 logo">Merchant App</h2>
				<form method="POST" action="login.jsp">
                	<input required type="email" name="email" class="form-control" placeholder="Email">

                	<input required type="password" name="password" class="form-control" placeholder="Password">
                	<button name="submit" class="btn btn-dark btn-block">Login</button>
				</form>
              </div>



            </div>
            <div class="tab-pane fade <%= Form == "2" ? "active show" : "" %>" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
              

              <div class="form px-3 pt-3">
				
				<h2 class="text-center pb-3 logo">Merchant App</h2>
				
				<form method="POST" action="register.jsp">
				
	                <input required type="text" name="name" class="form-control" placeholder="Name">
	
	                <input required type="email" name="email" class="form-control" placeholder="Email">
	
	                
	                <input required type="number" name="accNo" class="form-control" placeholder="Account Number">

	                <input required type="password" name="password" class="form-control" placeholder="Password">
	
	                <button name="submit" class="btn btn-dark btn-block">Signup</button>
                
                </form>
                
              </div>

            </div>
            
            </div>

    </div>
    

</div>
<jsp:include page="footer.jsp"></jsp:include>