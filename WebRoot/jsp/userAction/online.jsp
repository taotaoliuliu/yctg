<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/jsp/public/commons.jspf"%>
<title>online</title>
</head>
<body>

<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    &nbsp;&nbsp;
   <h4> <b>::&nbsp;&nbsp;在线用户&nbsp;&nbsp;::</b></h4><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<div align="center">
<font size="4" >当前共有<font color="red" size="6"><s:property value="%{#request.list.size}"/></font>人在线</font>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f0f0f0" align="center" height="150" valign="top">
  <table width="100%" border="1" cellspacing="0" cellpadding="2" class=font9  style="BORDER-bottom: #000000 2px solid;BORDER-top: #000000 2px solid;BORDER-left: #000000 1px solid;BORDER-right: #000000 1px solid;BACKGROUND-COLOR: #F6F6F6" bordercolor="#F6F6F6" >
    <tr> 
      
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#0000FF">用户登录名</font></div>
        </td>
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#0000FF">用户姓名</div>
        </td>				
        <td width="10%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">IP</font></div>
        </td>
	
        <td width="8%" bgcolor="959185"> 
          <div align="center"><font color="#FFFFFF">登录时间</font></div>
        </td>        
     
        </td>  
		            
      

       
   
<s:iterator value="#request.list">


  <tr>
			     
        <td width="8%"><a href="userAction_lookUser.action?username=${name_Login }">${name_Login}</a></td>
		<td width="8%">${name}</td>           
		<td width="10%">${ips}</td> 
		<td width="8%" align="center">${time}</td> 		
		
      </tr>


</s:iterator>

 </table>





</body>
</html>