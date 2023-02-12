<%

	if("POST".equalsIgnoreCase(request.getMethod()) 
			&& request.getParameter("submit") != null){
		%>
			<%@page import="Auth.Authentication"%>  
			<jsp:useBean id="obj" class="Auth.AuthData"/>  	  
			<jsp:setProperty property="*" name="obj"/>  
		<%
		
		int status = Authentication.Register(obj);
		
		if(status == 1){    
			session.setAttribute("session","TRUE");
			session.setAttribute("AccId",obj.getAccNo());
			session.setAttribute("success", "Registered Successfully Please Login");
			response.sendRedirect(request.getContextPath()+"/");
		}  
		else if(status == 2)
		{  
			session.setAttribute("err", "Account Already Exists");
			session.setAttribute("Form","2");
			response.sendRedirect(request.getContextPath()+"/");
		}else{
			session.setAttribute("err", "There Is Some Error Please Try Again");
			session.setAttribute("Form","2");
			response.sendRedirect(request.getContextPath()+"/");
		}
	}else{
		response.sendRedirect(request.getContextPath()+"/");
	}

 %>