
















<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags"%> 

<html>
<head runat="server">
<title>远程投稿管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="${pageContext.request.contextPath}/csss/style2.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/script/city.js"></script>
 <%@ include file="/jsp/public/commons.jspf"%>



<SCRIPT LANGUAGE = JavaScript>   
<!--   
//** Power by Fason(2004-3-11)   
//** Email:fason_pfx@hotmail.com   
  
var s=["s1","s2","s3"];   
var opt0 = ["请选择","请选择","请选择"];   
function setup()   
{   
for(i=0;i<s.length-1;i++)   
  document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");   
change(0);   
}   
//-->   
</SCRIPT>  



<script language="javascript" src="${pageContext.request.contextPath}/include/IdCard-Validate.js"></script>
</head>
<script language="javascript">



function AddForm_onclick() {

	
	
	if (AddForm.name_Login.value=="")
	{
		alert("用户登陆名不能为空！");
		AddForm.name_Login.focus();
		return false;
	}


	
	if (AddForm.password.value=="")
	{
		alert("用户登陆密码不能为空！");
		AddForm.password.focus();
		return false;
	}


	if(AddForm.password.value.length<="5")
	{
		alert("您输入的密码长度至少是六位！");
		AddForm.password.focus();
		return false;

		}
	if (AddForm.passwdconfirm.value=="")
	{
		alert("验证密码不能为空！");
		AddForm.passwdconfirm.focus();
		return false;
	}

	if(AddForm.passwdconfirm.value!=AddForm.password.value)
	{
		alert("两次输入密码不一样！");
		AddForm.passwdconfirm.focus();
		return false;
		
		}
	if (AddForm.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		AddForm.name_real.focus();
		return false;
	}
	
	if (AddForm.sex.value=="")
	{
		alert("用户性别不能为空！");
		AddForm.sex.focus();
		return false;
	}
	
	if(AddForm.province.value=="请选择")
	{
		alert("用户所属省不能为空！");
		AddForm.province.focus();
		return false;
	}

		if(AddForm.province.value=="")
	{
		alert("用户所属省不能为空！");
		AddForm.province.focus();
		return false;
	}

	if (AddForm.city.value=="请选择")
	{
		alert("用户所属城市不能为空！");
		AddForm.city.focus();
		return false;
	}
		if (AddForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		AddForm.city.focus();
		return false;
	}

	if (AddForm.county.value=="请选择")
	{
		alert("用户所属区(县)不能为空！");
		AddForm.county.focus();
		return false;
	}
	if (AddForm.county.value=="")
	{
		alert("用户所属区(县)不能为空！");
		AddForm.county.focus();
		return false;
	}
	
	if (AddForm.department.value=="")
	{
		alert("用户的通讯地址不能为空！");
		AddForm.department.focus();
		return false;
	}
	var qqStr=AddForm.QQ.value;
	if (qqStr!="")
	{
		if(isNaN(qqStr))
		{
			alert("QQ号码必须为数字！");
			AddForm.QQ.focus();
			return false;
		}		
	}
	var postalcodeStr=AddForm.postalcode.value;
	if (postalcodeStr!="")
	{
		if(isNaN(postalcodeStr))
		{
			alert("邮政编码必须为数字！");
			AddForm.postalcode.focus();
			return false;
		}
		
		if (postalcodeStr.length!=6)
		{		
			alert("邮政编码必须为6位数字！");
			AddForm.postalcode.focus();
			return false;
	
		}
	}else
		{
			alert("邮政编码不能为空！");
			AddForm.postalcode.focus();
			return false;
		}
	if (AddForm.idcard.value=="")
	{
		alert("用户身份证号不能为空！");
		AddForm.idcard.focus();
		return false;
	}
	
	if(!IdCardValidate(AddForm.idcard.value))
	{
		alert("请检查用户身份证号！");
		AddForm.idcard.focus();
		return false;
	}	
	
	if (AddForm.role.value=="")
	{
		alert("用户角色不能为空！");
		AddForm.role.focus();
		return false;
	}	

	
	
	
	if (AddForm.phone.value=="")
	{
		alert("办公电话不能为空！");
		AddForm.phone.focus();
		return false;
	}	
	
	




	return true;
	
}



</script>

<body bgcolor="#FFFFFF" text="#000000" onload="setup()">   

<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
   <h4><b>::&nbsp;&nbsp;注册新用户&nbsp;&nbsp;::</b></h4><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<s:form name="AddForm" method="post" action="userAction_add.action"  onsubmit="return AddForm_onclick();">
