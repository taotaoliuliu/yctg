<%@page contentType="text/html;charset=GBK" %> 
<%@page import = "java.util.*"%>

<%

	String usernameGroup = request.getParameter("username");
	String[] username=new String[100];
	username=usernameGroup.split("/");
	String curUsername = (String) session.getAttribute("truename");
	///curUsername=I18n.getGBText(curUsername);
	for(int i=0;i<username.length;i++)
	{
		//ManageUser.getInstance().AuditingUser(username[i],curUsername);
		
		//sdj;gjfds;gjd;ls
	}
	response.sendRedirect("../main_admin.jsp");
	
%>