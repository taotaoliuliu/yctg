<%@page contentType="text/html;charset=GBK"%>
<%@page import = "java.io.*"%>
<%@page import = "java.util.*"%>

<%

//	UserInfo user=(UserInfo)request.getSession().getAttribute("user");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<title>远程投稿管理系统</title>
</head>
<script language="JavaScript1.2">
<!--

top.window.moveTo(0,0);
if (document.all) {
	top.window.resizeTo(screen.availWidth,screen.availHeight);
}
else if (document.layers||document.getElementById) {
	if (top.window.outerHeight < screen.availHeight||top.window.outerWidth < screen.availWidth){
		top.window.outerHeight = screen.availHeight;
	top.window.outerWidth = screen.availWidth;
	}
}
//-->
</script>
<frameset rows="33,*" framespacing="0" frameborder="0" border="0" cols="*">
 <frame name="uniTitle" scrolling="no" src="<%=basePath %>main_top.jsp" scrolling="no"> 
    <frameset id="frmset" name="frmset" cols="*" framespacing="0" border="0" frameborder="NO" rows="*"> 
      <frame name="uniMain" src="<%=basePath %>userAction_home.action" scrolling="auto">
  </frameset>

  <noframes> 
  <body>
  <p>此网页使用了框架，但您的浏览器不支持框架。</p>
  </body>
  </noframes> 
  
</frameset>
</html>
