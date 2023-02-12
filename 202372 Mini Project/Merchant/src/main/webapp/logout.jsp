<%

session.removeAttribute("session");
session.removeAttribute("Email");
session.setAttribute("success", "Logged Out Successfully");
response.sendRedirect(request.getContextPath()+"/");

%>