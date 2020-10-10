<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "travel_community.community" %>

<!-- 만들어 놓은 클래스를 사용하기 위한 -->
<%@ page import="travel_community.communityDBProcess" %>

<!-- 스크립트문 편하게 사용하기 위한 -->
<%@ page import="java.io.PrintWriter" %>

<!-- 건너오는 데이터를 UTF-8 형태로 받아오기 위한 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 처리 페이지</title>
</head>
<body>
<%
	// 세션을 통해 글쓴 이메일 찾아옴
	String id = null;
	if (session.getAttribute("id") != null){
		id = (String) session.getAttribute("id");
	}

	if(id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>alert('로그인을 하세요')</script>"); 
		//script.println("<script>location.href = 'login.jsp'</script>"); 

	}

	int cmNum = 0;
	if(request.getParameter("cmNum") != null){
		cmNum = Integer.parseInt(request.getParameter("cmNum"));
	}

	if(cmNum == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>alert('유효하지 않는 게시물입니다')</script>"); 
		script.println("<script>location.href = 'community_list.jsp'</script>"); 

	}

	communityDBProcess cmProc = new communityDBProcess();
	
	int result = cmProc.contentDelete(cmNum); // 성공시 0 이상 반환 실패시 -1
	if( result == -1 ){ // 글삭제 실패시
		PrintWriter script = response.getWriter();
		script.println("<script>alert('글 삭제에 실패하였습니다')</script>"); 
		script.println("<script>history.back()</script>"); 

	} else { // 글삭제 성공시
		result = cmProc.commentDelete(cmNum);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('글 삭제에 실패하였습니다')</script>"); 
			script.println("<script>history.back()</script>");
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>history.go(-2)</script>");
		}		
	}
%>

</body>
</html>