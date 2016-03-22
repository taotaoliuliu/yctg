<%@page contentType="text/html;charset=utf-8" import="cn.uni.domain.*,com.yl.authcode.util.AuthCode,java.net.URLEncoder"%>
<%@page import="java.util.Date"%> 

<%@ taglib prefix="s" uri="/struts-tags"%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>远程投稿</title>

    <link rel="stylesheet" type="text/css" href="css/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="css/tougao.css">

    <script src="css/jquery.min.js"></script>
    <script src="css/semantic.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('.ui.dropdown')
                    .dropdown()
            ;
            $('.ui.radio.checkbox')
                    .checkbox()
            ;
        });
        
        
        
        function AddForm_onclick() {


	var aa=true;
	
	
	if (textForm.textTitle.value=="")
	{
		alert("稿件标题不能为空！");
		textForm.textTitle.focus();
		return false;
	}
	if (textForm.author.value=="")
	{
		alert("稿件作者不能为空！");
		textForm.author.focus();
		return false;
	}
	
		
	if (textForm.textContent.value=="")
	{
		alert("稿件内容不能为空！");
		textForm.textContent.focus();
		return false;
	} if(textForm.textContent.value.length>12000)
	{
		alert("稿件内容太长，请分段上传！");
		textForm.textContent.focus();
		return false;
	}
		var title=textForm.textTitle.value;
	
		
	$.ajax
       ({
             cache: false,
             async: false,   // 太关键了，学习了，同步和异步的参数
            dataType: 'json', type: 'post',
            data:{title:title},
             url: "textAction2_getTitle",
             success: function (data)
             { 
    	   
    	   
  	  		  				
              if(data.flag=='1')
  				{
  				//window.confirm('请不要发送相同标题的稿件，发送请确定，返回修改请取消');
  				
  				if (!confirm("请不要发送相同标题的稿件，发送请确定，返回修改请取消"))
				
  					{
  					aa= false;
  					}
  				

  				}
  			else
  				{
  				return true;
  				
  				}
             }

        });

	
	return aa;
	
	
}
    </script>
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
        <div class="ui breadcrumb" style="margin-bottom: 10px;">
            <a class="section" href="index.jsp">首页</a>

            <div class="divider"> /</div>
            <a class="section" href="textAction_textContribute.action">投稿区</a>
        </div>

        <div class="ui text container" style="margin-top: 5px;">
            <h1 class="ui centered header">${textTitle }</h1>
        </div>

        <div class="ui attached message">
            <div class="header">体裁：${rest1 }</div>
            <p>投稿时间：${contributeDate}</p>
        </div>
      
        
         <div class="field" style="margin-top: 5px;">
                <textarea name="textContent"  style="height: 200px;width: 100%">${textContent }</textarea>
            </div>
        
        
        
            <div class="ui text container" style="margin-top: 5em;text-align: center;margin-top: 2px;">
           
 	<s:if test="#request.mils<=60">
 	
 
   <s:generator separator=";" val="filepath">   
       <s:iterator>   
            <img align="middle" src="<s:property/>" width="200"/><br/>
           
       </s:iterator>   
    </s:generator>  
    </s:if>
    
    <s:else>
        <div class="ui bottom attached warning message">

    
    两个月之前的附件已由投稿系统转移至报社内网的全媒体系统中!
    </div>
           
    </s:else>   
        </div>
        
        
       


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
