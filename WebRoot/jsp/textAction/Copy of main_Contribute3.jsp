<%@page contentType="text/html;charset=utf-8" import="cn.uni.domain.*,com.yl.authcode.util.AuthCode,java.net.URLEncoder"%>

<%@ taglib prefix="s" uri="/struts-tags"%> 
<% 
	UserInfo user=(UserInfo)request.getSession().getAttribute("user");
	
String county=	user.getCounty();

if(county==null)
{
county="";
}
%>

<html>
<head>
<title>Contribution</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/style2.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/pageCommon.css" />
<script language="javascript" src="${pageContext.request.contextPath}/script/jquery.js"></script>

</head>
<script language="javascript">
function AddForm_onclick() {



var county='<%=county%>';



	var aa=true;
	
	if(county=="")
	{
	alert("请填写自己所属的县！");
	
			return false;
	
	}
	

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
	}else if(textForm.textContent.value.length>10000)
	{
		alert("稿件内容太长，超过1万字，请分段上传！");
		textForm.textContent.focus();
		return false;
	}
	
	
	
	var title=textForm.textTitle.value;
	var jsonObj={title:title};
		

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
  					alert('11');
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
			if( fileExtension!= "mp3" && fileExtension!= "wma" )
			{					
				alert('请选择mp3或者wma格式的图片文件！');
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
    	
    <TD width="25%" class=text><h4><B><A 
      href="textAction_textContribute.action">::&nbsp;投稿区---图文稿件&nbsp;::</A></B></h4> 
      <BR>
    </TD>	
    <TD width="25%" class=text><h4><B><A 
      href="textAction_textContribute2.action">::&nbsp;投稿区---视频稿件&nbsp;::</A></B> </h4>
      <BR>
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_textContribute3.action">::&nbsp;投稿区---音频稿件&nbsp;::</A></h4></B> 
      <BR>
    </TD>
    <TD width="25%" class=text><B><h4><A 
      href="textAction_statPerson.action">::&nbsp;${name}的上传稿件统计&nbsp;::</A></h4></B><BR>
  </TD></TR></TBODY></TABLE>



<s:form  name="textForm" action="textAction2_uploadFilePic.action" onsubmit="return AddForm_onclick();" enctype="multipart/form-data" method="post">
<input type="hidden" name="MyAction" value="Add">
<input type="hidden" name="mytype" value="4">

<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle bgColor=#ffffff height=250>
      <FIELDSET style="WIDTH: 90%;" align=center bgcolor="#FFFFFF">
      <LEGEND align=left><B>音频稿件：</B> </LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
        <TBODY>
        <TR>
          <TD height=30 colspan="2"><BR>
                   <font color=red size="4"> <s:fielderror></s:fielderror></font>
          	  标题：
            <input type="text" name="textTitle" value="${textTitle}" class="input0" style="width:400pt"><font color=red>*</font><BR>            <BR>
			体裁：
			<s:select list="#types" name="rest1"></s:select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			作者：
			<input type="text" name="author" value="${name }" class="input0" style="width:80pt "><font color="#FF0000">多个作者请请用逗号隔开</font>
			<BR>    
			<BR>
			
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
			音频附件：<input type="button" value="增加附件" onClick="AddMore()"><font color="#FF0000">附件MP3格式；单个附件大小请限定在10M以内，建议上传三个以内的附件以防上传失败</font>
			<div id="file_d">
    
            </div>

			<BR><BR>
            内容：<BR>
            <TextArea name="textContent" style="WIDTH: 85%; HEIGHT: 270pt" value="" class="input0">${textContent}</TextArea><font color=red>*</font>
            </TD>
          </TR>
        </TBODY>
     </TABLE>
      <BR></FIELDSET> <BR><BR></TD>
    
  </TR>
  </TBODY>
</TABLE>



<table width="90%" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td width="97%" align="center"><input type="image" src="images/queren.gif" width="69" height="20" border="0">　<a href="textAction_textContribute3.action"><img src="images/cancel.gif" width="69" height="20" border="0"></a></td>
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
