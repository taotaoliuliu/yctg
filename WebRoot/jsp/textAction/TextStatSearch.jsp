<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.Enumeration,java.lang.String"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import = "java.util.*"%>



<html>
<head>
<title>远程投稿系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<script Language="JavaScript">
function Search_OnClick()
{
     var frm = document.Search;     
     var i;
     
     var ifLimitTime;
     ifLimitTime=Search.LimitSetTime(1).value;
     
     var startTime="";
     var endTime="";
     var searchtext="";
     var searchtextflag="";
     
     if(ifLimitTime=="1")
     {
     	startTime=Search.StartDate.value;
     	endTime=Search.EndDate.value;
     }
     
     searchtext=Search.TextSearch.value;
     searchtext=encodeURI(searchtext);
     searchtext=encodeURI(searchtext);
     for(var i=0;i<Search.SearchRange.length;i++)
     {
     	if(Search.SearchRange[i].checked)
     	{
     		searchtextflag=Search.SearchRange[i].value;
     	}
     }
     	window.opener.location.href="textAction_textAmount.action?startTime="+startTime+"&&endTime="+endTime+"&&searchtextflag="+searchtextflag+"&&searchtext="+searchtext;

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
<script language="javascript" src="../include/DateList.js"></script>
<body bgcolor="#D9E8ED" text="#000000" leftmargin="20" topmargin="6">

<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;稿件统计检索&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="200" valign="top"> 

	<form name="Search" method="post" action="TextStatSearch.jsp" target="_self" onSubmit="return Search_OnClick()">
	<fieldset style="width:400" align="center" bgcolor="#FFFFFF">
	<legend align="left">
	<b>高级检索</b>
	</legend>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td width="90">时间范围：</td>
			<td>
				<input type="radio" name="LimitSetTime" value = "0" onclick="javascript: return checkradio1()" checked>不限制
	    		<input type="radio" name="LimitSetTime" value = "0" onclick="javascript: return checkradio()">
				<%@include file="/include/Ymd_Ymd1.jsp"%>		
			</td>
		</tr>

		<tr>
			<td width="90">搜索字段：</td>
			<td><Input name="TextSearch" style= "width:200pt;" class=input0 value="" ></td>
		</tr>		

		<tr>
			<td width="90">搜索范围：</td>
			<td><Input type="radio" name="SearchRange" value="province">作者所属省<Input type="radio" name="SearchRange" value="city">作者所属市<Input type="radio" name="SearchRange" value="Author" checked >作者姓名</td>
		</tr>		
							
	</table>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<TR align=left>
	            <TD align="left">
	           <input type="submit" name="btnSearch" id = "btnSearch"  align="bottom" border="0" width="69" height="20" value = "搜 索">
	           <input type="button" name="btnSearch" id = "btnSearch"  align="bottom" border="0" width="69" height="20" value = "取 消" onclick="javascript: self.close();">
			   
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
