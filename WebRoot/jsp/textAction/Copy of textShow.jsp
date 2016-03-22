<%@page contentType="text/html;charset=GBK" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<script language="javascript">

function resizewindow(w,h){

window.resizeTo(w,h);

}

</script>


<html>
<head>
<title>稿件信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">

</head>



<body bgcolor="#C8D4E2" text="#000000" onload=resizewindow(600,500)>



<form name="textForm" method="post" action="" onSubmit="return AddForm_onclick();">
<br>
<fieldset style="width:90%" align="center" bgcolor="#FFFFFF">
	<legend align="left">
	<b>稿件信息：</b>
	</legend>
<br>
  <table width="95%" border="0" cellspacing="0" cellpadding="2" class=font9  align="center">
    <tr>
    <td align="left">稿件标题:   <input type="text" name="textTitle" value="${textTitle }" class="input0" style="width:360px" readOnly ><br></td>
    </tr>
    <tr><td>稿件体裁：<input type="text" name="textType" value="${rest1 }" class="input0" style="width:360px" readOnly ><br></td></tr>
    <tr>
	<tr><td>传 稿 人：<input type="text" name="textAuthor" value="${sender }" class="input0" style="width:360px" readOnly ><br></td></tr>
    <tr>
    <td width="15%" align="left">稿件内容：</td>
    </tr>
    <tr>
    <td>
    <s:textarea name="textContent" cssStyle="width:95%;height:230px;" cssClass="input0" readonly=""></s:textarea> 
    </td>
    </tr>
	
	
	
	<tr>
	<s:if test="#request.text.rest2==2">
	<s:if test="#request.text.filepath!=null">
    <td width="15%" align="left">图片预览：</td>
    
	

	
 	<s:if test="#request.mils<=60">
 	
 
   <s:generator separator=";" val="filepath">   
       <s:iterator>   
           <tr>
    			<td align="center">
            <img align="middle" src="<s:property/>" width="200"/><br/>
            </td>
            </tr>
       </s:iterator>   
    </s:generator>  
    </s:if>
    
    <s:else>
    <tr>
    			<td align="center">
    <br/>
    
    两个月之前的附件已由投稿系统转移至报社内网的全媒体系统中!
     </td>
            </tr>
    </s:else>    
    
     
	  </s:if>
    	</s:if>
    	
    	
    	
    </tr>
    
    	<s:if test="#request.text.rest2==3">
    
	<tr>
    <td width="15%" align="left">视频预览：</td>
    </tr>
    
     	<s:if test="#request.mils<=60">
    
    
     <s:generator separator=";" val="filepath">   
       <s:iterator>   
           <tr>
    			<td align="center">
   <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" 
				height="120" width="190"> 
		<param name="movie" value="../../images/vcastr22.swf?vcastr_file=<s:property/>"> 
		<param name="quality" value="high"> 
		<param name="allowFullScreen" value="true" /> 
		<embed src="../../images/vcastr22.swf?vcastr_file=<s:property/>" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" 
				type="application/x-shockwave-flash" width="320" height="240"> </embed> 
			</object> 
            </td>
            </tr>
       </s:iterator>   
    </s:generator>   
    </s:if>
    
      <s:else>
    <tr>
    			<td align="center">
    <br/>
    
    两个月之前的附件已由投稿系统转移至报社内网的全媒体系统中!
     </td>
            </tr>
    </s:else>    
    
    
 
    
    </s:if>
        	<s:if test="#request.text.rest2==4">
    
	<tr>
    <td width="15%" align="left">音频预览：</td>
    </tr>


     	<s:if test="#request.mils<=60">

   <s:generator separator=";" val="filepath">   
       <s:iterator>   
           <tr>
    			<td align="center">
            <object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" id="MediaPlayer1" > 
			<param name="Filename" value="<s:property/>"> <!--你文件的位置-->
			<param name="PlayCount" value="1"><!--控制重复次数: “x”为几重复播放几次; x=0，无限循环。--> 
			<param name="AutoStart" value="0"><!--控制播放方式: x=1，打开网页自动播放; x=0，按播放键播放。--> 
			<param name="ClickToPlay" value="1"><!--控制播放开关: x=1，可鼠标点击控制播放或暂停状态; x=0，禁用此功能。-->
			<param name="DisplaySize" value="0"><!--控制播放画面: x=0，原始大小; x=1，一半大小; x=2，2倍大小。--> 
			<param name="EnableFullScreen Controls" value="1"><!--控制切换全屏: x=1，允许切换为全屏; x=0，禁用此功能。--> 
			<param name="ShowAudio Controls" value="1"><!--控制音量: x=1，允许调节音量; x=0，禁止音量调节。-->
			<param name="EnableContext Menu" value="1"><!--控制快捷菜单: x=1，允许使用右键菜单; x=0，禁用右键菜单。--> 
			<param name="ShowDisplay" value="1"><!--控制版权信息: x=1，显示电影及作者信息;x=0，不显示相关信息-->
		</object>
            </td>
            </tr>
       </s:iterator>   
    </s:generator>   
    </s:if>
    
    
    
          <s:else>
    <tr>
    			<td align="center">
    <br/>
    
    两个月之前的附件已由投稿系统转移至报社内网的全媒体系统中!
     </td>
            </tr>
    </s:else>    
    
    
    
    
    
    </s:if>
    
    </table>
  


<br><br>
	      
</FIELDSET>
<br><br>
<div align="center"><input type="button" value="关闭窗口" onClick="self.close()"></div>

</form>

<p>&nbsp;</p>
</body>
</html>
