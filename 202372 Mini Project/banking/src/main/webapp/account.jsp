<jsp:include page="header.jsp">
	<jsp:param value="Account" name="Title"/>
</jsp:include>
<%@page import="Auth.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Details</title>
</head>
<body class="bg-dark">
<nav class="navbar bg-light">
  <div class="container-fluid">
    <a class="navbar-brand Brand logo" href="/">
      Online Banking
    </a>
     <a href="logout.jsp" class="text-right pull-right">
                    <i class="fa fa-sign-out-alt fa-2x" title="Logout"></i>
	</a>
  </div>
</nav>
<% 
String msg =(String)session.getAttribute("msg");  
if(msg!=null){  
	out.print(msg);
	session.removeAttribute("msg");
}  
String[] data = Authentication.GetUserData((String) session.getAttribute("AccId")).toArray(new String[0]);
if(data.length < 1){
	session.setAttribute("err", "Please Login First!");
	response.sendRedirect(request.getContextPath()+"/");
	return;
}
 %>  

<div class="container">
	<div class="row">
		<div class="col-3">
			<div class="p-5 bg-light sidenav">
				<div class="profile">
					<img class="profile-img" src="https://ui-avatars.com/api/?rounded=true&size=150&name=<%= data[1] %>"/>
					<h2 class="py-3 text-center"><%= data[1] %></h2>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="mt-5 d-flex justify-content-center align-items-center ">
		        <div class="w-100 p-5 shadow-sm border rounded-4 bg-white">
		        <%= request.getAttribute("Alert") %>
		        <h2 class="text-center mb-4 text-primary">Account Details</h2>
		        	<table id="Account_Table" class="table table-bordered border-primary">
				<tbody>
				<tr>
					<th>Account No</th>
						<td><% out.print(data[0]); %></td>
				</tr>
				<tr>
					<th>Name</th>
						<td><% out.print(data[1]); %></td>
				</tr>
				<tr>
					<th>Email</th>
						<td><% out.print(data[2]); %></td>
				</tr>
				<tr>
					<th>Current Balance</th>
						<td><% out.print(data[3]); %></td>
				</tr>
				<tr>
					<th>Account Created On</th>
						<td><% out.print(data[4]); %></td>
				</tr>
				</tbody>
			</table>
		        </div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>