<%@page import="com.flo.model.AdminVO"%>
<%@page import="com.flo.model.AdminDAO"%>
<%@page import="com.flo.model.MemberVO"%>
<%@page import="com.flo.model.MemberDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="MemberDAO" class="com.flo.model.MemberDAO" />

<!-- 1. 사용자 정보 가져오기. -->
<!-- 2. CRUD. -->
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
		
	MemberDAO mdao = new MemberDAO();
	
	MemberVO mvo = new MemberVO();
	mvo.setId(id);
	mvo.setPwd(pwd);
	
	// int check = dao.loginCheck(id, pass);
	int check = mdao.loginCheck(mvo);
	
	request.setCharacterEncoding("UTF-8");
	String id2 = request.getParameter("id");
	String pwd2 = request.getParameter("pwd");
		
	AdminDAO adao = new AdminDAO();
	
	AdminVO avo = new AdminVO();
	avo.setId(id);
	avo.setPwd(pwd);
	
	// int check = dao.loginCheck(id, pass);
	int check2 = adao.adminLoginCheck(avo);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[FLO]SIGN IN</title>
</head>
<body>

</body>
</html>



<!-- 3. 화면 설계. -->
<%-- <%
	if (check == 1)
	{	// 로그인 성공시.
		// session.setAttribute("loginID", id);
		session.setAttribute("id", id);
		response.sendRedirect("login.jsp");
	} else if (check == 0)
	{	// 비밀번호 오기재시.
%> --%>

<%
	if (check == 1)
	{	// 로그인 성공시.
		// session.setAttribute("loginID", id);
		session.setAttribute("id", id);
		session.setAttribute("pwd", pwd);
		response.sendRedirect("signIn.jsp");
	} else if (check == 0)
	{	// 비밀번호 오기재시.
%>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.go(-1);
	</script>
<%
	} else
	{	// 아이디 오기재시.
%>
	<script>
		alert("없는 아이디 입니다.");
		history.go(-1);
	</script>
<%
	}
%>
<%
if (check2 == 1)
{
	session.setAttribute("id", id);
	session.setAttribute("pwd", pwd);
	response.sendRedirect("signIn.jsp");
} else if (check2 == 0)
{	// 비밀번호 오기재시.
%>
<script>
	alert("비밀번호가 일치하지 않습니다.");
	history.go(-1);
</script>
<%
} else
{	// 아이디 오기재시.
%>
<script>
	alert("없는 아이디 입니다.");
	history.go(-1);
</script>
<%
}
%>