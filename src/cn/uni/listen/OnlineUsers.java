package cn.uni.listen;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import cn.uni.domain.UserInfo;

public class OnlineUsers implements HttpSessionBindingListener{

	
	
	 private Map<Integer, UserInfo> users = new HashMap<Integer, UserInfo>();  
	 
	   private static OnlineUsers onlineUsers = new OnlineUsers();  
	 
	   public static OnlineUsers getInstance() {  
	       return onlineUsers;  
	   }  
	     
	   /** 
	    * @return 
	    */  
	   public Collection getUsers() {  
	       return users.values();  
	   }  
	 
	   public void addUser(UserInfo user) {  
	       users.put(user.getUserID(), user);  
	   }  
	 
	   public void removeUser(String userId) {  
	       users.remove(userId);  
	   }  

	public void valueBound(HttpSessionBindingEvent event) {
		
		HttpSession session = event.getSession();
		ServletContext context = session.getServletContext();
		String name =(String)session.getAttribute("name");
		List online=(List)context.getAttribute("online");
		if(online==null)
		{
			online = new ArrayList();
			context.setAttribute("online",online);
		}
		online.add(name);
		
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		
	}

}
