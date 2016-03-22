<%@page contentType="text/html;charset=utf-8" %> 

<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>stat management</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="javascript" src="${pageContext.request.contextPath}/script/jquery.js"></script>
<script language="javascript" src="${pageContext.request.contextPath}/script/jquery_validate/jquery.metadata.js"></script>
<script language="javascript" src="${pageContext.request.contextPath}/script/jquery_validate/jquery.validate.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />


<script type="text/javascript">

	$(function(){
   		$("form").validate();
   	});
</script>
</head>
<script language="javascript">	
	var submitType = "";
	function selectPlate()
	{
		//alert('uuuuuuuuuuuuuuu'+document.getElementById("plate").value);
		URL = "main_stat.jsp?curpage=" + "&plate="+document.getElementById("plate").value;
		//alert(URL);
		document.location = URL;
		//alert();
	}
	
	function downloadFile()
	{
		submitType = "download";
		ListForm_onclick();
		//alert("实现另存功能！！");
		ListForm.submit();
		
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
			alert("请选择稿件！");
			return false;
		}
		if(submitType=="download")
		{
			if(confirm("是否要下载所选内容?"))
			{
				ListForm.MyAction.value="download";
				ListForm.action="TextManage/text_delete.jsp?curpage=&limit=";
				return true;
			}
			else
				return false;
		}
		else
		{
			if(confirm("是否要删除所选信息?"))
			{
				ListForm.MyAction.value="Del";
				ListForm.action="TextManage/text_delete.jsp?curpage=&limit=";
				return true;
			}
			else
				return false;
		}
	}
	
	function Search_OnClick()
	{
		addWin = window.open("textAction_textSearch.action","searchWin","width=500,height=280,resizable=yes,menubar=no,scrollbars=yes,toolbar=no,menubar=no,location=no");
		addWin.focus();
	}	

	
	
	function selectAll()
	{
		if (ListForm.selectAllBox.checked)
			for (var i=0;i<ListForm.elements.length;i++)
		    	{
		    		var allName = ListForm.elements[i].name;
		    		if (allName=="selCheck")
		    			ListForm.elements[i].checked = 1;
		    	}
		if (!ListForm.selectAllBox.checked)
				for (var i=0;i<ListForm.elements.length;i++)
		    	{
		    		var allName = ListForm.elements[i].name;
		    		if (allName=="selCheck")
		    			ListForm.elements[i].checked = 0;
		    	}
	}
	
    function openWin(srcFile,winWidth,winHeight)    
    {       
        //var winFeatures = "scroll:yes;dialogWidth:"+winWidth+"px;dialogHeight:"+winHeight+"px;dialogLeft:"+(event.screenX-winWidth)+";help:no;resizable:yes;status:no;dialogTop:"+(20);
		var winFeatures = "scrollbars=yes,resizable=yes,status=no,width="+winWidth+",height="+winHeight+",left="+(event.screenX)+",top="+(20);
		//alert(event.screenX);
       var obj = "";  //將物件传到新窗中  
	   window.open(srcFile, obj, winFeatures);              
        //window.showModalDialog(srcFile, obj, winFeatures);          
       /* var retstr = window.showModalDialog(srcFile, obj, winFeatures);
        if (retstr)
        {
        	if (retstr == "qfok")
        	{
        		alert("签发成功，按确定返回！")
				self.close();
        	}
        }  */          
    }	
</script>	
<body bgcolor="#C8D4E2" text="#000000">

<Table border=0 width=100% cellpadding="0" cellspacing="0">
<br/>
<br/>

        <tr align="center" > 
          
    <td width="99%" class="text">
  
    <b>::&nbsp;&nbsp;稿件查询&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b>
    
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_textStatusUI.action">稿件统计 </a>&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b>
	&nbsp;&nbsp;
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_authorStatusUI.action">作者统计</a>&nbsp;&nbsp;::</b>
	
		<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_textStatusUI2.action">见报统计</a>&nbsp;&nbsp;::</b>
	
	<br>
	<br>
	<br>
	
          <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>
 

<form name="ListForm" method="post" action="" onSubmit="return ListForm_onclick();">
<input type="hidden" name="MyAction">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="jsp/images/main_01.gif" width="2" height="27"></td>
    <td background="images/main_01.gif" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<TR>
		<TD>
        <a href="#" onClick="Search_OnClick()"><image src="jsp/images/search.gif" border="0"></a>
        <a href="textAction_manyList.action"><image src="jsp/images/sign_05.gif" border="0"></a>
        </TD>
    </TR>
</table>
</td>


    <td width="5" align="right"><img src="images/main_02.gif" width="5" height="27"></td>
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
        <td width="30%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">稿件标题</font></div>
        </td>				
        <td width="6%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">体裁</font></div>
        </td> 				
        <td width="9%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">传稿人</font></div>
        </td>        
        <td width="9%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">传稿日期</font></div>
        </td>      
        <td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">版块</font></div>
        </td>
        <td width="9%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">IP地址</font></div>
       	</td> 
	<td width="5%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">提交</font></div>
        </td> 
        <td width="5%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">入库</font></div>
        </td>  
        <td width="9%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">状态</font></div>
        </td>
       
      </tr>
			    

	<s:iterator value="recordList">
      <tr bgcolor=> 
 	<td width="5%" align="center"> 
	<input type="checkbox" name="selCheck" value="${textID }" >               
        </td>
        <td width="30%"><a href="javascript:void(0)" onClick="openWin('textAction_showText.action?textID=${textID}',650,500)">${textTitle}</a></td>	
	<td width="6%" >${rest1 }</td>	
	<td width="9%" >${sender}</td> 
	<td width="9%" align="center">${ContributeDate }</td>
	<td width="7%" align="center">${cat }</td> 
	<td width="9%" align="center">${AuthorIP }</td> 
	<td width="5%" align="center">${rest3 }</td>
	<td width="5%" align="center">${isUsed }</td>
	<td width="9%" align="center">${status }</td>
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
