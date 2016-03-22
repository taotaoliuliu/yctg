





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





<%
String province=(String)request.getAttribute("province");

String city=(String)request.getAttribute("city");

String LimitSetTime=(String)request.getAttribute("LimitSetTime");
%>

<SCRIPT LANGUAGE = JavaScript>   
<!--   
//** Power by Fason(2004-3-11)   
//** Email:fason_pfx@hotmail.com   
  
var s=["s1","s2"];   
var opt0 = ["请选择","请选择"];   
function setup()     
{     
for(i=0;i<s.length;i++)     
	
	
  document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");     
change(0);     
		function trimStr(str){return str.replace(/(^\s*)|(\s*$)/g,"");};


var pr='${province}';



var ci='${city}';



 pr=trimStr(pr);
  ci=trimStr(ci);
  
 if(pr=='北京'||pr=='天津'||pr=='重庆'||pr=='上海')
	  {
	  	ci=pr;
	  }
 
if(pr=='') pr='请选择';
if(ci=='') ci='请选择';



    document.getElementById('s1').value=pr;  
    change(1);   
document.getElementById('s2').value=ci;   
}      

//-->   
</SCRIPT>  






<script language="javascript">
	function makefile_onclick()
	{

		  Status.MyAction.value="export";
		  //SourceSeek.target = "bottomFrame";
		 //alert('mmmmmmmm');
		  Status.submit();
		  //Status.MyAction.value=null;
		  return false;
	}
	function status_onclick(){
		Status.MyAction.value=null;
		Status.submit();
	}
	
	function status_onclick2(){
			Status.MyAction.value=null;
	
		Status.submit();
	}
	
	function aa(obj){
	
		if(obj==0){
			
		ll= document.getElementById("LimitSetTime").value;
		
		}
		if(obj==1){
			
		ll=	document.getElementById("LimitSetTime2").value;
		
			
		}
	
	}
	function zhuzhuang(obj){
	
		var pp= document.getElementById("s1").value;
				var cc= document.getElementById("s2").value;
		
		var ss= document.getElementById("StartDate").value;
		var ee= document.getElementById("EndDate").value;
	
		  var ll="";
  var radio=document.getElementsByName("LimitSetTime");
  for(var i=0;i<radio.length;i++){
	if(radio[i].checked==true){
	  ll=radio[i].value;
	  break;
	}
  }
		
document.location.href="textAction_textStatusZZ.action?city="+cc+"&province="+pp+"&StartDate="+ss+"&EndDate="+ee+"&LimitSetTime="+ll+"";
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	function baobiao(obj){
	
		var ss= document.getElementById("StartDate").value;
		var ee= document.getElementById("EndDate").value;
	
		  var ff="";
  var radio=document.getElementsByName("LimitSetTime");
  for(var i=0;i<radio.length;i++){
	if(radio[i].checked==true){
	  ff=radio[i].value;
	  break;
	}
  }
document.location.href="textAction_textStatusBaoBiao.action?StartDate="+ss+"&EndDate="+ee+"&LimitSetTime="+ff;
		
		
		
	}
	
	
		function county(obj){
	
		var ss= document.getElementById("StartDate").value;
		var ee= document.getElementById("EndDate").value;
	
		  var ff="";
  var radio=document.getElementsByName("LimitSetTime");
  for(var i=0;i<radio.length;i++){
	if(radio[i].checked==true){
	  ff=radio[i].value;
	  break;
	}
  }
document.location.href="textAction_textStatusByCounty.action?StartDate="+ss+"&EndDate="+ee+"&LimitSetTime="+ff;
		
		
		
	}
	
	
	
</script>


</head>
<script language="javascript" src="include/DateList.js"></script>
<body bgcolor="#C8D4E2" text="#000000" onload="setup()">  
<table border=0 width=100% cellpadding="0" cellspacing="0">
<br/>
<br/>
  <tr align="center">
    <td width="99%" class="text">
	<b>::&nbsp;&nbsp;<a href="textAction_manyList.action">稿件查询</a>&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b>
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;稿件统计&nbsp;&nbsp;::&nbsp;&nbsp;&nbsp;&nbsp;</b> 
	<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_authorStatusUI.action">作者统计</a>&nbsp;&nbsp;::</b>	
			<b>&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;&nbsp;<a href="textAction_textStatusUI2.action">见报统计</a>&nbsp;&nbsp;::</b>
	
	<br>
	<br>
	<br>
        <hr width="100%" size="1" noshade>
    </td>
  </tr>
</table>



<form name="Status" method="post" action="textAction_textStatusZZ.action">
<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td>
<input type="hidden" name="MyAction" value="">
&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="LimitSetTime" id="LimitSetTime" value="0" <%if("0".equals(LimitSetTime)){%>checked  <%}%> onchange="aa('0')">不限制
<input type="radio" name="LimitSetTime" id="LimitSetTime2" value="1" <%if("1".equals(LimitSetTime)){%>  checked <%}%> onchange="aa('1')"> 
<%@ include file="/include/Ymd_Ymd1.jsp"%>&nbsp;&nbsp;&nbsp;&nbsp;



省：
         <select id="s1" name="province"><option>请选择</option></select>
市：<select id="s2" name="city"><option>请选择</option></select>





&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value=" 统   计 " onClick="status_onclick()">&nbsp;&nbsp;
&nbsp;
<input type="button" value=" 柱 状 图 " onClick="zhuzhuang(<%=LimitSetTime %>)">&nbsp;&nbsp;

<input type="button" value="省市县统计" onClick="baobiao(<%=LimitSetTime %>)">&nbsp;&nbsp;
<input type="button" value="县区统计" onClick="county(<%=LimitSetTime %>)">&nbsp;&nbsp;


</td></tr></table>


<table width="98%" align="center">
<th align="center">中国气象报来稿统计</th>
</table>

<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="60" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="1" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr bgcolor="#F3F9FD">
	<td align="center" width="40%" bgcolor="#6481A9">省份</td>
	<td align="center" bgcolor="#6481A9">稿件数量</td>

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
    <td background="images/main_03.gif" width="5"><img src="images/main_03.gif" width="5" height="1"></td>
  </tr>
</table>
<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4" height="4"><img src="images/main_06.gif" width="4" height="4"></td>
    <td background="images/main_05.gif" height="4"><img src="images/main_05.gif" width="1" height="4"></td>
    <td width="5" height="4"><img src="images/main_04.gif" width="5" height="4"></td>
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
