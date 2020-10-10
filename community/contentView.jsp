<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="travel_community.community" %>
<%@ page import="travel_community.communityDBProcess" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file ="/main/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#th {
	width: 130px;		
}

.container {    
    font-family: 'Cafe24Oneprettynight';
    font-size: 18px;
    }
.h2, h2 {
    font-size: 30px;
    font-weight: bold;
}

.bt{
	border: 1px solid white;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 1px 1px 3px grey;
    font-weight: bold;
}
.bt:hover {
	border: 1px solid #D8D8D8;
	background-color: #FAFAFA;
}
#cm_img{
	width: 50%;
	height: 50%;
}
</style>
</head>
<body>
<hr>		
<%
	String id = null;
	if (session.getAttribute("id") == null){
%>	
	<script>	
	alert("로그인이 필요한 서비스입니다.");
	history.back();
	</script>
<%
	}			
	int cmNum = 0;
	if(request.getParameter("cmNum") != null){
		cmNum = Integer.parseInt(request.getParameter("cmNum"));
	}

	if(cmNum == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>alert('유효하지 않는 게시물입니다')</script>"); 
		script.println("<script>location.href = 'content.jsp'</script>"); 
	}
	community content = new communityDBProcess().getContent(cmNum);
				
	if(session.getAttribute("id") != null){
		id = (String) session.getAttribute("id");
		
	 
%>
<!-- 페이지 1번 새로고침 -->
<script type="text/javascript">
	if (self.name != 'reload') {
    	self.name = 'reload';
    	self.location.reload(true);
	}
	else self.name = '';
</script>

<div class="container">
	<h2>게시물 상세보기</h2>          
	<table class="table table-hover">
    	<tbody>
    		<tr>
		      	<th id="th">글 제목</th>
		      	<!-- 글 제목 악성 스크립트 공격 막기 위해서 -->
		      	<td><%= content.getCmTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      		</tr>
      		
		    <tr>
		      	<th id="th">작성자</th>
		      	<td><%= content.getCmUser() %></td>
		    </tr>
      		
      		<tr>
		      	<th id="th">작성일자</th>
		      	<td><%= content.getCmDate().substring(0, 11) + content.getCmDate().substring(11, 13) + "시 " + content.getCmDate().substring(14, 16) + "분 " %></td>
      		</tr>
      		
     		<tr>
      			<th id="th">글 내용</th>
      			<!-- 출력 시 공백이나 < > 줄바꿈 우리 눈에 보여주기 하기 위해서(html 태그로 인식해서 안되기 때매) -->
        		<td><%= content.getCmDetail().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      		</tr>
      		<tr>
      			<th id="th">태그</th>
      			<!-- 출력 시 공백이나 < > 줄바꿈 우리 눈에 보여주기 하기 위해서(html 태그로 인식해서 안되기 때매) -->
        		<td><%= content.getCmTag().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      		</tr>
      		<tr>
      			<!-- 출력 시 공백이나 < > 줄바꿈 우리 눈에 보여주기 하기 위해서(html 태그로 인식해서 안되기 때매) -->
        		<th id="th">사진</th>
        		<td><div ><img id="cm_img" src="/final/image/community_image/<%=content.getCmFileRealName()%>"></div></td>        		      			
      		</tr>      		
		</tbody>
	</table>
	<!-- 목록으로 돌아가기와 작성자이면 수정할 수 있게 하기 -->
	<a href = "javascript:history.back();" class="bt">이전</a>
	<%
  		if(id != null && id.equals(content.getCmUser())){
	%>
  			<a href="contentUpdate.jsp?cmNum=<%=cmNum %>" class="bt">수정</a>
 			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="contentDeleteProcess.jsp?cmNum=<%=cmNum %>" class="bt">삭제</a>
	<%
		}
	%>
</div>
<hr>
<%
	}
%>
<%@ include file ="/main/footer.jsp" %>	
</body>
</html>