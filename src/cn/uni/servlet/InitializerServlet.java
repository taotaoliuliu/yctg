

package cn.uni.servlet;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;

import cn.uni.util.FileDeleter;
import cn.uni.util.log;






public class InitializerServlet extends HttpServlet {

    private static boolean loaded = false;
    private static int mYear = 2019;
    private static int mMonth = 12;	
  
    
    public void init() throws ServletException {
        if (loaded) {
            System.err.println("Fatal error: Initializer executing multiple " +
                               "times.  Aborting.");
            return;
        } else {
            loaded = true;
        }
	
			String scriptName = getServletContext().getInitParameter("initfile");
	        System.out.println("Initialization using: " + scriptName);
			
			//删除上传多媒体文件			
			FileDeleter fm = new FileDeleter();
			//fm.start();

		//}
		
    
	}

    public void destroy() {
        log.close();
    }
    
	 public static boolean getdog()
	 {
	     String str = "";
	     boolean c=false;
		 try
	     {

	         java.util.Calendar calendar = java.util.Calendar.getInstance();   
	         calendar.setTime(new java.util.Date());
	         if(calendar.get(Calendar.YEAR)<=mYear && (calendar.get(Calendar.MONTH)+1)<=mMonth)
	         {
	        	 c=true;
	         }
	         if (c)
	        	 return true;

	     }
	     catch(Exception ex)
	     {
	         ex.printStackTrace();
	     }
	     return false;
	 }	       
}
