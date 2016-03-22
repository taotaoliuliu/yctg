<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0022)http://220.231.41.111/ -->

<HTML>
	<HEAD>
		<TITLE>远程投稿管理系统</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<script language=javascript>
<!--
function window_onload()
{
	form1.name_Login.focus();
	return true;
}
function Submit_onclick() 
           {

	    //用户
           var uusername;
           uusername=form1.name_Login.value ;
           if(uusername=="")
          {
            alert("用户名不能为空!");
            form1.username.focus ();
            return false;
         }
		 
		//密码
           var upassword;
           upassword=form1.password.value ;
           if(upassword=="")
          {
            alert("密码不能为空!");
            form1.password.focus ();
            return false;
         }
		 }
//-->
</script>
		<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}

body,td,th {
	color: #000000;
}

a:link {
	color: #666666;
	text-decoration: none;
}

a:visited {
	color: #333333;
	text-decoration: none;
}

a:hover {
	color: #000000;
	text-decoration: underline;
}

a:active {
	color: #CCCCCC;
	text-decoration: none;
}
-->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />

</style>
	</head>

	<body onLoad="return window_onload()">
		
		<table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td bgcolor="#FFFFFF">
					<table width="566" align="center" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="18"
									background="images/login_3.jpg" bgcolor="#FFFFFF">
									<tr>
										<td bgcolor="#FFFFFF" style="border: solid 1px #233758;">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td>
														<img src="images/login_1.jpg" width="527" height="200">
													</td>
												</tr>
												<tr>
													<td bgcolor="#CCCCCC" height="5"></td>
												</tr>
												<tr>
													<td bgcolor="F0F0F0">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td width="55" bgcolor="#FFFFFF">
																	&nbsp;
																</td>
																<td width="248">
																	<img src="images/login_2.gif" width="248" height="137"
																		border="0" usemap="#Map">
																</td>
																<td width="228" valign="top" bgcolor="#FFFFFF">
																<s:form action="userAction_login.action" method="post" onsubmit="return Submit_onclick();" name="form1">
																
																	
																		<table width="100%" height="133" border="0"
																			cellpadding="0" cellspacing="0">
																			<tr>
																				<td height="8"></td>
																			</tr>
																			<tr>
																				<td height="26" bgcolor="#FFFFFF">
																					<INPUT class=input0 size=23 name="name_Login"/>
																				</td>
																			</tr>
																			<tr>
																				<td height="26" bgcolor="#FFFFFF">
																					<INPUT class=input0 type=password size=24
																						name="password"/>
																				</td>
																			</tr>
																			<tr>
																				<td height="26" bgcolor="#FFFFFF">
																					<input
																						style="BORDER-RIGHT: 1px ridge; BACKGROUND-POSITION: left center; BORDER-TOP: 1px ridge; BACKGROUND-IMAGE: url(jsp/images/ok.gif); BORDER-LEFT: 1px ridge; BORDER-BOTTOM: 1px ridge; BACKGROUND-REPEAT: no-repeat"
																						type=submit value="            " name=okbtn2>
																					<input
																						style="BORDER-RIGHT: 1px ridge; BACKGROUND-POSITION: left center; BORDER-TOP: 1px ridge; BACKGROUND-IMAGE: url(jsp/images/cancel.gif); BORDER-LEFT: 1px ridge; BORDER-BOTTOM: 1px ridge; BACKGROUND-REPEAT: no-repeat"
																						type=reset value="            " name=okbtn>
																				</td>
																			</tr>
																				
																			<tr>
																				<td height="34" bgcolor="#FFFFFF">

																					<A href="userAction_createPerson.action"><FONT
																						color=#ff0000 size=2>.用户注册</FONT>
																					</A>&nbsp;&nbsp;&nbsp;
																					<A href="userAction_findPassword.action" target="_blank"><FONT
																						color=#ff0000 size=2>.忘记密码?</FONT>
																					<br/>
																					<A href="apk/BeiJingCMAContribute.apk"><font size="2">移动采集手机客户端下载</font></A>	
																					</A>
																					
																				</td>
																			</tr>
																			 
																				
																			
																			
																		</table>
																		</s:form>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
	</body>
</html>

