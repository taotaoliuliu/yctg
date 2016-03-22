<%@page contentType="text/html;charset=GBK" %> 

<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<title>user management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<%@ include file="/jsp/public/commons.jspf"%>

</head>

<script language="javascript">	

	function eidtTextButton(bb)
	{
		var temp=new Array(); 
		for(var i=0;i<bb.selCheck.length;i++) 
		{ 
			if(bb.selCheck[i].checked) 
				temp.push(bb.selCheck[i].value);
		} 
		if(temp.length==0)
		{
			alert("请选择要编辑的稿件！");
		}else if (temp.length>1)
		{
			alert("您选中了多篇稿件！");
		}else
		{
			var url = "editText.jsp?textID="+temp[0];
			//openWin(url,650,500);
			document.location = url;
		}
		
	}
	
	function deleteTextButton()
	{
	    /*var f = document.getElementById("ListForm");
	    f.action = "text_process.jsp";
		f.submit();*/
		
		ListForm.MyAction.value="Del";
		ListForm.action = "text_process.jsp";
		ListForm.submit();
	}

	function submitTextButton(bb)
	{
		var temp=new Array(); 
		for(var i=0;i<bb.selCheck.length;i++) 
		{ 
			if(bb.selCheck[i].checked) 
				temp.push(bb.selCheck[i].value);
		} 
		if(temp.length==0)
		{
			alert("请选择要提交的稿件！");
		}else
		{		
			ListForm.MyAction.value="Sub";
			ListForm.action = "text_process.jsp";
			ListForm.submit();
		}
	}


	
    function openWin(srcFile,winWidth,winHeight)    
    {       
        var winFeatures = "scrollbars=yes,resizable=yes,status=no,width="+winWidth+",height="+winHeight+",left="+(event.screenX)+",top="+(20);
        var obj = "";  //將物件传到新窗中         
		 window.open(srcFile, obj, winFeatures);         
        
    }	

</script>	
<body text="#000000" leftmargin="0" topmargin="0" >
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="30" background="../images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="../images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="../images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="../images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="../images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
  </TR>
  <TR align="center">
    <TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute.action">::&nbsp;投稿区---图文稿件&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
	<TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute2.action">::&nbsp;投稿区---视频稿件&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
	<TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute3.action">::&nbsp;投稿区---音频稿件&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_statPerson.action">::&nbsp;${name }的上传稿件统计&nbsp;::</A></h4></B><BR>
      
  </TD></TR></TBODY></TABLE>


<form name="ListForm" method="post" action="" >	
			<input type="hidden" name="MyAction">
