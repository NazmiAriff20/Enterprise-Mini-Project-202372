<%@page import="Auth.Authentication"%>
<jsp:include page="header.jsp">
        <jsp:param name="Title" value="Login"/>
        <jsp:param value="True" name="NoSessionCheck"/>
</jsp:include>

<%
	if(Authentication.SessionCheck(session)){
		session.setAttribute("msg", "Already Logged In");
		response.sendRedirect(request.getContextPath()+"/account.jsp");
	}
%>

<div class="container">
	<div class="vh-100 d-flex justify-content-center align-items-center ">
            <div class="col-md-5 p-5 shadow-sm border rounded-5 border-primary bg-white">
           <%= request.getAttribute("Alert") %>
                <h2 class="text-center mb-4 text-primary logo">Online Banking</h2>
                <form method="POST" action="login.jsp">
                    <div class="mb-3">
                        <label for="AccountNo" class="form-label">Account No.</label>
                        <input type="number" name="accNo" class="form-control border border-primary" id="AccNo">
                    </div>
                    <div class="mb-3">
                        <label for="PinNo" class="form-label">Pin No.</label>
                        <input type="password" name="pinNo" class="form-control border border-primary" id="PinNo">
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-primary" name="submit" type="submit">Login</button>
                    </div>
                </form>
            </div>
        </div>
</div>
        
<jsp:include page="footer.jsp"/>