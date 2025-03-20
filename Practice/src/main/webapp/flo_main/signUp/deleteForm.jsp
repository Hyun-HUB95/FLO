<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
</head>
<script language="javascript">
	function begin()
	{
		document.myForm.pass.focus();
	}
	
	function checkIt() {
		if (!document.myForm.pass.value)
		{
			alert("비밀번호를 입력하지 않았습니다");
			document.myForm.pass.focus();
			return false;
		}
	}
</script>
<div class="menu">
        <ul class="menu_contents_left">
            <li><a href="/Practice/flo_main/signIn/main.jsp">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="Flo_Main.html">둘러보기</a></li>
            <li><a href="Flo_Main.html">보관함</a></li>
            <li><a href="Flo_Main.html">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp">로그인</a></li>
                        
            <li><a href="/Practice/flo_main/signUp/signUp.jsp">회원가입</a></li>
        </ul>
    </div>
<body onload="begin()">
	<form name="myForm" method="post" action="deleteProc.jsp"
		onsubmit="return checkIt()">
		<table width="260" border="1" align="center">
			<tr>
				<td colspan="2" align="center"><b>회원 탈퇴</b></td>
			</tr>
			<tr>
				<td width="150"><b>비밀번호입력</b></td>
				<td width="110"><input type="password" name="pass" size="15"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="회원탈퇴"> <input type="button" value="취 소"
					onclick="javascript:window.location='signIn.jsp'"></td>
			</tr>
		</table>
	</form>
</body>
</html>