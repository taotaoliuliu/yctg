<%@ page language="java" import="java.util.*,cn.uni.domain.*" pageEncoding="utf-8"%>
<%

//	UserInfo user=(UserInfo)request.getSession().getAttribute("user");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

     pageContext.setAttribute("enter", "\r\n");   


%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>远程投稿系统-中国气象报社</title>

    <link rel="stylesheet" type="text/css" href="css/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="css/tougao.css">

    <script src="css/jquery.min.js"></script>
    <script src="css/semantic.min.js"></script>
</head>
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
        <div class="ui main container">
            <div class="ui text container" style="margin-top: 5em;">
                <h1 class="ui centered header">欢迎使用<br>中国气象报社远程投稿系统！</h1>
            </div>
            <div class="ui centered header">
            
                    <c:if test="${ user!=null && user!=''}">
                    
                     <a href="textAction_statPerson.action" class="ui blue big button">进入工作区</a>
                
                <c:if test="${user!=null&&user.role=='管理员' }"><a href="<%=basePath %>jsp/indexAction/index4.jsp" class=\"ui blue big button\">进入管理区</a></c:if>
                    </c:if>
                    
                     <c:if test="${user==null || user=='' }">
               
                                   <a href="login.jsp" class="ui blue big button">登录</a>

               </c:if>
                    
            
               
            </div>

            <h4 class="ui horizontal header divider" style="margin: 2em;">
                <a href="#">使用帮助</a>
            </h4>
            
            <c:forEach items="${list }" var="vo">
                <div class="ui attached message">
                    <div class="header">公告：${vo.bulletinTitel}</div>
                    <p>发布时间：${vo.creatTime}</p>
                </div>
                <div class="ui attached fluid segment">
                
                ${fn:replace(vo.bulletinContent,enter,'<br>')}
                
                </div>
                <div class="ui bottom attached warning message">
                    公告编号：${vo.bulletinID}
                </div>
           </c:forEach>
<!--             <div class="ui text container">{$page}</div>
 -->        </div>
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

</html>
