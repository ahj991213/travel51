<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="board.DAO" />

<%
	int total = dao.count();
ArrayList<VO> alist = dao.getMemberList();
int size = alist.size();
int size2 = size;

final int ROWSIZE = 4;
final int BLOCK = 5;
int indent = 0;

int pg = 1;

if (request.getParameter("pg") != null) {
	pg = Integer.parseInt(request.getParameter("pg"));
}

int end = (pg * ROWSIZE);

int allPage = 0;

int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;

allPage = (int) Math.ceil(total / (double) ROWSIZE);

if (endPage > allPage) {
	endPage = allPage;
}

size2 -= end;
if (size2 < 0) {
	end = size;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/main/header.jsp"%>
<title>게시판</title>
<style>
section {
	max-width: 500px;
}

details {
	background: #f0f0f0;
	padding: 20px;
	margin-bottom: 5px;
}

summary {
	cursor: pointer;
	font-weight: bold;
	font-size: 1.1em;
}
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
<div style="height: 900px; width: 70%; margin: auto;">
	<br>
	<h2>자주하는 질문</h2>
	<hr>
	<details> <summary> 자주하는 질문1 </summary>
	<p>답변</p>
	</details>
	<details> <summary> 자주하는 질문2 </summary>
	<p>답변</p>
	</details>
	<details> <summary> 자주하는 질문3 </summary>
	<p>답변</p>
	</details>
	<hr>
	<br><br>
	<h2>Q&A</h2>
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="table table-hover">
		
		<tr text-align: center;">			
			<td width="73">번호</td>
			<td width="379">제목</td>
			<td width="73">작성자</td>
			<td width="164">작성일</td>
			<td width="58">조회수</td>			
		</tr>
		<%
			if (total == 0) {
		%>
		<tr align="center" style="height: 200px; border-bottom: 1px solid #ddd;" >
			<td colspan="6" style="vertical-align: middle; ">등록된 글이 없습니다.</td>
		</tr>
		<%
			} else {
			for (int i = ROWSIZE * (pg - 1); i < end; i++) {
				VO vo = alist.get(i);
				indent = vo.getIndent();
				int idx = vo.getNum();
		%>
		<tr height="25" align="center">
			<td align="center">&nbsp;</td>
			<td align="center"><%=idx%></td>
			<td align="left">
				<%
					for (int j = 0; j < indent; j++) {
				%> &nbsp;&nbsp;&nbsp;<%
 	}
 if (indent != 0) {
 %><img src='/final/image/reply_icon.gif' />
				<%
					}
				%> <a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=vo.getTitle()%></a>
				<%
					if (vo.isDayNew()) {
				%> <img src='/final/image/new.jpg' /> <%
 	}
 %>
			</td>
			<td align="center"><%=vo.getName()%></td>
			<td align="center"><%=vo.getTime()%></td>
			<td align="center"><%=vo.getHit()%></td>
			<td align="center">&nbsp;</td>
		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>
		<%
			}
		}
		%>
		
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		<tr>
			<td align="center">
				<%
					if (pg > BLOCK) {
				%> [<a href="list.jsp?pg=1">◀◀</a>] [<a
				href="list.jsp?pg=<%=startPage - 1%>">◀</a>] <%
					}
				%> <%
 	for (int i = startPage; i <= endPage; i++) {
 	if (i == pg) {
 %> <u><b>[<%=i%>]
				</b></u> <%
 	} else {
 %> [<a href="list.jsp?pg=<%=i%>"><%=i%></a>] <%
 	}
 }
 %> <%
 	if (endPage < allPage) {
 %> [<a href="list.jsp?pg=<%=endPage + 1%>">▶</a>] [<a
				href="list.jsp?pg=<%=allPage%>">▶▶</a>] <%
 	}
 %>
			</td>
		</tr>
		<tr align="center">
			<td><input id="sub1" type=button value="글쓰기"
				OnClick="window.location='write.jsp'"></td>
		</tr>
	</table>
</div>
<hr>	
<%@ include file="/main/footer.jsp"%>
</body>

</html>