package cn.liu;


import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.uni.domain.BulletinInfo;
import cn.uni.service.BullentinService;

public class TestSF {

	
	
	@Test
	public void FF(){
		ApplicationContext sc = new ClassPathXmlApplicationContext("applicationContext.xml");
		SessionFactory f= (SessionFactory) sc.getBean("sessionFactory");
		System.out.println(f);
		
	}
	@Test
	public void Tx()
	{
		ApplicationContext sc = new ClassPathXmlApplicationContext("applicationContext.xml");
		BullentinService s=	(BullentinService) sc.getBean("bullentinServiceImpl");
		
		
		BulletinInfo bullentinInfo = new BulletinInfo();
		bullentinInfo.setBulletinContent("fdsfsdfsd");
		bullentinInfo.setIfPut(1);
		
		s.save(bullentinInfo);
	}
}
