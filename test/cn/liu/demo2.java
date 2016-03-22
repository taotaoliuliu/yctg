package cn.liu;

import java.util.Calendar;

import cn.uni.util.ManagerPro;

public class demo2 {

	
	public static void main(String[] args) {
		String maxday = ManagerPro.getString("maxday");
		int days_i = Integer.parseInt(maxday);
		Calendar c = Calendar.getInstance();  
		c.setTime(new java.util.Date());  
		java.util.Date today = c.getTime(); 
		c.add(Calendar.DAY_OF_YEAR, -(days_i));  
		java.util.Date today_plus1 = c.getTime(); 
		
		System.out.println(today_plus1);
	}
	
	
	
	
	
	
	
	
}
