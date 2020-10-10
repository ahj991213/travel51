<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/main/header.jsp"%>
<script language="javascript">  // 자바 스크립트 시작

function writeCheck()
  {
   var form = document.writeform;
   
   if( !form.name.value )   // form 에 있는 name 값이 없을 때
   {
    alert( "이름을 적어주세요" ); // 경고창 띄움
    form.name.focus();   // form 에 있는 name 위치로 이동
    return;
   }
   
   if( !form.password.value )
   {
    alert( "비밀번호를 적어주세요" );
    form.password.focus();
    return;
   }
   
  if( !form.title.value )
   {
    alert( "제목을 적어주세요" );
    form.title.focus();
    return;
   }
 
  if( !form.memo.value )
   {
    alert( "내용을 적어주세요" );
    form.memo.focus();
    return;
   }
 
  form.submit();
  }
 </script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<style type="text/css">
#sub1 {
	padding: 11px;
    font-size: 17px;
    width: 80px;
	border: 1px solid #ccc;
	background-color: white;
	border-radius: 0px;
	box-shadow: 1px 1px 3px #585858;
	font-family: 'Cafe24Oneprettynight';
	font-weight: 600;
}
</style>
</head>
<body>
<hr>
	<form name=writeform method=post action="write_ok.jsp" style="width: 70%; margin: auto;">
		<table class="table table-hover">
			<tr>
				<td colspan="2" align="center">글쓰기</td>
			</tr>

			<tr>

				<td align="center">제목</td>
				<td><input name="title" size="50" maxlength="100"
					class="form-control"></td>

			</tr>

			<tr>

				<td align="center">이름</td>
				<td><input name="name" size="50" maxlength="50"
					class="form-control"></td>

			</tr>

			<tr>

				<td align="center">비밀번호</td>
				<td><input type="password" name="password" size="50"
					maxlength="50" class="form-control"></td>

			</tr>


			<tr>

				<td align="center">내용</td>
				<td><textarea name="memo" cols="50" rows="13"
						class="form-control"></textarea></td>

			</tr>

			<tr align="center">
				<td colspan="2">
				<input id="sub1" type=button value="등록" OnClick="javascript:writeCheck();"> 
				<input id="sub1" type=button value="취소" OnClick="javascript:history.back(-1)"></td>
			</tr>
		</table>
	</form>
<hr>
<%@ include file="/main/footer.jsp"%>
</body>
</html>