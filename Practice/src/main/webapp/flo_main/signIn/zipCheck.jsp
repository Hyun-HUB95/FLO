<%@page import="java.util.ArrayList"%>
<%@page import="com.flo.model.ZipCodeDAO"%>
<%@page import="com.flo.model.MemberVO"%>
<%@page import="com.flo.model.ZipCodeVO"%>
<%@page import="com.flo.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 1. 사용자 정보 가져오기. -->
<!-- 2. CRUD. -->
<%
	request.setCharacterEncoding("UTF-8");
	String dong = request.getParameter("dong");
	String check = request.getParameter("check");	// n으로 옴.
	
	ArrayList <ZipCodeVO> zipList = null;
	
	if (check.equals("n") == true)
	{
		// VO 호출.
		ZipCodeVO zvo = new ZipCodeVO();
		zvo.setDong(dong);
		
		// DAO 호출. useBeans로 가져와도 됨.
		ZipCodeDAO zdao = new ZipCodeDAO();
		zipList = zdao.selectZipCode(zvo);
	}
%>

<!-- 3. 화면 설계. -->
<!DOCTYPE html>
<html>
<head>
<title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body bgcolor="#FFFFCC">
	<main>
		<b>우편번호 찾기</b>
		<form name="zipForm" method="post" action="zipCheck.jsp">
			<input type="hidden" name="check" value="n">
			<table>
				<tr>
					<td>동이름 입력 :
					<input name="dong" type="text"> 
					<input type="button" value="검색" onclick="dongCheck()" />
					</td>
				</tr>
			</table>
		</form>
		<table>
<%
	if (check.equals("n"))
	{
%>
<%
	if (zipList.isEmpty())
	{
%>
			<tr>
				<td align="center"><br />검색된 결과가 없습니다.</td>
			</tr>
			<tr>
				<td align="center"><a href="javascript:this.close();">닫기</a></td>
			</tr>
<%
	} else
	{
%>
			<tr>
				<td align="center"><br /> ※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
			</tr>
<%
			for (ZipCodeVO p : zipList)
			{
				String tempZipcode = p.getZipCode();
				String tempSido = p.getSido();
				String tempGugun = p.getGugun();
				String tempDong = p.getDong();
				String tempBunji = p.getBunji();
				if (tempBunji == null)
					tempBunji = " ";
%>
			<tr>
				<td>
<%-- 				<a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>'
,'<%=tempGugun%>','<%=tempDong%>','<%=tempBunji%>')">
						<%=tempZipcode%>&nbsp;<%=tempSido%>&nbsp;<%=tempGugun%> &nbsp;<%=tempDong%>&nbsp;<%=tempBunji%></a><br> --%>
						<a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>','<%=tempGugun%>','<%=tempDong%>','<%=tempBunji%>')">
						<%=p.toString()%></a><br>
<%
				} // end of for
	} // end of zipList.isEmpty() else
%>
<%
 	}	// end of check.equals("n")
%></td>
			</tr>
<!-- 			<tr>
				<td align="center"><a href="javascript:this.close();">닫기</a></td>
			</tr> -->
		</table>
	</main>
</body>
</html>