<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 만들어 놓은 클래스를 사용하기 위한 -->
<%-- <%@ page import = "travel_community.community" %> --%>
<%@ page import="travel_community.communityDBProcess"%>
<!-- 스크립트문 편하게 사용하기 위한 -->
<%@ page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.*" %>

<!-- 건너오는 데이터를 UTF-8 형태로 받아오기 위한 -->
<% request.setCharacterEncoding("UTF-8"); %>




<!-- 자바빈즈 사용하기 위해, 범위는 현재 페이지에서만 사용하기 위해 -->
<jsp:useBean id="travel_community" class="travel_community.community"
	scope="page" />
<!-- 로그인 페이지 넘긴 userEmail와 userPassword 사용하기 위한 -->
<jsp:setProperty name="travel_community" property="cmTitle" />
<jsp:setProperty name="travel_community" property="cmDetail" />

<%@ page import="java.io.File"%>

<!-- 파일 이름이 동일한게 나오면 자동으로 다른걸로 바꿔주고 그런 행동 해주는것 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!-- 실제로 파일 업로드 하기 위한 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 처리 페이지</title>
</head>
<body>
	<script type="text/javascript">
	var fileCheck = multipartRequest.getOriginalFileName("file");
	if(fileCheck==null){
	    alert("파일을 첨부해 주세요");	  
	    return false;
	}
	
</script>
	<% 
	// 세션을 통해 글쓴 아이디 찾아옴
	String id = null;
	if (session.getAttribute("id") != null){
		id = (String) session.getAttribute("id");
	}
		
	communityDBProcess communityProc = new communityDBProcess();
	
	String cmTitle = travel_community.getCmTitle();
	String cmDetail = travel_community.getCmDetail();
	String cmTag = travel_community.getCmTag();
	
	String userPropliePicture = "user.png";
	int userLikeAmount = 0;
	int userCommentAmount = 0;
	
	// 해당 폴더에 이미지를 저장시킨다
	String uploadDir ="/final/image/community_image";
	//uploadDir = uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"final/WebContent/image/community_image";
	//out.println("절대경로 : " + uploadDir + "<br/>");
			
	// 총 100M 까지 저장 가능하게 함
	int maxSize = 1024 * 1024 * 100;
	String encoding = "UTF-8";
	String uploadPath =request.getSession().getServletContext().getRealPath(uploadDir);
	String dir = application.getRealPath("image/community_image");
	
    //out.println("경로:"+dir +"<br>");

	// 사용자가 전송한 파일정보 토대로 업로드 장소에 파일 업로드 수행할 수 있게 함
	MultipartRequest multipartRequest = new MultipartRequest(request, dir, maxSize, "UTF-8");
			
	// 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일
	// fineName은 사용자가 올린 파일의 이름이다
	if(multipartRequest.getOriginalFileName("file")==null||multipartRequest.getParameter("cmTitle")==null||multipartRequest.getParameter("cmDetail")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>alert('사진을 첨부해 주세요')</script>"); 
		script.println("<script>history.back()</script>"); 
	}	
	else {					
			// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
			String fileName = multipartRequest.getOriginalFileName("file");
			// 실제 서버에 업로드 된 파일시스템 네임
			String fileRealName = multipartRequest.getFilesystemName("file");
			//fileRealName = id + fileRealName;
			
			if(multipartRequest.getParameter("cmTitle") != null){
				cmTitle = multipartRequest.getParameter("cmTitle");
			}

			if(multipartRequest.getParameter("cmDetail") != null){
				cmDetail = multipartRequest.getParameter("cmDetail");
			}
			
			if(multipartRequest.getParameter("cmTag") != null){
				cmTag = multipartRequest.getParameter("cmTag");
			}
					
			int result = communityProc.upload(cmTitle, id, cmDetail,fileName,fileRealName,userPropliePicture,userLikeAmount,userCommentAmount, cmTag);
									
			if( result == -1 ){ // 글쓰기 실패시
				PrintWriter script = response.getWriter();
				script.println("<script>alert('글쓰기에 실패하였습니다')</script>"); 
				script.println("<script>history.back()</script>"); 

			}else { // 글쓰기 성공시
				PrintWriter script = response.getWriter();
				script.println("<script>location.href = '/final/community/community.jsp'</script>");
			}
		}
		
	
	
				
	%>
</body>
</html>