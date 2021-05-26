/**********************************************/
/* write.jsp */
function trans(theform){
	if(theform.name.value == ""){
		alert("이름을 기입하세요");
		theform.name.focus();
		return;
	}
	if(theform.email.value == ""){
		alert("이메일을 기입하세요");
		theform.email.focus();
		return;
	}
	if(theform.homepage.value == ""){
		alert("홈페이지를 기입하세요");
		theform.homepage.focus();
		return;
	}
	if(theform.title.value == ""){
		alert("제목을 기입하세요");
		theform.title.focus();
		return;
	}
	if(theform.content.value == ""){
		alert("내용을 기입하세요");
		theform.content.focus();
		return;
	}
	if(theform.pwd.value == ""){
		alert("암호를 기입하세요");
		theform.pwd.focus();
		return;
	}
	theform.submit();
}
/**********************************************/
/* list.jsp, search.jsp */
function send(theform){
	if(theform.search.value==""){
		alert("검색어를 입력하세요.");
		theform.search.focus();
		return;
	}
	theform.submit();
}
/**********************************************/
/* content.jsp */
function editsend(idx){
	location.href="edit.jsp?idx="+idx;
}
function delsend(idx){
	location.href="del.jsp?idx="+idx;
}