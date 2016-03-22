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
        //ÿ��ɾ��һ��
        timer.scheduleAtFixedRate(this, new Date(), 1000 * 3600*24);        
    }
	
	//ɾ����Ŀ¼
	private static void doDeleteEmptyDir(String dir) {
        boolean success = (new File(dir)).delete();
        if (success) {
            System.out.println("Successfully deleted empty directory: " + dir);
        } else {
            System.out.println("Failed to delete empty directory: " + dir);
        }
    }

    /**
     * �ݹ�ɾ��Ŀ¼�µ������ļ�����Ŀ¼�������ļ�
     * @param dir ��Ҫɾ�����ļ�Ŀ¼
     * @return boolean Returns "true" if all deletions were successful.
     *                 If a deletion fails, the method stops attempting to
     *                 delete and returns "false".
     */
    private static boolean deleteDir(File dir) {
        if (dir.isDirectory())
		{
            String[] children = dir.list();
			//�ݹ�ɾ��Ŀ¼�е���Ŀ¼��
            for (int i=0; i<children.length; i++)
			{
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success)
				{
                    return false;
                }
            }
        }
        // Ŀ¼��ʱΪ�գ�����ɾ��
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
			//ɾ������Ŀ¼
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
					System.out.println("ʱ��ת��ʧ��"+e.toString());
					log.logDebug( "ʱ��ת��ʧ��");
				}
	        }
		    
	        //�°�֮ǰֹͣ���� ~.~
	        /*if(calendar.get(Calendar.HOUR_OF_DAY) == 19 && calendar.get(Calendar.MINUTE) == 15){
	            this.cancel();
	        }*/
		}
    }
	
	
	
}
