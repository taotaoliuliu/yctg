<%@page contentType="text/html;charset=utf-8" import="java.util.*"%> 
<%@ taglib prefix="s" uri="/struts-tags"%> 
<script language="javascript" src="/include/jquery.js"></script>

<%
String LimitSetTime=(String)request.getAttribute("LimitSetTime");
String name=(String)request.getAttribute("name");
if(name==null) name="";
%>
<script language="javascript">

	function status_onclick(){
		Status.MyAction.value=null;
		Status.submit();
	}
	function zhuzhuang(){
		
		
				var ss= document.getElementById("StartDate").value;
	var ee= document.getElementById("EndDate").value;
	document.location.href="textAction_authorStatusZZ.action?StartDate="+ss+"&EndDate="+ee;
		
	}
	

	
</script>

<script type="text/javascript">
		function onSortByChange( selectedValue ){
			 $(document).ready(function(){
				  var hidval = $("#hidval").val();
				  if(selectedValue==hidval)
				  {
					  $("#hidval").attr("selected","selected");
					  }
				  
				  
				  })
		
		}

		
	</script>

<html>
<head>
<title>stat management</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />


</head>
<script language="javascript" src="include/DateList.js"></script>
<body bgcolor="#C8D4E2" text="#000000">
<table border=0 width=100% cellpadding="0" cellspacing="0">
<br/>
<br/>
  <tr align="center">
    <td width="99%" class="text">
	<b>::&nbsp;&nbsp;<a href="textAction_manyList.action">稿件查询</a>&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b>
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_textStatusUI.action">稿件统计</a>&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b> 
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;作者统计&nbsp;&nbsp;::</b>	
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_textStatusUI2.action">见报统计</a>&nbsp;&nbsp;::</b>
	
	<br>
	<br>
	<br>
        <hr width="100%" size="1" noshade>
    </td>
  </tr>
</table>
<form name="Status" method="post" action="textAction_authorStatus.action">
<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td>
<input type="hidden" name="MyAction" value="">
&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="LimitSetTime" value = "0" <%if("0".equals(LimitSetTime)){%>checked<%}%> >不限制
	    		<input type="radio" name="LimitSetTime" value = "1" <%if("1".equals(LimitSetTime)){%>checked<%}%>> 
<%@ include file="/include/Ymd_Ymd1.jsp"%>&nbsp;&nbsp;&nbsp;&nbsp;


&nbsp;&nbsp;&nbsp;&nbsp;

<input type="submit" value=" 统   计 " onClick="status_onclick()">&nbsp;&nbsp;
&nbsp;

<input type="button" value=" 柱 状 图 " onClick="zhuzhuang()">&nbsp;&nbsp;
</td></tr></table>


<table width="98%" align="center">
<th align="center">中国气象报作者统计</th>
</table>

<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="60" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="1" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr bgcolor="#F3F9FD">
	<td align="center" width="40%" bgcolor="#6481A9">作者</td>
	<td align="center" bgcolor="#6481A9">人数</td>

	</tr>
	<s:if test="#listStatus!=null&&#listStatus.size>0">
	<s:iterator value="#listStatus" var="ss" status="status">
	<tr>
		
			<td align="center">
			${sum2}
			</td>
			<td align="center">
			${sum}
			</td>
		
	</tr>
	</s:iterator>
	</s:if>
    </table>  
 </td>
    
  </tr>
</table>

</form>

<%
List list=(List)request.getAttribute("list2");

%>
<%
if(list!=null&&list.size()>0)
	{%>
	

<SPAN >
<div align="center">

<fieldset style="width: 600px; height: 600px; padding: 1 background:${pageContext.request.contextPath }/images/back1.JPG"><legend>
<font color="#0000FF">
<img border="0" src="${pageContext.request.contextPath }/images/zoom.gif" width="14" height="14"> 报表统计</font></legend>		
	<img src="${pageContext.request.contextPath}/Unicontribution/${filename}" border="0">
</fieldset>
</div>
</SPAN>

	<% }%>

<p>&nbsp;</p>
</body>
</html>
