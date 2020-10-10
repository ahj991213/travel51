<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page import="user.UserDAO"%>
<%@ page import="file.fileDAO"%>
<%@ page import="likey.LikeyDAO"%> --%>
<%@ page import="travel_community.communityDBProcess"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%

	    // 로그인한 유저의 아이디를 가져오기(세션 확인)
		String id = null;
		if(session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		}
		
		if(id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	
		request.setCharacterEncoding("UTF-8");
	    
		// 이전의 파라매터로 보낸 게시판 글제목 가져오기
		int cmNum = 0;
		String cmTitle = null;
		
		if(request.getParameter("cmNum") != null) {
			cmNum = Integer.parseInt(request.getParameter("cmNum"));
		}
		if(request.getParameter("cmTitle") != null) {
			cmTitle = (String) request.getParameter("cmTitle");
		}
	
		//fileDAO file = new fileDAO();
		//LikeyDAO likeyDAO = new LikeyDAO();
		communityDBProcess cmDBProcess = new communityDBProcess();
		
		// userID와 userWriteTtilte을 PK, NN 설정이기때매 중복이 불가
		int result = cmDBProcess.like_upload(id,cmTitle,cmNum);
	
		// 정상적으로 1번 데이터가 들어가면 1이 출력되고
	
		if (result == 1) {
			result = cmDBProcess.like_update(cmNum);
			if (result == 1) { // 1인경우 디비에서 해당 게시물 추천 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");				
				script.println("location.href='/final/community/community.jsp'");
				script.println("</script>");
				script.close();
				//return;
	
			} else {
	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				//return;
			}
			
		} else { // 이미 PK, NN으로 설정되어 중복되면 1 반환이 되지 않음
			result = cmDBProcess.like_delete(cmNum,id);
			if(result == 1){
				result = cmDBProcess.like_update(cmNum);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('좋아요를 취소합니다.');");
					script.println("location.href='/final/community/community.jsp'");
					script.println("</script>");
					script.close();
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류가 발생했습니다.');");
					script.println("history.back();");
					script.println("</script>");
					script.close();
				}
				
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}
	
		}

	%>
</body>
</html>