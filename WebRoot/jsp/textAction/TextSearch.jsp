<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.Enumeration,java.lang.String"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="s" uri="/struts-tags"%> 
<%@ page import = "java.util.*"%>



<html>
<head>
<title>远程投稿系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/css/style2.css" type="text/css">
<script Language="JavaScript">
function Search_OnClick()
{
     var frm = document.Search;     
     var i;
     var query;
     
     var ifLimitTime;
     ifLimitTime=Search.LimitSetTime(1).value;
     query="";
     if(ifLimitTime=="1")
     {
     	var startTime=Search.StartDate.value;
     	var endTime=Search.EndDate.value;
     	query=" and textInfo.ContributeDate >= '"+startTime+"' and  textInfo.ContributeDate <'"+endTime+"'";
     }
     
     var author;
     author=Search.author.value;
     if(!(author==null||author==""))
     {
     	query+=" and textInfo.author ='"+author+"'";
     }
	 
	 var sender;
     sender=Search.sender.value;
     if(!(sender==null||sender==""))
     {
     	query+=" and textInfo.sender ='"+sender+"'";
     }
	 
     var IDCard;
     IDCard=Search.IDCard.value;
     if(!(IDCard==null||IDCard==""))
     {
     	query+=" and userInfo.IDCard like '"+IDCard+"%25'";
     }     
     
     
	 
	 var workcompany;
     workcompany=Search.workcompany.value;
     if(!(workcompany==null||workcompany==""))
     {
     	query+=" and userInfo.workcompany ='"+workcompany+"'";
     }
     	//alert(query);
		window.opener.location.href="../main_stat.jsp?limit="+query;

	 self.close();
}
function checkradio()
{
	if (Search.LimitSetTime(1).value == "0"){
		Search.LimitSetTime(1).value="1";
		Search.LimitSetTime(0).value="1";
	}
	else{
		Search.LimitSetTime(0).value="0";
		Search.LimitSetTime(1).value="0";
	}
	
}

function checkradio1()
{
	if (Search.LimitSetTime(1).value == "1"){
		Search.LimitSetTime(1).value="0";
		Search.LimitSetTime(0).value="0";
	}
	else{
		Search.LimitSetTime(0).value="1";
		Search.LimitSetTime(1).value="1";
	}
	
}

</script>


</head>
<script language="javascript" src="${pageContext.request.contextPath}/include/DateList.js"></script>
<body bgcolor="#D9E8ED" text="#000000" leftmargin="20" topmargin="6">

<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;稿件检索&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="200" valign="top"> 

	<form name="Search" method="post" action="textAction_textSearchRe.action" target="_self" />
	<input name="search" type="hidden" value="kkkk">
	<fieldset style="width:400" align="center" bgcolor="#FFFFFF">
	<legend align="left">
	<b>高级检索</b>
	</legend>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td width="90">时间范围：</td>
			<td>
				<input type="radio" name="LimitSetTime" value = "0" onClick="javascript: return checkradio1()" checked>不限制
	    		<input type="radio" name="LimitSetTime" value = "0" onClick="javascript: return checkradio()">
				<%@include file="/include/Ymd_Ymd.jsp"%>		
			</td>
		</tr>

		<tr>
			<td width="90">作　　者：</td>
			<td> <s:textfield name="author" cssStyle="width:200pt;" cssClass="input0"></s:textfield></td>
		</tr>	
		<tr>
			<td width="90">传 稿 人：</td>
			<td><s:textfield name="sender" cssStyle="width:200pt;" cssClass="input0"></s:textfield></td>
		</tr>		
		<tr>
			<td width="90">作者身份证：</td>
			<td><s:textfield name="idcard" cssStyle="width:200pt;" cssClass="input0"></s:textfield></td>
		</tr>
		
		<tr>
			<td width="90">作者单位：</td>
			<td><s:textfield name="workcompany" cssStyle="width:200pt;" cssClass="input0"></s:textfield></td>
		</tr>			

		
	
							
	</table>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<TR align=left>
	            <TD align="left">
	           <input type="submit" name="btnSearch" id = "btnSearch"  align="bottom" border="0" width="69" height="20" value = "搜 索">
	           <input type="button" name="btnSearch" id = "btnSearch"  align="bottom" border="0" width="69" height="20" value = "取 消" onClick="javascript: self.close();">
			   
		       </TD>
			</TR>
		</table>
		<br>	
	</fieldset>
   		
	</form>
      
    </td>
    <td background="../images/main_03.gif" width="5"><img src="../images/main_03.gif" width="5" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4" height="4"><img src="../images/main_06.gif" width="4" height="4"></td>
    <td background="../images/main_05.gif" height="4"><img src="../images/main_05.gif" width="2" height="4"></td>
    <td width="5" height="4"><img src="../images/main_04.gif" width="5" height="4"></td>
  </tr>
</table>

</body>
</html>
