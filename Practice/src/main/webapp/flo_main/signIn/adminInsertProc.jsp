<%@page import="com.flo.model.ProductsInsertDAO"%>
<%@page import="com.flo.model.ProductsInsertVO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page
	import="java.io.*,
								javax.servlet.*,
								javax.servlet.http.*,
								java.nio.file.Files,
								java.nio.file.Paths"%>
<%@ page
	import="org.apache.commons.fileupload.*,
								org.apache.commons.fileupload.disk.*,
								org.apache.commons.fileupload.servlet.*,
								org.apache.commons.fileupload.FileItem"%>

<html>
<head>
<title>관리자 상품등록 페이지</title>
</head>
<body>

	<%
	String uploadDirectory = getServletContext().getRealPath("/uploads"); // 웹 접근 가능한 디렉토리
	File uploadDir = new File(uploadDirectory);
	if (!uploadDir.exists()) {
	    uploadDir.mkdirs(); // 디렉토리가 없으면 생성
	}

	// 파일 업로드 처리
	DiskFileItemFactory factory = new DiskFileItemFactory();
	factory.setRepository(new File(uploadDirectory));
	ServletFileUpload upload = new ServletFileUpload(factory);
	factory.setSizeThreshold(1024 * 500);

	try {
	    List<FileItem> formItems = upload.parseRequest(request);
	    String name = null;
	    String description = null;
	    double price = 0;
	    String imageUrl = null;

	    for (FileItem item : formItems) {
	        if (item.isFormField()) {
	            // 일반 입력 필드 처리
	            String fieldName = item.getFieldName();
	            if (fieldName.equals("name")) {
	                name = item.getString();
	            } else if (fieldName.equals("description")) {
	                description = item.getString();
	            } else if (fieldName.equals("price")) {
	                price = Double.parseDouble(item.getString());
	            }
	        } else {
	            // 파일 처리
	            String fileName = item.getName();
	            if (fileName != null && !fileName.isEmpty()) {
	                // 파일 이름 처리
	                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
	                String uniqueFileName = System.currentTimeMillis() + fileExtension;
	                File file = new File(uploadDirectory + File.separator + uniqueFileName);
	                item.write(file); // 파일 저장

	             // 파일 처리 후, DB에 저장할 경로는 단순히 파일 이름만 저장
	                imageUrl = uniqueFileName;  // "uploads/"는 포함하지 않음 // 이미지 URL
	            }
	        }
	    }

	    // DB에 데이터 저장
	    ProductsInsertVO pivo = new ProductsInsertVO();
	    pivo.setName(name);
	    pivo.setDescription(description);
	    pivo.setPrice(price);
	    pivo.setImageUrl(imageUrl); // imageFilePath를 imageUrl로 수정
	    pivo.setCreatedAt(new Timestamp(System.currentTimeMillis()));
	    pivo.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

	    ProductsInsertDAO dao = new ProductsInsertDAO();
	    boolean insertSuccess = dao.insertProducts(pivo);

	    if (insertSuccess) {
	        out.println("<script>");
	        out.println("alert('상품 등록이 완료되었습니다.');");
	        out.println("window.location.href = 'productsList.jsp';"); // 등록 후 목록 페이지로 리다이렉트
	        out.println("</script>");
	    } else {
	        out.println("<script>");
	        out.println("alert('상품 등록이 실패하였습니다. 이전페이지로 돌아갑니다.');");
	        out.println("history.back();"); // 실패 시 이전 페이지로 돌아가기
	        out.println("</script>");
	    }

	} catch (Exception ex) {
	    out.println("<script>");
	    out.println("alert('파일 업로드 중 오류 발생: " + ex.getMessage() + "');");
	    out.println("history.back();"); // 오류 발생 시 이전 페이지로 돌아가기
	    out.println("</script>");
	}

	%>

</body>
</html>
