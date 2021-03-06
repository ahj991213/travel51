<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "travel_community.communityDBProcess" %>
<%@ page import = "travel_community.community" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>커뮤니티</title>

<%@ include file ="/main/header.jsp" %>
<link rel="stylesheet" href="/final/css/community_best.css">
<style type="text/css">

#footer_content {
    background-color: #D0CFCF;
    position: relative;
    margin: 0 auto;
    height: 130px;
    top: 150px;
}

#col {
	transform: scale(1); 
	transition: all 0.3s ease-in-out; 
	padding: 0px;  
	width: 1020px;
    margin: 0px auto;
	}
	
#col:hover {transform: scale(1);}

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
<div class="btn-group-vertical" role="group" aria-label="..." id="minibar" style="right: 82%; top: 360px;">
	<p><a href="/final/community/community_best_b.jsp" id="minibar"><img src="/final/image/like.png"><br>좋아요순<br></a></p><hr>
	<p><a href="/final/community/community_best.jsp" id="minibar"><img src="/final/image/new.png"><br>최신순</a></p><hr>	
</div>

<div class="btn-group-vertical" role="group" aria-label="..." id="minibar">
	<p><a href="/final/community/community.jsp" id="minibar"><img src="/final/image/big_content.png"><br>큰 화면 보기</a></p><hr>
	<p><a href="/final/community/community_best.jsp" id="minibar"><img src="/final/image/grid.png"><br>작은 화면 보기</a></p><hr>
	<p><a href="/final/community/communityWrite.jsp" id="minibar"><img src="/final/image/edit.png"><br>글쓰기</a></p><hr>
	<p><a href="#" id="minibar" onclick="$('html, body').stop().animate( { scrollTop : '0' } )"><img src="/final/image/up_arrow.png"><br>상단으로 이동</a></p>
</div>

<hr style="margin:0px;">

<div class="row" id="search">
	<div class="col-sm-6 col-md-4">   	
		<div class="container h-100">		
			<div class="d-flex justify-content-center h-100">		        
		        <div class="searchbar">
		        <input class="search_input" type="text" name="" placeholder="검색어를 입력하세요.">
		        <a href="#" class="search_icon"><i class="fas fa-search"></i></a>
	        	</div>
			</div>
		</div>
	</div>  
</div>

<hr style="margin-top:0px; margin-bottom: 10px;">
<div class="feed">	
	  	  
<%
    	communityDBProcess communityDBProcess = new communityDBProcess();
   		ArrayList<community> list = communityDBProcess.getBestList(pageNumber);
   		
   		if(list.size()==0){
   	   		%>
   	   			<p id="none">등록된 게시글이 없습니다.</p>
   	   		<%   			
   	   		} 
   		
   		for(int i=0; i<list.size(); i++){
   			int cmNum = list.get(i).getCmNum();
   			String title = list.get(i).getCmTitle();
   			int comment_count = communityDBProcess.comment_count(cmNum);
   			int likey_count = communityDBProcess.likey_count(title);
   			
   		%>   		    
   		    <div id="cmb_img_div" class="col-xs-6 col-md-4">  		    	
	    		<a class="thumbnail" >	      		
	      		<img id="cmb_img" src="/final/image/community_image/<%= list.get(i).getCmFileRealName() %>">	      		
	    		<div>
	    			<a id="text" href="/final/community/contentView.jsp?cmNum=<%= list.get(i).getCmNum()%>">좋아요  <%= likey_count %>&nbsp;  &nbsp;댓글  <%= comment_count %></a>
	    		</div>
	    		</a>
	    		
	  		</div>
   		       		   
   		<%
   			}
    	%>
</div>

</body>
<footer>
<%@ include file ="/main/footer.jsp" %>
</footer>
</html>