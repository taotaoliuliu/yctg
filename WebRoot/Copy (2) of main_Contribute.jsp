<%@page contentType="text/html;charset=utf-8" import="cn.uni.domain.*,com.yl.authcode.util.AuthCode,java.net.URLEncoder"%>
<%@page import="java.util.Date"%> 

<%@ taglib prefix="s" uri="/struts-tags"%> 


<html>
<head>
<title>Contribution</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />
<script language="javascript" src="${pageContext.request.contextPath}/script/jquery.js"></script>
<script language="javascript" src="${pageContext.request.contextPath}/script/include.js"></script>

<% 
	UserInfo user=(UserInfo)request.getSession().getAttribute("user");

	System.out.println(user.getCounty()+"################");


String name=user.getName_Login();

System.out.println(name+"name");
String county=	user.getCounty();
System.out.println(county+"sds");
String pwd=user.getPassword();
if(county==null)
{
county="";
}

Date date = new Date();
Long ss=date.getTime();

String ss2="@qq.com";
ss2=ss+ss2;

String str="mod=logging&username="+name+"&password="+pwd+"&email="+ss2+"";


AuthCode authCode = new AuthCode();
String encode = authCode.encode(str, "11223344", 0);
String encode2 = URLEncoder.encode(encode);

%>
<script type="text/javascript" src="http://club.zgqxb.com.cn/discuz/upload/api/member_api.php?code=<%=encode2 %>"></script>
 
	
  
  <script type="text/javascript">

  var xhr = null;
  if(window.XMLHttpRequest){
  	xhr = new XMLHttpRequest();
  }else{
  	xhr = new ActiveXObject("Msxml2.XMLHttp.4.0");
  }
  function Ajax(){
  	this.post=function(url,param,func,dt){
  		xhr.open("POST",url,true);
  		xhr.setRequestHeader("accept","application/"+dt);
  		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
  		xhr.onreadystatechange=function(){
  			if(xhr.readyState==4){
  				if(xhr.status==200){
  					if(dt=="json"){
  						var str = xhr.responseText;
  						alert(str);
  						str = eval("("+str+")");
  						func(str);
  					}else{
  						var xml = xhr.responseXML;
  						func(xml);
  					}
  				}
  			}
  		};
  		xhr.send(param);
  	};
  	this.get=function(url,func,dt){
  		xhr.open("GET",url,true);
  		xhr.setRequestHeader("accept","application/"+dt);
  		xhr.onreadystatechange=function(){
  			if(xhr.readyState==4){
  				if(xhr.status==200){
  					if(dt=="json"){
  						var str = xhr.responseText;
  						str = eval("("+str+")");
  						func(str);
  					}else{
  						var xml = xhr.responseXML;
  						func(xml);
  					}
  				}
  			}
  		};
  		xhr.send(null);
  	};
  }

    	$(function(){
    		$("#_all").click(function(){
    			var ajax = new Ajax();
    			var url = "http://localhost:8080/day02_cxf/ws/person/all";
    			ajax.get(url,function(data){
    				///alert("这是返回的数据："+data);
    				//alert(typeof(data));
    				//alert(data.arrayOfString.user.name);
    			},"json");
    		});
    		$("#_save").click(function(){
        		var name=$("#name").val();
        		var age= $("#age").val();
    			var ajax = new Ajax();
    			var url = "http://localhost:8080/0529webservice/ws/person/save";
    			ajax.post(url,"name="+name+"&age="+age+"",function(data){
    				alert(">>>><<<:"+data);
    			},"xml");
    		});
    	});
    </script>




