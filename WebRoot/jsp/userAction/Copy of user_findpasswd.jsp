<%@ page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="s" uri="/struts-tags"%> 
<HTML>
<HEAD>
<title>重置密码</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">
<script language="javascript">
function pwdForm_onclick() {

	if (changepwd.name_Login.value=="")
	{
		alert("用户登陆名不能为空！");
		changepwd.name_Login.focus();
		return false;
	}
	
	if (changepwd.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		changepwd.name_real.focus();
		return false;
	}
	
	var idCardStr=changepwd.idcard.value;
	if (idCardStr="")
	{
		alert("身份证号不能为空！");
		changepwd.idcard.focus();
		return false;	
	}	
	
	var pswd = changepwd.password.value;
	if (pswd=="")
	{
		alert("新密码不能为空！");
		changepwd.password.focus();
		return false;
	}
	if(changepwd.password.value.length<="5")
	{
		alert("您输入的密码长度至少为六位！");
		changepwd.password.focus();
		return false;

		}
	
	var pswd2 = changepwd.password2.value;
	if (pswd2=="")
	{
		alert("确认密码不能为空！");
		changepwd.password2.focus();
		return false;
	}
	
	if(pswd2!=pswd1)
	{
		alert("密码两次输入不一致！");
		changepwd.password.focus();
		return false;
	}			

	return true;
}
</script>
</HEAD>


<BODY topmargin=0>

	

<form name="changepwd" method="post" action="userAction_findPasswordRe.action" onSubmit="return pwdForm_onclick();">
<input type="hidden" name="MyAction" value="findpwd">
<table width="100%" border=0>
	<tr>
		<td><br>
			<fieldset style="width:95%;height:150" align="center" >
			<legend align="left">
			<b>用户重置密码：</b>
			</legend><br>   
			<s:fielderror></s:fielderror>
				<table width="80%" border=0 align="center">
					<tr>
						<td width="100" height="23" align="center">用户登录名：</td>
						<td>
						<input type="text" name="name_Login" value="" class="input0">
						<font color="#FF0000">*</font></td>
					</tr>
					<tr>
						<td height="23" align="center">真实姓名：</td>
						<td>
						<input type="text" name="name_real" value="" class="input0">
						<font color="#FF0000">*</font></td>
					</tr>
					<tr>
						<td height="23" align="center">身份证号：</td>
						<td>
						<input type="text" name="idcard" value="" class="input0">
						<font color="#FF0000">*</font></td>
					</tr>						
					<tr>
						<td height="23" align="center">新密码：</td>
						<td><input type="password" name="password" value="" class="input0"><font color="#FF0000">*，请输入6位以上由字母、数字组成的密码</font></td>
					</tr>			
					<tr>
						<td height="23" align="center">确认密码：</td>
						<td><input type="password" name="password2" value="" class="input0"><font color="#FF0000">*</font></td>
					</tr>										
				</table><br>
				<div align="center"><font color="#5a5d5d">注意：请保管好自己的密码。</font></div>						
		    </fieldset> 					
		</td>
	</tr>
</table>
<br>
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="97%" align="center">
			  <input type="image" src="images/queren.gif" width="69" height="20" border="0">
			  <a href="#" OnClick="javascript:self.close()"><img src="images/cancel.gif" width="69" height="20" border="0"></a></td>
	        </tr>
	      </table>
</form>

</body>
