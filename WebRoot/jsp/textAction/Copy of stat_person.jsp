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
			alert("��ѡ��Ҫ�༭�ĸ����");
		}else if (temp.length>1)
		{
			alert("��ѡ���˶�ƪ�����");
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
			alert("��ѡ��Ҫ�ύ�ĸ����");
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
        var obj = "";  //����������´���         
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
      href="textAction_textContribute.action">::&nbsp;Ͷ����---ͼ�ĸ��&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
	<TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute2.action">::&nbsp;Ͷ����---��Ƶ���&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
	<TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute3.action">::&nbsp;Ͷ����---��Ƶ���&nbsp;::</A></h4></B> 
      <BR>
      
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_statPerson.action">::&nbsp;${name }���ϴ����ͳ��&nbsp;::</A></h4></B><BR>
      
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
              <div align="center"><font color="#FFFFFF">ѡ��</font></div>
    	</td>
        <td width="38%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">�������</font></div>
        </td>		
        <td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">���</font></div>
        </td>				
        <td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">������</font></div>
        </td>        
        <td width="11%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">��������</font></div>
        </td>
		<td width="13%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">���</font></div>
        </td> 
		<td width="5%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">Ͷ�巽ʽ</font></div>
        </td> 
		<td width="6%" bgcolor="959185">
			<div align="center"><font color="#FFFFFF">���</font></div>
		</td>
		<td width="7%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">ʹ��ý��</font></div>
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
		ҳ�Σ�${currentPage}/${pageCount }ҳ &nbsp;
		ÿҳ��ʾ��${pageSize }�� &nbsp;
		�ܼ�¼����${recordCount }��
	</div>
	<div id=PageSelectorSelectorArea>
	
		<a href="javascript:gotoPage(1)" title="��ҳ" style="cursor: hand;">
			��ҳ
		</a>
		
		<s:iterator begin="beginPageIndex" end="endPageIndex" var="num">
			<s:if test="#num == currentPage"><!-- ��ǰҳ -->
				<span class="PageSelectorNum PageSelectorSelected">${num}</span>
			</s:if>
			<s:else><!-- �ǵ�ǰҳ -->
				<span class="PageSelectorNum" style="cursor: hand;" onClick="gotoPage(${num});">${num}</span>
			</s:else>
		</s:iterator>
		
		<a href="javascript:gotoPage(${pageCount})" title="βҳ" style="cursor: hand;">
			βҳ
		</a>
		<!-- 
		ת����
		<select id="pn" onchange="gotoPage(this.value)">
			<s:iterator begin="1" end="%{pageCount}" var="num">
				<option value="${num}">${num}</option>
			</s:iterator>
		</select>
		
		<script type="text/javascript">
			$("#pn").val(${currentPage});
		</script>
		-->
	ת��
    <input type="text" id="pageNum2" name="pageNum2" value="${currentPage }" style="width: 30px;" /> 
     ҳ 
     <input type="button" value="��ѯ" style="width: 30px;" onclick="go(${pageCount }, ${currentPage })" />
		
		
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
<div style="text-align:center;">ʹ��ý��˵����<br>
======================================================<br>
����ȡ��������Ѿ��������ݿ⣬�ɹ��༭�鿴��<br>
��ĳý�壺��ȡ���������ĳý���ע��<br>
��ĳý�壺��***�������������ĳý�塣<br>
�й����󱨾���绰��010-68406868
CMA��վ��ϵ�绰��010-68409797
��ý����ϵ�绰��010-58995850<br>
======================================================<br>
��ע��<a href="/newmedia.docx">������ý�巢��������˵��</a>

	</div>
</body>
</html>


<script type="text/javascript">
	function gotoPage( pageNum ){
		 //window.location.href = "topicAction_show.action?id=${topic.id}&pageNum=" + pageNum;
		
		$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
		document.forms[0].pageNum.value = pageNum;
		document.forms[0].submit(); // �ύ��
	}
	
	function go(totalPageNum, defaultValue) {
  		// ����ı������������
  		var pageNumObj = document.getElementById("pageNum2");
  		var pageNum = pageNumObj.value;
  		if(pageNum==null || pageNum=="") {
  			alert("ҳ������Ϊ��");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  		var num = parseInt(pageNum);	// NaN  not a number
  		if(isNaN(num)) {
  			alert("������һ������");
  			pageNumObj.value = defaultValue;
  			return ;
  		}
  		if(num<1 || num>totalPageNum) {
  			alert("�Բ���û����һҳ");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  	$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
  		
  		document.forms[0].submit();
	}
</script>

