<%

session.removeAttribute("session");
session.removeAttribute("AccId");
session.setAttribute("success", "Logged Out Successfully");
response.sendRedirect(request.getContextPath()+"/");

%>