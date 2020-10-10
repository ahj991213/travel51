<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩 사용하기 위해 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>게시판 글쓰기 페이지</title>
<%@ include file="/main/header.jsp"%>
<style>
th{
	width: 120px;
	text-align: center;
	vertical-align: middle;
}

</style>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") == null) {
	%>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		history.back();		
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		//이미지 미리보기 스크립트
		var InputImage = (function loadImageFile() {
			if (window.FileReader) {
				var ImagePre;
				var ImgReader = new window.FileReader();
				var fileType = /^(?:image\/mp4|image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i;

				ImgReader.onload = function(Event) {
					if (!ImagePre) {
						var newPreview = document
								.getElementById("imagePreview");
						ImagePre = new Image();
						ImagePre.style.width = "20%";
						ImagePre.style.height = "20%";
						newPreview.appendChild(ImagePre);
					}
					ImagePre.src = Event.target.result;
				};

				return function() {
					var img = document.getElementById("image").files;
					/* if (!fileType.test(img[0].type)) {
						alert("이미지 파일을 업로드 하세요");
						return;
					} */
					ImgReader.readAsDataURL(img[0]);
				}
			}
			document.getElementById("imagePreview").src = document
					.getElementById("image").value;

		})();
		
			
	
	
	</script>
	<script type="text/javascript" src="//web.lazygyu.net/storage/simple-editor.js"></script>
	<hr>
	<form method="post" action="communityWriteProcess.jsp"
		enctype="multipart/form-data">
		<div class="container">
			<h2>글쓰기</h2>
			<table class="table table-hover">
				<tbody>
					<tr>
						<th style="line-height: 40px;">제목</th>
						<td><input style="height: 40px;" type="text" id="cmTitle" class="form-control"
							placeholder="글 제목" name="cmTitle" maxlength="40" required="required"></td>
					</tr>
					<tr>
						<th style="line-height: 60px;">사진 첨부</th>
						<td><input id="image" type="file" onchange="InputImage();"
							name="file"><a style="color: red; margin: 6px 0;">사진첨부 필수!</a></td>						
						
					</tr>
					<tr>
						<th style="line-height: 380px;">내용</th>
						<td ><textarea type="text" id="cmDetail" class="form-control"
								placeholder="글 내용을 작성하세요." name="cmDetail" maxlength="1024"
								style="height: 400px;" required="required"></textarea></td>
					</tr>
					<tr>
						<th style="line-height: 60px;">태그</th>
						<td ><textarea type="text" id="cmTag" class="form-control"
								placeholder='"#태그" 를 적어주세요. ex)#좋아요 #여행어디가' name="cmTag" maxlength="1024"
								style="height: 60px;" required="required"></textarea></td>
					</tr>															
					<tr>
						<th style="line-height: 50px;">사진 미리보기</th>
						<td ><div id="imagePreview"></div></td>
					</tr>
					
				</tbody>
			</table>
			
			<br> <input type="submit" class="btn btn-primary pull-right"
				value="글쓰기">
		</div>
	</form>
	<hr>

	<%
		}
	%>

</body>
<%@ include file="/main/footer.jsp"%>
</html>