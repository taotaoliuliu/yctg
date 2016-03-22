package cn.uni.action;

import cn.uni.domain.PageBean;
import cn.uni.domain.UserInfo;
import cn.uni.service.BullentinService;
import cn.uni.service.UserService;
import cn.uni.util.I18n;
import cn.uni.util.ManagerPro;
import cn.uni.util.UninewsTools;
import cn.uni.util.log;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.yl.authcode.util.AuthCode;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.HttpException;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("prototype")
public class UserAction extends ActionSupport implements ModelDriven<UserInfo>,
		ServletRequestAware, ServletResponseAware {
	public HttpServletRequest request;
	public HttpServletResponse response;
	UserInfo userInfo = new UserInfo();

	@Resource
	private UserService userService;

	@Resource
	private BullentinService bullentinService;
	public int pageNum = 1;

	public String login() throws IOException {
		String nameLogin = this.userInfo.getName_Login();
		String password = this.userInfo.getPassword();

		String encode = AuthCode.encode(password, "11223344", 0);

		String password2 = UninewsTools.encryptPassword(password);

		UserInfo newUserInfo = this.userService.getUserBynameLoginAndPassword(
				nameLogin, password2);

		List list = this.bullentinService.getAllByIfPut();
		
		request.setAttribute("list", list);
		if ((list != null) && (list.size() > 0)) {
			if (newUserInfo == null) {
				addFieldError("name", "用户名或密码出错或没有激活!");

				return "in";
			}

			int seconds = 86400;
			String cookRealName = newUserInfo.getName_real();
			String cookRole = newUserInfo.getRole();
			String cookRole2 = URLEncoder.encode(cookRole, "UTF-8");
			String cookRealName2 = URLEncoder.encode(cookRealName, "UTF-8");

			Cookie cookie = new Cookie("autologins", newUserInfo
					.getName_Login()
					+ "_" + cookRealName2 + "_" + cookRole2 + "_" + encode);
			cookie.setMaxAge(seconds);
			cookie.setPath("/");
			this.response.addCookie(cookie);

			ActionContext.getContext().getSession().put("user", newUserInfo);
			this.request.setAttribute("password", password);

			this.request.getSession().setAttribute("user", newUserInfo);

			this.request.getSession().setAttribute("name_Login",
					newUserInfo.getName_Login());
			this.request.getSession().setAttribute("name_real",
					newUserInfo.getName_real());
			this.request.getSession().setAttribute("workcompany",
					newUserInfo.getWorkcompany());
			this.request.getSession().setAttribute("versin", "V4.3.1B");

			this.request.getSession().setAttribute("ips",
					this.request.getRemoteAddr());

			return "index2";
		}

		if (newUserInfo == null) {
			addFieldError("name", "用户名或密码出错或没有激活!");
			return "in";
		}

		int seconds = 86400;
		String cookRealName = newUserInfo.getName_real();
		String cookRole = newUserInfo.getRole();
		String cookRole2 = URLEncoder.encode(cookRole, "UTF-8");
		String cookRealName2 = URLEncoder.encode(cookRealName, "UTF-8");
		Cookie cookie = new Cookie("autologins", newUserInfo.getName_Login()
				+ "_" + cookRealName2 + "_" + cookRole2 + "_" + encode);
		cookie.setMaxAge(seconds);
		cookie.setPath("/");
		this.response.addCookie(cookie);
		ActionContext.getContext().getSession().put("user", newUserInfo);

		this.request.getSession().setAttribute("name_Login",
				newUserInfo.getName_Login());
		this.request.getSession().setAttribute("name_real",
				newUserInfo.getName_real());
		this.request.getSession().setAttribute("workcompany",
				newUserInfo.getWorkcompany());
		this.request.getSession().setAttribute("versin", "V2.3.1");
		this.request.getSession().setAttribute("ips",
				this.request.getRemoteAddr());

		return "index";
	}
	
	
	
	public String toIndex(){
		
		List list = this.bullentinService.getAllByIfPut();
		
	
		
		request.setAttribute("list", list);
		
		
		return "toIndex";

	}

	public String httpLogin() throws Exception {
		String username = this.request.getParameter("username");

		username = URLDecoder.decode(username, "UTF-8");

		username = AuthCode.decode(username, "11223344");

		String password = this.request.getParameter("password");

		password = URLDecoder.decode(password, "UTF-8");

		String encode = password;
		String passwordParameter = AuthCode.decode(password, "11223344");
		System.out.println(passwordParameter + "解密后：");
		System.out.println(username);
		password = UninewsTools.encryptPassword(passwordParameter);

		System.out.println(password);
		UserInfo newUserInfo = this.userService.getUserBynameLoginAndPassword(
				username, password);

		if (newUserInfo != null) {
			System.out.println("lll");

			int seconds = 86400;
			String cookRealName = newUserInfo.getName_real();
			String cookRole = newUserInfo.getRole();
			String cookRole2 = URLEncoder.encode(cookRole, "UTF-8");
			String cookRealName2 = URLEncoder.encode(cookRealName, "UTF-8");
			Cookie cookie = new Cookie("autologins", newUserInfo
					.getName_Login()
					+ "_" + cookRealName2 + "_" + cookRole2 + "_" + encode);
			cookie.setMaxAge(seconds);
			cookie.setPath("/");
			this.response.addCookie(cookie);
			this.request.getSession().setAttribute("user", newUserInfo);
			this.response.getWriter().println("chenggong!");
		} else {
			UserInfo byLoginName2 = this.userService.getByLoginName(username);

			System.out.println(byLoginName2);
			if (byLoginName2 != null) {
				this.userService.setPassword(passwordParameter, username);

				UserInfo newUserInfo2 = this.userService
						.getUserBynameLoginAndPassword(username, password);

				int seconds = 86400;
				String cookRealName = newUserInfo2.getName_real();
				String cookRole = newUserInfo2.getRole();
				String cookRole2 = URLEncoder.encode(cookRole, "UTF-8");
				String cookRealName2 = URLEncoder.encode(cookRealName, "UTF-8");
				System.out.println(cookRealName + "密码不一样");
				Cookie cookie = new Cookie("autologins", newUserInfo2
						.getName_Login()
						+ "_" + cookRealName2 + "_" + cookRole2 + "_" + encode);
				cookie.setMaxAge(seconds);
				cookie.setPath("/");
				this.response.addCookie(cookie);
				this.request.getSession().setAttribute("user", newUserInfo);

				System.out.println("dsad");
			}
		}

		return null;
	}

	public String httpLogins() {
		try {
			this.response.setContentType("application/json");
			this.response.setCharacterEncoding("UTF-8");

			String jsondata = this.request.getParameter("parameter");

			JSONObject json = JSONObject.fromObject(jsondata);

			String username = json.get("UserName").toString();
			String password = json.get("Password").toString();

			String password2 = UninewsTools.encryptPassword(password);

			UserInfo userBynameLoginAndPassword = this.userService
					.getUserBynameLoginAndPassword(username, password2);

			if (userBynameLoginAndPassword != null) {
				this.request.getSession().setAttribute("user",
						userBynameLoginAndPassword);

				JSONObject jObject = new JSONObject();

				jObject.put("Ret", "1");
				jObject.put("Msg", "成功");
				try {
					this.response.getWriter().println(jObject);
				} catch (IOException e) {
					e.printStackTrace();
				}

			} else {
				JSONObject jObject = new JSONObject();

				jObject.put("ret", "0");
				jObject.put("msg", "失败");
				try {
					this.response.getWriter().println(jObject);
				} catch (IOException e) {
					e.printStackTrace();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public String httpLogout() throws Exception {
		Cookie[] cookie = this.request.getCookies();
		int length = cookie.length;
		for (int i = 0; i < length; i++) {
			cookie[i].setPath("/");
			cookie[i].setValue("");
			cookie[i].setMaxAge(0);
			this.response.addCookie(cookie[i]);
		}

		this.request.getSession().removeAttribute("user");

		return null;
	}

	public String home() {
		PageBean pageBean = this.userService.getAllFenYe(this.pageNum,
				UserInfo.class);
		ActionContext.getContext().getValueStack().push(pageBean);

		return "home";
	}

	public String add() {
		this.userInfo.setAuditingFlag(Integer.valueOf(0));
		this.userInfo.setPassword2(this.userInfo.getPassword());

		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String dd = dateFormat.format(new Date());
		this.userInfo.setCreatetime(dd);
		this.userInfo.setPassword2(this.userInfo.getPassword());

		UserInfo byLoginName = this.userService.getByLoginName(this.userInfo
				.getName_Login());
		if (byLoginName != null) {
			addFieldError("error", "登陆名已存在！");

			String workcompanystr = ManagerPro.getString("workcompany");
			workcompanystr = I18n.getGBText(workcompanystr);
			String[] workcompanys = workcompanystr.split(",");
			ActionContext.getContext().put("workcompanys", workcompanys);

			return "addUI";
		}

		String password = this.userInfo.getPassword();
		password = UninewsTools.encryptPassword(password);
		this.userInfo.setPassword(password);

		this.userService.save(this.userInfo);
		log.logDebug("[" + getClass().getName() + "] : create user:"
				+ this.userInfo.getName_Login() + " >> create by "
				+ this.request.getSession().getAttribute("name_real"));

		return "tolist";
	}

	public String addUI() throws IOException {
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		return "addUI";
	}

	public String delete() {
		String[] parameterValues = this.request.getParameterValues("selCheck");

		if ((parameterValues != null) && (parameterValues.length > 0)) {
			for (int x = 0; x < parameterValues.length; x++) {
				this.userService.deleteByLoginName(parameterValues[x]);
				log.logDebug("[" + getClass().getName() + "] : delete user:"
						+ parameterValues[x] + " >> delete by "
						+ this.request.getSession().getAttribute("name_real"));
			}

		}

		return "tolist";
	}

	public String editUI() {
		String loginName = this.request.getParameter("username");
		UserInfo user = this.userService.getByLoginName(loginName);
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		ActionContext.getContext().getValueStack().push(user);
		return "editUI";
	}

	public String lookUser() {
		String loginName = this.request.getParameter("username");
		UserInfo user = this.userService.getByLoginName(loginName);
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		ActionContext.getContext().getValueStack().push(user);

		return "lookUser";
	}

	public String edit() {
		this.userInfo.setAuditingFlag(Integer.valueOf(1));

		String nameLogin = this.userInfo.getName_Login();
		UserInfo user = this.userService.getByLoginName(nameLogin);

		String yeMpassword = this.userInfo.getPassword();

		if (("".equals(yeMpassword)) || (yeMpassword == null)) {
			this.userInfo.setPassword(user.getPassword());
		} else {
			yeMpassword = UninewsTools.encryptPassword(yeMpassword);
			this.userInfo.setPassword(yeMpassword);
		}

		this.userInfo.setCreatetime(user.getCreatetime());
		this.userService.update(this.userInfo);
		log.logDebug("[" + getClass().getName() + "] : update user:"
				+ nameLogin + " >> updated by "
				+ this.request.getSession().getAttribute("name_real"));
		return "tolist";
	}

	public String search() {
		return "search";
	}

	public String editAuditing() {
		String loginName = this.request.getParameter("username");
		UserInfo user = this.userService.getByLoginNameAndAuditing(loginName);
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		ActionContext.getContext().getValueStack().push(user);
		return "editAuditing";
	}

	public String lookAuditing() {
		String loginName = this.request.getParameter("username");
		UserInfo user = this.userService.getByLoginNameAndAuditing(loginName);
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		ActionContext.getContext().getValueStack().push(user);
		return "lookAuditing";
	}

	public String editAuditingRe() {
		this.userInfo.setAuditingFlag(Integer.valueOf(0));

		String nameLogin = this.userInfo.getName_Login();

		UserInfo byLoginName = this.userService.getByLoginName(nameLogin);
		this.userInfo.setCreatetime(byLoginName.getCreatetime());
		this.userService.update(this.userInfo);
		return "toAuditingList";
	}

	public String auditingList() {
		List list = this.userService.getAllByAuditing();
		ActionContext.getContext().put("listUser", list);
		return "auditingList";
	}

	public String auditingDelete() {
		String[] parameterValues = this.request.getParameterValues("selCheck");

		if ((parameterValues != null) && (parameterValues.length > 0)) {
			for (int x = 0; x < parameterValues.length; x++) {
				this.userService.deleteByLoginName(parameterValues[x]);
			}
		}
		return "toAuditingList";
	}

	public String auditing() throws HttpException, IOException {
		String usernameGroup = this.request.getParameter("username");
		String[] username = new String[100];
		username = usernameGroup.split("/");

		for (int i = 0; i < username.length; i++) {
			this.userService.auditing(username[i]);
		}
		return "tolist";
	}

	public String editpassword() {
		String loginName = this.request.getParameter("username");
		UserInfo user = this.userService.getByLoginName(loginName);
		ActionContext.getContext().getValueStack().push(user);

		return "editpassword";
	}

	public String editpasswordRe() {
		String password = this.userInfo.getPassword();

		String nameLogin = this.userInfo.getName_Login();

		this.userService.setPassword(password, nameLogin);
		return "tolist";
	}

	public String pageEditUI() {
		UserInfo user2 = (UserInfo) this.request.getSession().getAttribute(
				"user");
		String nameLogin = user2.getName_Login();

		UserInfo user = this.userService.getByLoginName(nameLogin);
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		ActionContext.getContext().getValueStack().push(user);
		return "pageEditUI";
	}

	public String pageEdit() {
		this.userInfo.setAuditingFlag(Integer.valueOf(1));

		UserInfo user2 = (UserInfo) this.request.getSession().getAttribute(
				"user");
		String loginName = user2.getName_Login();

		UserInfo user = this.userService.getByLoginName(loginName);
		String yeMpassword = this.userInfo.getPassword();
		if (("".equals(yeMpassword)) || (yeMpassword == null)) {
			this.userInfo.setPassword(user.getPassword());
		} else {
			yeMpassword = UninewsTools.encryptPassword(yeMpassword);
			this.userInfo.setPassword(yeMpassword);
		}

		this.userInfo.setCreatetime(user.getCreatetime());

		this.userService.update(this.userInfo);

		return "pageEdit";
	}

	public String pageSearch() {
		return "pageSearch";
	}

	public String pageSearchRe() {
		String searchString = this.request.getParameter("searchString");
		String properties = this.request.getParameter("properties");
		List listUser = this.userService.getListByCondition(searchString,
				properties);
		ActionContext.getContext().put("listUser", listUser);
		return "pageSearch";
	}

	public String logout() {
		Cookie[] cookie = this.request.getCookies();
		int length = cookie.length;
		for (int i = 0; i < length; i++) {
			cookie[i].setPath("/");
			cookie[i].setValue("");
			cookie[i].setMaxAge(0);
			this.response.addCookie(cookie[i]);
		}

		this.request.getSession().removeAttribute("user");

		return "logout";
	}

	public String pauseUser() {
		String usernameGroup = this.request.getParameter("username");
		String[] username = new String[100];
		username = usernameGroup.split("/");

		for (int i = 0; i < username.length; i++) {
			this.userService.pauseUser(username[i]);
		}

		log.logConsole("[" + getClass().getName() + "] : pause user:"
				+ username + " >> paused by "
				+ this.request.getSession().getAttribute("name_real"));

		return "tolist";
	}

	public String searchRe() {
		String searchString = this.request.getParameter("searchString");
		String properties = this.request.getParameter("properties");

		this.request.getSession().setAttribute("name", properties);
		this.request.getSession().setAttribute("searchString", searchString);
		List listUser = this.userService.getListByCondition(searchString,
				properties);
		ActionContext.getContext().put("listUser", listUser);
		return "search";
	}

	public String changePassword() {
		UserInfo user = (UserInfo) this.request.getSession().getAttribute(
				"user");
		String name_Login = user.getName_Login();

		ActionContext.getContext().put("name_Login", name_Login);

		return "changePassword";
	}

	public String changePasswordRe() {
		String password = this.request.getParameter("passwd");
		String passwdconfirm = this.request.getParameter("passwdconfirm");
		String oldpasswd = this.request.getParameter("oldpasswd");
		UserInfo user2 = (UserInfo) this.request.getSession().getAttribute(
				"user");

		String name_Login = user2.getName_Login();

		oldpasswd = UninewsTools.encryptPassword(oldpasswd);

		UserInfo user = this.userService.getUserBynameLoginAndPassword(
				name_Login, oldpasswd);
		if (user == null) {
			addActionError("原密码不正确！");
			return "changePassword";
		}
		if ((password == null) || ("".equals(password))) {
			addActionError("请输入新密码！");
			return "changePassword";
		}

		if ((passwdconfirm == null) || ("".equals(passwdconfirm))) {
			addActionError("请输入确认密码！");
			return "changePassword";
		}

		if (!password.equals(passwdconfirm)) {
			addActionError("两次输入密码不一致！");
			return "changePassword";
		}

		this.userService.setPassword(password, name_Login);
		return "changePasswordRe";
	}

	public String changehttpPassword() throws IOException {
		String httpusrname = this.request.getParameter("username");
		String httppassword = this.request.getParameter("password");

		if ((httpusrname != null) && (httppassword != null)) {
			UserInfo byLoginName = this.userService.getByLoginName(httpusrname);

			if (byLoginName != null) {
				this.userService.setPassword(httppassword, httpusrname);
				this.response.getWriter().println("1");
			} else {
				this.response.getWriter().println("0");
			}

		}

		return null;
	}

	public String createPerson() {
		return "createPerson";
	}

	public String createPersonRe() {
		String workcompanystr = ManagerPro.getString("workcompany");
		workcompanystr = I18n.getGBText(workcompanystr);
		String[] workcompanys = workcompanystr.split(",");
		ActionContext.getContext().put("workcompanys", workcompanys);

		return "createPersonRe";
	}

	public String checkLoginName() throws IOException {
		String result = null;
		String name = this.request.getParameter("name_Login");
		UserInfo user = this.userService.getByLoginName(this.userInfo
				.getName_Login());

		if ((isAlphaValid(name)) && (user == null)) {
			result = "true";
		} else {
			result = "false";
		}

		ServletActionContext.getResponse().getWriter().write(result);
		return null;
	}

	public static boolean isAlphaValid(String name) {

		boolean ok;
		if (name == null)
			return false;
		if (name.length() == 0)
			return false;
		String authorizedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789";
		char[] chars = authorizedCharacters.toCharArray();
		char[] nameBuffer = name.toCharArray();
		boolean badCharFound = false;
		for (int i = 0; (i < nameBuffer.length) && (!badCharFound); i++) {
			int j = 0;

			for (ok = false; (j < chars.length) && (!ok); j++) {
				if (chars[j] == nameBuffer[i])
					ok = true;
			}
			badCharFound = ok ^ true;
			if (badCharFound) {
				System.out
						.println("UninewsTools.isAlphaValid >> --/ Bad character found in ["
								+ name + "] at position " + Integer.toString(i));
			}
		}
		return badCharFound ^ true;
	}

	public String checkIdcard() throws IOException {
		UserInfo user = this.userService.getByLoginIdcard(this.userInfo
				.getIdcard());
		String result = user == null ? "true" : "false";
		ServletActionContext.getResponse().getWriter().write(result);
		return null;
	}
//TODO
	public String regin() {
		this.userInfo.setAuditingFlag(Integer.valueOf(0));

		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss ");
		String dd = dateFormat.format(new Date());
		this.userInfo.setCreatetime(dd);
		this.userInfo.setPassword2(this.userInfo.getPassword());
		String password = this.userInfo.getPassword();

		password = UninewsTools.encryptPassword(password);
		this.userInfo.setPassword(password);
		
		
		String name_Login = userInfo.getName_Login();
		
		UserInfo user = this.userService.getByLoginIdcard(this.userInfo
				.getIdcard());
		
		String bankcard = userInfo.getBankcard();
		
		String bankaddress = userInfo.getBankaddress();
		
		if(user!=null)
		{
			request.setAttribute("error", "该身份证已经被注册，请不要重复注册！");
			
			return "createPersonRe";

		}
		
		UserInfo user2 = this.userService.getByLoginName(this.userInfo
				.getName_Login());
		 if((!isAlphaValid(name_Login)) || (user2 != null))
		{
			 request.setAttribute("error", "用户名已存在或登录名有中文！");
				
				return "createPersonRe";
			
		}
		 if(bankcard==null || "".equals(bankcard))
		 {
			 
			 request.setAttribute("error", "银行卡号不能为空！");
				
				return "createPersonRe";
			 
		 }
		 
		 if(bankaddress==null || "".equals(bankaddress))
		 {
			 
			 request.setAttribute("error", "开户行准确地址不能为空！");
				
				return "createPersonRe";
			 
		 }
		else {
			this.userService.save(this.userInfo);
			return "regin";

			
		}


	}

	public String findPassword() {
		return "findPassword";
	}

	public String online() {
		Map<String, HttpSession> map = (Map<String, HttpSession>) request
				.getSession().getServletContext().getAttribute("map");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		if (map != null) {
			for (HttpSession hs : map.values()) {
				Map mm = new HashMap();
				long lts = hs.getLastAccessedTime();

				SimpleDateFormat format = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");

				String format2 = format.format(Long.valueOf(lts));
				String name = (String) hs.getAttribute("name_real");
				String name_Login = (String) hs.getAttribute("name_Login");
				String ips = (String) hs.getAttribute("ips");

				mm.put("ips", ips);

				mm.put("time", format2);
				mm.put("name", name);
				mm.put("name_Login", name_Login);
				list.add(mm);
			}
		}
		System.out.println(list.size());
		this.request.setAttribute("list", list);

		return "online";
	}

	public String findPasswordRe() {
		UserInfo info = this.userService.findUser(this.userInfo);
		if (info == null) {
			addFieldError("name", "您输入的用户信息有误！");
			return "findPassword";
		}

		this.userService.setPassword(this.userInfo.getPassword(), this.userInfo
				.getName_Login());

		return "findPasswordRe";
	}

	public String up() {
		return "up";
	}

	public UserInfo getModel() {
		return this.userInfo;
	}

	public void setServletRequest(HttpServletRequest req) {
		this.request = req;
	}

	public int getPageNum() {
		return this.pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
}