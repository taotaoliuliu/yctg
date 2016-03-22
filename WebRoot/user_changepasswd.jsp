<%@ page language="java" import="java.util.*,cn.uni.domain.*" pageEncoding="utf-8"%>
<%

//	UserInfo user=(UserInfo)request.getSession().getAttribute("user");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

     pageContext.setAttribute("enter", "\r\n");   


%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<HTML>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>修改口令</title>

    <link rel="stylesheet" type="text/css" href="css/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="css/tougao.css">

    <script src="css/jquery.min.js"></script>
    <script src="css/semantic.min.js"></script>
</head>


<script language="javascript">
function pwdForm_onclick() {

	var oldpswd = changepwd.oldpasswd.value;
	if (oldpswd=="")
	{
		alert("新密码不能为空！");
		changepwd.oldpasswd.focus();
		return false;
	}
	var pswd = changepwd.passwd.value;
	if (pswd=="")
	{
		alert("新密码不能为空！");
		changepwd.passwd.focus();
		return false;
	}
	if(changepwd.passwd.value.length<="5")
	{
		alert("您输入的密码长度必须大于六位！");
		changepwd.passwd.focus();
		return false;

		}
	
	var pswd2 = changepwd.passwdconfirm.value;
	if (pswd2=="")
	{
		alert("确认密码不能为空！");
		changepwd.passwdconfirm.focus();
		return false;
	}
	
	if(pswd2!=pswd)
	{
		alert("密码两次输入不一致！");
		changepwd.passwd.focus();
		return false;
	}			

	return true;
}

function backlist()
{

opener.location.reload();
window.close();


}
</script>


<body>
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
    <div class="column">
        <div class="ui breadcrumb" style="margin-bottom: 10px;">
            <a class="section" href="/">首页</a>
            <div class="divider"> /</div>
            <a class="section" href="/Article/">投稿区</a>
        </div>
        <div class="text container">
            <div class="ui segment"> 
                <a href="javascript:void(0)"  onclick="backlist()" class="ui blue button" style="margin: 3px">返回稿件列表</a>
            </div>
        </div>

        <form name="changepwd" class="ui form" action="userAction_changePasswordRe.action" method="post" onsubmit="return pwdForm_onclick();">
            <h3 class="ui dividing green header" style="margin-top: 1em; ">修改（${name_real }）的密码</h3>

            <div class="ui error message"></div>
            <div class="field">
                <label>原密码</label>
                <input name="oldpasswd" maxlength="15" placeholder="原密码" type="password">
            </div>
            <div class="field">
                <label>新密码</label>
                <input name="passwd" maxlength="15" placeholder="新密码" type="password">
            </div>
            <div class="field">
                <label>确认密码</label>
                <input name="passwdconfirm" maxlength="15" placeholder="确认密码" type="password">
            </div>
            
            			<s:fielderror></s:fielderror>
            

            <input type="submit" class="ui green button" value="保存">
            <input type="button" class="ui green button" value="不保存，返回" onclick="backlist()">

            <div class="ui red text segment">
                投稿用户请注意：新密码在下次登录系统时生效。
            </div>
        </form>
    </div>
</div>
<script>
    $(document)
            .ready(function () {
                $('.ui.form')
                        .form({
                            fields: {
                                new_password1: {
                                    identifier: 'new_password1',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: '新密码不能为空'
                                        },
                                        {
                                            type: 'length[6]',
                                            prompt: '新密码至少6位'
                                        }
                                    ]
                                },
                                new_password2: {
                                    identifier: 'new_password2',
                                    rules: [
                                        {
                                            type: 'match[new_password1]',
                                            prompt: '确认密码与新密码不同，请仔细检查'
                                        },
                                        {
                                            type: 'length[6]',
                                            prompt: '确认密码至少6位'
                                        }
                                    ]
                                }
                            }
                        })
                ;
            })
    ;
</script>

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

