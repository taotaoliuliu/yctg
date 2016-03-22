package cn.uni.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ManagerPro {
	static Properties properties = new Properties();

	static {
		
		InputStream inputStream = ManagerPro.class.getClassLoader().getResourceAsStream("uniContribute.properties");
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static String getString(String str)
	{
		String property = properties.getProperty(str);
		return property;
	}
	
}
