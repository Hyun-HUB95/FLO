<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
</head>
<script language="javascript">
	function begin()
	{
		document.myForm.pwd.focus();
	}
	
	function checkIt() {
		if (!document.myForm.pwd.value)
		{
			alert("비밀번호를 입력하지 않았습니다");
			document.myForm.pwd.focus();
			return false;
		}
	}
</script>
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../style.css">

<div class="menu">
        <ul class="menu_contents_left">
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="board.jsp">게시판</a></li>
            <li><a href="Flo_Main.html">보관함</a></li>
            <li><a href="Flo_Main.html">이용권</a></li>
        </ul>
        
         <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass" style="color: #333333;"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp">로그인</a></li>
            
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
    
    <br>
		<br>
<body onload="begin()">
	<form name="myForm" method="post" action="deleteProc.jsp" onsubmit="return checkIt()" id="lastTwo" style="color:#333333;">
		<table width="260" border="1" align="center">
			<tr>
				<td colspan="2" align="center"><b>회원 탈퇴</b></td>
			</tr>
			<tr>
				<td width="150"><b>비밀번호입력</b></td>
				<td width="110"><input type="password" name="pwd" size="15"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="회원탈퇴"
				style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';">
				<input type="button" value="취 소" onclick="javascript:window.location='signIn.jsp'"
				style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';"></td>
			</tr>
		</table>		
	</form>
	
			  <div id="fixed_icons_bar"></div>
			    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>
	
	
</body>
	 <br>
     <hr id="footer_top">

    <footer>
        <div id="first">
            <ul id="first_ul">
                <li>　　　　　　　　　　　고객센터</li>
                <li>　　　　　　　　　　　공지사항</li>
                <li>　　　　　　　　　　　</li>
                <li>　　　　　　　　　　　</li>
            </ul>
        </div>

        <div id="second">
            <ul id="second_ul">
                <li>FLO 서비스</li>
                <li>FLO 크리에이터 스튜디오</li>
                <li>FLO 플레이어 다운로드</li>
                <li>서비스 소개</li>
            </ul>
        </div>

        <div id="third">
            <ul id="third_ul">
                <li>기업 정보</li>
                <li>회사소개</li>
                <li>인재 채용</li>
                <li>　</li>
            </ul>
        </div>

        <div id="fourth">
            <ul id="fourth_ul">
                <li>문의</li>
                <li>마케팅・광고・제휴 문의</li>
                <li>서비스 이용 문의</li>
                <li>음원 유통 문의</li>
            </ul>
        </div>
    </footer>
</html>