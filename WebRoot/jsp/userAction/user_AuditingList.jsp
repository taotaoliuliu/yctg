<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>user management</title>
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
		for (i=0;i<AuditingListForm.selCheck.length;i++)
		{
			if (AuditingListForm.selCheck(i).checked)
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
			var username = AuditingListForm.selCheck(k).value;
			document.location.href="userAction_editAuditing.action?username="+ username;
			}			
	}
	
	function ListForm_onclick()
	{
		var i;
		var flag=0;
		var dele_list = "";
		for (i=0;i<AuditingListForm.selCheck.length;i++)
		{
			if (AuditingListForm.selCheck(i).checked)
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
			AuditingListForm.MyAction.value="Del";
			AuditingListForm.action="userAction_auditingDelete.action";
			return true;
			}
		else
		return false;
	}
	
	function  AuditingButton_onclick()
	{
		var i;
		var k;
		var flag=0;
		var username;
		for (i=0;i<AuditingListForm.selCheck.length;i++)
		{
			if (AuditingListForm.selCheck(i).checked)
			{	
				flag=1;
			}
		}
		
		if (flag==0)
		{
			alert("请点击选择框进行审核操作！");
		}else{
		
			if(confirm("是否要审核所选用户?"))
				{
					for(k=0;k<AuditingListForm.selCheck.length;k++)
					{
						if(AuditingListForm.selCheck(k).checked)
						{
							if(username=="")
							{
								username=AuditingListForm.selCheck(k).value;
							}else{
								username+="/"+AuditingListForm.selCheck(k).value;
							      }							
						}
					}
					document.location.href="userAction_auditing.action?username="+ username;
				}
			}
	}
			
</script>
<body bgcolor="#C8D4E2" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;&nbsp;&nbsp;
   <h4> <b>::&nbsp;&nbsp;用户审核&nbsp;&nbsp;::</b></h4> <br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<form name="AuditingListForm" method="post" action="" onSubmit="return ListForm_onclick();">
<input type="hidden" name="MyAction">
<input type="hidden" name="dele_list">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
    <td background="../images/main_01.gif" align="right">

<table width="100%" border="0" cellspacing="0" cellpadding="2">
<TR><TD>
<!--	
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td width="50%">共<font color="#FF0000">16</font>篇，分<font color="#FF0000">2</font>页，当前为第<font color="#FF0000">1</font>页
      
      　到 <select name="goPage" onChange="location.href='inUserSet.jsp?myid=1&page=' + this.options(this.selectedIndex).value;">
      			
      			<option value="1" selected>1</option>
      			
      			<option value="2" >2</option>
      			
      		 </select>
      	 页
      
      </td>
      <td align="right" width="50%">
		
			  <FONT COLOR="#8B8B8B"><font face="Webdings">3</font>首页&nbsp;&nbsp;上一页&nbsp;&nbsp;</FONT>
		
		
				  <a href="inUserSet.jsp?myid=1&page=2" class="volti">
				  下一页</a>&nbsp;&nbsp;
				  <a href="inUserSet.jsp?myid=1&page=2" class="volti">
				  尾页<font face="Webdings">4</font></a>
		
	  </td>
    </tr>
  </table>
-->
            </TD>
    </TR>
</table>    

</td>
    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
    <td background="../images/main_01.gif" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<TR><TD>
        <a href="javascript: ModiButton_onclick()"><img src="jsp/images/change_01.gif" border="0"></a>
        <input type="image" border="0" name="Remove" src="jsp/images/cut_01.gif" width="69" height="20">
    	<a href="javascript: AuditingButton_onclick()"><img src="jsp/images/sign_03.gif" border="0"></a>        
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
        <td width="5%" bgcolor="959185"> 
              <div align="center"><font color="#FFFFFF">选择</font></div>
    	</td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户登录名</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户姓名</font></div>
        </td>				
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">电话</font></div>
        </td>
	
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属省</font></div>
        </td>        
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">用户所属市</font></div>
        </td> 
        
         <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">所属县(区)</font></div>
        </td> 
        <td width="19%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">通讯地址</font></div>
        </td>
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">邮编</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">角色</font></div>
        </td>     
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">注册时间</font></div>
        </td>      
      </tr>
			      

     <s:iterator value="#listUser" status="s">
      <tr bgcolor="">
        <td width="5%" align="center"> 
			<input type="checkbox" name="selCheck" value="${name_Login}" >               
        </td>
        <td width="8%"><a href="userAction_lookAuditing.action?username=${name_Login }">${name_Login }</a></td>
		<td width="8%">${ name_real}</td>           
		<td width="10%">${phone }</td> 
		<td width="8%" align="center">${province }</td> 		
		<td width="8%" align="center">${city }</td> 
						<td width="8%" align="center">${county }</td> 
		
		<td width="19%">${department }</td> 
		<td width="10%" align="center">${postalcode }</td>
		<td width="8%">${role }</td>
		
		<td width="8%">${createtime }</td>
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
  <input type="checkbox" name="selCheck" id="selCheck" style="display:none"> 

</form>

<p>&nbsp;</p>
</body>
</html>
