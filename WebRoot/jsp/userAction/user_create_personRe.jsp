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
    <script type="text/javascript" src="${pageContext.request.contextPath}/script/city.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/include/IdCard-Validate.js"></script>
    
    
    <SCRIPT type="text/javascript">   
<!--   
//** Power by Fason(2004-3-11)   
//** Email:fason_pfx@hotmail.com   
  
var s=["s1","s2","s3"];   
var opt0 = ["请选择","请选择","请选择"];   
function setup()     
{     


for(i=0;i<s.length-1;i++)     
	
	
  document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");     
change(0);     
		function trimStr(str){return str.replace(/(^\s*)|(\s*$)/g,"");};


var pr='${province}';

var ci='${city}';

var co='${county}';

   co=trimStr(co);

 pr=trimStr(pr);
  ci=trimStr(ci);
  
 if(pr=='北京'||pr=='天津'||pr=='重庆'||pr=='上海')
	  {
	  	ci=pr;
	  }
 


    document.getElementById('s1').value=pr;  
    change(1);   
document.getElementById('s2').value=ci;   
change(2);   
document.getElementById('s3').value=co;    
}      

//-->   
</SCRIPT>  
    <script type="text/javascript">
        $(document).ready(function(){
        
        
               var fileExtentionRange = '.jpg.zip .rar .tar .pdf .doc .docx .xls .xlsx .ppt .pptx';
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
        
        
        
        
        
        
        
            $('.ui.dropdown')
                    .dropdown()
            ;
            $('.ui.radio.checkbox')
                    .checkbox()
            ;
        });
        
    </script>
    
    <script type="text/javascript">
function UpdateForm_onclick() {

	if (UpdateForm.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		UpdateForm.name_real.focus();
		return false;
	}
	
	if (UpdateForm.sex.value=="")
	{
		alert("用户性别不能为空！");
		UpdateForm.sex.focus();
		return false;
	}		
	
	
if(UpdateForm.province.value=="请选择")
	{
		alert("用户所属省不能为空！");
		UpdateForm.province.focus();
		return false;
	}

		if(UpdateForm.province.value=="")
	{
		alert("用户所属省不能为空！");
		UpdateForm.province.focus();
		return false;
	}

	if (UpdateForm.city.value=="请选择")
	{
		alert("用户所属城市不能为空！");
		UpdateForm.city.focus();
		return false;
	}
		if (UpdateForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		UpdateForm.city.focus();
		return false;
	}

	if (UpdateForm.county.value=="请选择")
	{
		alert("用户所属区(县)不能为空！");
		UpdateForm.county.focus();
		return false;
	}
	if (UpdateForm.county.value=="")
	{
		alert("用户所属区(县)不能为空！");
		UpdateForm.county.focus();
		return false;
	}
	if (UpdateForm.mobilePhone.value=="")
	{
		alert("不能为空！");
		UpdateForm.mobilePhone.focus();
		return false;
	}
	if (UpdateForm.phone.value=="")
	{
		alert("办公电话不能为空！");
		UpdateForm.phone.focus();
		return false;
	}

	
	if (UpdateForm.department.value=="")
	{
		alert("用户的通讯地址不能为空！");
		UpdateForm.department.focus();
		return false;
	}
	var qqStr=UpdateForm.QQ.value;
	if (qqStr!="")
	{
		if(isNaN(qqStr))
		{
			alert("QQ号码必须为数字！");
			UpdateForm.QQ.focus();
			return false;
		}		
	}
	var postalcodeStr=UpdateForm.postalcode.value;
	if (postalcodeStr!="")
	{
		if(isNaN(postalcodeStr))
		{
			alert("邮政编码必须为数字！");
			UpdateForm.postalcode.focus();
			return false;
		}
		
		if (postalcodeStr.length!=6)
		{		
			alert("邮政编码必须为6位数字！");
			UpdateForm.postalcode.focus();
			return false;
	
		}
	}else{
		alert("邮政编码不能为空！");
		UpdateForm.postalcode.focus();
		return false;
	     }
	
	if (UpdateForm.idcard.value=="")
	{
		alert("用户身份证号不能为空！");
		UpdateForm.idcard.focus();
		return false;
	}
	
	if (UpdateForm.bankcard.value=="")
	{
		alert("银行卡号不能为空！");
		UpdateForm.bankcard.focus();
		return false;
	}
	
	if (UpdateForm.bankaddress.value=="")
	{
		alert("开户行名称不能为空！");
		UpdateForm.bankaddress.focus();
		return false;
	}
	


	return true;
}
</script>
</head>
<body onload="setup()">


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
                    <a class="ui inverted button" href="/User/Login/logout.html">退出</a>
                </div>
               </c:if>
                
                <c:if test="${user==null || user=='' }">
                <div class="item">
                    <a class="ui inverted button" href="/User/Login/login.html">登陆</a>
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

            <div class="divider"> /</div>
            <a class="active section">修改个人信息</a>
        </div>
        <div class="text container">
            <div class="ui segment">
                <a href="textAction_statPerson.action" class="ui blue button" style="margin: 3px">返回稿件列表</a>
            </div>
        </div>

        <form class="ui form" name="UpdateForm" method="post" action="userAction_pageEdit.action" onsubmit="return UpdateForm_onclick();">
        
        <input type="hidden" name="MyAction" value="Update" />
<input type="hidden" name="username" value="" />

