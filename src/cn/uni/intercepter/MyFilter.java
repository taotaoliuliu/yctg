package cn.uni.intercepter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yl.authcode.util.AuthCode;

import cn.uni.domain.UserInfo;
import cn.uni.servcie.impl.UserServiceImpl;
import cn.uni.service.UserService;

public class MyFilter implements Filter{

	
	
	//private UserService userService = new UserServiceImpl();
	public void destroy() {
		
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request;
        HttpServletResponse response;
		request = (HttpServletRequest) req;
        response = (HttpServletResponse) resp;
        
        
        
    	Cookie[] cookies = request.getCookies();
  		String autologins = null;
  		for(int i=0; cookies!=null&&i<cookies.length; i++) {
  			if(cookies[i].getName().equals("autologins")) {
  				autologins = cookies[i].getValue();
  			}
  		
  		}
  		
  		// 	如果带cookie 了
  		if(autologins!=null) {
			// 检查用户名和密码的正确性
			String username = autologins.split("_")[0];
			String namereal = autologins.split("_")[1];
			String workCompany = autologins.split("_")[2];
			
			//String password = autologins.split("_")[3];
			
			
				// 用户名和密码都正确
				// 创建 user 存入 session 域
			
			UserInfo user= new UserInfo();
			
			//=userService.getByLoginName(username);
			
			user.setName_Login(username);
			
			String cookRealName=URLDecoder.decode(namereal, "UTF-8");
			String cookWorkCompany=URLDecoder.decode(workCompany, "UTF-8");
			user.setName_real(cookRealName);
				user.setRole(cookWorkCompany);
				
				//password=AuthCode.decode(password, "11223344");

				
				
				//user.setPassword(password);
			request.getSession().setAttribute("user", user);
			
			request.getSession().setAttribute("name_Login", username);
			request.getSession().setAttribute("name_real", cookRealName);
			request.getSession().setAttribute("workcompany", workCompany);
			request.getSession().setAttribute("versin","V4.3.1");
			request.getSession().setAttribute("ips", request.getRemoteAddr());
		}
  		
  		// 放行
  		chain.doFilter(request, response);
	}

	public void init(FilterConfig arg0) throws ServletException {
		
	}

	
	
}
