<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "travel_community.communityDBProcess" %>
<%@ page import = "travel_community.community" %>
<%@ page import = "travel_community.CommentDAO" %>
<%@ page import = "travel_community.LikeyDTO" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="Travel.TrDBBean"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여행어디가</title>

<%@ include file="header.jsp"%>

</head>
<body>
	<div id="demo" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ul class="carousel-indicators">
			<li data-target="#demo" data-slide-to="0" class="active"></li>
			<li data-target="#demo" data-slide-to="1"></li>
			<li data-target="#demo" data-slide-to="2"></li>
		</ul>

		<!-- The slideshow -->
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="/final/image/travelmain.png" alt="Los Angeles">
			</div>

			<div class="carousel-item">
				<img src="/final/image/rr.jpg" alt="Chicago">
			</div>

			<div class="carousel-item">
				<img src="/final/image/rr.jpg" alt="New York">
			</div>
		</div>
		
		<!-- Left and right controls -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
			class="carousel-control-prev-icon"></span>
		</a> <a class="carousel-control-next" href="#demo" data-slide="next">
			<span class="carousel-control-next-icon"></span>
		</a>
	</div>

	<!--main-->
	<br>
	<h1 align="center">Best 여행 후기</h1>
	<div class="container" align="center">
		<%-- <div class="row">
			<%
			communityDBProcess communityDBProcess = new communityDBProcess();
			
	   		ArrayList<community> list = communityDBProcess.getBestList();
	   		
	   		for(int i =0 ;i<3 ;i++){
	   		%>
	   			<div class="col-md-4">
				<br> 
				<a href="/final/community/contentView.jsp?cmNum=<%= list.get(i).getCmNum()%>">
				<img  id="cmb_img" src="/final/image/community_image/<%= list.get(i).getCmFileRealName() %>"
					class="img-thumbnail" style="width:300px; height: 300px;">
				<h2><%= list.get(i).getCmTitle() %></h2>
				<p><%= list.get(i).getCmDetail() %></p>
				</a>
				</div>
	   		
	   		<%
	   		}
			%>			
		</div> --%>
		<br>
		<p align="right">
			<button type="button" class="btn btn-light">더 보기</button>
		</p>
		<hr>
		<!-- 베스트 후기 끝-->

		<!-- 국내인기 여행지 시작-->
		<h1 align="center">국내 인기 여행지</h1>
		<div class="container" align="center">
			<div class="row">
				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 1</h2>
				</div>

				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 2</h2>
				</div>

				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 3</h2>
				</div>

				<br>

				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 4</h2>
				</div>

				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 5</h2>
				</div>

				<div class="col-md-4">
					<br> <img src="/final/image/beach.jpg" alt="..."
						class="img-thumbnail" width="300px" height="300px">
					<h2>Best 6</h2>
				</div>
			</div>
			<br>
			<hr>
		</div>
	</div>

	<%@include file="footer.jsp"%>

</body>
</html>
