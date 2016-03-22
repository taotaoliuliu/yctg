<%@ page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<HTML>
<HEAD>
<title>修改口令</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">
</HEAD>


<script language="javascript">
function pwdForm_onclick() {

	var oldpswd = changepwd.oldpasswd.value;
	if (oldpswd=="")
	{
		alert("新密码不能为空！");
		changepwd.oldpasswd.focus();
		return false;
	}
	var pswd = changepwd.passwd.value;
	if (pswd=="")
	{
		alert("新密码不能为空！");
		changepwd.passwd.focus();
		return false;
	}
	if(changepwd.passwd.value.length<="5")
	{
		alert("您输入的密码长度必须大于六位！");
		changepwd.passwd.focus();
		return false;

		}
	
	var pswd2 = changepwd.passwdconfirm.value;
	if (pswd2=="")
	{
		alert("确认密码不能为空！");
		changepwd.passwdconfirm.focus();
		return false;
	}
	
	if(pswd2!=pswd)
	{
		alert("密码两次输入不一致！");
		changepwd.passwd.focus();
		return false;
	}			

	return true;
}
</script>







<BODY topmargin=0>

	
	

<form name="changepwd" method="post" action="userAction_changePasswordRe.action" onsubmit="return pwdForm_onclick();">
<input type="hidden" name="MyAction" value="changepwd">
<table width="100%" border=0>
	<tr>
		<td><br>
			
			<fieldset style="width:95%;height:150" align="center" >
			<legend align="left">
			<b>用户(${name_real })修改口令：</b>
			</legend><br>   
				<table width="80%" border=0 align="center">
					<tr>
						<td width="100" height="23" align="center">原 密 码：</td>
						<td><input type="password" name="oldpasswd" value="" class="input0"></td>
					</tr>
					<tr>
						<td height="23" align="center">新 密 码：</td>
						<td><input type="password" name="passwd" value="" class="input0"></td>
					</tr>
					<tr>
						<td height="23" align="center">确认密码：</td>
						<td><input type="password" name="passwdconfirm" value="" class="input0"></td>
					</tr>	
						<s:fielderror></s:fielderror>	
						<s:actionerror/>				
				</table><br>
				<div align="center"><font color="#5a5d5d">注意：新密码在下次登录系统时生效。</font></div>						
		    </fieldset> 					
		</td>
	</tr>
</table>
<br>
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="97%" align="center"><input type="image" src="images/queren.gif" width="69" height="20" border="0">　<a href="#" OnClick="javascript:self.close()"><img src="images/cancel.gif" width="69" height="20" border="0"></a></td>
	        </tr>
	      </table>
</form>

</body>
