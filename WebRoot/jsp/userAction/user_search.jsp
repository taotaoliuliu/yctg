<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>user search</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />
</head>
<script language="javascript">
function ModiButton_onclick()
	{
		var i;
		var k;
		var flag=0;
		for (i=0;i<ListForm.selCheck.length;i++)
		{
			if (ListForm.selCheck(i).checked)
			{	
				k=i;
				flag++;
			}
		}

		if (flag != 1)
			{
				alert("请选择一个信息进行修改！");
			}
		else
			{
			var username = ListForm.selCheck(k).value;
			document.location.href="userAction_editUI.action?username="+ username;
			}			
	}
	
	function ListForm_onclick()
	{
		var i;
		var flag=0;
		var dele_list = "";
		for (i=0;i<ListForm.selCheck.length;i++)
		{
			if (ListForm.selCheck(i).checked)
			{	
				flag=1;
			}
		}
		
		if (flag==0)
			{
				alert("请点击选择框进行删除操作！");
				return false;
			}
			
		if(confirm("是否要删除所选信息?"))
			{
			ListForm.MyAction.value="Del";
			ListForm.action="userAction_delete.action";
			return true;
			}
		else
		return false;
	}
	
	function check()
	{
		if (document.form1.searchString.value=="") {
			alert("请填写查询关键词！")
			return false;
			document.form1.searchString.focus();
		}	
		return true;
	}
</script>

<body bgcolor="#FFFFFF" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
    <h5><b>::&nbsp;&nbsp;用户管理--查询用户&nbsp;&nbsp;::</b></h5><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="2"><img src="../images/main_01.gif" width="2" height="27"></td>
	    <td background="../images/main_01.gif" align="left">&nbsp; 
            </TD>	    
	    </td>
	    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="27"></td>
	  </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="200">
	 <tr>
	   <td bgcolor="#f0f0f0" align="center" height="150" valign="top"> 
      <br>
 <form name="form1" method="post" action="userAction_searchRe.action" onSubmit="return check();">
      <input type="hidden" name="MyAction" value="Search">
		<fieldset style="width:85%;height:180" align="center" >
		<legend align="left">
		<b>查询条件：</b>
		</legend>
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
			<tr height="23">
				<td>
				搜索: <input type="text" name="searchString" value="${sessionScope.searchString }" class="input0" size="20" >
				<input type="submit" name="submit" value="查询">				
				</td>
			</tr>		
			<tr>
				<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<s:if test="#session.name=='name_Login'">
                        <input type="radio" name="properties" value="name_Login" checked="checked"> 登录名<br>
                        </s:if>
                        
                        <s:else>
                      <input type="radio" name="properties" value="name_Login" > 登录名<br>
                        
                        </s:else>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:if test="#session.name=='name_real'">
                        
                        <input type="radio" name="properties" value="name_real" checked="checked"> 用户名<br>
                        </s:if>
                        <s:else>
                      	<input type="radio" name="properties" value="name_real" > 用户名<br>
                        
                        </s:else>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:if test="#session.name=='role'">
                        
                        <input type="radio" name="properties" value="role" checked="checked"> 角色名<br>
                        </s:if>
                        <s:else>
                      <input type="radio" name="properties" value="role" > 角色名<br>
                        
                        </s:else>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:if test="#session.name=='province'">
                        
						<input type="radio" name="properties" value="province" checked="checked"> 用户所属省<br>
						</s:if>
						<s:else>
                      <input type="radio" name="properties" value="province" > 用户所属省<br>
                        
                        </s:else>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:if test="#session.name=='city'">
                        						
                        
						<input type="radio" name="properties" value="city" checked="checked"> 用户所属市<br>
						</s:if>
						<s:else>
                      <input type="radio" name="properties" value="city" > 用户所属市<br>
                        
                        </s:else>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        						<s:if test="#session.name=='idcard'">
                        
                        <input type="radio" name="properties" value="idcard" checked="checked"> 用户身份证号<br>	
                        </s:if>
                        <s:else>
                      <input type="radio" name="properties" value="idcard" > 用户身份证号<br>
                        
                        </s:else>
						&nbsp;&nbsp;&nbsp;&nbsp;
												<s:if test="#session.name=='workcompany'">
						
						<input type="radio" name="properties" value="workcompany" checked="checked"> 用户所属单位<br>	
						</s:if>		
						<s:else>
                      <input type="radio" name="properties" value="workcompany" > 用户所属单位<br>
                        
                        </s:else>
                 </td>
			</tr>	
		
			
		</table>
		</fieldset> 
		
		</form>
	   </td>
	   
	   <td width="70%" bgcolor="#f0f0f0" valign="top">
	   <br>
	   
	   
	   
	   <form name="ListForm" method="post" action="user_search.jsp" onSubmit="return ListForm_onclick();">
	   <input type="hidden" name="MyAction" value="select">   

		<fieldset style="width:95%;height:180" align="center" >
		<legend align="left">
		<b>查询结果：</b>
		</legend>	   
	    
        <a href="javascript:ModiButton_onclick()"><img src="jsp/images/change_01.gif" border="0"></a>
        <input type="image" border="0" name="Remove" src="jsp/images/cut_01.gif" width="69" height="20">		
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class=font9 >
    <tr> 
        <td width="5%" bgcolor="959185"> 
              <div align="center"><font color="#FFFFFF">选择</font></div>
    	</td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">登录名</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户姓名</font></div>
        </td>				
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">电话</font></div>
        </td>
	
       <td width="4%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属省</font></div>
        </td>        
        <td width="4%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属市</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">通讯地址</font></div>
        </td> 
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">邮编</font></div>
        </td> 
        <td width="12%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">身份证</font></div>
        </td>
          <td width="12%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">银行卡号</font></div>
        </td>     
          <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">开户行地址</font></div>
        </td>              
      </tr>
			     


     <s:iterator value="#listUser" var="nu">
               
      <tr>
			     
        <td width="5%" align="center"> 
        
			  <s:if test="#nu.name_Login=='admin'"><input type="checkbox" name="selCheck" value="${name_Login}" disabled="disabled">               
        </s:if>
        <s:else>
			<input type="checkbox" name="selCheck" value="${name_Login}" > 
			
		</s:else>             
        </td>
        <td width="8%"><a href="userAction_lookUser.action?username=${name_Login }">${name_Login }</a></td>
		<td width="8%">${ name_real}</td>           
		<td width="8%">${phone }</td> 
		<td width="4%" align="center">${province }</td> 		
		<td width="4%" align="center">${city }</td> 
		<td width="15%">${department }</td> 
		<td width="10%" align="center">${postalcode }</td>
		<td width="8%">${idcard }</td>
		<td width="10%">${bankcard }</td>
		<td width="10%">${bankaddress }</td>
		
      </tr>
		 </s:iterator>			
						            
             
    </table>	   

		</fieldset> 

    <input type="checkbox" name="selCheck" id="selCheck" style="display:none"> 
	
	   </form>
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



</body>
</html>
