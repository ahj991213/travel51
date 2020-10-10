<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "travel_community.communityDBProcess" %>
<%@ page import = "travel_community.community" %>
<%@ page import = "travel_community.CommentDAO" %>
<%@ page import = "travel_community.LikeyDTO" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file ="/main/header.jsp" %>
<link rel="stylesheet" href="/final/css/community.css">

<meta charset="UTF-8">

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<title>커뮤니티</title>
<style type="text/css">

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
	<p><a href="/final/community/community_b.jsp" id="minibar"><img src="/final/image/like.png"><br>좋아요순<br></a></p><hr>
	<p><a href="/final/community/community.jsp" id="minibar"><img src="/final/image/new.png"><br>최신순</a></p><hr>	
</div>

<div class="btn-group-vertical" role="group" aria-label="..." id="minibar">
	<p><a href="#" id="minibar"><img src="/final/image/big_content.png"><br>큰 화면 보기<br></a></p><hr>
	<p><a href="/final/community/community_best.jsp" id="minibar"><img src="/final/image/grid.png"><br>작은 화면 보기</a></p><hr>
	<p><a href="/final/community/communityWrite.jsp" id="minibar"><img src="/final/image/edit.png"><br>글쓰기</a></p><hr>
	<p><a href="#" id="minibar" onclick="$('html, body').stop().animate( { scrollTop : '0' } )"><img src="/final/image/up_arrow.png"><br>상단으로 이동</a></p>
</div>

<!-- <hr style="margin: 0px;"> -->
<hr style="margin-bottom: 15px;">
<div class="row">
        <div class="col-md-4 col-md-offset-3">
            <form action="/final/community/community.jsp" class="search-form">
                <div class="form-group has-feedback">
            		<label for="search" class="sr-only">태그를 검색해주세요</label>
            		<input type="text" class="form-control" name="search" id="search" placeholder="태그를 검색해주세요">
              		<span class="glyphicon glyphicon-search form-control-feedback"></span>
            	</div>
            </form>
        </div>
</div>

<hr style="margin: 0px;">
<br>

		<%
		String search  = request.getParameter("search");
    	communityDBProcess communityDBProcess = new communityDBProcess();
		
   		ArrayList<community> list = communityDBProcess.getList(pageNumber, search);   		
   		ArrayList<CommentDAO> CommentList = null;
   		//ArrayList<LikeyDTO> likeyuser = null;
   		
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
   			CommentList = communityDBProcess.getCommentList(cmNum);     			
   			LikeyDTO likeyuser = communityDBProcess.likeyUser(id,title); 
   			String tag = list.get(i).getCmTag();  			
		%>
   		    <div class="row" >
  				<div class="col-sm-6 col-md-4" id="col">
    				<div class="thumbnail">
						<img id="profile" src="/final/image/<%= list.get(i).getUserPropilePicture() %>" ><a id="user_id"><%= list.get(i).getCmUser() %></a>
    					<div id="cm_img_div"><img id="cm_img" src="/final/image/community_image/<%= list.get(i).getCmFileRealName() %>"></div>
    					<div class="caption">
	        				<p>	
	        					<% 
	        					if(likeyuser==null){
	        					%>	
	        						<a href="/final/community/likey.jsp?cmNum=<%= list.get(i).getCmNum() %>&cmTitle=<%= list.get(i).getCmTitle() %>"><img src="/final/image/heart_empty.png" id="heart"></a>
	        					<%
	        						}
	        					else{
	        						String user = likeyuser.getUserID();
		        					if(user.equals(id)){
		        						%>	
		        						<a href="/final/community/likey.jsp?cmNum=<%= list.get(i).getCmNum() %>&cmTitle=<%= list.get(i).getCmTitle() %>"><img src="/final/image/heart.png" id="heart"></a>
		        						<%
		        					}else{
		        						%>	
		        						<a href="/final/community/likey.jsp?cmNum=<%= list.get(i).getCmNum() %>&cmTitle=<%= list.get(i).getCmTitle() %>"><img src="/final/image/heart_empty.png" id="heart"></a>
		        						<%
		        					}
	        					}	
   								%>
			        			<a><img src="/final/image/comment.png" id="heart"></a>
	        				</p>  
	        				      	
	        				<p id="content"><a id="content_detail"><%= list.get(i).getCmDetail() %></a></p>
	        				<p id="content"><a id="content_tag"><%= list.get(i).getCmTag() %></a></p>
	        				<hr style="margin: 0px;">
	        				<p id="content_info">좋아요  <%=likey_count%>&nbsp; | &nbsp;댓글  <%=comment_count%><a id="content_view" href="/final/community/contentView.jsp?cmNum=<%= list.get(i).getCmNum() %>">상세보기</a></p>	        				
	        				<hr style="margin: 0px;">
	     <%    				 
	        				for(int j=0; j<CommentList.size(); j++){
	     %>
	        					<p id="comment"><%= CommentList.get(j).getUserID() %>&nbsp; | &nbsp;<%= CommentList.get(j).getUserComment() %></p>
	     <%   					
	        				}		        				
	     %>
	        										
    					</div>
    					    	
    					<form method="post" action="/final/community/commentWriteProcess.jsp">
	    				<%if(session.getAttribute("id") == null) {%>
	    					<div id="comment_info_div"><p id="comment_info" >댓글을 작성하기 위해서는 로그인이 필요합니다.</p></div>
	    				<%} else{ %>
	    					<input type="text" name="userComment" id="userComment" class="form-control" placeholder="댓글쓰기">
	    					<input type="hidden" name="cmNum" id="cmNum" value="<%= list.get(i).getCmNum() %>">
	    					<button id="comment_b" type="submit">게시</button>
    					<%} %>
    					</form>    	
    				</div>
  				</div>    
			</div>
			<hr>

   		<%
   		
   		}
    	%>
    	
<%@ include file ="/main/footer.jsp" %>
</body>
</html>	