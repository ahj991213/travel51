<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="travel_community.communityDBProcess"%>
<%@ page import="travel_community.community"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/main/header.jsp"%>
<link rel="stylesheet" href="/final/css/common.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩 사용하기 위해 -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

<title>게시판 페이지</title>
<script type="text/javascript">
$( document ).ready(function() {	
	
	//세션 값이 없을 경우
	<%
 		if(session.getAttribute("id") == null){
	%>
	 		$("#signup_menu").show(); 
	     	$("#login_menu").show();
	     	$("#dropdown1").hide();
	     	$("#hello").hide();
	     	$('#myModal').modal('hide');
	     	
	<%
	 	}
	%>
	
	//3. 로그인
	$('#login').click(function () {
	    //jQuery에서 선택자역할
	    
	    var idStr = $("#id").val();
	    var passStr = $("#pass").val();
	    
	    if(idStr == ""){
	    	alert("아이디를 입력해주세요");
	    	$("#id").focus();
	    	return;
	    }else if(passStr == ""){
	    	alert("비밀번호를 입력해주세요");
	    	$("#pass").focus();
	    	return;
	    }
	    
	     $.ajax({
	    	type : "POST",
	    	url : "../TrDBBean?id="+idStr+"&pass="+passStr+"&gubun=login",
	        success : function(data){
	             if(data == "loginFail"){	            	  
	                   alert('로그인에 실패하였습니다.')
	                  
	             }else { 
	            	location.reload();
	            	alert("로그인 성공!");	
	            	//로그인 후에 로그인, 회원가입은 숨기고 사람아이콘과 사용자 환영하는 문구 나타내기
	                $("#signup_menu").hide(); 
                 	$("#login_menu").hide();
                 	$("#dropdown1").show();
                 	$("#hello").show();
                 	$('#myModal').modal('hide');
                 	
                 	//window.location.href = "/final/index.jsp";
           	
                 	
	             }
	        }
	    });
	});
	
	/* $('#myModal').on('shown.bs.modal', function () {
 		  $('#myInput').focus()
 		}) */
 	
});
</script>
<!-- 링크를 달때쓰는 태그들을 검은색으로 만들고 밑줄이 그어지지 않게 스타일 설정 -->
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
.container {
    width: 1170px;
    font-family: 'Cafe24Oneprettynight';
    font-weight: bold;
}
</style>

</head>
<body>

	<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String) session.getAttribute("id");
		}

		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<hr>
	<div class="container">
		<h2>게시판</h2>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<!-- db에서 실제적으로 게시물 데이터 뽑아오기 위한 -->
				<%
    	communityDBProcess communityDBProcess = new communityDBProcess();
   		ArrayList<community> list = communityDBProcess.getList(pageNumber);
   		for(int i=0; i<list.size(); i++){		
   		%>
				<tr>
					<td><%= list.get(i).getCmNum() %></td>
					<td><a href="contentView.jsp?cmNum=<%= list.get(i).getCmNum() %>"><%= list.get(i).getCmTitle() %></a></td>
					<td><%= list.get(i).getCmUser() %></td>
					<td><%= list.get(i).getCmDate().substring(0, 11) + list.get(i).getCmDate().substring(11, 13) + "시 " + list.get(i).getCmDate().substring(14, 16) + "분 " %></td>
				</tr>

				<%
   			}
    	%>
			</tbody>
		</table>
		<% 
  	if(pageNumber != 1){
  %>
		<a href="comminuty_list.jsp?pageNumber=<%=pageNumber -1 %>"
			class="btn btn-success btn-arraw-left">이전</a>
		<%

    // 다음 페이지가 존재한다면
  	} if(communityDBProcess.nextPage(pageNumber + 1)) {
  %>
		<a href="comminuty_list.jsp?pageNumber=<%=pageNumber +1 %>"
			class="btn btn-success btn-arraw-left">다음</a>
		<%
  	}
  %>
		<a href="communityWrite.jsp" id="wb"><img id="wb_img"
			src="/final/image/edit.png">&nbsp; 글쓰기</a>
	</div>
	<hr>
	<%@ include file="/main/footer.jsp"%>
</body>

</html>