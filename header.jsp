<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Enumeration"%>
<%@page import="Travel.TrDBBean"%>
<%@page import="Travel.TrDBBeanService"%>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여행어디가?</title>
<!--검색창 css 소스-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/common.css">
<style>
.modal-backdrop {
	z-index: -1;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8" />
<!-- 모달창 위에 alert문 띄우기위해 db값 가져오기 -->

<jsp:useBean id="Travel" class="Travel.TrDBData" />
<jsp:setProperty property="*" name="Travel" />
<jsp:useBean id="abc" class="Travel.TrDBBean" />
<!-- 회원가입시 아이디 중복체크 함수  -->

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
	     	//$("#ad1").hide();
	     	$('#myModal').modal('hide');
	     	
	<%
	 	}
		if(session.getAttribute("id") == "admin"){
	%>
			$("#signup_menu").hide();
 			$("#login_menu").hide();
 			$("#dropdown1").show(); 
	     	$("#hello").show(); 
	     	//$("#ad1").show(); 
	<%
	 	}		
	%>
	
	//1. 아이디중복체크
	$('#chkBtn').click(function () {
	    //jQuery에서 선택자역할
	    var idStr = $("#ab_id").val();
	    //console.log("ssssss");
	     $.ajax({
	        url : "../TrDBBean?id="+idStr+"&gubun=idcheck",
	        success : function(data){
	             if(data == "success"){
	                  $("#result").text("사용가능한 아이디입니다.");
	                  $("#result").css('color','black');
	                  
	             }else if(data == "fail"){
	                  $("#result").text("중복된 아이디입니다.");
	                  $("#result").css('color','red');
	             }
	        }
	    });
	});
	//2. 가입하기
	$('#signup').click(function () {
	    //jQuery에서 선택자역할
	    var idStr = $("#ab_id").val();
	    var nameStr = $("#ab_name").val();
	    var passStr = $("#ab_pass").val();
	    var pass1Str = $("#ab_pass1").val();
	    
	    if(idStr == ""){
	    	alert("아이디를 입력해주세요");
	    	$("#ab_id").focus();
	    	return;
	    }else if(nameStr == ""){
	    	alert("이름을 입력해주세요");
	    	$("#ab_name").focus();
	    	return;
	    }else if(passStr == ""){
	    	alert("비밀번호를 입력해주세요");
	    	$("#ab_pass").focus();
	    	return;
	    }else if(pass1Str == ""){
	    	alert("비밀번호 확인을 입력해주세요");
	    	$("#ab_pass1").focus();
	    	return;
	    }
	    
	     $.ajax({
	        url : "../TrDBBean?id="+idStr+"&name="+nameStr+"&pass="+passStr+"&pass1="+pass1Str+"&gubun=signup",
	        success : function(data){
	             if(data == "success"){
	                  alert("회원가입이 완료되었습니다.");
	                  window.location.href = "/final/main/index.jsp"	                  
	              	  $('#myModal').modal('show');
	             }else if(data == "fail"){
	                  alert("회원가입을 실패했습니다.");
	             }
	        }
	    });
	});
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
	                   alert('로그인에 실패하였습니다.');
	                   
	             }else { 	            	
	            	location.reload();
	            	alert("로그인 성공!");	
	            	//로그인 후에 로그인, 회원가입은 숨기고 사람아이콘과 사용자 환영하는 문구 나타내기	                
	            	$("#signup_menu").hide();	            	 
                 	$("#login_menu").hide();
                 	$("#dropdown1").show();                 	
                 	$("#hello").show();
                 	//$("#ad1").show();
                 	$('#myModal').modal('hide');                 	                 	
                 	//window.location.href = "/final/main/index.jsp";                 	        
	   }
	        }
	    });
	});
	
	$('#myModal').on('shown.bs.modal', function () {
 		  $('#myInput').focus()
 		})
	
 		
});

</script>


<style>
.modal-backdrop {
	z-index: -1;
}
</style>


</head>
<body>
	<nav class="navbar navbar-expand-md navbar-dark fixed-top">
	<div id="top" align="center">
		<h3>
			<a href="/final/main/index.jsp">여행 어디가?</a>
		</h3>
		<br>
		<div id="cle">
			<li id="dropdown1">
				<a class="dropdown"> 
					<a id="dropdownMenu1" href="#" role="button" class="dropdown-toggle"data-toggle="dropdown"> 
						<img src="/final/image/user.png" width="30px">
					</a>					  
					<ul id="sub" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						<li role="presentation"><a role="menuitem" tabindex="-1" href="/final/cilpBoard/clipboard.jsp">클립보드</a></li>    
						<li role="presentation"><a role="menuitem" tabindex="-1" href="/final/mypage/mypage.jsp">마이페이지</a></li>						    											    
						<li role="presentation"><a role="menuitem" tabindex="-1" href="/final/board/list.jsp"> Q&A </a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="/final/main/logout.jsp">로그아웃</a></li>
					</ul>
				</a>
			</li>
			<!-- 로그인 모달창 내용 -->
			<div class="modal fade bs-example-modal-sm" id="myModal"
				data-backdrop="static" data-keyboard="false" tabindex="-1"
				role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="staticBackdropLabel">LOGIN</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form method="get" action="/final/members_control.jsp">
								<br>
								<div class="form-group">
									<div class="col-lg-12">
										<label id="label" for="exampleInputEmail1">아이디 (ID)</label> <input
											type="text" name="ab_id" class="form-control" id="id"
											aria-describedby="emailHelp" placeholder="아이디(ID)를 입력하세요.">
									</div>
								</div>

								<br>
								<div class="form-group">
									<div class="col-lg-12">
										<label id="label" for="exampleInputPassword1">비밀번호 (PASSWD)</label> <input
											type="password" name="ab_passwd" class="form-control"
											id="pass" placeholder="비밀번호(PASSWD)를 입력하세요.">
									</div>
								</div>

								<div class="form-group form-check">
									<div style="text-align: left; margin: auto;">
										<input type="checkbox" class="form-check-input"
											id="exampleCheck1"> <label id="label" class="form-check-label"
											for="exampleCheck1">&emsp;아이디 저장</label>
									</div>
								</div>
								<br>
							</form>
						</div>

						<div class="modal-footer">
							<div style="text-align: center; margin: auto;">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">닫기 (Close)</button>
								<button type="submit" class="btn btn-primary" id="login">로그인
									(Login)</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		<ul style="display: inline;">
			<li id="signup_menu" style="display: none"><a
				href="/final/main/signup_Form.jsp">회원가입</a></li>
			<li id="login_menu" style="display: none" data-toggle="modal"
				data-target="#myModal"><a>로그인</a></li>
			<% if(session.getAttribute("id")=="admin"){ %>
				<li id="ad1"><a id="ad1" href="/final/main/signup_Form.jsp">게시판 관리</a></li>
			<%} %>
			<li id="hello"><a><%=session.getAttribute("id")%> 님 환영합니다.</a></li>
		</ul>
		</div>
		<div id="navbarCollapse" class="collapse navbar-collapse">
			<ul id="top_menu">
				<h4 align="center">
					<li><a class="h_menu"href="how/HowTo.jsp">이용방법</a></li>
					<li><a class="c_menu" href="community/community.jsp">커뮤니티</a></li>
					<li><a class="p_menu"href="propensity/propensityTest.jsp">여행취향분석</a></li>
					<li><a class="t_menu"href="travel/travel.jsp">여행지</a></li>
				</h4>
			</ul>
		</div>
	</div>
	</nav>
</body>
</html>