<s:hidden name="role"/>
<s:hidden name="userID"></s:hidden>
<s:hidden name="name_Login"></s:hidden>
            <h3 class="ui dividing green header" style="margin-top: 1em; ">修改个人（${name_real }）信息，带<i class="red small check square icon"></i>号的是必填项。</h3>

            <div class="ui error message"></div>
            <div class="field">
                <div class="three fields">
                    <div class="field">
                        <label>用户真实姓名<i class="red check square icon"></i></label>
                        <input name="name_real" maxlength="15" placeholder="用户真实姓名" type="text" value="${name_real }">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="four fields">
                  
                    
                    
                     <div class="field" >
                        <label>性别</label>
                        <select name="sex">
                         <option <c:if test="${sex=='男' }">selected="selected"</c:if>  value="男">男</option>
                         <option <c:if test="${sex=='女' }">selected="selected"</c:if> value="女">女</option>
                        </select>
                    </div>
                 
                    
                    
                    <div class="field" >
                        <label>省（直辖市）</label>
                        <select id="s1" name="province">
                         <option>请选择</option>
                        </select>
                    </div>
                    
                     <div class="field" >
                        <label>市（地区）</label>
                        <select id="s2" name="city">
                         <option>请选择</option>
                        </select>
                    </div>
                    
                    
                     <div class="field" >
                        <label>县（区）</label>
                        <select id="s3" name="county">
                         <option>请选择</option>
                        </select>
                    </div>
                  
                 
                </div>
            </div>
            <div class="field">
                <div class="four fields">
                    <div class="field">
                        <label>手机号码<i class="red check square icon"></i></label>
                        <input name="mobilePhone" maxlength="30" placeholder="手机号码" type="text"
                               value="${mobilePhone }">
                    </div>
                    <div class="field">
                        <label>办公电话<i class="red check square icon"></i></label>
                        <input name="phone" maxlength="30" placeholder="办公电话" type="text"
                               value="${phone}">
                    </div>
                    <div class="field">
                        <label>家庭电话</label>
                        <input name="homePhone" maxlength="30" placeholder="家庭电话" type="text"
                               value="${homePhone}">
                    </div>
                    <div class="field">
                        <label>传真号码</label>
                        <input name="fax" maxlength="30" placeholder="传真号码" type="text"
                               value="${fax}">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="four fields">
                    <div class="field">
                        <label>电子邮件<i class="red check square icon"></i></label>
                        <input name="email" maxlength="30" placeholder="电子邮件" type="text"
                               value="${email}">
                    </div>
                    <div class="field">
                        <label>QQ号码</label>
                        <input name="QQ" maxlength="30" placeholder="QQ号码" type="text"
                               value="${QQ}">
                    </div>
                </div>
            </div>

            <h4 class="ui green dividing header">银行与地址信息（稿酬汇款用）</h4>

            <div class="field">
                <label>身份证号<i class="red check square icon"></i></label>
                <input name="idcard" maxlength="18" placeholder="身份证号" type="text" value="${idcard }">
            </div>
            <div class="field">
                <div class="two fields">
                    <div class="field">
                        <label>银行卡号<i class="red check square icon"></i></label>
                        <input name="bankcard" maxlength="50" placeholder="银行卡号" type="text"
                               value="${bankcard}">
                    </div>
                    <div class="field">
                        <label>开户行准确名称<i class="red check square icon"></i></label>
                        <input name="bankaddress" maxlength="50" placeholder="开户行准确名称" type="text"
                               value="${bankaddress}">
                    </div>
                    <div class="field">
                        <label>开户行联行号</label>
                        <input name="banklinkcard" maxlength="50" placeholder="开户行联行号" type="text"
                               value="${banklinkcard}">
                    </div>
                </div>
            </div>
            <div class="field">
                <label>通讯地址<i class="red check square icon"></i></label>
                <input name="department" maxlength="50" placeholder="详细通讯地址" type="text"
                       value="${department}">
            </div>
            <div class="field">
                <div class="four fields">
                    <div class="field">
                        <label>邮编<i class="red check square icon"></i></label>
                        <input name="postalcode" maxlength="11" placeholder="邮编" type="text"
                               value="${postalcode}">
                    </div>
                </div>
            </div>
            <h4 class="ui green dividing header">其他信息</h4>

            <div class="field">
                <div class="four fields">
                    <div class="field">
                        <label>职务</label>
                        <input name="职务" maxlength="20" placeholder="职务" type="text"
                               value="${principalship}">
                    </div>
                    <div class="field">
                        <label>角色</label>

                        <div class="ui selection dropdown">
                            <input name="角色" maxlength="15" type="hidden">

                            <div class="default text">${role }</div>
                         
                        </div>
                    </div>
                  <div class="field" >
                        <label>所属单位</label>
                        <select  name="workcompany">
                        
                        <option>请选择</option>
                        
                        
                        <c:forEach items="${workcompanys }" var="m">
                         <option  <c:if test="${m==workcompany }">selected="selected"</c:if> value="${m }">${m }</option>
                         
                         </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <input type="submit" class="ui green button" value="保存">
            <input type="button" class="ui green button" value="不保存，返回" onclick="javascript:history.back(-1);">

            <div class="ui red message">
                投稿用户请注意：请先补充完整您的银行卡号、开户行准确名称和所在地的“县（区） ”信息再投稿，否则无法提交稿件，谢谢！<br>
                注意：修改完成后，需要退出投稿系统，重新登录才能提交稿件。
            </div>
        </form>
    </div>
</div>
<script>
    $(document)
            .ready(function () {
                $('.ui.form')
                        .form({
                            username: {
                                identifier: 'text_title',
                                rules: [
                                    {
                                        type: 'empty',
                                        prompt: '标题不能为空'
                                    }
                                ]
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
        <img src="/images/logo.png" class="ui centered image">

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