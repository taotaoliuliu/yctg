<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>user management</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">
 <%@ include file="/jsp/public/commons.jspf"%>
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

	function getselectedphoto(clickflag)
	{
		
	}
	
function PauseButton_onclick()
	{
		var i;
		var k;
		var username;
		var flag=0;
		for (i=0;i<ListForm.selCheck.length;i++)
		{
			if (ListForm.selCheck(i).checked)
			{	
				flag=1;
			}
		}

		if (flag == 0)
			{
				alert("请点击选择框进行冻结用户操作！");
			}
		else {
			if(confirm("是否要冻结所选用户?"))
				{
					for(k=0;k<ListForm.selCheck.length;k++)
					{
						if(ListForm.selCheck(k).checked)
						{
							if(username=="")
							{
								username=ListForm.selCheck(k).value;
							}else{
								username+="/"+ListForm.selCheck(k).value;
							      }							
						}
					}
					document.location.href="userAction_pauseUser.action?username="+ username;
				}
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
	
	
	function ModiPasswordButton_onclick()
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
				alert("请选择一个用户进行密码的修改！");
			}
		else
			{
			var username = ListForm.selCheck(k).value;
			document.location.href="userAction_editpassword.action?username="+username;
			}			
	}
	


function userSearch()
{
	var usersearchWin;
	usersearchWin = window.open("../include/getUserList.jsp?returnCount=aa","usersearchWin","width=500,height=400,resizable=yes,menubar=no,scrollbars=yes,toolbar=no,menubar=no,location=no");
	usersearchWin.focus();
}		
</script>
<body bgcolor="#C8D4E2" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
   <h4> <b>::&nbsp;&nbsp;用户管理&nbsp;&nbsp;::</b></h4><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<form name="ListForm" method="post" action="" onSubmit="return ListForm_onclick();">
<input type="hidden" name="MyAction">
<input type="hidden" name="dele_list">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="images/main_01.gif" width="2" height="0"></td>
    <td background="images/main_01.gif" align="right">    

		  </td>
	    </tr>
	  </table>
	 </td> 

</td>
    <td width="5" align="right"><img src="images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="images/main_01.gif" width="2" height="0"></td>
    <td background="images/main_01.gif" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<TR><TD>
        <a href="userAction_addUI.action"><img src="jsp/images/add_01.gif" border="0"></a>
        <a href="javascript: ModiButton_onclick()"><img src="jsp/images/change_01.gif" border="0"></a>
        <input type="image" border="0" name="Remove" src="jsp/images/cut_01.gif" width="69" height="20">
        <a href="userAction_search.action"><img src="jsp/images/search.gif" border="0"></a>
        <a href="userAction_auditingList.action"><img src="jsp/images/sign_03.gif" border="0"></a>
        <a href="javascript: PauseButton_onclick()"><img src="jsp/images/sign_06.gif" border="0"></a>
        <a href="javascript: ModiPasswordButton_onclick()"><img src="jsp/images/change_02.gif" border="0"></a>
                        <a href="userAction_online.action"><img src="jsp/images/online.gif" border="0"></a>
        
            </TD>
    </TR>
</table>
</td>
    <td width="5" align="right"><img src="images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="150" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="2" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr> 
        <td width="5%" bgcolor="959185"> 
              <div align="center"><font color="#FFFFFF">选择</font></div>
    	</td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF"><a href="main_admin.jsp?sortName=name_Login">用户登录名</a></font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF"><a href="main_admin.jsp?sortName=name_real">用户姓名</a></div>
        </td>				
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">电话</font></div>
        </td>
		<!--<td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">基层单位</font></div>
        </td> -->
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">所属省</font></div>
        </td>        
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">所属市</font></div>
        </td> 
        
         <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">所属县(区)</font></div>
        </td> 
        <td width="20%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">通讯地址</font></div>
        </td>
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">邮编</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">角色</font></div>
        </td>  
        
        
         <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">注册时间</font></div>
        </td>  
         <s:iterator value="recordList" var="nu">
               
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
		<td width="10%">${phone }</td> 
		<td width="8%" align="center">${province }</td> 		
		<td width="8%" align="center">${city }</td> 
				<td width="8%" align="center">${county }</td> 
		
		<td width="20%">${department }</td> 
		<td width="10%" align="center">${postalcode }</td>
		<td width="8%">${role }</td>
				<td width="10%">${createtime }</td>
		
      </tr>
		 </s:iterator>				            
      

       
    </table>
  
  <s:form action="userAction_list"></s:form>
	<%@ include file="/jsp/public/pageView.jspf" %>
 </td>
    <td background="images/main_03.gif" width="5"><img src="images/main_03.gif" width="5" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4" height="4"><img src="images/main_06.gif" width="4" height="4"></td>
    <td background="images/main_05.gif" height="4"><img src="images/main_05.gif" width="1" height="4"></td>
    <td width="5" height="4"><img src="images/main_04.gif" width="5" height="4"></td>
  </tr>
</table>  
  <input type="checkbox" name="selCheck" id="selCheck" style="display:none"> 

</form>

<p>&nbsp;</p>
</body>
</html>
