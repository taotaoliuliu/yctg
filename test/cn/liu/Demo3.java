package cn.liu;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import org.junit.Test;

public class Demo3 extends TimerTask{
	
	
	
		
	@Test	
	public void start() throws ParseException {
		
		Timer timer = new Timer();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); 
		String format = dateFormatter.format(new Date());
       Date startDate = dateFormatter.parse(format);  
		timer.scheduleAtFixedRate(this, startDate, 1000*3);
		
	}	
		

		

	@Override
	public void run() {
		int i=1;
		System.out.println("dslfjsflks"+i++);
	}
		

}
