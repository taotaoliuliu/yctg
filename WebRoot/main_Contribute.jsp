﻿<%@page contentType="text/html;charset=utf-8" import="cn.uni.domain.*,com.yl.authcode.util.AuthCode,java.net.URLEncoder"%>
<%@page import="java.util.Date"%> 

<%@ taglib prefix="s" uri="/struts-tags"%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% 
	UserInfo user=(UserInfo)request.getSession().getAttribute("user");
	
String bankcard=	user.getBankcard();
 
if(bankcard==null) bankcard="";


String bankaddress=user.getBankaddress();

if(bankaddress==null) bankaddress="";
	
	%>

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
        
        
        
               var fileExtentionRange = '.jpg';
var MAX_SIZE = 30; // MB

$(document).on('change', '.btn-file1 :file', function() {
    var input = $(this);

    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
        var label = input.val();

        input.trigger('fileselect', [ 1, label, 0 ]);
    } else {
        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
        var size = input.get(0).files[0].size;

        input.trigger('fileselect', [ numFiles, label, size ]);
    }
});

$('.btn-file1 :file').on('fileselect', function(event, numFiles, label, size) {


label=label+"将被改名为01.jpg";
    $('#uploadImages1').attr('name', 'uploadImages'); // allow upload.

    var postfix = label.substr(label.lastIndexOf('.'));
    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
        if (size > 1024 * 1024 * MAX_SIZE ) {
            alert('您上传的文件过大');

            $('#uploadImages1').removeAttr('name'); // cancel upload file.
        } else {
            $('#_attachmentName1').val(label);
        }
    } else {
        alert('您上传的附件格式不对！');

        $('#uploadImages1').removeAttr('name'); // cancel upload file.
    }
});
        
        
        
        
   $(document).on('change', '.btn-file2 :file', function() {
    var input = $(this);

    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
        var label = input.val();

        input.trigger('fileselect', [ 1, label, 0 ]);
    } else {
        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
        var size = input.get(0).files[0].size;

        input.trigger('fileselect', [ numFiles, label, size ]);
    }
});

$('.btn-file2 :file').on('fileselect', function(event, numFiles, label, size) {
    $('#uploadImages2').attr('name', 'uploadImages'); // allow upload.

label=label+"将被改名为02.jpg";

    var postfix = label.substr(label.lastIndexOf('.'));
    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
        if (size > 1024 * 1024 * MAX_SIZE ) {
            alert('您上传的文件过大');

            $('#uploadImages2').removeAttr('name'); // cancel upload file.
        } else {
            $('#_attachmentName2').val(label);
        }
    } else {
        alert('您上传的附件格式不对！');

        $('#uploadImages2').removeAttr('name'); // cancel upload file.
    }
});     
        
        
       $(document).on('change', '.btn-file3 :file', function() {
    var input = $(this);

    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
        var label = input.val();

        input.trigger('fileselect', [ 1, label, 0 ]);
    } else {
        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
        var size = input.get(0).files[0].size;

        input.trigger('fileselect', [ numFiles, label, size ]);
    }
});

$('.btn-file3 :file').on('fileselect', function(event, numFiles, label, size) {
    $('#uploadImages3').attr('name', 'uploadImages'); // allow upload.
label=label+"将被改名为03.jpg";


    var postfix = label.substr(label.lastIndexOf('.'));
    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
        if (size > 1024 * 1024 * MAX_SIZE ) {
            alert('您上传的文件过大');

            $('#uploadImages3').removeAttr('name'); // cancel upload file.
        } else {
            $('#_attachmentName3').val(label);
        }
    } else {
        alert('您上传的附件格式不对！');

        $('#uploadImages3').removeAttr('name'); // cancel upload file.
    }
});       
        
     
     
     
     
       $(document).on('change', '.btn-file4 :file', function() {
    var input = $(this);

    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
        var label = input.val();

        input.trigger('fileselect', [ 1, label, 0 ]);
    } else {
        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
        var size = input.get(0).files[0].size;

        input.trigger('fileselect', [ numFiles, label, size ]);
    }
});

