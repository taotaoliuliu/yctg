<%@page contentType="text/html;charset=GBK" %> 
<%@page import = "java.util.*"%>

<%
	//��ȡMyActionֵ���жϲ�����ɾ��
	String strAction = request.getParameter("MyAction");
	String username = request.getParameter("username");
	String curUsername = (String) session.getAttribute("truename");
	//curUsername=I18n.getGBText(curUsername);
	String dele_list[] = request.getParameterValues("selCheck");
	
	if (strAction != null)
	{
		if (strAction.equals("Del"))	
		{

			for (int i=0;i<dele_list.length;i++)
			{
				//ManageUser.getInstance().RemoveUser(dele_list[i],curUsername);
			}		
		
		}
	}
	response.sendRedirect("../main_admin.jsp");
%>