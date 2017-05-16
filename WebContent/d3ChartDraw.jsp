<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="js/d3.js"></script>
<script src="js/Chart.js"></script>
<script src="js/jquery-3.1.1.js"></script>
<svg width="960" height="10"></svg>
<script>
/* 	var span = d3.select("body").select("h3").select("span");
	alert("123");
	span.text("hello world").style("font-size", "24px");
	alert("456"); 
*/

	var death_rate = [['越南',24.26],['阿魯巴',17.48],['關島',10.01],['澳門',5.84]];
	var div_data_bind = d3.select("body").selectAll("div").data(death_rate);
	div_set = div_data_bind.enter().append("div");
	div_data_bind.exit().remove();
	div_set.text(function(d,i) {
	  return i + " / " + d[0];
	});
	div_set.style("height", "20px");
	  div_set.style("background", "red");
	  div_set.style("margin", "5px");
	  div_set.style("width", function(d,i) {
	    return (d[1] * 10)+"px";
	  });
</script>

<title>Insert title here</title>
</head>
<body>
	<div>
	</div>
</body>
</html>