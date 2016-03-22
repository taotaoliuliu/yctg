<%@ page contentType="text/html;charset=utf-8"%> 

      <%@ page import="cn.uni.util.*"%>


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

    从<input name=StartDate id=StartDate type=text readonly size=10 value=<%=strChooseStartDate%>  onClick="javascript:fPopCalendar(StartDate,StartDate);return false;" class="input0"> 到 <Input Name=EndDate id=EndDate type=text readonly size=10 value=<%=strChooseEndDate%> onclick="javascript:fPopCalendar(EndDate,EndDate);return false;" class="input0">
			

