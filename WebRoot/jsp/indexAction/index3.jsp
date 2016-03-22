<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
<div class="ui middle aligned center aligned grid" style="margin-top: 2em;">
    <div class="column" style="max-width: 450px;">
        <img src="images/logo.png" class="image">

        <h2 class="ui teal image header">
            <div class="content">
                欢迎登录远程投稿！
            </div>
        </h2>
        <form class="ui large form" action="userAction_login.action" method="post">
            <div class="ui stacked segment">
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="name" placeholder="用户名">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input type="password" name="password" placeholder="密码">
                    </div>
                </div>
                <input class="ui fluid large teal submit button" type="submit" value="登录">
            </div>

            <div class="ui error message"></div>
            	${name }

        </form>

        <div class="ui equal width grid" style="padding: 2em;">
            <div class="column"><a href="reg.html" class="ui teal button">注册新用户</a></div>
            <div class="column"><a href="reg.html" class="ui orange button">忘记密码</a></div>
        </div>
    </div>
</div>
<div class="ui inverted vertical footer segment">
    <div class="ui center aligned container">
        <div class="ui stackable inverted divided grid">

            <div class="column">
                <h4 class="ui inverted header">中国气象报社</h4>
                <p>技术支持电话：58995832,58993186</p>
            </div>
        </div>
    </div>
</div>
<script>
    $(document)
            .ready(function () {
                $('.ui.form')
                        .form({
                            fields: {
                                name: {
                                    identifier: 'name',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: '请输入您的用户名'
                                        }
                                    ]
                                },
                                password: {
                                    identifier: 'password',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: '请输入您的密码'
                                        },
                                        {
                                            type: 'length[3]',
                                            prompt: '密码至少三位字符'
                                        }
                                    ]
                                }
                            }
                        })
                ;
            })
    ;
</script>

</body>
</html>