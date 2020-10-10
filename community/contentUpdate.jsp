<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "travel_community.community" %>
<%@ page import = "travel_community.communityDBProcess" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file ="/main/header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩 사용하기 위해 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<title>게시글 수정하기 페이지</title>
</head>
<body>
<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String) session.getAttribute("id");
		}
		if (id == null){
			PrintWriter script = response.getWriter();
			
			script.println("<script>alert('로그인을 하고 접근하세요')</script>");
			
			//script.println("<script>location.href = 'login.jsp'</script>"); 
		}

		int cmNum = 0;
		if(request.getParameter("cmNum") != null){
			cmNum = Integer.parseInt(request.getParameter("cmNum"));
		}

		if(cmNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('유효하지 않는 게시물입니다')</script>"); 
			script.println("<script>location.href = 'community_list.jsp'</script>"); 
		}
		community cm = new communityDBProcess().getContent(cmNum);
	%>
<script type="text/javascript">
//이미지 미리보기 스크립트
var InputImage = (function loadImageFile() {
	if (window.FileReader) {
		var ImagePre;
		var ImgReader = new window.FileReader();
		var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i;
		
		ImgReader.onload = function(Event) {
			if (!ImagePre) {
				var newPreview = document.getElementById("imagePreview");
				ImagePre = new Image();					
				ImagePre.style.width = "20%";
				ImagePre.style.height = "20%";
				newPreview.appendChild(ImagePre);
			}
			ImagePre.src = Event.target.result;
		};

		return function() {
			var img = document.getElementById("image").files;
			if (!fileType.test(img[0].type)) {
				alert("이미지 파일을 업로드 하세요");
				return;
			}
			ImgReader.readAsDataURL(img[0]);
		}
	}
	document.getElementById("imagePreview").src = document.getElementById("image").value;

})();	
</script>
<hr>
<form method="post" action="contentUpdateProcess.jsp?cmNum=<%=cmNum%>" enctype="multipart/form-data">
<div class="container">
  <h2>게시판 글 수정하기</h2>          
  <table class="table table-hover">
    <tbody>
        <tr>
        	<!-- 자신의 글을 수정하려면 이전의 값을 보여줘야하기 때매 value에 이전 값을 출력해준다 -->
      		<td><input type="text" class="form-control" placeholder="글 제목" name="cmTitle" maxlength="40" value="<%= cm.getCmTitle() %>"></td>
        </tr>
        
      	<tr>
			<td><input id="image" type="file" onchange="InputImage();" name="file"></td>
		</tr>
		
      	<tr>
      		<td><textarea type="text" class="form-control" placeholder="글 내용을 작성하세요" name="cmDetail" maxlength="1024" style="height: 400px;"><%= cm.getCmDetail() %></textarea></td>
      	</tr>
      	
      	<tr>
      		<td><textarea type="text" class="form-control" placeholder="태그를 작성하세요" name="cmTag" maxlength="1024" style="height: 400px;"><%= cm.getCmTag() %></textarea></td>
      	</tr>
      	
      	<tr>
			<td><div id="imagePreview"></div></td>
		</tr>
    </tbody>
  </table>
  <a id="wb"><button id="wb_b" type="submit"><img id="wb_img" src="/final/image/edit.png">&nbsp;글 수정하기</button></a>
  <!-- <a id="wb"><img id="wb_img" src="/final/image/edit.png"><button id="wb_b" type="submit" value="글수정">&nbsp;글 수정하기</button></a> -->
</div>
</form>
<hr>
<%@ include file ="/main/footer.jsp" %>
</body>
</html>