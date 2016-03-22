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
<link rel="stylesheet" href="${pageContext.request.contextPath}/csss/style2.css" type="text/css">
    <script src="css/jquery.min.js"></script>


<link
	href="${pageContext.request.contextPath}/script/jquery-validation/1.11.0/jquery.validate.min.css"
	type="text/css" rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/script/jquery-validation/1.11.0/jquery.validate.min.js"
	type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="css/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="css/tougao.css">

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



function AddForm_onclick() {

	
	
	if (AddForm.name_Login.value=="")
	{
		alert("用户登陆名不能为空！");
		AddForm.name_Login.focus();
		return false;
	}


	
	if (AddForm.password.value=="")
	{
		alert("用户登陆密码不能为空！");
		AddForm.password.focus();
		return false;
	}


	if(AddForm.password.value.length<="5")
	{
		alert("您输入的密码长度至少是六位！");
		AddForm.password.focus();
		return false;

		}
	if (AddForm.passwdconfirm.value=="")
	{
		alert("验证密码不能为空！");
		AddForm.passwdconfirm.focus();
		return false;
	}

	if(AddForm.passwdconfirm.value!=AddForm.password.value)
	{
		alert("两次输入密码不一样！");
		AddForm.passwdconfirm.focus();
		return false;
		
		}
	if (AddForm.name_real.value=="")
	{
		alert("用户真实姓名不能为空！");
		AddForm.name_real.focus();
		return false;
	}
	
	if (AddForm.sex.value=="")
	{
		alert("用户性别不能为空！");
		AddForm.sex.focus();
		return false;
	}
	
	
	if (AddForm.province.value=="请选择")
	{
		alert("用户所属省不能为空！");
		AddForm.province.focus();
		return false;
	}
	
	
	if (AddForm.city.value=="请选择"||AddForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		AddForm.city.focus();
		return false;
	}
	
	
	if (AddForm.county.value=="请选择")
	{
		alert("用户所属区(县)不能为空！");
		AddForm.county.focus();
		return false;
	}
	
	if (AddForm.department.value=="")
	{
		alert("用户的通讯地址不能为空！");
		AddForm.department.focus();
		return false;
	}
	var qqStr=AddForm.QQ.value;
	if (qqStr!="")
	{
		if(isNaN(qqStr))
		{
			alert("QQ号码必须为数字！");
			AddForm.QQ.focus();
			return false;
		}		
	}
	var postalcodeStr=AddForm.postalcode.value;
	if (postalcodeStr!="")
	{
		if(isNaN(postalcodeStr))
		{
			alert("邮政编码必须为数字！");
			AddForm.postalcode.focus();
			return false;
		}
		
		if (postalcodeStr.length!=6)
		{		
			alert("邮政编码必须为6位数字！");
			AddForm.postalcode.focus();
			return false;
	
		}
	}else
		{
			alert("邮政编码不能为空！");
			AddForm.postalcode.focus();
			return false;
		}
	if (AddForm.idcard.value=="")
	{
		alert("用户身份证号不能为空！");
		AddForm.idcard.focus();
		return false;
	}
	
	if(!IdCardValidate(AddForm.idcard.value))
	{
		alert("请检查用户身份证号！");
		AddForm.idcard.focus();
		return false;
	}	
	
	if (AddForm.role.value=="")
	{
		alert("用户角色不能为空！");
		AddForm.role.focus();
		return false;
	}	

	var phoneObj=AddForm.phone.value;
	if (phoneObj!="")
	{
		if(isNaN(phoneObj))
		{
			alert("办公电话必须为数字！");
			AddForm.phone.focus();
			return false;
		}
		
		
	}else
		{
			alert("办公电话不能为空！");
			AddForm.phone.focus();
			return false;
		}



	return true;
	
}



</script>
 
