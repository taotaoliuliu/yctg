<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>
 

<html>
<head>
<title>bulletin management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style2.css" type="text/css">

</head>


<script language="javascript">
function UpdateForm_onclick() {

	if (UpdateForm.textTitle.value=="")
	{
		alert("公告标题不能为空！");
		UpdateForm.textTitle.focus();
		return false;
	}
	
	if (UpdateForm.textContent.value=="")
	{
		alert("公告内容不能为空！");
		UpdateForm.textContent.focus();
		return false;
	}	
	


	return true;
}
</script>
<body bgcolor="#FFFFFF" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;公告管理--查看公告信息&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<s:form action="bulletinAction_edit.action" method="post" onsubmit="return UpdateForm_onclick();" name="form1">

<input type="hidden" name="MyAction" value="Update">
<s:hidden name="bulletinID"></s:hidden>
 <table width="70%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center" height="150" valign="top">
    
<fieldset style="width:100%" align="center" bgcolor="#FFFFFF">
	<legend align="left">
	<b>发布公告</b>
	</legend>
	    
  <table width="95%" border="0" cellspacing="0" cellpadding="2" class=font9align="center">
    <tr>
    <td  align="left">公告标题：<input type="text" readonly="readonly" name="bulletinTitel" value="${bulletinTitel}" class="input0" style="width:440px"><font color=red>*</font></td>
    </tr>
    <tr><td><br></td></tr>
    <tr>
    <td  width="15%" align="left">公告内容：</td>
    </tr>
    <tr>
    <td ><s:textfield name="bulletinContent" readonly="true" cssClass="input0" cssStyle="width:90%;height:270px;"/><font color=red>*</font></td>   
    </tr>
    </table>

<br><br>
	      
</FIELDSET>
  
 </td>

    
  </tr>
</table>
<br><br>

<table width="90%" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td width="97%" align="center"><input type="image" src="jsp/images/queren.gif" width="69" height="20" border="0">　<a href="bulletinAction_home.action"><img src="jsp/images/cancel.gif" width="69" height="20" border="0"></a></td>
</tr>
</table>


</s:form>

<p>&nbsp;</p>
</body>
</html>
