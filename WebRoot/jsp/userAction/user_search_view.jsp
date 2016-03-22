<%@page contentType="text/html;charset=utf-8" %> 

<%@ taglib prefix="s" uri="/struts-tags" %>


<html>
<head>
<title>user search</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
			document.location.href="user_edit.jsp?username="+ username;
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
			ListForm.action="user_delete.jsp";
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
    
    <b>::&nbsp;&nbsp;用户管理--查询用户&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
	    <td background="../images/main_01.gif" align="left">&nbsp; 
            </TD>	    
	    </td>
	    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
	  </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="200">
	 <tr>
	   <td bgcolor="#f0f0f0" align="center" height="150" valign="top"> 
      <br>
      <form name="form1" method="post" action="userAction_pageSearchRe.action" onsubmit="return check();">
      <input type="hidden" name="MyAction" value="Search">
		<fieldset style="width:85%;height:180" align="center" >
		<legend align="left">
		<b>查询条件：</b>
		</legend>
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
			<tr height="23">
				<td>
				搜索: <input type="text" name="searchString" value="" class="input0" size="20">
				<input type="submit" name="submit" value="查询">				
				</td>
			</tr>		
			<tr>
				<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="name_Login" checked> 登录名<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="name_real" /> 用户名<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="role" /> 角色名<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="province" /> 用户所属省<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="city" /> 用户所属城市<br>	
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="properties" value="idcard" /> 用户身份证号<br>				
                 </td>
			</tr>			
		</table>
		</fieldset> 
		
		</form>
	   </td>
	   
	   <td width="70%" bgcolor="#f0f0f0" valign="top">
	   <br>
	   <form name="ListForm" method="post" action="user_search_view.jsp" onSubmit="return ListForm_onclick();">
	   <input type="hidden" name="MyAction" value="select">   

		<fieldset style="width:95%;height:180" align="center" >
		<legend align="left">
		<b>查询结果：</b>
		</legend>	   
	    
        
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class=font9 >
    <tr> 

        <td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户登录名</font></div>
        </td>
        <td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户姓名</font></div>
        </td>				
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">电话</font></div>
        </td>
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属省</font></div>
        </td>        
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属市</font></div>
        </td> 
        <td width="18%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">通讯地址</font></div>
        </td> 
        <td width="9%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">邮编</font></div>
        </td> 
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">身份证</font></div>
        </td>         
      </tr>
      
			  <s:iterator value="#listUser">
               
      <tr>
			     
       
        <td width="8%"><a href="userAction_lookUser.action?username=${name_Login }">${name_Login }</a></td>
		<td width="8%">${ name_real}</td>           
		<td width="10%">${phone }</td> 
		<td width="8%" align="center">${province }</td> 		
		<td width="8%" align="center">${city }</td> 
		<td width="35%">${department }</td> 
		<td width="10%" align="center">${postalcode }</td>
		<td width="8%">${idcard }</td>
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
