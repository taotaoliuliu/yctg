<%@page contentType="text/html;charset=utf-8" %> 
<%@page import = "java.util.*"%>

<%
	//获取MyAction值，判断操作是删除

	String curUsername = (String) session.getAttribute("truename");
	//curUsername=I18n.getGBText(curUsername);
	String strbulletinID = request.getParameter("bulletinID");
	int bulletinID = Integer.parseInt(strbulletinID);

	//ManageBulletin.getInstance().StopBulletin(bulletinID,curUsername);

	response.sendRedirect("../main_bulletin.jsp");
%>