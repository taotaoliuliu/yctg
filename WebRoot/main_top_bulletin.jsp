<%@ page contentType="text/html;charset=gb2312"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>中国气象报远程投稿管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />

</head>
<script language="javascript">
function changePasswd()
{
	changePassWin = window.open("userAction_changePassword.action","changePasswdWin","width=400,height=250,resizable=no,menubar=no,scrollbars=no,toolbar=no,menubar=no,location=no");
	//changePassWin();
}

function openwin() 
{
	window.open("bulletinAction_show.action", "", "height=300, width=400, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}
</script>

<body bgcolor="#5F72A5" text="#000000" leftmargin="0" topmargin="0" onmouseover="self.status='欢迎进入远程投稿管理系统';return true" ondragstart="window.event.returnValue=false" oncontextmenu="window.event.returnValue=false" onselectstart="event.returnValue=false" onload="openwin()">
<TABLE height=33 cellSpacing=0 cellPadding=0 width="100%" bgColor=#5f72a5 
border=0>
  <TBODY>
  <TR>
    <TD width=300 align="left" vAlign=center background="jsp/images/top.jpg">&nbsp;<FONT 
      color=#ffffff><B><span class="style2">中国气象报远程投稿管理系统(${sessionScope.versin })<B></span></FONT><span class="style2"></B></B></span></TD>
    <TD align=right vAlign=bottom background="jsp/images/top.jpg">
      <TABLE height=28 cellSpacing=0 cellPadding=0 width=650 align=right 
      border=0>
        <TBODY>
        <TR>
          <TD align="right" valign="middle"><span class="style1"><FONT color=white>用户：${user.name_real }  </FONT></span></TD>
         <TD align=right width="20" ></TD>
          <TD align=right valign="middle">
            
          	
          <s:if test="#session.user.role=='管理员'"> 
         
           <A class=toplink 
            href="textAction_manyList.action" 
            target=uniMain>稿件统计</A> 
        </s:if>
            
             <s:if test="#session.user.role=='管理员'"> 
            
            <FONT color=#898989>| 
            </FONT>
          <A class=toplink 
            href="userAction_home.action" 
            target=uniMain>管理区</A> <FONT color=#898989>| </FONT><A class=toplink 
            href="textAction_manageText.action" 
            target=uniMain>稿件管理区</A> <FONT color=#898989>| </FONT><A 
            class=toplink href="bulletinAction_home.action" 
            target=uniMain>公告区</A> 
         </s:if>
         <s:else>
            <FONT color=#898989>| </FONT>
            
            
				<a href="userAction_pageEditUI.action" target="uniMain"  class="toplink">修改个人信息</a> 
				</s:else>
				<s:if test="#session.user.role=='用户统计员'">
			<font color="#898989"> | </font>
			<A class=toplink 
            href="userAction_pageSearch.action" 
            target=uniMain>用户查询</A> 
            </s:if>
            
            <FONT color=#898989>| </FONT>
            <A class=toplink 
            href="textAction_textContribute.action" 
            target=uniMain>投稿区</A> <FONT color=#898989>| </FONT><A class=toplink 
            onclick=changePasswd() 
            href="main_top.jsp#">修改口令</A> <FONT 
            color=#898989>| </FONT><A class=toplink 
            href="userAction_logout.action" target=_top>退 出</A> </TD>
      <TD width=30></TD></TR></TBODY></TABLE>　 </TD>
</TR>
  </TBODY></TABLE>

<form name=paraForm>
	<input type="hidden" name="prevUrl">
	<input type="hidden" name="prevUrlQueryString">
	<input type="hidden" name="photoMainCatalog">
	<input type="hidden" name="photoCurrStatus">
	<input type="hidden" name="linkPage">
</form>


</body>
</html>
