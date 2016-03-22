<%@ page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<HTML>
<HEAD>
<title>修改口令</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">


   <link rel="stylesheet" type="text/css" href="css/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="css/tougao.css">

    <script src="css/jquery.min.js"></script>
    <script src="css/semantic.min.js"></script>
</HEAD>

<script language="javascript">
function pwdForm_onclick() {

	if (changepwd.name_Login.value=="")
	{
		alert("用户登陆名不能为空！");
		changepwd.name_Login.focus();
		return false;
	}
	
	if (changepwd.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		changepwd.name_real.focus();
		return false;
	}
	
	var idCardStr=changepwd.idcard.value;
	if (idCardStr="")
	{
		alert("身份证号不能为空！");
		changepwd.idcard.focus();
		return false;	
	}	
	
	var pswd = changepwd.password.value;
	if (pswd=="")
	{
		alert("新密码不能为空！");
		changepwd.password.focus();
		return false;
	}
	if(changepwd.password.value.length<="5")
	{
		alert("您输入的密码长度至少为六位！");
		changepwd.password.focus();
		return false;

		}
	
	var pswd2 = changepwd.password2.value;
	if (pswd2=="")
	{
		alert("确认密码不能为空！");
		changepwd.password2.focus();
		return false;
	}
	
	if(pswd2!=pswd1)
	{
		alert("密码两次输入不一致！");
		changepwd.password.focus();
		return false;
	}			

	return true;
}


function backlist()
{

window.close();


}
</script>







<BODY topmargin=0>

	
	
	<div class="ui fixed inverted menu">
    <div class="ui container">
        <div href="#" class="header item">
            <img class="logo" src="images/tougao_logo.png">
            投稿
        </div>

        <div class="right menu">
        
    
        
        <c:if test="${ user!=null && user!=''}">
                <div class="item">
                    欢迎：${user.name_real}
                </div>
                <div class="item">
                    <a class="ui inverted button" href="userAction_logout.action">退出</a>
                </div>
                
                </c:if>
                
                <c:if test="${user==null || user=='' }">
               
                <div class="item">
                    <a class="ui inverted button" href="login.jsp">登陆</a>
                </div>
               </c:if>
         
        </div>
    </div>
</div>
	

<div class="ui main column grid container">
    <div  class="column">
    

<form class="ui form" name="changepwd" method="post" action="userAction_findPasswordRe.action" onSubmit="return pwdForm_onclick();">
<input type="hidden" name="MyAction" value="findpwd">


            <h3 class="ui dividing green header" style="margin-top: 1em; ">用户重置密码：</h3>

            <div class="ui error message"></div>
            
              <div class="field">
                <label>用户登录名</label>
                <input name="name_Login" maxlength="15" placeholder="用户登录名" type="text">
            </div>
            
              <div class="field">
                <label>真实姓名</label>
                <input name="name_real" maxlength="30" placeholder="真实姓名" type="text">
            </div>
            <div class="field">
                <label>身份证号</label>
                <input name="idcard" maxlength="18" placeholder="身份证号" type="text">
            </div>
            <div class="field">
                <label>新密码</label>
                <input name="password" maxlength="15" placeholder="新密码" type="password">
            </div>
            <div class="field">
                <label>确认密码</label>
                <input name="password2" maxlength="15" placeholder="确认密码" type="password">
            </div>
                        <div class="field" style="color: red;">
            
            			<s:fielderror></s:fielderror>
            
</div>
            <input type="submit" class="ui green button" value="保存">
            <input type="button" class="ui green button" value="不保存，返回" onclick="backlist()">

      
        </form>
    </div>
</div>


<div class="ui inverted vertical footer segment">
    <div class="ui center aligned container">
        <div class="ui stackable inverted divided grid">

            <div class="column">
                <h4 class="ui inverted header">中国气象报社</h4>

                <p>本系统提供互联网投稿功能<br>
                    支持手机与电脑投稿，您所投的稿件将会被报纸、网站和新媒体编辑看到并选用。<br>
                    中国气象报纠错电话：010-68406868 CMA网站联系电话：010-68409797 新媒体联系电话：010-58995850
                </p>
            </div>
        </div>
        <div class="ui inverted section divider"></div>
        <img src="images/logo.png" class="ui centered image">

        <div class="ui horizontal inverted small divided link list">
            <a class="item" href="#">网站地图</a>
            <a class="item" href="#">关于我们</a>
            <a class="item" href="#">版权</a>
            <a class="item" href="#">其他声明</a>
        </div>
    </div>
</div>

</body>
