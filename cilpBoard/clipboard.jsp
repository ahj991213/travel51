<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "travel_community.communityDBProcess" %>
<%@ page import = "travel_community.community" %>
<%@ page import = "travel_community.CommentDAO" %>
<%@ page import = "travel_community.mypageDBProcess" %>
<%@ page import = "travel_community.LikeyDTO" %>
<%@ page import = "Clipboard.ClipboardDAO" %>
<%@ page import = "Clipboard.ClipboardDTO" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file ="/main/header.jsp" %>

<link rel="stylesheet" href="/final/css/community_best.css">

<meta charset="UTF-8">

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<title>마이페이지</title>
<style type="text/css">
.my {text-align: center; font-size: 20px;}

#footer_content {
    background-color: #D0CFCF;
    position: relative;
    margin: 0 auto;
    height: 130px;
    top: 200px;
}
</style>
<%
	String id = null;
	if(session.getAttribute("id") != null){
		id = (String) session.getAttribute("id");
	}
%> 
</head>
<body>
<div class="my">	
	<h2>찜한 여행지 목록</h2>
	<hr style="margin: 40px;">
	<hr>
</div>
<div class="btn-group-vertical" role="group" aria-label="..." id="minibar">
	<p><a href="myspace.jsp" id="minibar"><img src="/final/image/big_content.png"><br>큰 화면 보기<br></a></p><hr>
	<p><a href="/final/mypage/mypage.jsp" id="minibar"><img src="/final/image/grid.png"><br>작은 화면 보기</a></p><hr>
	<p><a href="/final/community/communityWrite.jsp" id="minibar"><img src="/final/image/edit.png"><br>글쓰기</a></p><hr>
	<p><a href="#" id="minibar" onclick="$('html, body').stop().animate( { scrollTop : '0' } )"><img src="/final/image/up_arrow.png"><br>상단으로 이동</a></p>
</div>
<div class="h">
	<br>
</div>
<div class="feed" style="height: 300px;">	
<%
		ClipboardDAO ClipboardDBProcess = new ClipboardDAO();
		
		ArrayList<ClipboardDTO> list = ClipboardDBProcess.getClipList(id);   		   		   		
		
		if(list.size()==0){
   	   		%>
   	   			<p id="none" >찜해놓은 여행지가 없습니다.</p>
   	   		<%   			
   	   		} 
   		
   		for(int i=0; i<list.size(); i++){   			   	   			
   		%>   		    
   		    <div id="cmb_img_div" class="col-xs-6 col-md-4">  		    	
	    		<a class="thumbnail">	      		
	      		<img id="cmb_img" src="/final/image/travel_image/<%= list.get(i).getPlaceImage() %>" >	      		
	    		<div>
	    		<a id="text" href="/final/travel/<%= list.get(i).getPlaceName()%>.jsp"><%= list.get(i).getPlaceName()%></a>	    			
	    		</div>
	    		</a>
	    		
	  		</div>
   		       		   
   		<%
   			}
    	%>
</div>
<br>
<%@ include file ="/main/footer.jsp" %>
</body>
</html>