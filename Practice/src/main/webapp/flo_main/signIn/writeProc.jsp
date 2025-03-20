<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 업로드 경로를 절대 경로로 수정
    String uploadPath = "C:/dev/eclipseWorkspace/Practice/src/main/webapp/upload"; // 로컬 절대 경로 설정

    // 2. 업로드 최대 사이즈 설정
    int size = 10 * 1024 * 1024;    // 10MB 허용
    String writer = "";
    String subject = "";
    String email = "";
    String pass = "";   // 비밀번호 값
    String content = "";   // 내용 값
    String filename1 = "";

    try {
        // 3. MultipartRequest 객체를 생성, 업로드 처리
        MultipartRequest multiRequest = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

        // 업로드된 파일의 이름 가져오기
        filename1 = multiRequest.getFilesystemName("filename1");

        // 디버깅: 업로드된 파일 경로 출력
        System.out.println("Uploaded Filename: " + filename1); // 파일 업로드 확인

        // 폼 데이터 가져오기
        writer = multiRequest.getParameter("writer");
        subject = multiRequest.getParameter("subject");
        email = multiRequest.getParameter("email");
        pass = multiRequest.getParameter("pass");
        content = multiRequest.getParameter("content");

        // 파일 경로 생성 (DB에 저장할 경로)
        String contextPath = request.getContextPath(); // Context path를 포함한 경로 설정
        String filePath1 = filename1 != null ? contextPath + "/upload/" + filename1 : "";  // 파일 경로 설정

        // BoardVO 객체에 데이터 설정
        BoardVO bvo = new BoardVO();
        bvo.setWriter(writer);
        bvo.setEmail(email);
        bvo.setPass(pass);
        bvo.setSubject(subject);
        bvo.setContent(content);
        bvo.setFilename1(filePath1);  // 업로드된 파일 경로
        bvo.setRegdate(new Timestamp(System.currentTimeMillis()));
        bvo.setIp(request.getRemoteAddr());

        // BoardDAO 객체를 통해 DB에 저장
        BoardDAO bdao = BoardDAO.getInstance();    // 싱글톤 방식
        boolean flag = bdao.insertDB(bvo);  // DB에 데이터 저장

        // 게시글 등록 성공 시
        if (flag == true) {
            %>
            <script>
                alert("게시글이 등록되었습니다.");
                window.location.href = "board.jsp";  // 게시판 리스트로 이동
            </script>
            <%
        } else {
            %>
            <script>
                alert("게시판 등록 실패.");
                history.go(-1);
            </script>
            <%
        }
    }
    catch (Exception e) {
        e.printStackTrace();
    }
%>
