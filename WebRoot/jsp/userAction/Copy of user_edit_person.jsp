<%@page contentType="text/html;charset=utf-8" %> 
<%@page import = "java.util.*"%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>user management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/script/city.js"></script>






</head>


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
		function trimStr(str){return str.replace(/(^\s*)|(\s*$)/g,"");};


var pr='${province}';

alert(pr);

var ci='${city}';

var co='${county}';

   co=trimStr(co);

 pr=trimStr(pr);
  ci=trimStr(ci);
  
 if(pr=='北京'||pr=='天津'||pr=='重庆'||pr=='上海')
	  {
	  	ci=pr;
	  }
 


    document.getElementById('s1').value=pr;  
    change(1);   
document.getElementById('s2').value=ci;   
change(2);   
document.getElementById('s3').value=co;    
}      

//-->   
</SCRIPT>  

<script language="javascript" src="${pageContext.request.contextPath}/include/IdCard-Validate.js"></script>

<script language="javascript">
function UpdateForm_onclick() {

	if (UpdateForm.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		UpdateForm.name_real.focus();
		return false;
	}
	
	if (UpdateForm.sex.value=="")
	{
		alert("用户性别不能为空！");
		UpdateForm.sex.focus();
		return false;
	}		
	
	
if(UpdateForm.province.value=="请选择")
	{
		alert("用户所属省不能为空！");
		UpdateForm.province.focus();
		return false;
	}

		if(UpdateForm.province.value=="")
	{
		alert("用户所属省不能为空！");
		UpdateForm.province.focus();
		return false;
	}

	if (UpdateForm.city.value=="请选择")
	{
		alert("用户所属城市不能为空！");
		UpdateForm.city.focus();
		return false;
	}
		if (UpdateForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		UpdateForm.city.focus();
		return false;
	}

	if (UpdateForm.county.value=="请选择")
	{
		alert("用户所属区(县)不能为空！");
		UpdateForm.county.focus();
		return false;
	}
	if (UpdateForm.county.value=="")
	{
		alert("用户所属区(县)不能为空！");
		UpdateForm.county.focus();
		return false;
	}

	
	if (UpdateForm.department.value=="")
	{
		alert("用户的通讯地址不能为空！");
		UpdateForm.department.focus();
		return false;
	}
	var qqStr=UpdateForm.QQ.value;
	if (qqStr!="")
	{
		if(isNaN(qqStr))
		{
			alert("QQ号码必须为数字！");
			UpdateForm.QQ.focus();
			return false;
		}		
	}
	var postalcodeStr=UpdateForm.postalcode.value;
	if (postalcodeStr!="")
	{
		if(isNaN(postalcodeStr))
		{
			alert("邮政编码必须为数字！");
			UpdateForm.postalcode.focus();
			return false;
		}
		
		if (postalcodeStr.length!=6)
		{		
			alert("邮政编码必须为6位数字！");
			UpdateForm.postalcode.focus();
			return false;
	
		}
	}else{
		alert("邮政编码不能为空！");
		UpdateForm.postalcode.focus();
		return false;
	     }
	
	if (UpdateForm.idcard.value=="")
	{
		alert("用户身份证号不能为空！");
		UpdateForm.idcard.focus();
		return false;
	}
	
	if (UpdateForm.bankcard.value=="")
	{
		alert("银行卡号不能为空！");
		UpdateForm.idcard.focus();
		return false;
	}
	
	if (UpdateForm.bankaddress.value=="")
	{
		alert("开户行名称不能为空！");
		UpdateForm.idcard.focus();
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
   <h5> <b>::&nbsp;&nbsp;用户管理--修改（${name_real }）用户信息&nbsp;&nbsp;::</b></h5><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<s:form name="UpdateForm" method="post" action="userAction_pageEdit.action" onsubmit="return UpdateForm_onclick();">

<input type="hidden" name="MyAction" value="Update" />
<input type="hidden" name="username" value="" />

<s:hidden name="role"/>
<s:hidden name="userID"></s:hidden>
<s:hidden name="name_Login"></s:hidden>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" height="250" valign="top"> 
	      <FIELDSET style="WIDTH: 90%;" align=center bgcolor="#FFFFFF">
      <LEGEND align=left><B>${name_real }(${name_Login })：用户信息</B> </LEGEND>
      
	            <table width="100%" border="0" cellspacing="1" cellpadding="0">
	              <tr>
	                <td  align="center"> 
	                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
	                    <tr> 
	                      
	                    </tr>
	                    <tr> 
	                      <td > 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">     
     
      <tr>
       <td  width="15%" align="left" height="30">用户真实名：</td>
        <td  width="45%" align="left"><s:textfield  name="name_real"  id="cnname"  cssClass="input0"/> <font color=red>*</font></td>
         <td  width="15%" align="left">性&nbsp;&nbsp;别：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"> <s:select list="{'男','女'}"  name="sex" cssStyle='width:132' cssClass="input0"
				          headerKey="" headerValue="请选择">
				     </s:select> <font color=red>*</font></td>
      </tr>
       
      <tr>
      
      
     <td colspan="2" bgcolor="#F6F6F6" width="45%" align="left">   用户所属省：&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <select id="s1" name="province"><option>请选择</option></select><font color=red>*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		用户所属市： <select id="s2" name="city"><option>请选择</option></select><font color=red>*</font>

		</td>
   
        <td bgcolor="#F6F6F6" width="15%" align="left">区(县)：</td>
        <td bgcolor="#F6F6F6" width="25%" align="left">	<select id="s3" name="county"><option>请选择</option></select><font color=red>*</font> </td>
        
      </tr>
	  
       <tr>
        <td  width="15%" align="left" height="30">详细通讯地址：</td>
        <td  width="45%" align="left"><s:textfield  name="department" cssClass="input0" /> <font color=red>*</font></td>
        <td  width="15%" align="left">邮政编码：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"><s:textfield  name="postalcode" cssClass="input0"/> <font color=red>*</font></td>
      </tr>	
      
      <tr>
        <td  width="15%" align="left" height="30">身份证号：</td>
        <td  width="45%" align="left"><s:textfield name="idcard" cssClass="input0"></s:textfield> <font color=red>*</font></td>
        <td  width="15%" align="left">角&nbsp;&nbsp;色：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"><s:select cssClass="input0" cssStyle="width:132" name="role"  list="{'记者','通讯员','统计员','管理员','普通用户'}" 
						headerKey="" headerValue="" disabled="true" >
						</s:select> <font color=red>*</font></td>

      </tr>   
      
      <tr>
        <td  width="15%" align="left" height="30">办公电话：</td>
        <td  width="45%" align="left"><s:textfield name="phone" cssStyle="input0"></s:textfield></td>
        <td  width="15%" align="left">职&nbsp;&nbsp;务：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"><s:textfield name="principalship" cssStyle="input0"></s:textfield></td>

      </tr>   
      
       <tr>
        <td  width="15%" align="left" height="30">家庭电话：</td>
        <td  width="45%" align="left"><s:textfield name="homePhone" cssStyle="input0"/></td>
        <td  width="15%" align="left">传&nbsp;&nbsp;真：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"><s:textfield name="fax" cssStyle="input0"/></td>      
      </tr>     
      
      <tr>
        <td  width="15%" align="left" height="30">电子邮件：</td>
        <td  width="45%" align="left"><s:textfield name="email" cssStyle="input0" size="40"/></td>
        <td  width="15%" align="left">手&nbsp;&nbsp;机：&nbsp;&nbsp;</td>
        <td  width="25%" align="left"><s:textfield name="mobilePhone" cssStyle="input0"/></td>     	
      </tr> 
       <tr>
        <td align="left" height="30">用户密码：</td>
        <td>
        
          <s:password name="password" cssStyle="input0" value=""/>    如不填，则不更改用户密码        </td>
        
        <td align="left">所属单位：</td>
        <td ><s:select list="#workcompanys" name="workcompany"  ></s:select>
        </td>       
      </tr>   
      <tr>
        <td width="15%" align="left" height="30">MSN账号：</td>
        <td width="45%" align="left"><s:textfield name="MSN" cssStyle="input0" size="40"/></td>
        <td width="15%" align="left">QQ号码：</td>
        <td width="25%" align="left"><s:textfield name="QQ" cssStyle="input0"/></td>     	
      </tr>   
      <tr>
        <td  width="15%" align="left">银行卡号：</td>
        <td  width="45%" align="left"><input type="text" name="bankcard" value="${bankcard }" class="input0"><font color=red>*</font></td>
        <td  width="15%" align="left">开户行名称：</td>
        <td  width="25%" align="left"><input type="text" name="bankaddress" value="${ bankaddress}" class="input0"> <font color=red>*</font></td>     	
      </tr> 
      
      <tr>
        <td  width="15%" align="left">开户行联行号：</td>
        <td  width="25%" align="left"><input type="text" name="banklinkcard" value="${banklinkcard }" class="input0"></td>     	
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
	          <td width="97%" align="center"><input type="image" src="jsp/images/queren.gif" width="69" height="20" border="0">　<a href="textAction_textContribute.action"><img src="jsp/images/cancel.gif" width="69" height="20" border="0"></a></td> 
	        </tr>
	      </table>	



</s:form>
<p>&nbsp;</p>
</body>
</html>
