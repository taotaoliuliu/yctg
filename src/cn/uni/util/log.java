
package cn.uni.util;

import java.io.*;
import java.util.Date;
import java.text.*;

public class log
{
	
	private PrintWriter logout = null;
	private long loglen;
	private String filename;
	private int maxlen = 0;
	private boolean isDebug;
	public static Object ob = new Object( ); 
	public static log instance = null;
	
	public log( )
	{
		 
		try{
			
			//filename = PropertyManager.getProperty("logfile");
			filename =ManagerPro.getString("logfile");
			if( filename == null )
			
					System.out.println("file is null");
			else 
				System.out.println(filename);
			maxlen = Integer.parseInt(PropertyManager.getProperty("loglen"));
			String debuginfo = PropertyManager.getProperty("logdebug");
			if( debuginfo.equalsIgnoreCase("true"))
				isDebug = true;
			else
				isDebug = false;	
			//System.out.println("TEST4");
			File f = new File(filename);
			loglen = f.length( );
			logout= new PrintWriter(new FileOutputStream(filename, true));
			logPrint("System is start now....file length is["+loglen+"]");
		}catch(Exception e){
			System.out.println("TEST " + e.toString());
		    e.printStackTrace();
		}
				
	}
	
	private synchronized void rolllogfile( )  throws Exception 
	{
		
		File fbak = new File( filename + ".bak" );
		if(fbak.exists())
			fbak.delete();
		logout.close( );
		File f = new File(filename);
		f.renameTo(fbak ); 
		loglen = 0;
		logout = new PrintWriter(new FileOutputStream(filename,true));	
		logPrint("Logfile is moved to file" + filename + ".bak");
		
	}
	/*
	* For must to log to logfile information.
	*/
	public static void logConsole( String s)
	{
		
		if (instance == null) {
            synchronized(ob) {
                if (instance == null) {
                    instance = new log();
                }
            }
        }
		try{
			instance.logPrint(s);
		}catch(Exception e){System.out.println(e.toString());}
	}
	public static void logDebug( String s)
	{
		if (instance == null) {
            synchronized(ob) {
                if (instance == null) {
                    instance = new log();
                }
            }
        }
		try{
			if(instance.isDebug)
				instance.logPrint(s);
		}catch(Exception e){}
	} 	
	public void logPrint( String s ) throws Exception
	{
			
		Date now = new Date( );
		String logstr = DateFormat.getDateTimeInstance().format(now) + "[" + s +"]";
		logout.println( logstr);
		logout.flush();
		loglen += logstr.length( ); 	
		if ( loglen > maxlen){
			rolllogfile( );
		}	
	}
	
	public void closeLog( ) throws Exception
	{
		logPrint("System is Down.....");
		logout.close( );
	}
	
	public static log getInstance()
	{
		return instance;	
	}
    protected void finalize() throws Throwable
 	{
		closeLog( );
 	}
    public static void close()
    {
		try
		{
			instance.closeLog(); 
		}catch(Exception e)
		{
		}	
    }
}
