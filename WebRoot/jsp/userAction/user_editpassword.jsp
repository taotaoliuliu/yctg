<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>user management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />

</head>



<script language="javascript">
function UpdateForm_onclick() {

	if(UpdateForm.password.value=="")
	{
		alert("用户密码不能为空！");
		UpdateForm.password.focus();
		return false;
	}	

	if(UpdateForm.password.value.length<="5")
	{
		alert("您输入的密码长度必须大于六位！");
		UpdateForm.password.focus();
		return false;

		}
	if(UpdateForm.passwordConfirm.value=="")
	{
		alert("密码确认不能为空！");
		UpdateForm.passwordConfirm.focus();
		return false;
	}
	
	if(UpdateForm.passwordConfirm.value!=UpdateForm.password.value)
	{
		alert("密码和密码确认不匹配，请重新输入！");
		UpdateForm.password.focus();
		return false;
	}

	return true;
}
</script>
<body bgcolor="#FFFFFF" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
   <h4> <b>::&nbsp;&nbsp;用户管理--修改（${name_real }）用户密码&nbsp;&nbsp;::</b></h4><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<form name="UpdateForm" method="post" action="userAction_editpasswordRe.action" onSubmit="return UpdateForm_onclick();">
<input type="hidden" name="MyAction" value="Update">
<input type="hidden" name="username" value="">
<s:hidden name="name_Login"></s:hidden>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" height="250" valign="top"> 
	      
	    <FIELDSET style="WIDTH: 90%; HEIGHT: 200px" align=center bgcolor="#FFFFFF">
      <LEGEND align=left><B>修改密码：</B> </LEGEND>
	            <table width="100%" border="0" cellspacing="1" cellpadding="0">
	              <tr>
	                <td align="center"> 
	                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
	                    <tr> 
	                 
	                      </td>
	                    </tr>
	                    <tr> 
	                      <td > 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">     
      <tr>
       <td width="15%" align="right" height="50">用户密码：</td>
       <td width="45%" align="left"><input type="password" name="password"  class="input0" size="50"> <font color=red>*</font></td>
      </tr>
      <tr>
       <td width="15%" align="right" height="50">密码确认：</td>
       <td width="45%" align="left"><input type="password" name="passwordConfirm"  class="input0" size="50"> <font color=red>*</font></td>
      </tr>
      <tr>
      <td width="15%" align="left">&nbsp;</td>
      <td width="45%" align="left">&nbsp;</td>
      </tr>
      		          
    </table>

	                      </td>
	                    </tr>
		                  </table>
	                </td>
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
	          <td width="97%" align="center"><input type="image" src="jsp/images/queren.gif" width="69" height="20" border="0">　<a href="userAction_home.action"><img src="jsp/images/cancel.gif" width="69" height="20" border="0"></a></td> 
	        </tr>
	      </table>
	


</form>

<p>&nbsp;</p>
</body>
</html>
