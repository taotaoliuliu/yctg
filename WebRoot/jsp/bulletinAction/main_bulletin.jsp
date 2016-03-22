<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>bulletin management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="csss/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />
</head>
<script language="javascript">
	function StopPut_onclick()
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
				alert("请选择一个公告停发！");
			}
		else
			{
			var bulletinID = ListForm.selCheck(k).value;
			document.location.href="bulletinAction_stop.action?bulletinID="+ bulletinID;
			}
	}
	function huiFuPut_onclick()
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
				alert("请选择一个公告进行恢复！");
			}
		else
			{
			var bulletinID = ListForm.selCheck(k).value;
			document.location.href="bulletinAction_resume.action?bulletinID="+ bulletinID;
			}
	}


	
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
			var bulletinID = ListForm.selCheck(k).value;
			document.location.href="bulletinAction_editUI.action?bulletinID="+ bulletinID;
			}			
	}
	
	function ListForm_onclick()
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
				alert("请选择一个信息进行删除！");
			}
		else
			{
			var bulletinID = ListForm.selCheck(k).value;
			document.location.href="bulletinAction_delete.action?bulletinID="+ bulletinID;
			}			
	}
	
</script>
<body bgcolor="#C8D4E2" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
   <h4> <b>::&nbsp;&nbsp;公告管理&nbsp;&nbsp;::</b></h4><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<form name="ListForm" method="post" action="" onSubmit="return ListForm_onclick();">
<input type="hidden" name="MyAction">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="images/main_01.gif" width="2" height="0"></td>
    <td background="images/main_01.gif" align="right">

   

</td>
    <td width="5" align="right"><img src="images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="/jsp/images/main_01.gif" width="2" height="0"></td>
    <td background="/jsp/images/main_01.gif" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<TR><TD>
        <a href="bulletinAction_addUI.action"><img src="jsp/images/add_01.gif" border="0"></a>
        <a href="javascript: ModiButton_onclick()"><img src="jsp/images/change_01.gif" border="0"></a>
        <a href="javascript: ListForm_onclick()"><img src="jsp/images/cut_01.gif" border="0"></a>
      
          <a href="javascript: StopPut_onclick()"><img src="jsp/images/sign_04.gif" border="0"></a>
          <a href="javascript: huiFuPut_onclick()"><img src="jsp/images/sign_huiFu.gif" border="0"  ></a>
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
        <td width="6%" bgcolor="959185"> 
              <div align="center"><font color="#FFFFFF">选择</font></div>
    	</td>
        <td width="50%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">通告标题</font></div>
        </td>
        <td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">目前是否发布</font></div>
        </td>				
        <td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">发布时间</font></div>
        </td>        
      </tr>
		
     <s:iterator value="#request.listBulletin" var="bu">


      <tr bgcolor=> 
        <td width="6%" align="center"> 
			<input type="checkbox" name="selCheck" value="${bulletinID }" >               
        </td>
        <td width="50%"><a href="bulletinAction_editUI.action?bulletinID=${bulletinID }"><s:property value="%{#bu.bulletinTitel}"/></a> </td>
        
		<td width="13%" align="center"><s:if test="#bu.ifPut!=0">是 </s:if><s:else>否</s:else></td>           
		<td width="13%"><s:property value="%{#bu.CreatTime}"/></td> 		
      </tr>
						            
     </s:iterator>	
      

       
    </table>
  
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
