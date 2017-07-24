<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Home Page</title>
</head>

<body>
	<s:form name="myForm" action="ChartDrawing_line" target="_blank">
		UserName:<input type="text" name="userName"/>
		<br>
		FileName:<input type="text" name="chartNames"/>
		<br>
		<input type="submit" name="submitButton" value="submit"/>
	</s:form>
	<s:a href="https://www.google.com.tw/#q=25.073735,121.54992" target="_blank">G-Map</s:a>
</body>
</html>