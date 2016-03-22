package cn.uni.intercepter;


import org.apache.commons.lang3.StringUtils;

import cn.uni.domain.UserInfo;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class MyIntercepter implements Interceptor {

	public void destroy() {		
	}

	public void init() {		
	}

	public String intercept(ActionInvocation invocation) throws Exception {
		
		
		UserInfo userInfo=(UserInfo) ActionContext.getContext().getSession().get("user");
		
		String actionName = invocation.getProxy().getActionName();
		System.out.println(actionName);
		if(userInfo==null)
		{
			if(StringUtils.isNotBlank(actionName)&&"userAction_login".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_createPerson".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_findPassword".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_createPersonRe".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_regin".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_checkIdcard".equals(actionName))
			{
				return invocation.invoke();
			}
			if(StringUtils.isNotBlank(actionName)&&"userAction_checkLoginName".equals(actionName))
			{
				return invocation.invoke();
			}
		
			return "loginUI";
		}
		else
			
			return invocation.invoke();
		
	}

}
