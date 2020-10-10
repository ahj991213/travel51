<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@page import = "Travel.TrDBBean" %>
     

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여행어디가?</title>

<%@include file ="header.jsp" %>

<link rel="stylesheet" href="/final/css/signup_Form.css">

</head>
<body>
      <hr>
      <div class="container">
        <div class="py-5 text-center">            
            <img class="d-block mx-auto mb-4 " src="/final/image/signup.png" alt="" width="72" height="72">
            <h2>회원가입</h2>
            <p class="lead">여행어디가에 오신것을 환영합니다.</p>
        </div>

        <div class="col-md-12 order-md-1">
            <h4 class="mb-3">회원정보 입력</h4>
            <!-- <form class="needs-validation" action = "/TrDBBean" method="POST"> -->
			<hr>
				
				<div class="mb-3">
                    <label for="user_name">이름</label> 
                    <input type="text" class="form-control" id="ab_name" placeholder="이름을 입력하세요." required name="user-real-name">
                    
                </div>
                
                <div class="mb-3">
                    <label for="user_id">아이디</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="ab_id" name="user_id" placeholder="아이디를 입력하세요.">
                        <span id="result"></span>
                    </div>
                </div>
                <div class="mb-3">	                
	                <input type = "button" id = "chkBtn" value="중복확인" class="btn btn-default">	             
                </div>
                <div class="mb-3">
                    <label for="password">비밀번호</label> 
                    <input type="password" class="form-control" id="ab_pass" placeholder="비밀번호를 입력하세요">
                    <div class="invalid-feedback">유효한 비밀번호가 필요합니다.</div>
                </div>

				<div class="mb-3">
                    <label for="password">비밀번호 확인</label> 
                    <input type="password" class="form-control" id="ab_pass1" placeholder="비밀번호를 한번 더입력해주세요.">
                    <div class="invalid-feedback">유효한 비밀번호가 필요합니다.</div>
                </div>
                
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" id = "signup">가입하기</button>
                <hr class="mb-4">
				<br><br>
                
            <!-- </form> -->
        </div>

    </div>
      <%@include file ="footer.jsp" %>
</body>
</html>