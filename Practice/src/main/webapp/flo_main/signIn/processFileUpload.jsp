<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	// 1. 사용자가 전송할때 form에 enctype="multipart/form-data"
	// 1. 사용자가 전송할 때 form에 multipartEncode타입이 존재하는지 여부 확인.
	if (FileUpload.isMultipartContent(request))
	{
		// 2. 임시파일 지정.
		String temporaryDir = "D:\\temp";
		
		// 3. MultipartRequest(request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy() 객체와 유사한 기능.
		DiskFileUpload fileUpload = new DiskFileUpload();
		
		// 3.1 위치.
		fileUpload.setRepositoryPath(temporaryDir);
		
		// 3.2 사이즈 최대 1MB까지 업로드 가능.
		fileUpload.setSizeMax(1024 * 1024);
		
		// 3.3 내부 메모리에 들어올 사이즈 한번에 100K정도 메모리에 저장.
		fileUpload.setSizeThreshold(1024 * 100);
		
		// 4. Enumeration files = multiRequest.getFileNames(); FileItem의 리스트.
		// 4. (String)files.nextElement();와 유사함.
		java.util.List fileItemList = fileUpload.parseRequest(request);
		
		for (int i = 0; i < fileItemList.size(); i++)
		{
			// 4.1 해당되는 파일 정보를 가져옴.
			FileItem fileItem = (FileItem) fileItemList.get(i);
			
			// 4.2 formParameter에서 보내온 text, password, checkbox, radiobutton같은 parameter인지 확인.
			// 4.2 폼 파라미터에서 보내온 <input type="file">아닌 요소만을 찾음.
			if (fileItem.isFormField())
			{	// 파일 이외의 파라미터
				out.println("폼 파라미터:");
				out.println(fileItem.getFieldName() + " = " + fileItem.getString() + "<br>");
			} else
			{ // <input type="file"> 파일인 경우
				out.println("파일:");
				out.println(fileItem.getFieldName() + " = " + fileItem.getString() + "(" + fileItem.getSize() + "bytes) <br>");
		if (fileItem.isInMemory())
		{
			// 메모리 or 디스크 중 저장되어있는 장소에 대한 출력. 디스크 -> D:/의 temp.
			out.println("메모리에 저장 <br>");
		} else
		{
			out.println("디스크에 저장 <br>");
		}
	
		// upload위치를 알려줌.
		String filepath = application.getRealPath("upload");
		
		// 업로드한 파일 사이즈가 존재하는 경우(check).
		if (fileItem.getSize() > 0)
		{
			
			// D:\\temp, '\\'의 위치를 찾아주는 것.
			int idx = fileItem.getName().lastIndexOf("\\");
			
			if (idx == -1)
			{
				// '/'의 위치를 찾아주는 것.
				idx = fileItem.getName().lastIndexOf("/");
			}
			
			// String 분할.
			String fileName = fileItem.getName().substring(idx + 1);
			
			try
			{
				// filePath가 무엇인지, String filepath = application.getRealPath("upload"); -> 업로드 위치.
				// upload/img.png파일을 new로 만드는 것.
				File uploadedFile = new File(filepath, fileName);
				
				// D:\\temp\\img.png파일을 -> /jspStudy/upload/img.png로 '임시 파일'을 '직접'옮기는 것.
				fileItem.write(uploadedFile);
			} catch (IOException ex)
			{
				// 예외 처리
			}
		} // 업로드한 파일이 존재하는 경우
			} // 파일인 경우
		} //end of for
	} else
	{	// 1.사용자가 전송할때 form에 enctype="multipart/form-data"
		out.println("인코딩 타입이 multipart/form-data가 아님.");
	}
%>