<input type="hidden" name="MyAction" value="Add">


  <table width="100%">
	  <tr>
	    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
	    <td background="../images/main_01.gif" align="right">&nbsp; </td>
	    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
	  </tr>
  </table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td bgcolor="#f0f0f0" align="center" height="250" valign="top"> 
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td>&nbsp;</td>
	        </tr>
	        <tr> 
	          <td bgcolor="#000000">
	            <table width="100%" border="0" cellspacing="1" cellpadding="0">
	              <tr>
	                <td bgcolor="#F6F6F6" align="center"> 
	                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
	                    <tr> 
	                      <td height="30">&nbsp;
	                    </tr>
	                    <tr> 
	                      <td bgcolor="#000000"> 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">用户登录名：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><s:textfield name="name_Login"  cssClass="InputStyle {remote:'userAction_checkLoginName.action', messages:{remote:'用户名已存在或登录名有中文！'}}"/> <font color=red>*</font>只允许字母、数字和下划线</td>
      	<td bgcolor="#F6F6F6" width="15%" align="left">基层单位</td>
        <td bgcolor="#F6F6F6" width="25%" align="left">       <s:select list="#workcompanys" name="workcompany"></s:select>
        </td>
      </tr>

      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">用户密码：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="password" name="password" value="" class="input0"><font color=red>*</font>密码至少为6位</td>
        <td bgcolor="#F6F6F6" width="15%" align="left">确认密码：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="password" name="passwdconfirm" value="" class="input0"><font color=red>*</font></td>
      </tr>
      
      <tr>
       <td bgcolor="#F6F6F6" width="15%" align="left">用户真实名：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="name_real" value="" class="input0"><font color=red>*</font></td>
         <td bgcolor="#F6F6F6" width="15%" align="left">性&nbsp;&nbsp;别：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><select  name="sex"  class="input0" style="width:132"><option value="">请选择</option><option value="男">男性</option><option value="女">女性</option></select><font color=red>*</font></td>
      </tr>

      <tr>
     
        <td colspan="2" bgcolor="#F6F6F6" width="45%" align="left">   用户所属省：&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <select id="s1" name="province"><option>请选择</option></select>  
		<font color=red>*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		用户所属市：<select id="s2" name="city"><option>请选择</option></select><font color=red>*</font>

		</td>
   
        <td bgcolor="#F6F6F6" width="15%" align="left">区(县)：</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><select id="s3" name="county"><option>请选择</option></select>  <font color=red>*</font> </td>
      </tr>
      
       <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">详细通讯地址：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="department" value="" class="input0" maxlength="40"><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">邮政编码：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="postalcode" value="" class="input0"><font color=red>*</font></td>
      </tr>	
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">身份证号：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><s:textfield name="idcard" cssClass="InputStyle {remote:'userAction_checkIdcard.action', messages:{remote:'身份证已存在，请更换！'}}"/><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">角&nbsp;&nbsp;色：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><select  name="role"  class="input0" style="width:132">
		<option value="记者" >记者</option>
		<option value="通讯员" selected="selected">通讯员</option>
		
		</select><font color=red>*</font></td>

      </tr>   
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">办公电话：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="phone" value="" class="input0"><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">职&nbsp;&nbsp;务：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="principalship" value="" class="input0"></td>

      </tr>   
      
       <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">家庭电话：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="homePhone" value="" class="input0"></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">传&nbsp;&nbsp;真：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="fax" value="" class="input0"></td>      
      </tr>     
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">电子邮件：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="email" value="" class="input0">
        <td bgcolor="#F6F6F6" width="15%" align="left">手&nbsp;&nbsp;机：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="mobilePhone" value="" class="input0">  	
      </tr> 	
	  <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">MSN账号：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="MSN" value="" class="input0" size="40"></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">QQ号码：</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="QQ" value="" class="input0"></td>      	
      </tr> 	    	  
	
		      
    </table>

	                      </td>
	                    </tr>
						<tr> 
	                      <td height="30">&nbsp;</td>
	                    </tr>
	                  </table>
	                </td>
	              </tr>
	            </table>
	          </td>
	        </tr>
	        <tr>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
	      
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	         <tr> 
	          <td width="97%" align="center"><input type="image" src="${pageContext.request.contextPath}/jsp/images/queren.gif" width="69" height="20" border="0">　<a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/jsp/images/cancel.gif" width="69" height="20" border="0"></a></td>
	        </tr>
	      </table>
	    </td>
	    <td background="../images/main_03.gif" width="5"><img src="/jsp/images/main_03.gif" width="5" height="1"></td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td width="4" height="4"><img src="/jsp/images/main_06.gif" width="4" height="4"></td>
	    <td background="/jsp/images/main_05.gif" height="4"><img src="/jsp/images/main_05.gif" width="1" height="4"></td>
	    <td width="5" height="4"><img src="/jsp/images/main_04.gif" width="5" height="4"></td>
	  </tr>
	</table>
	
<s:token/>


</s:form>

<p>&nbsp;</p>
</body>
</html>

