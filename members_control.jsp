<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.util.ArrayList" %>
 <%@page import = "Travel.TrDBBeanService" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="Travel" class = "Travel.TrDBData"/>
<jsp:setProperty property="*" name="Travel"/>
<jsp:useBean id = "ab" class = "Travel.TrDBBean"/>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	request.setCharacterEncoding("euc-kr");
	String id= request.getParameter("id");
	String pass = request.getParameter("pass");
	
	TrDBBeanService tr = TrDBBeanService.getInstance();
    int check = tr.login(id, pass);

    if(check==1){
    	session.setAttribute("id", id);    	
    	response.sendRedirect("/final/main/index.jsp");
    }
    response.sendRedirect("/final/main/index.jsp");
%>

</body>
</html>