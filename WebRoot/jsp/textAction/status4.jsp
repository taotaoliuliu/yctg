





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
		
	

		
		document.location.href="textAction_textStatusBaoBiao.action?StartDate="+ss+"&EndDate="+ee;
		
		
		
	}
</script>


</head>
<script language="javascript" src="include/DateList.js"></script>
<body bgcolor="#C8D4E2" text="#000000" onload="setup()">  



<form name="Status" method="post" action="textAction_textStatusZZ.action">

<%

String jianbao=(String)request.getAttribute("jianbao");
if(jianbao==null) jianbao="来稿";
else jianbao="见报";

%>

<table width="98%" align="center">
<th align="center">中国气象报<%=jianbao %>统计</th>
</table>

<table width="75%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="60" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="1" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr bgcolor="#F3F9FD">
	<td align="center" width="10%" bgcolor="#6481A9">省份</td>
	
	<td align="center" width="10%" bgcolor="#6481A9">省份稿件数量</td>
		<td align="center" width="20%" bgcolor="#6481A9">市区</td>
	
		<td align="center" width="10%" bgcolor="#6481A9">市区稿件数量</td>
	
		<td align="center" width="30%" bgcolor="#6481A9">县区</td>
	
	
		<td align="center" width="20%" bgcolor="#6481A9">县区稿件数量</td>

	</tr>
	<s:if test="#listStatus!=null&&#listStatus.size>0">
	<s:iterator value="#listStatus" var="ss" status="status"> 
	<tr>
	

		
			<td align="center">
			${name_Login}  
			</td>
			<td align="center">
			${name_real}
			</td>
			<td align="center">
			${sum}
			</td>
			<td align="center">
			${sum2}
			</td>
			<td align="center">
			${sum3}
			</td>
			<td align="center">
			${sum4}
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

</body>
</html>