<script>
  $(function(){
   $("#AddForm").validate(
   {
    
    rules: {
     name_Login:{required:true,rangelength:[6,20],
        remote:{                                          //验证用户名是否存在
               type:"POST",
               url:"userAction_checkLoginName.action",             //servlet
               data:{
                 name_Login:function(){return $("#name_Login").val();}
               } 
              } 
            },
     idcard:{required:true,rangelength:[18,18],
        remote:{                                          //验证用户名是否存在
               type:"POST",
               url:"userAction_checkIdcard.action",             //servlet
               data:{
                 idcard:function(){return $("#idcard").val();}
               } 
              } 
            },
     password: {required:true,minlength:6},
     passwdconfirm: {required:true,equalTo:"#password"},
     
     name_real: {required:true},
     
     bankcard: {required:true},
     bankaddress: {required:true},
     mobilePhone: {required:true},
     phone: {required:true},
     department: {required:true},
     email: {required:true,email: true}
     
    },
    messages: {
     name_Login:{required:"用户名不能为空！",rangelength:jQuery.format("用户名位数必须在{0}到{1}字符之间！"),remote:jQuery.format("用户名已存在或登录名有中文！")},
     idcard:{required:"身份证号不能为空！",rangelength:jQuery.format("身份证号必须18位！"),remote:jQuery.format("身份证号已存在！")},
     password: {required:"密码不能为空！",minlength:jQuery.format("密码位数必须大于等于6个字符！")},
     passwdconfirm: {required:"确认密码不能为空！",equalTo:"确认密码和密码不一致！"},
     name_real: {required:"用户真实姓名不能为空！"},
     bankcard: {required:"银行卡号不能为空！"},
     bankaddress: {required:"开户行准确名称不能为空！"},
     mobilePhone: {required:"手机号码不能为空！"},
     department: {required:"通讯地址不能为空！"},
     email: {required:"电子邮件不能为空！",email: '请检查电子邮件的格式'}
    }
   });
  });
 
 </script>
</head>
<body onload="setup()">


<div class="ui fixed inverted menu">
    <div class="ui container">
        <div href="#" class="header item">
            <img class="logo" src="images/tougao_logo.png">
            投稿
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
            <a class="active section">注册新用户</a>
        </div>
       

        <form class="ui form" id="AddForm" name="AddForm" method="post" action="userAction_regin.action"  onsubmit="return AddForm_onclick();">
        

            <h3 class="ui dividing green header" style="margin-top: 1em; ">带<i class="red small check square icon"></i>号的是必填项。</h3>

            <div class="ui error message"></div>
            <div class="field">
                <div class="three fields">
                
                <div class="field">
                        <label>用户登录名<i class="red check square icon"></i>只允许字母、数字和下划线</label>
                        <input id="name_Login" name="name_Login" class="InputStyle {remote:'userAction_checkLoginName.action', messages:{remote:'用户名已存在或登录名有中文！'}}" maxlength="15" placeholder="用户登录名" type="text" value="">
                    </div>
                
                
                    <div class="field">
                        <label>用户真实姓名<i class="red check square icon"></i></label>
                        <input name="name_real" maxlength="15" placeholder="用户真实姓名" type="text" value="">
                    </div>
                </div>
            </div>
            
            
            <div class="field">
                <div class="three fields">
                
              <div class="field">
                        <label>用户密码<i class="red check square icon"></i></label>
                        <input id="password" name="password" maxlength="15" placeholder="密码" type="password" value="">
                    </div>
                               
                      <div class="field">
                        <label>确认密码<i class="red check square icon"></i></label>
                        <input  id="passwdconfirm" name="passwdconfirm" maxlength="15" placeholder="确认密码" type="password" value="">
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
                <input id="idcard" name="idcard" maxlength="18" placeholder="身份证号" type="text" ><br>
                
                ${error }
                
            </div>
            <div class="field">
                <div class="two fields">
                    <div class="field">
                        <label>银行卡号<i class="red check square icon"></i></label>
                        <input name="bankcard" maxlength="50" placeholder="银行卡号" type="text"
                               value="${bankcard}">
                    </div>
                    <div class="field">
                        <label>开户行准确名称（XX银行XX支行）<i class="red check square icon"></i></label>
                        <input name="bankaddress" maxlength="50" placeholder="XX银行XX支行" type="text"
                               value="${bankaddress}">
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

                       <select  name="role"  class="input0" style="width:132">
		<option value="记者" >记者</option>
		<option value="通讯员" selected="selected">通讯员</option>
		
		</select><font color=red>*</font>
                    </div>
                  <div class="field" >
                        <label>所属单位</label>
                        <select  name="workcompany">
                        
                                     
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
            
            <s:token/>
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