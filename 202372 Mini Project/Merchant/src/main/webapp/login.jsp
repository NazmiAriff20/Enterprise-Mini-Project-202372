<%

	if("POST".equalsIgnoreCase(request.getMethod()) 
			&& request.getParameter("submit") != null){
		%>
			<%@page import="Auth.Authentication"%>  
			<jsp:useBean id="obj" class="Auth.AuthData"/>  	  
			<jsp:setProperty property="*" name="obj"/>  
		<%
		
		boolean status=Authentication.login_validate(obj);
		
		if(status){    
			session.setAttribute("session","TRUE");
			session.setAttribute("Email",obj.getEmail());
			session.setAttribute("success", "Logged In Successfully");
			response.sendRedirect(request.getContextPath()+"/home.jsp");
		}  
		else
		{  
			session.setAttribute("err", "Incorrect Email Or Password");
			response.sendRedirect(request.getContextPath()+"/");
		}
	}else{
		response.sendRedirect(request.getContextPath()+"/");
	}

 %>