<%@ page contentType="text/html;charset=gb2312"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>�й�����Զ��Ͷ�����ϵͳ</title>
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

<body bgcolor="#5F72A5" text="#000000" leftmargin="0" topmargin="0" onmouseover="self.status='��ӭ����Զ��Ͷ�����ϵͳ';return true" ondragstart="window.event.returnValue=false" oncontextmenu="window.event.returnValue=false" onselectstart="event.returnValue=false" onload="openwin()">
<TABLE height=33 cellSpacing=0 cellPadding=0 width="100%" bgColor=#5f72a5 
border=0>
  <TBODY>
  <TR>
    <TD width=300 align="left" vAlign=center background="jsp/images/top.jpg">&nbsp;<FONT 
      color=#ffffff><B><span class="style2">�й�����Զ��Ͷ�����ϵͳ(${sessionScope.versin })<B></span></FONT><span class="style2"></B></B></span></TD>
    <TD align=right vAlign=bottom background="jsp/images/top.jpg">
      <TABLE height=28 cellSpacing=0 cellPadding=0 width=650 align=right 
      border=0>
        <TBODY>
        <TR>
          <TD align="right" valign="middle"><span class="style1"><FONT color=white>�û���${user.name_real }  </FONT></span></TD>
         <TD align=right width="20" ></TD>
          <TD align=right valign="middle">
            
          	
          <s:if test="#session.user.role=='����Ա'"> 
         
           <A class=toplink 
            href="textAction_manyList.action" 
            target=uniMain>���ͳ��</A> 
        </s:if>
            
             <s:if test="#session.user.role=='����Ա'"> 
            
            <FONT color=#898989>| 
            </FONT>
          <A class=toplink 
            href="userAction_home.action" 
            target=uniMain>������</A> <FONT color=#898989>| </FONT><A class=toplink 
            href="textAction_manageText.action" 
            target=uniMain>���������</A> <FONT color=#898989>| </FONT><A 
            class=toplink href="bulletinAction_home.action" 
            target=uniMain>������</A> 
         </s:if>
         <s:else>
            <FONT color=#898989>| </FONT>
            
            
				<a href="userAction_pageEditUI.action" target="uniMain"  class="toplink">�޸ĸ�����Ϣ</a> 
				</s:else>
				<s:if test="#session.user.role=='�û�ͳ��Ա'">
			<font color="#898989"> | </font>
			<A class=toplink 
            href="userAction_pageSearch.action" 
            target=uniMain>�û���ѯ</A> 
            </s:if>
            
            <FONT color=#898989>| </FONT>
            <A class=toplink 
            href="textAction_textContribute.action" 
            target=uniMain>Ͷ����</A> <FONT color=#898989>| </FONT><A class=toplink 
            onclick=changePasswd() 
            href="main_top.jsp#">�޸Ŀ���</A> <FONT 
            color=#898989>| </FONT><A class=toplink 
            href="userAction_logout.action" target=_top>�� ��</A> </TD>
      <TD width=30></TD></TR></TBODY></TABLE>�� </TD>
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
