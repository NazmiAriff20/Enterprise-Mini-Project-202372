<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online Banking | <%=request.getParameter("Title") %></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
<link href="style.css" rel="stylesheet">
</head>
<body>
<%	
	if(request.getParameter("NoSessionCheck") == null){
			if(!Auth.Authentication.SessionCheck(session)){
				session.setAttribute("msg", "Please Login First");
				response.sendRedirect(request.getContextPath()+"/");
				return;
			}
	}
	String msg =(String)session.getAttribute("msg");
	String success =(String)session.getAttribute("success");
	String err =(String)session.getAttribute("err");
	String Message = "";
	if(msg!=null && !msg.equals("null")){
		Message = ("<div class=\"alert alert-info text-center\">"+msg+"</div>");
			session.removeAttribute("msg");
	}
	
	if(success!=null && !success.equals("null")){
		Message = ("<div class=\"alert alert-success text-center\">"+success+"</div>");
			session.removeAttribute("success");
	}
					
	if(err!=null && !err.equals("null")){
		Message = ("<div class=\"alert alert-danger text-center\">"+err+"</div>");
			session.removeAttribute("err");
	}
	request.setAttribute("Alert",Message);				
%>
<!-- Header End Body Start -->