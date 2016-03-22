package cn.liu;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cn.uni.util.ManagerPro;

public class Demo {
	public static void main(String[] args) throws ParseException {
		
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//Date date = sdf.parse("E:\\soft\\Tomcat\\apache-tomcat-6.0.26\\webapps\\uniContribute_qxb\\Unicontribution\\picAll\\2013-04-09");         
		
		
		String targetPath1 = ManagerPro.getString("pic_folder2");
		
		targetPath1 = targetPath1.replaceAll("/","\\\\");
		
		File targetFile = new File(targetPath1);
		System.out.println(targetFile);
		if (targetFile.isDirectory())
		{
			String[] children = targetFile.list();
			//删除过期目录
	        for (int i=0; i<children.length; i++)
			{   
				
				
					//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					//Date date = sdf.format(children[i]);  
	                deleteDir(new File(targetFile,children[i]));

					
		
		
	}
		}}
	




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

}


