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
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("prototype")
public class Demo extends ActionSupport
  implements ModelDriven<UserInfo>, ServletRequestAware, ServletResponseAware
{
  public HttpServletRequest request;
  public HttpServletResponse response;
  UserInfo userInfo = new UserInfo();

  @Resource
  private UserService userService;

  @Resource
  private BullentinService bullentinService;
  public int pageNum = 1;

  public String login()
    throws IOException
  {
    String csss = this.request.getParameter("csss");
    System.out.println(csss);
    String nameLogin = this.userInfo.getName_Login();
    String password = this.userInfo.getPassword();
    String phone = this.userInfo.getPhone();

    System.out.println(nameLogin);
    System.out.println(password);
    System.out.println(phone);
    password = UninewsTools.encryptPassword(password);

    UserInfo newUserInfo = this.userService.getUserBynameLoginAndPassword(nameLogin, password);

    List list = this.bullentinService.getAllByIfPut();
    if ((list != null) && (list.size() > 0))
    {
      if (newUserInfo == null)
      {
        addFieldError("name", "用户名或密码出错或没有激活!");

        return "in";
      }

      ActionContext.getContext().getSession().put("user", newUserInfo);
      Map session = ActionContext.getContext().getSession();
      this.request.getSession().setAttribute("name_Login", newUserInfo.getName_Login());
      this.request.getSession().setAttribute("name_real", newUserInfo.getName_real());
      this.request.getSession().setAttribute("workcompany", newUserInfo.getWorkcompany());
      this.request.getSession().setAttribute("versin", "V3.3.1B");
      if (StringUtils.isNotBlank(csss))
      {
        return "tolist";
      }
      return "index2";
    }

    if (newUserInfo == null)
    {
      addFieldError("name", "用户名或密码出错或没有激活!");
      return "in";
    }

    ActionContext.getContext().getSession().put("user", newUserInfo);

    this.request.getSession().setAttribute("name_Login", newUserInfo.getName_Login());
    this.request.getSession().setAttribute("name_real", newUserInfo.getName_real());
    this.request.getSession().setAttribute("workcompany", newUserInfo.getWorkcompany());
    this.request.getSession().setAttribute("versin", "V2.3.1");

    return "index";
  }

  public String home()
  {
    PageBean pageBean = this.userService.getAllFenYe(this.pageNum, UserInfo.class);
    ActionContext.getContext().getValueStack().push(pageBean);

    return "home";
  }

  public String add()
  {
    this.userInfo.setAuditingFlag(Integer.valueOf(0));

    UserInfo byLoginName = this.userService.getByLoginName(this.userInfo.getName_Login());
    if (byLoginName != null)
    {
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
    log.logDebug("[" + getClass().getName() + "] : create user:" + this.userInfo.getName_Login() + " >> create by " + this.request.getSession().getAttribute("name_real"));

    return "tolist";
  }

  public String addUI() throws IOException
  {
    String workcompanystr = ManagerPro.getString("workcompany");
    workcompanystr = I18n.getGBText(workcompanystr);
    String[] workcompanys = workcompanystr.split(",");
    ActionContext.getContext().put("workcompanys", workcompanys);

    return "addUI";
  }

  public String delete() {
    String[] parameterValues = this.request.getParameterValues("selCheck");

    if ((parameterValues != null) && (parameterValues.length > 0))
    {
      for (int x = 0; x < parameterValues.length; x++)
      {
        this.userService.deleteByLoginName(parameterValues[x]);
        log.logDebug("[" + getClass().getName() + "] : delete user:" + parameterValues[x] + " >> delete by " + this.request.getSession().getAttribute("name_real"));
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

    if (("".equals(yeMpassword)) || (yeMpassword == null))
    {
      this.userInfo.setPassword(user.getPassword());
    }
    else
    {
      yeMpassword = UninewsTools.encryptPassword(yeMpassword);
      this.userInfo.setPassword(yeMpassword);
    }

    this.userService.update(this.userInfo);
    log.logDebug("[" + getClass().getName() + "] : update user:" + nameLogin + " >> updated by " + this.request.getSession().getAttribute("name_real"));
    return "tolist";
  }

  public String search()
  {
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

  public String lookAuditing()
  {
    String loginName = this.request.getParameter("username");
    UserInfo user = this.userService.getByLoginNameAndAuditing(loginName);
    String workcompanystr = ManagerPro.getString("workcompany");
    workcompanystr = I18n.getGBText(workcompanystr);
    String[] workcompanys = workcompanystr.split(",");
    ActionContext.getContext().put("workcompanys", workcompanys);

    ActionContext.getContext().getValueStack().push(user);
    return "lookAuditing";
  }

  public String editAuditingRe()
  {
    this.userInfo.setAuditingFlag(Integer.valueOf(0));
    this.userService.update(this.userInfo);
    return "toAuditingList";
  }

  public String auditingList()
  {
    List list = this.userService.getAllByAuditing();
    ActionContext.getContext().put("listUser", list);
    return "auditingList";
  }

  public String auditingDelete()
  {
    String[] parameterValues = this.request.getParameterValues("selCheck");

    if ((parameterValues != null) && (parameterValues.length > 0))
    {
      for (int x = 0; x < parameterValues.length; x++)
      {
        this.userService.deleteByLoginName(parameterValues[x]);
      }
    }
    return "toAuditingList";
  }

  public String auditing()
  {
    String usernameGroup = this.request.getParameter("username");
    String[] username = new String[100];
    username = usernameGroup.split("/");

    for (int i = 0; i < username.length; i++)
    {
      this.userService.auditing(username[i]);
    }
    return "tolist";
  }

  public String editpassword()
  {
    String loginName = this.request.getParameter("username");
    UserInfo user = this.userService.getByLoginName(loginName);
    ActionContext.getContext().getValueStack().push(user);

    return "editpassword";
  }

  public String editpasswordRe()
  {
    String password = this.userInfo.getPassword();

    String nameLogin = this.userInfo.getName_Login();

    this.userService.setPassword(password, nameLogin);
    return "tolist";
  }

  public String pageEditUI()
  {
    String loginName = (String)this.request.getSession().getAttribute("name_Login");
    UserInfo user = this.userService.getByLoginName(loginName);
    String workcompanystr = ManagerPro.getString("workcompany");
    workcompanystr = I18n.getGBText(workcompanystr);
    String[] workcompanys = workcompanystr.split(",");
    ActionContext.getContext().put("workcompanys", workcompanys);

    ActionContext.getContext().getValueStack().push(user);
    return "pageEditUI";
  }

  public String pageEdit()
  {
    this.userInfo.setAuditingFlag(Integer.valueOf(1));

    String loginName = (String)this.request.getSession().getAttribute("name_Login");
    UserInfo user = this.userService.getByLoginName(loginName);
    String yeMpassword = this.userInfo.getPassword();
    if (("".equals(yeMpassword)) || (yeMpassword == null))
    {
      this.userInfo.setPassword(user.getPassword());
    }
    else
    {
      yeMpassword = UninewsTools.encryptPassword(yeMpassword);
      this.userInfo.setPassword(yeMpassword);
    }

    this.userService.update(this.userInfo);

    return "pageEdit";
  }

  public String pageSearch()
  {
    return "pageSearch";
  }

  public String pageSearchRe() {
    String searchString = this.request.getParameter("searchString");
    String properties = this.request.getParameter("properties");
    List listUser = this.userService.getListByCondition(searchString, properties);
    ActionContext.getContext().put("listUser", listUser);
    return "pageSearch";
  }

  public String logout()
  {
    this.request.getSession().removeAttribute("name_Login");
    this.request.getSession().removeAttribute("name_real");
    this.request.getSession().removeAttribute("workcompany");
    return "logout";
  }

  public String pauseUser()
  {
    String usernameGroup = this.request.getParameter("username");
    String[] username = new String[100];
    username = usernameGroup.split("/");

    for (int i = 0; i < username.length; i++)
    {
      this.userService.pauseUser(username[i]);
    }

    log.logConsole("[" + getClass().getName() + "] : pause user:" + username + " >> paused by " + this.request.getSession().getAttribute("name_real"));

    return "tolist";
  }

  public String searchRe()
  {
    String searchString = this.request.getParameter("searchString");
    String properties = this.request.getParameter("properties");

    this.request.getSession().setAttribute("name", properties);
    this.request.getSession().setAttribute("searchString", searchString);
    List listUser = this.userService.getListByCondition(searchString, properties);
    ActionContext.getContext().put("listUser", listUser);
    return "search";
  }

  public String changePassword()
  {
    String name_Login = (String)this.request.getSession().getAttribute("name_Login");
    ActionContext.getContext().put("name_Login", name_Login);

    return "changePassword";
  }

  public String changePasswordRe()
  {
    String password = this.request.getParameter("passwd");
    String passwdconfirm = this.request.getParameter("passwdconfirm");
    String oldpasswd = this.request.getParameter("oldpasswd");
    String name_Login = (String)this.request.getSession().getAttribute("name_Login");
    oldpasswd = UninewsTools.encryptPassword(oldpasswd);
    UserInfo user = this.userService.getUserBynameLoginAndPassword(name_Login, oldpasswd);
    if (user == null)
    {
      addActionError("原密码不正确！");
      return "changePassword";
    }
    if ((password == null) || ("".equals(password)))
    {
      addActionError("请输入新密码！");
      return "changePassword";
    }

    if ((passwdconfirm == null) || ("".equals(passwdconfirm)))
    {
      addActionError("请输入确认密码！");
      return "changePassword";
    }

    if (!password.equals(passwdconfirm))
    {
      addActionError("两次输入密码不一致！");
      return "changePassword";
    }

    this.userService.setPassword(password, name_Login);
    return "changePasswordRe";
  }

  public String createPerson()
  {
    return "createPerson";
  }

  public String createPersonRe()
  {
    String workcompanystr = ManagerPro.getString("workcompany");
    workcompanystr = I18n.getGBText(workcompanystr);
    String[] workcompanys = workcompanystr.split(",");
    ActionContext.getContext().put("workcompanys", workcompanys);

    return "createPersonRe";
  }

  public String checkLoginName()
    throws IOException
  {
    String result = null;
    String name = this.request.getParameter("name_Login");
    UserInfo user = this.userService.getByLoginName(this.userInfo.getName_Login());

    if ((isAlphaValid(name)) && (user == null))
    {
      result = "true";
    }
    else
    {
      result = "false";
    }

    ServletActionContext.getResponse().getWriter().write(result);
    return null;
  }

  public static boolean isAlphaValid(String name) {
	  if(name == null)
          return false;
      if(name.length() == 0)
          return false;
      String authorizedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789";
      char chars[] = authorizedCharacters.toCharArray();
      char nameBuffer[] = name.toCharArray();
      boolean badCharFound = false;
      for(int i = 0; i < nameBuffer.length && !badCharFound; i++)
      {
          int j = 0;
          boolean ok;
          for(ok = false; j < chars.length && !ok; j++)
              if(chars[j] == nameBuffer[i])
                  ok = true;

          badCharFound = ok ^ true;
          if(badCharFound)
              System.out.println("UninewsTools.isAlphaValid >> --/ Bad character found in [" + name + "] at position " + Integer.toString(i));
      }

      return badCharFound ^ true;
  }

  public String checkIdcard()
    throws IOException
  {
    UserInfo user = this.userService.getByLoginIdcard(this.userInfo.getIdcard());
    String result = user == null ? "true" : "false";
    ServletActionContext.getResponse().getWriter().write(result);
    return null;
  }

  public String regin()
  {
    this.userInfo.setAuditingFlag(Integer.valueOf(0));

    String password = this.userInfo.getPassword();

    password = UninewsTools.encryptPassword(password);
    this.userInfo.setPassword(password);

    this.userService.save(this.userInfo);

    return "regin";
  }

  public String findPassword() {
    return "findPassword";
  }

  public String online() {
	  Map<String,HttpSession> map
		= (Map<String, HttpSession>)request.getSession().getServletContext().getAttribute("map");
    List list = new ArrayList();

    if (map != null) {
      for (HttpSession hs : map.values()) {
        Map mm = new HashMap();
        long lts = hs.getLastAccessedTime();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String format2 = format.format(Long.valueOf(lts));
        String name = (String)hs.getAttribute("name_real");
        String name_Login = (String)hs.getAttribute("name_Login");

        mm.put("id", this.request.getRemoteAddr());
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

  public String findPasswordRe()
  {
    UserInfo info = this.userService.findUser(this.userInfo);
    if (info == null)
    {
      addFieldError("name", "您输入的用户信息有误！");
      return "findPassword";
    }

    this.userService.setPassword(this.userInfo.getPassword(), this.userInfo.getName_Login());

    return "findPasswordRe";
  }

  public String up()
  {
    return "up";
  }

  public UserInfo getModel() {
    return this.userInfo;
  }
  public void setServletRequest(HttpServletRequest req) {
    this.request = req;
  }

  public int getPageNum()
  {
    return this.pageNum;
  }

  public void setPageNum(int pageNum) {
    this.pageNum = pageNum;
  }

  public void setServletResponse(HttpServletResponse response)
  {
    this.response = response;
  }
}