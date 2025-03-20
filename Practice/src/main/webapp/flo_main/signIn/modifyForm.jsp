<%@page import="com.flo.model.MemberDAO"%>
<%@page import="com.flo.model.MemberVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.*"%>

<jsp:useBean id="dao" class="com.flo.model.MemberDAO" />

<!DOCTYPE html>
<html>
<head>
<title>Update Form</title>

<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../style.css">


<script language="javascript" src="script.js"></script>
<%-- <script language="javascript" src="script.js" <% System.currentTimeMillis(); %>></script> --%>
</head>
<%
	/* String loginID = (String) session.getAttribute("loginID");
	StudentVO svo = dao.getMember(loginID); */
	
	String id = (String) session.getAttribute("id");
	MemberVO mvo = dao.getMember(id);
	
/* 	String id = (String) session.getAttribute("id");
	String pass = (String) session.getAttribute("pass");
	StudentVO svo = new StudentVO();
	svo.setId(id);
	StudentDAO sdao = new StudentDAO ();
	svo = sdao.getMember(svo); */
%>

<div class="menu">
        <ul class="menu_contents_left">
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="writeForm.jsp">게시판</a></li>
            <li><a href="EproductsCart.jsp">Cart</a></li>
            <li><a href="EproductsForm.jsp">이용권</a></li>
        </ul>
        
         <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass" style="color: #333333;"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
<%if (id == null) {%>
            <li><a href="signIn.jsp">로그인</a></li>
            <%} else{ %>
            <li><a href="signIn.jsp"><font size="2.5pt"><%=id %>님, 환영합니다.</font></a></li>
            <%} %>
            
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
    
    <br>
		<br>

<body>
		<form name="signUpForm" method="post" action="modifyProc.jsp" id="lastOne" style="color:#333333;">
			<table border="1" align="center" class="lastOne">
				<tr>
					<td colspan="2" align="center">회원 수정 정보 입력</td>
				</tr>
				<tr>
					<td align="right">아이디 </td>
					<td><%=mvo.getId()%></td>
				</tr>
				<tr>
					<td align="right">패스워드 </td>
					<td><input type="password" name="pwd"
						value="<%=mvo.getPwd()%>" /></td>
				</tr>
				<tr>
					<td align="right">패스워드 확인</td>
					<td><input type="password" name="repass"
						value="<%=mvo.getPwd()%>" /></td>
				</tr>
				<tr>
					<td align="right">이름 </td>
					<td><%=mvo.getName()%></td>
				</tr>
				<tr>
					<td align="right">전화번호 </td>
					<td><input type="text" name="phone1" size="4"
						value="<%=mvo.getPhone1()%>" /> - <input type="text" name="phone2"
						size="5" value="<%=mvo.getPhone2()%>" /> - <input type="text"
						name="phone3" size="5" value="<%=mvo.getPhone3()%>" /></td>
				</tr>
				<tr>
					<td align="right">이메일 </td>
					<td><input type="text" name="email" value="<%=mvo.getEmail()%>" /></td>
				</tr>
				<tr>
					<td align="right">우편번호 </td>
					<td><input type="text" name="zipCode"
						value="<%=mvo.getZipCode()%>" /> <input type="button" value="찾기"
						onClick="zipCheck()" 
						style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';"/></td>
				</tr>
				<tr>
					<td align="right">주소1 </td>
					<td><input type="text" name="address1" size="50"
						value="<%=mvo.getAddress1()%>" /></td>
				</tr>
				<tr>
					<td align="right">주소2 </td>
					<td><input type="text" name="address2" size="30"
						value="<%=mvo.getAddress2()%>" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="button"value="정보수정" onClick="updateCheck()"
					style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';"/>
						&nbsp;&nbsp;
					<input type="button" value="취소" 	onClick="javascript:window.location='signIn.jsp'"
					style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';"/>
					</td>
				</tr>
			</table>
			    <div id="fixed_icons_bar"></div>
			    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>
			
		</form>
		
		<br>
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
		
</body>
</html>