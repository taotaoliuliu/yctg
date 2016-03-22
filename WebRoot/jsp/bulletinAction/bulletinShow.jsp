<%@page contentType="text/html;charset=GBK" %> 



<html>
<head>
<title>公告信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">

</head>
<%

	//Vector result = ManageBulletin.getInstance().ListBulletinPut();
	//BulletinInfo bulletinInfo = (BulletinInfo)result.elementAt(0);
%>


<body bgcolor="#C8D4E2" text="#000000">



<form name="textForm" method="post" action="" onSubmit="return AddForm_onclick();">

<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td bgcolor="#f0f0f0" align="center"  valign="top">
  <table width="90%" border="0" cellspacing="0" cellpadding="2" class=font9   align="center">
    <tr>
    <td bgcolor="#F6F6F6" align="center"><font size=3 color="red">${bulletinTitel }</font></td>
    </tr>
    <tr></tr>
    <tr>
    <td bgcolor="#F6F6F6"><TextArea name="textContent" style="width:380px;height:230px;" readOnly >${bulletinContent }</TextArea></td>
    </tr>
    </table>
  
 </td>
  </tr>
</table>


<div align="center"><input type="button" value="关闭窗口" onclick="self.close()"></div>

</form>


</body>
</html>
