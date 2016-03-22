package cn.uni.listen;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

public class SL implements HttpSessionAttributeListener{

	public void attributeAdded(HttpSessionBindingEvent se) {
		String name = se.getName();
		System.out.println(name);
		if(se.getName().equals("name_real"))
		{
		HttpSession session = se.getSession();
		ServletContext sc= session.getServletContext();
		System.out.println(session);
		String id=session.getId();
		Map<String,HttpSession> map 
		=(Map<String, HttpSession>) session.getServletContext().getAttribute("map");
		if(map==null)
		{
			map=new HashMap<String,HttpSession>();
			sc.setAttribute("map", map);
		}
		map.put(id, session);
		System.out.println(map);
		}
	}

	public void attributeRemoved(HttpSessionBindingEvent se) {
		if(se.getName().equals("name_real")){
			//获取所有已经登录的人map
			Map<String,HttpSession> map = 
					(Map<String, HttpSession>) 
					se.getSession().getServletContext().getAttribute("map");
			//根据sessin的id删除这个session
			map.remove(se.getSession().getId());
		}
	}

	public void attributeReplaced(HttpSessionBindingEvent se) {
		
	}

}