$('.btn-file4 :file').on('fileselect', function(event, numFiles, label, size) {
    $('#uploadImages4').attr('name', 'uploadImages'); // allow upload.


label=label+"将被改名为04.jpg";

    var postfix = label.substr(label.lastIndexOf('.'));
    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
        if (size > 1024 * 1024 * MAX_SIZE ) {
            alert('您上传的文件过大');

            $('#uploadImages4').removeAttr('name'); // cancel upload file.
        } else {
            $('#_attachmentName4').val(label);
        }
    } else {
        alert('您上传的附件格式不对！');

        $('#uploadImages4').removeAttr('name'); // cancel upload file.
    }
});  



  $(document).on('change', '.btn-file5 :file', function() {
    var input = $(this);

    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
        var label = input.val();

        input.trigger('fileselect', [ 1, label, 0 ]);
    } else {
        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
        var size = input.get(0).files[0].size;

        input.trigger('fileselect', [ numFiles, label, size ]);
    }
});

$('.btn-file5 :file').on('fileselect', function(event, numFiles, label, size) {
    $('#uploadImages5').attr('name', 'uploadImages'); // allow upload.


label=label+"将被改名为05.jpg";

    var postfix = label.substr(label.lastIndexOf('.'));
    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
        if (size > 1024 * 1024 * MAX_SIZE ) {
            alert('您上传的文件过大');

            $('#uploadImages5').removeAttr('name'); // cancel upload file.
        } else {
            $('#_attachmentName5').val(label);
        }
    } else {
        alert('您上传的附件格式不对！');

        $('#uploadImages5').removeAttr('name'); // cancel upload file.
    }
});     
        
        
            $('.ui.dropdown')
                    .dropdown()
            ;
            $('.ui.radio.checkbox')
                    .checkbox()
            ;
        });
        
        
        
        
        
        
        
        
        function AddForm_onclick() {
var bankcard="<%=bankcard%>";

var bankaddress="<%=bankaddress%>";


if(bankcard=="")
{

alert("银行卡号不能为空,请修改个人信息重新登录！");
return false;
}

if(bankaddress=="")
{

alert("开户行准确名称不能为空,请修改个人信息重新登录！");

return false;
}

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
	} if(textForm.textContent.value.length>8000)
	{
		alert("稿件内容太长，请分段上传！");
		textForm.textContent.focus();
		return false;
	}
	
	