<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
    <td background="../images/main_01.gif" align="right">    


    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="150" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="2" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr> 
	<td width="6%" bgcolor="959185"> 
              <div align="center"><font color="#FFFFFF">选择</font></div>
    	</td>
        <td width="38%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">稿件标题</font></div>
        </td>		
        <td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">体裁</font></div>
        </td>				
        <td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">传稿人</font></div>
        </td>        
        <td width="11%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">传稿日期</font></div>
        </td>
		<td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">版块</font></div>
        </td> 
		<td width="5%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">投稿方式</font></div>
        </td> 
		<td width="6%" bgcolor="959185">
			<div align="center"><font color="#FFFFFF">入库</font></div>
		</td>
		<td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">使用媒体</font></div>
        </td>         
      </tr>	      
         <s:iterator value="recordList">


      <tr bgcolor=> 
 	<td width="6%" align="center"> 
	<input type="checkbox" disabled="" name="selCheck" value="${textID }"  />               
        </td>
        <td width="38%"><a href="javascript:void(0)" onClick="openWin('textAction_showText.action?textID=${textID}',650,500)">${textTitle }</a></td>	
		<td width="7%" >${rest1 }</td> 
	<td width="7%" >${author }</td> 
	<td width="11%" align="center">${ContributeDate }</td> 
	<td width="13%" align="center">${Cat }</td> 
	<td width="5%" align="center">${rest3 }</td>
	<td width="6%" align="center">${IsUsed }</td>
	<td width="7%" align="center">${status }</td>
	
      </tr>
					 </s:iterator>				            
						         
    </table>
    
       <s:form action="userAction_list"></s:form>
	<div id=PageSelectorBar>
	<div id=PageSelectorMemo>
		页次：${currentPage}/${pageCount }页 &nbsp;
		每页显示：${pageSize }条 &nbsp;
		总记录数：${recordCount }条
	</div>
	<div id=PageSelectorSelectorArea>
	
		<a href="javascript:gotoPage(1)" title="首页" style="cursor: hand;">
			首页
		</a>
		
		<s:iterator begin="beginPageIndex" end="endPageIndex" var="num">
			<s:if test="#num == currentPage"><!-- 当前页 -->
				<span class="PageSelectorNum PageSelectorSelected">${num}</span>
			</s:if>
			<s:else><!-- 非当前页 -->
				<span class="PageSelectorNum" style="cursor: hand;" onClick="gotoPage(${num});">${num}</span>
			</s:else>
		</s:iterator>
		
		<a href="javascript:gotoPage(${pageCount})" title="尾页" style="cursor: hand;">
			尾页
		</a>
		<!-- 
		转到：
		<select id="pn" onchange="gotoPage(this.value)">
			<s:iterator begin="1" end="%{pageCount}" var="num">
				<option value="${num}">${num}</option>
			</s:iterator>
		</select>
		
		<script type="text/javascript">
			$("#pn").val(${currentPage});
		</script>
		-->
	转到
    <input type="text" id="pageNum2" name="pageNum2" value="${currentPage }" style="width: 30px;" /> 
     页 
     <input type="button" value="查询" style="width: 30px;" onclick="go(${pageCount }, ${currentPage })" />
		
		
	</div>	
</div>
   </td>
    <td background="../images/main_03.gif" width="5"><img src="../images/main_03.gif" width="5" height="1"></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4" height="4"><img src="../images/main_06.gif" width="4" height="4"></td>
    <td background="../images/main_05.gif" height="4"><img src="../images/main_05.gif" width="1" height="4"></td>
    <td width="5" height="4"><img src="../images/main_04.gif" width="5" height="4"></td>
  </tr>
</table>  
  <input type="checkbox" name="selCheck" id="selCheck" style="display:none"> 
</form>

<p>&nbsp;</p>
<div style="text-align:center;">使用媒体说明：<br>
======================================================<br>
“待取”：稿件已经进入数据库，可供编辑查看。<br>
“某媒体：待取”：稿件被某媒体关注。<br>
“某媒体：见***”：稿件发布至某媒体。<br>
中国气象报纠错电话：010-68406868
CMA网站联系电话：010-68409797
新媒体联系电话：010-58995850<br>
======================================================<br>
备注：<a href="/newmedia.docx">附：新媒体发布渠道的说明</a>

	</div>
</body>
</html>


<script type="text/javascript">
	function gotoPage( pageNum ){
		 //window.location.href = "topicAction_show.action?id=${topic.id}&pageNum=" + pageNum;
		
		$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
		document.forms[0].pageNum.value = pageNum;
		document.forms[0].submit(); // 提交表单
	}
	
	function go(totalPageNum, defaultValue) {
  		// 获得文本框输入的内容
  		var pageNumObj = document.getElementById("pageNum2");
  		var pageNum = pageNumObj.value;
  		if(pageNum==null || pageNum=="") {
  			alert("页数不能为空");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  		var num = parseInt(pageNum);	// NaN  not a number
  		if(isNaN(num)) {
  			alert("请输入一个数字");
  			pageNumObj.value = defaultValue;
  			return ;
  		}
  		if(num<1 || num>totalPageNum) {
  			alert("对不起！没有这一页");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  	$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
  		
  		document.forms[0].submit();
	}
</script>

