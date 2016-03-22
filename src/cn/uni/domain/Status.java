package cn.uni.domain;

import java.util.Vector;


public class Status
{
	private static Status mObject = null;

	public Status()
    {
      
    }

	public static Status getInstance()
	{
		if (mObject == null)
			mObject = new Status();
		return mObject;
	}

	public Vector ListStatus(String startDate,String endDate,String orderStr,String province)
	{
//        CmsConnection conn=null;
//		Statement stmt = null;
//		ResultSet rs = null;
//		
//		
//        Vector vt = new Vector();                
//
//	    try{
//	    	String strsql = "SELECT userInfo.name_Login,userInfo.name_real,count(textID) as sum,";
//			strsql += " sum(case when status!='' and rest3 ='是' then 1 else 0 end) as sum2,";
//			strsql += " sum(case when status like '%版%' and status like '%见报%' and rest3 ='是' then 1 else 0 end) as sum3,";
//			strsql += " sum(case when status like '%网站%' and status like '%见报%' and rest3 ='是' then 1 else 0 end) as sum4";
//			
//            strsql += " FROM textInfo LEFT OUTER JOIN userInfo ON textInfo.sender = userInfo.name_Login ";
//			strsql += " where ContributeDate >='";
//			strsql += startDate + " 00:00:00' and  ContributeDate <='"+ endDate +" 23:59:59' and anonyFlag = 0 ";
//			strsql += " and userInfo.province = '"+province+"' and role!='管理员'";
//							
//			strsql+="  GROUP BY name_Login,name_real order by "+orderStr+" desc";
//			//System.out.println(strsql);
//	    	conn = CmsPool.getInstance().connect();
//			stmt = conn.getOriginalConnection().createStatement();
//			rs = stmt.executeQuery(strsql);
//			if(rs != null)
//            while(rs.next())
//            {
//                    String name_Login = rs.getString("name_Login");
//                    String name_real = rs.getString("name_real");
//                    String sum = rs.getString("sum");
//                    String sum2 = rs.getString("sum2");
//                    String sum3 = rs.getString("sum3");
//                    String sum4 = rs.getString("sum4");
//                    StatusInfo statusInfo = new StatusInfo(name_Login,name_real,sum,sum2,sum3,sum4);
//                    vt.add(statusInfo);
//			}
//		 }catch(SQLException e){
//			System.out.println("Error" + e.toString());
//	    	return null;
//	    }finally{
//              try {
//                rs.close();
//                stmt.close();
//              }
//              catch (SQLException e) {
//                System.out.println("Error" + e.toString());
//                log.logDebug(e.toString());
//              }
//
//              try {
//                conn.close();
//              }
//              catch (SQLException e) {
//                System.out.println("Error" + e.toString());
//                log.logDebug(e.toString());
//              }
//
//			}
//
	return null;
	}
	
	
	
}
