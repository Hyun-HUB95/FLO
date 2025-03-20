<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pass = request.getParameter("pass");
%>

<%
	BoardVO bvo = new BoardVO();
	bvo.setNum(num);
	bvo.setPass(pass);
	
	BoardDAO bdao = BoardDAO.getInstance();
	boolean flag = bdao.deleteDB(bvo);
	if (flag == true)
	{
%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%
	} else
	{
%>
<script language="JavaScript">
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>