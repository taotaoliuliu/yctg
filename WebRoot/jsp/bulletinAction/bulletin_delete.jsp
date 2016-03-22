<%@page contentType="text/html;charset=utf-8" %> 
<%@page import = "java.util.*"%>

<%
	//获取MyAction值，判断操作是删除
	String strAction = request.getParameter("MyAction");
	String curUsername = (String) session.getAttribute("truename");
	//curUsername=I18n.getGBText(curUsername);
	String dele_list[] = request.getParameterValues("selCheck");
	
	if (strAction != null)
	{
		if (strAction.equals("Del"))	
		{

			for (int i=0;i<dele_list.length;i++)
			{
				//ManageBulletin.getInstance().RemoveBulletin(Integer.parseInt(dele_list[i]),curUsername);
			}		
		
		}
	}
	response.sendRedirect("../main_bulletin.jsp");
%>