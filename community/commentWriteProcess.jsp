<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 만들어 놓은 클래스를 사용하기 위한 -->
<%-- <%@ page import = "travel_community.community" %> --%>

<%@ page import="travel_community.communityDBProcess"%>
<%@ page import="comment.CommentDTO"%>
<!-- 스크립트문 편하게 사용하기 위한 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 건너오는 데이터를 UTF-8 형태로 받아오기 위한 -->
<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 자바빈즈 사용하기 위해, 범위는 현재 페이지에서만 사용하기 위해 -->
<jsp:useBean id="comment" class="comment.CommentDAO" scope="page" />
<!-- 로그인 페이지 넘긴 userEmail와 userPassword 사용하기 위한 -->
<jsp:setProperty name="comment" property="cmNum" />
<jsp:setProperty name="comment" property="userComment" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		
						
		if (session.getAttribute("id") == null) { //로그인 없이 댓글 작성
	%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			history.back();				
		</script>
	<%
		} else {  //로그인 후 댓글 작성
		
		// 세션을 통해 글쓴 아이디 찾아옴
		String id = null;
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		}	
			
		communityDBProcess commentProc = new communityDBProcess();
	
		String userPropliePicture = "user2.png";
		String userComment = comment.getUserComment();
		int cmNum = comment.getCmNum();
	
		if (request.getParameter("userComment") != null) {
			userComment = request.getParameter("userComment");
		}
		if (request.getParameter("cmNum") != null) {
			cmNum = Integer.parseInt(request.getParameter("cmNum"));
		}
	
		int result = commentProc.comment(cmNum, id, userComment);
	
		if (result == -1) { // 글쓰기 실패시
			PrintWriter script = response.getWriter();
			script.println("<script>alert('댓글 작성에 실패하였습니다')</script>");
			script.println("<script>history.back()</script>");
	
		} else { // 글쓰기 성공시
			PrintWriter script = response.getWriter();
			script.println("<script>location.href = '/final/community/community.jsp'</script>");
		}
	}
	%>
</body>
</html>