function idCheck()
{	// [회원가입] 폼 '아이디'체크.
	// let value = document.signUp.id.value;
	let value = document.signUpForm.id.value;

	if (value === "")
	{
		alert("아이디를 입력해 주세요.");
		document.signUpForm.id.focus();
	} else
	{
		alert("아이디를 이미 입력하였습니다.");3
		url = "idCheck.jsp?id=" + value;
		window.open(url, "post", "width=500, height=300");
	}
}

function zipCheck()
{	// [회원가입] 폼 '주소'체크.
	url = "zipCheck.jsp?check=y";
	// url="idCheck.jsp?id=" + value;
	window.open(url, "post", "width=500, height=300, directories=no, status=yes, scrollbars=yes, menubar=no");
}

function dongCheck()
{	// [회원가입] 폼 '동'체크.
	let value = document.zipForm.dong.value;
	if (value === "")
	{
		alert("동이름을 입력해 주세요.");
		document.zipForm.dong.focus();	// regForm.jsp의 name명. id를 찾을 때는 selectQuery로.
		return;
	}

	document.zipForm.submit();
}

function sendAddress(zipCode, sido, gugun, dong, bunji)
{	// 주소내용을 윈도우창 각 요소에 저장.
	var address = sido + " " + gugun + " " + dong + " " + bunji;
	opener.document.signUpForm.zipCode.value = zipCode;
	opener.document.signUpForm.address1.value = address;
	self.close();
}

function inputCheck() {	// 회원가입 폼 패턴검색.
	if (document.signUpForm.id.value == "") {
		alert("아이디를 입력해 주세요.");
		document.signUpForm.id.focus();
		return;
	}
	if (document.signUpForm.pwd.value == "") {
		alert("비밀번호를 입력해 주세요.");
		document.signUpForm.pwd.focus();
		return;
	}
	if (document.signUpForm.repass.value == "") {
		alert("비밀번호를 확인해 주세요");
		document.signUpForm.repass.focus();
		return;
		
	}
	if (document.signUpForm.pwd.value !=
		document.signUpForm.repass.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.signUpFrom.repass.focus();
		return;
	}
	if (document.signUpForm.name.value == "") {
		alert("이름을 입력해 주세요.");
		document.signUpForm.name.focus();
		return;
	}
	if (document.signUpForm.phone1.value == "") {
		alert("통신사를 입력해 주세요.");
		document.signUpForm.phone1.focus();
		return;
	}
	if (document.signUpForm.phone2.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.signUpForm.phone2.focus();
		return;
	}
	if (document.signUpForm.phone3.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.signUpForm.phone3.focus();
		return;
	}
	if (document.signUpForm.email.value == "") {
			alert("이메일을 입력해 주세요.");
			document.signUpForm.email.focus();
			return;
		}
	//var str=document.regForm.email.value;	   
	//var atPos = str.indexOf('@');
	//var atLastPos = str.lastIndexOf('@');
	//var dotPos = str.indexOf('.'); 
	//var spacePos = str.indexOf(' ');
	//var commaPos = str.indexOf(',');
	//var eMailSize = str.length;
	//if (atPos > 1 && atPos == atLastPos && 
	// dotPos > 3 && spacePos == -1 && commaPos == -1
	//	&& atPos + 1 < dotPos && dotPos + 1 < eMailSize);
	//}else {
	//   alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	//	      document.regForm.email.focus();
	//		  return;
	//}
	if (document.signUpForm.zipCode.value == "") {
		alert("우편번호를 입력해 주세요.");
		document.signUpForm.zipCode.focus();
		return;
	}
	if (document.signUpForm.address1.value == "") {
		alert("주소를 입력해 주세요.");
		document.signUpForm.address1.focus();
		return;
	}
	if (document.signUpForm.address2.value == "") {
		alert("세부주소를 입력해 주세요.");
		document.signUpForm.address2.focus();
		return;
	}
	document.signUpForm.submit();
}

function updateCheck()
{
	if (document.signUpForm.pwd.value == "")
	{
		alert("비밀번호를 입력해 주세요.");
		document.signUpForm.pwd.focus();
		return;
	}
	if (document.signUpForm.repass.value == "")
	{
		alert("비밀번호를 확인해 주세요");
		document.signUpForm.repass.focus();
		return;
	}
	if (document.signUpForm.pwd.value != document.signUpForm.repass.value)
	{
		alert("비밀번호가 일치하지 않습니다.");
		document.signUpForm.repass.focus();
		return;
	}
	if (document.signUpForm.phone1.value == "") {
		alert("통신사를 입력해 주세요.");
		document.signUpForm.phone1.focus();
		return;
	}
	if (document.signUpForm.phone2.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.signUpForm.phone2.focus();
		return;
	}
	if (document.signUpForm.phone3.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.signUpForm.phone3.focus();
		return;
	}
	if (document.signUpForm.email.value == "") {
		alert("이메일을 입력해 주세요.");
		document.signUpForm.email.focus();
		return;
	}
	var str = document.signUpForm.email.value;
	var atPos = str.indexOf('@');
	var atLastPos = str.lastIndexOf('@');
	var dotPos = str.indexOf('.');
	var spacePos = str.indexOf(' ');
	var commaPos = str.indexOf(',');
	var eMailSize = str.length;
	if (atPos > 1 && atPos == atLastPos &&
		dotPos > 3 && spacePos == -1 && commaPos == -1
		&& atPos + 1 < dotPos && dotPos + 1 < eMailSize);
	else {
		alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
		document.signUpForm.email.focus();
		return;

	}
	if (document.signUpForm.zipcode.value == "") {
		alert("우편번호를 입력해 주세요.");
		document.signUpForm.zipcode.focus();
		return;
	}
	if (document.signUpForm.address1.value == "") {
		alert("주소를 입력해 주세요.");
		document.signUpForm.address1.focus();
		return;
	}
	if (document.signUpForm.address2.value == "") {
		alert("세부주소를 입력해 주세요.");
		document.signUpForm.address2.focus();
		return;
	}
	document.signUpForm.submit();
}