</head>
<script language="javascript">
function AddForm_onclick() {



var county='<%=county%>';


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
function CheckFileExt(strFullfilepath)
	{
			//从字符串中提取文件全名。
			var count = strFullfilepath.lastIndexOf("\\");
			var strFileinfo = strFullfilepath.substr(count+1);

			//判断文件的扩展名是否为指定的文件格式
			var fileExtension;
			fileExtension = new String(getFileExtension(strFileinfo));
			fileExtension = fileExtension.toLowerCase();
			if( fileExtension!= "jpg" && fileExtension != "jpeg")
			{					
				alert('请选择jpeg或者jpg格式的图片文件！');
				//return false;	
			}
			//else
			//{
			//	return true;
			//}
	}
	//得到文件的后缀
	function getFileExtension(strFullfilename){
		var index,fullfilename,fileExtension;

		fullfilename = new String(strFullfilename);
		count = fullfilename.lastIndexOf(".");
		fileExtension = fullfilename.substr(count + 1);

		return fileExtension;
	}
	//继续添加附件
	 function AddMore(){
	 
	 
	 var aa=	$("input[type=file]").length;


if(aa>=5)
{
alert("最多只能上传五张！");

return false;
}
	 
            var more = document.getElementById("file_d");
            var br = document.createElement("br");
            var input = document.createElement("input");
            var button = document.createElement("input");
            
            input.type = "file";
            input.name = "uploadImages";
			input.size = "80";
			input.onchange=function()
			{
				CheckFileExt(input.value);
			}
            
            button.type = "button";
            button.value = "删除";
            
            more.appendChild(br);
            more.appendChild(input);
            more.appendChild(button);
            
            button.onclick = function(){
			more.removeChild(br);
			more.removeChild(input);
			more.removeChild(button);
            }; 
        }

</script>


<BODY text=#000000 leftMargin=0 topMargin=0>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="30" background="images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
    <TD background="images/Line.jpg" class=text><HR width="100%" noShade SIZE=1></TD>
  </TR>
  <TR align="center">
 
    <TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute.action">::&nbsp;投稿区---图文稿件aaaaaaaaaaa&nbsp;::</A></h4> </B> 
      <BR>
      <HR width="100%" noShade SIZE=1>
    </TD>	
    <TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute2.action">::&nbsp;投稿区---视频稿件&nbsp;::</A></h4></B> 
      <BR>
      <HR width="100%" noShade SIZE=1>
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute3.action">::&nbsp;投稿区---音频稿件&nbsp;::</A></h4></B> 
      <BR>
      <HR width="100%" noShade SIZE=1>
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_statPerson.action">::&nbsp;${name}的上传稿件统计&nbsp;::</A></h4></B><BR>
      <HR width="100%" noShade SIZE=1>
  </TD></TR></TBODY></TABLE>



<s:form  name="textForm" action="textAction2_uploadFilePic.action" onsubmit="return AddForm_onclick();" enctype="multipart/form-data" method="post">
<input type="hidden" name="MyAction" value="Add">
<input type="hidden" name="mytype" value="2">

<table cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle bgColor=#ffffff height=250>
      <FIELDSET style="WIDTH: 90%;" align=center bgcolor="#FFFFFF">
      <LEGEND align=left><B>图文稿件：</B> </LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
        <TBODY>
        <TR>
          <TD height=30 colspan="2"><BR>
         <font color=red size="4"> <s:fielderror></s:fielderror></font>
           	 标题：
            <input type="text" name="textTitle" value="${textTitle}" class="input0" style="width:400pt"> <font color=red>*</font><BR>            <BR>
			体裁：
			        <s:select list="#types" name="rest1"></s:select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			作者：
			<input type="text" name="author" value="${user.name_real }" class="input0" style="width:80pt "><font color="#FF0000">多个作者请请用逗号隔开</font><BR>    <BR>
			
			版面：<s:radio list="#txtplates" name="Cat" value="'全部'"/>
			 <BR> <BR>
			 	是否同步：<s:checkbox name="bbsyes" id="bbsyes" value="1" ></s:checkbox>
			<BR>
			<BR>
			同步类型：
			        <s:select  name="bbstype" id="bbstype" list="{'帖子'}" 
						disabled="true">
						
						</s:select>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
			同步版块：           	<s:select list="#bbss" name="bbstype2" id="bbstype2" listKey="id" listValue="name" disabled="true"></s:select>
			<BR>    <BR>
			 
			图片附件：<input type="button" value="增加附件" onClick="AddMore()"><font color="#FF0000">附件jpg格式；单个附件大小请限定在10M以内，建议上传三个以内的附件以防上传失败</font>
			<div id="file_d">
            </div>
            
            
			<BR>
		
           	 内容：<font color=red>（请使用IE浏览器，并选择兼容模式投稿，谢谢。）</font><br>
            <TextArea name="textContent" style="WIDTH: 85%; HEIGHT: 270pt" value="" class="input0">${textContent}</TextArea><font color=red>*</font>
            </TD>
          </TR>
        </TBODY>
     </TABLE>
     
     <font color=red>投稿用户请注意：请先补充完整您所在地的“县（区） ”信息再投稿，否则无法提交稿件，谢谢！<br>
	注意：修改完成后，需要退出投稿系统，重新登录才能提交稿件。<br>
</font>
      <BR></FIELDSET> <BR><BR></TD>
    
  </TR>
  </TBODY>
</table>



<table width="90%" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td width="97%" align="center"><input type="image" src="images/queren.gif" width="69" height="20" border="0">　<a href="textAction_textContribute.action"><img src="images/cancel.gif" width="69" height="20" border="0"></a></td>
</tr>
</table>

</s:form>

<p>&nbsp;</p>
</body>


    <script language="JavaScript">
  	$().ready(function(){
  		$("#bbsyes").attr("checked",false);
  		
   $("#bbsyes").click(function() {
                       if (!!$("#bbsyes").attr("checked")) {
                              $("#bbstype").attr("disabled",false);
                              $("#bbstype2").attr("disabled",false);
                       }
                       
                                              if (!$("#bbsyes").attr("checked")) {
                              $("#bbstype").attr("disabled",true);
                              $("#bbstype2").attr("disabled",true);
                       }
               });
		
  		$("#bbstype").change(function(){
  	  	

  		  var jsonObj={
  			  	 bbsname:$(this).val()
  			  }


  		 $("#bbstype2 option[value!='']").remove();
  			$.post("textAction_getBBSByName",jsonObj,function(data,textStatus){
  	  		
  				var dataObj=eval("("+data+")");

  			   for(var i=0;i<dataObj.length;i++){
  			   //<option value="1">xinjiang</option>
  				  var $option=$("<option/>");
  				  $option.attr("value",dataObj[i].id);
  				  $option.text(dataObj[i].name);
  				  $("#bbstype2").append($option);	
  				}	


  	  			});

  	  		});




  	  	});
  	  	
  
  	</script>
</html>