var rediovalue=$("input[type='radio']:checked").val(); 

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
        <div class="text container">
            <div class="ui segment">
                <a href="textAction_statPerson.action" class="ui blue button" style="margin-bottom: 5px;">返回稿件列表</a>
                <a href="textAction_textContribute2.action" class="ui blue button" style="margin-bottom: 5px;">视频投稿</a>
                <a href="textAction_textContribute3.action" class="ui blue button" style="margin-bottom: 5px;">音频投稿</a>
            </div>
        </div>

        <form class="ui form"   name="textForm" action="textAction2_uploadFilePic.action" method="post" enctype="multipart/form-data" onsubmit="return AddForm_onclick();">
        
        <input type="hidden" name="mytype" value="2">
            <h3 class="ui dividing green header" style="margin-top: 1em; ">图文投稿</h3>

            <div class="ui error message"></div>
            <div class="field">
                <label>标题</label>
                <input name="textTitle" maxlength="60" placeholder="标题" type="text">
            </div>
            <div class="field">
                <div class="four fields">
                    
                    
                    
                     <div class="field" >
                        <label>体裁</label>
                        <select  name="rest1">
                         <c:forEach items="${types }" var="m">
                                	<option class="item">${m }</option>
                                	</c:forEach>
                                </select>
                    </div>
                    
                    
                    
                    <div class="field">
                        <label>作者</label>
                        <input readonly="true" name="author" maxlength="11" placeholder="作者" type="text" value="${user.name_real }">
                    </div>
                </div>
            </div>

            <h4 class="ui green dividing header">版面意向</h4>

            <div class="inline fields">
                <label for="fruit">投稿版面意向：</label>

                <div class="field">
                    <div class="ui radio checkbox">
                        <input value="全部" tabindex="0" name="Cat" checked="checked" type="radio">
                        <label> 全部</label>
                    </div>
                </div>
                <div class="field">
                    <div class="ui radio checkbox">
                        <input value="一版" tabindex="0" name="Cat" type="radio">
                                                <label>一版</label>
                        
                    </div>
                </div>
                <div class="field">
                    <div class="ui radio checkbox">
                        <input value="二版" tabindex="0" name="Cat" type="radio">
                                                <label>二版</label>
                        
                       
                    </div>
                </div>
                <div class="field">
                    <div class="ui radio checkbox">
                        <input value="三版" tabindex="0" name="Cat" type="radio">
                                                <label>三版</label>
                        
                    </div>
                </div>
                <div class="field">
                    <div class="ui radio checkbox">
                        <input value="四版" tabindex="0" name="Cat" type="radio">
                                                <label>四版</label>
                        
                    </div>
                </div>
            </div>

            <h4 class="ui green dividing header">图片附件（图片作者与描述请在正文中说明，不要写在文件名中）</h4>

            
             <div class="two fields">
           <div class="field">
    <div class="ui action input">
        <input type="text" id="_attachmentName1">
        <label for="uploadImages1" class="ui icon button btn-file1">
               <i class="file image outline icon"></i>选择图片
             <input type="file" id="uploadImages1" name="uploadImages" style="display: none">
        </label>
    </div>
	</div>  
	</div>
	
	 <div class="two fields">
         <div class="field">
    <div class="ui action input">
        <input type="text" id="_attachmentName2">
        <label for="uploadImages2" class="ui icon button btn-file2">
               <i class="file image outline icon"></i>选择图片
             <input type="file" id="uploadImages2" name="uploadImages" style="display: none">
        </label>
    </div>
</div> 
</div> 

 <div class="two fields">
         <div class="field">
    <div class="ui action input">
        <input type="text" id="_attachmentName3">
        <label for="uploadImages3" class="ui icon button btn-file3">
               <i class="file image outline icon"></i>选择图片
             <input type="file" id="uploadImages3" name="uploadImages" style="display: none">
        </label>
    </div>
</div> 
</div> 
<div class="two fields">
         <div class="field">
    <div class="ui action input">
        <input type="text" id="_attachmentName4">
        <label for="uploadImages4" class="ui icon button btn-file4">
               <i class="file image outline icon"></i>选择图片
             <input type="file" id="uploadImages4" name="uploadImages" style="display: none">
        </label>
    </div>
</div> 
</div> 



 <div class="two fields">
         <div class="field">
    <div class="ui action input">
        <input type="text" id="_attachmentName5">
        <label for="uploadImages5" class="ui icon button btn-file5">
               <i class="file image outline icon"></i>选择图片
             <input type="file" id="uploadImages5" name="uploadImages" style="display: none">
        </label>
    </div>
</div> 
</div> 

















            <h4 class="ui green dividing header">正文</h4>

            <div class="field">
                <textarea name="textContent" style="height: 200px;"></textarea>
            </div>
            <div class="field">
                 <div class="ui toggle checkbox">
                      <!--     <input name="internet" type="checkbox"
                            <if condition="$data.internet == '1'">checked="checked"</if>
                            > -->
                      <label>是否转至社区</label>
                </div>
            </div>
            <input type="submit" class="ui green button" value="提交">
            <input type="button" class="ui green button" value="不保存，返回" onclick="javascript:history.back(-1);">

            <div class="ui red text segment">
                投稿用户请注意：请先补充完整您所在地的“县（区） ”信息再投稿，否则无法提交稿件，谢谢！<br>
                注意：修改完成后，需要退出投稿系统，重新登录才能提交稿件。
            </div>
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

</html>
