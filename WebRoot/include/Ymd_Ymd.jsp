      <%@ page import="cn.uni.util.*"%>
      
<%@ page contentType="text/html;charset=utf-8"%>
      
         
         
            <%
				String strChooseStartDate = request.getParameter("StartDate");
				String strChooseEndDate = request.getParameter("EndDate");
				String strDate = UninewsTools.strNowtime();
				if (strChooseStartDate == null)
				{
					strChooseStartDate = strDate;
				}
				if (strChooseEndDate == null)
				{
					strChooseEndDate = strDate;
				}
				String strIf="";
				strIf = "where TextInfo.TI_TextDate_Dt>=\'" + strChooseStartDate + "\'";
				strIf = strIf + " and TextInfo.TI_TextDate_Dt<=\'" + strChooseEndDate + "\'";
				
			%>

      <input name="StartDate" type=text readonly size=10 value=<%=strChooseStartDate%>  onClick="javascript:fPopCalendar(StartDate,StartDate,Search);return false;" class="input0"> 到 <input name="EndDate" type=text readonly size=10 value=<%=strChooseEndDate%> onclick="javascript:fPopCalendar(EndDate,EndDate,Search);return false;" class="input0">
			

