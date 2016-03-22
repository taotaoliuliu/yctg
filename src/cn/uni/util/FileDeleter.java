package cn.uni.util;

import java.io.File;
import java.text.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class FileDeleter extends TimerTask {
    private Timer timer = new Timer();
    
    private Calendar calendar = Calendar.getInstance();
  
    
    public void start() {
        //每天删除一次
        timer.scheduleAtFixedRate(this, new Date(), 1000 * 3600*24);        
    }
	
	//删除空目录
	private static void doDeleteEmptyDir(String dir) {
        boolean success = (new File(dir)).delete();
        if (success) {
            System.out.println("Successfully deleted empty directory: " + dir);
        } else {
            System.out.println("Failed to delete empty directory: " + dir);
        }
    }

    /**
     * 递归删除目录下的所有文件及子目录下所有文件
     * @param dir 将要删除的文件目录
     * @return boolean Returns "true" if all deletions were successful.
     *                 If a deletion fails, the method stops attempting to
     *                 delete and returns "false".
     */
    private static boolean deleteDir(File dir) {
        if (dir.isDirectory())
		{
            String[] children = dir.list();
			//递归删除目录中的子目录下
            for (int i=0; i<children.length; i++)
			{
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success)
				{
                    return false;
                }
            }
        }
        // 目录此时为空，可以删除
        return dir.delete();
    }

	
    public void run() {        
         String targetPath1 = ManagerPro.getString("pic_folder2");
		targetPath1 = targetPath1.replaceAll("/","\\\\");
		
		String maxday = ManagerPro.getString("maxday");
		int days_i = Integer.parseInt(maxday);
		Calendar c = Calendar.getInstance();  
		c.setTime(new java.util.Date());  
		java.util.Date today = c.getTime(); 
		c.add(Calendar.DAY_OF_YEAR, -(days_i+1));  
		java.util.Date today_plus1 = c.getTime(); 
		
		File targetFile = new File(targetPath1);
		if (targetFile.isDirectory())
		{
			String[] children = targetFile.list();
			//删除过期目录
	        for (int i=0; i<children.length; i++)
			{   
				try
				{
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date date = sdf.parse(children[i]);         
		            if (date.compareTo(today_plus1)<=0) 
					{
		                deleteDir(new File(targetFile,children[i]));
		            }
				}catch(Exception e)
				{
					System.out.println("时间转换失败"+e.toString());
					log.logDebug( "时间转换失败");
				}
	        }
		    
	        //下班之前停止任务 ~.~
	        /*if(calendar.get(Calendar.HOUR_OF_DAY) == 19 && calendar.get(Calendar.MINUTE) == 15){
	            this.cancel();
	        }*/
		}
    }
	
	
	
}
