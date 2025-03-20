<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자정보를 가져온다  -->
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
BoardVO vo = new BoardVO();
vo.setNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
%>
<!-- 2.curd  -->
<%
try {
	BoardDAO bdao = BoardDAO.getInstance();
	BoardVO bvo = bdao.selectBoardDB(vo);
  String filePath1 = bvo.getFilename1();  // DB에서 파일 경로 가져오기
  
	int _num = vo.getNum();
	int ref = bvo.getRef();
	int step = bvo.getStep();
	int depth = bvo.getDepth();
	
	
	
	request.setCharacterEncoding("UTF-8");

	// 1. [서버 업로드시 진행 순서.] 업로드 경로 작성.
	String uploadPath = request.getRealPath("upload");

	// 2. 업로드 최대 사이즈 설정.
	int size = 10 * 1024 * 1024;	// 10MB허가.
	String name = "";
	String subject = "";
	String filename1 = "";
	String filename2 = "";
	String origfilename1 = "";
	String origfilename2 = "";
	
	try
	{
		// 3. MultipartRequest 객체를 생성, 매개변수(request, 업로드 위치, 최대 사이즈, encoding, 이름 재정의 정책.)
		MultipartRequest multiRequest = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		name = multiRequest.getParameter("name");
		
		subject = multiRequest.getParameter("subject");
		
		// 4. multiRequest.getFileNames()로 Enumeration을 구함. -> 정책임.
		Enumeration files = multiRequest.getFileNames();
		
		String file1 = (String) files.nextElement();	// String file1 = fileName2

		// 가져올 때는 Enumeration, next 사용.
		// 5. 업로드 후, 서버에 저장된 이름을 가져옴.(테이블에 저장되는 이름임.)
		filename1 = multiRequest.getFilesystemName(file1);
		// 6. '사용자가 지정한' 파일 이름(original)을 가져옴.(테이블에 저장되는 이름.)
		origfilename1 = multiRequest.getOriginalFileName(file1);
		
		String file2 = (String) files.nextElement();	// String file2 = fileName1
		filename2 = multiRequest.getFilesystemName(file2);	// 서버에 저장된 이름.(DefaultFileRenamePolicy()에 의해서 이름이 변경됨. 뒤에 숫자가 붙는 형식으로.)
		origfilename2 = multiRequest.getOriginalFileName(file2);	// coffee_ice.png (사용자가 직접 지정한 이미지의 이름.)
		
		System.out.println(file1);
		System.out.println(file2);
		System.out.println(uploadPath);
	} catch (Exception e)
	{
		e.printStackTrace();
	}
%>

<style>
	.board_content_form
	{
		width: 100%;
		border: none;
		padding: 0;
	}
</style>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../style.css">
<link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<script>
    function showImagePreview() {
        const fileInput = document.getElementById("fileInput");
        const file = fileInput.files[0];
        const imagePreview = document.getElementById("imagePreview");

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    }
</script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="signUp.css">
    <link rel="stylesheet" href="../style.css">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="menu">
        <ul class="menu_contents_left">
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="board.jsp">게시판</a></li>
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
		<form class="board_content_form" method="POST" enctype="multipart/form-data">
			<table width="500" border="1" cellspacing="0" cellpadding="0" id="ct" style="color: #333333;">
				<tr height="30">
					<td align="center" width="125">번호</td>
					<td align="center" width="125" align="center"><%=bvo.getNum()%></td>
					<td align="center" width="125" >조회수</td>
					<td align="center" width="125" align="center"><%=bvo.getReadcount()%></td>
				</tr>
				<tr height="30">
					<td align="center" width="125" >작성자</td>
					<td align="center" width="125" align="center"><%=bvo.getWriter()%></td>
					<td align="center" width="125" >작성일</td>
					<td align="center" width="125" align="center"><%=sdf.format(bvo.getRegdate())%></td>
				</tr>
				<tr height="30">
					<td align="center" width="125" >제목</td>
					<td align="center" width="375" align="center" colspan="3"><%=bvo.getSubject()%></td>
				</tr>
				<tr>
					<td align="center" width="125" >내용</td>
					<td align="left" width="375" height="400" colspan="3"><pre><%=bvo.getContent()%></pre></td>
				</tr>
				<tr height="30">
					<td colspan="4"  align="right">
					<input
						type="button"
						value="수정"
						onclick="document.location.href='updateForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'"
						style="background:none;
									border: 1px solid #333333;
									border-radius: 5px;
									cursor: pointer;
									padding: 3px;
									margin: 3px"
						onmouseover="this.style.backgroundColor='#f0f0f0';"
    				onmouseout="this.style.backgroundColor='transparent';">
						&nbsp;
					<input 
						type="button"
						value="삭제"
						onclick="document.location.href='BdeleteForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'"
						style="background:none;
									border: 1px solid #333333;
									border-radius: 5px;
									cursor: pointer;
									padding: 3px;
									margin: 3px"
						onmouseover="this.style.backgroundColor='#f0f0f0';"
    				onmouseout="this.style.backgroundColor='transparent';">
						&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;
						
<% 
    // 업로드된 파일이 있으면 이미지 출력
    if (filePath1 != null && !filePath1.isEmpty()) {
        // 웹에서 접근 가능한 경로로 이미지 URL 설정
        String imageUrl = request.getContextPath() + "/upload/" + filePath1;
        // 파일명만 추출 (파일명만 표시하고 싶을 경우)
        String fileName = filePath1.substring(filePath1.lastIndexOf("/") + 1);
%>
    <!-- 업로드된 이미지가 있을 경우 이미지 표시 -->
    <!-- <img src="<%= imageUrl %>" alt="게시글 이미지" style="width:100px; height:100px; margin-left: 10px;" /> -->
    <!-- '이미지 보기' 링크를 파일명으로 설정 -->
    <a href="<%= imageUrl %>" target="_blank"><%= fileName %></a>
<%
    } else {
%>
    <!-- 이미지가 없는 경우 (없으면 텍스트 표시 또는 빈 이미지 아이콘 등) -->
    <span>이미지 없음</span>
<%
    }
%>




						
		<form name="filecheck" action="fileCheck.jsp" method="post">
			<input type="hidden" name="filename1" value="<%=filename1%>">
			<input type="hidden" name="origfilename1" value="<%=origfilename1%>">
		</form>
				
<%-- 						<a href="#" onclick="javascript:filecheck.submit()">업로드 확인 및 다운로드 페이지 이동</a>	
<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- 수정<1> -->
						 <input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&step=<%=step%>&depth=<%=depth%>'">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'"> --%>
			
					</td>
				</tr>
			</table>
		<!-- 수정<1> -->
		<div style="text-align: right; margin-right: 450px">
			<input
				type="button"
				value="답글쓰기"
				onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&step=<%=step%>&depth=<%=depth%>'"
				style="background:none;
									border: 1px solid #333333;
									border-radius: 5px;
									cursor: pointer;
									padding: 3px;
									margin: 3px"
						onmouseover="this.style.backgroundColor='#f0f0f0';"
    				onmouseout="this.style.backgroundColor='transparent';">
					&nbsp;
			<input
				type="button"
				value="글목록"
				onclick="document.location.href='board.jsp?pageNum=<%=pageNum%>'"
				style="background:none;
									border: 1px solid #333333;
									border-radius: 5px;
									cursor: pointer;
									padding: 3px;
									margin: 3px"
						onmouseover="this.style.backgroundColor='#f0f0f0';"
    				onmouseout="this.style.backgroundColor='transparent';">
		</div>

		<div id="fixed_icons_bar"></div>
    
    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>
			<%
			} catch (Exception e) {
			}
			%>
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