<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags"%> 

<html>
<head>
<title>text management</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">

</head>
<script language="javascript">

function Search_OnClick()
{
	addWin = window.open("textAction_textStatSearch.action","searchWin","width=500,height=280,resizable=yes,menubar=no,scrollbars=yes,toolbar=no,menubar=no,location=no");
	addWin.focus();
}	

</script>


<body bgcolor="#C8D4E2" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;稿件数量统计&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<form name="TextListForm" method="post" action="">
<input type="hidden" name="MyAction">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
    <td background="../images/main_01.gif" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<TR><TD>
        <a href="javascript: Search_OnClick()"><image src="${pageContext.request.contextPath}/jsp/images/search.gif" border="0"></a>
    </TD>
    </TR>
</table>
</td>
    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="150" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="2" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr> 
    	<td width="10%" bgcolor="959185"> 
          <div align="center">序号</div>
        </td>
        <td width="50%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">投稿实体</font></div>
        </td>
        <td width="30%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">投稿篇数</font></div>
        </td>	
        <td width="10%" bgcolor="959185"> 
          <div align="center"></div>
        </td>			     
      </tr>
			    

	<s:iterator value="#result" status="status">
     
	<td width="10%" align="center"><s:property value="#status.index+1"/></td>
        <td width="50%">${contributeEsse }</td>
	<td width="30%"><a href="textAction_manyList?limit=${contributeEsse }">${textAmout }</a></td> 
	<td width="10%"></td>          
		
      </tr>
					            
       </s:iterator>

       
    </table>
  
 </td>
    <td background="../images/main_03.gif" width="5"><img src="../images/main_03.gif" width="5" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4" height="4"><img src="../images/main_06.gif" width="4" height="4"></td>
    <td background="../images/main_05.gif" height="4"><img src="../images/main_05.gif" width="1" height="4"></td>
    <td width="5" height="4"><img src="../images/main_04.gif" width="5" height="4"></td>
  </tr>
</table>  
</form>

<p>&nbsp;</p>
</body>
</html>
