<%@page contentType="text/html;charset=GBK" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>

<script language="javascript">

function resizewindow(w,h){

window.resizeTo(w,h);

}

</script>


<html>
<head>
<title>�����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">

</head>



<body bgcolor="#C8D4E2" text="#000000" onload=resizewindow(600,500)>



<form name="textForm" method="post" action="" onSubmit="return AddForm_onclick();">
<br>
<fieldset style="width:90%" align="center" bgcolor="#FFFFFF">
	<legend align="left">
	<b>�����Ϣ��</b>
	</legend>
<br>
  <table width="95%" border="0" cellspacing="0" cellpadding="2" class=font9  align="center">
    <tr>
    <td align="left">�������:   <input type="text" name="textTitle" value="${textTitle }" class="input0" style="width:360px" readOnly ><br></td>
    </tr>
    <tr><td>�����ã�<input type="text" name="textType" value="${rest1 }" class="input0" style="width:360px" readOnly ><br></td></tr>
    <tr>
	<tr><td>�� �� �ˣ�<input type="text" name="textAuthor" value="${sender }" class="input0" style="width:360px" readOnly ><br></td></tr>
    <tr>
    <td width="15%" align="left">������ݣ�</td>
    </tr>
    <tr>
    <td>
    <s:textarea name="textContent" cssStyle="width:95%;height:230px;" cssClass="input0" readonly=""></s:textarea> 
    </td>
    </tr>
	
	
	
	<tr>
	<s:if test="#request.text.rest2==2">
	<s:if test="#request.text.filepath!=null">
    <td width="15%" align="left">ͼƬԤ����</td>
    
	

	
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
    
    ������֮ǰ�ĸ�������Ͷ��ϵͳת��������������ȫý��ϵͳ��!
     </td>
            </tr>
    </s:else>    
    
     
	  </s:if>
    	</s:if>
    	
    	
    	
    </tr>
    
    	<s:if test="#request.text.rest2==3">
    
	<tr>
    <td width="15%" align="left">��ƵԤ����</td>
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
    
    ������֮ǰ�ĸ�������Ͷ��ϵͳת��������������ȫý��ϵͳ��!
     </td>
            </tr>
    </s:else>    
    
    
 
    
    </s:if>
        	<s:if test="#request.text.rest2==4">
    
	<tr>
    <td width="15%" align="left">��ƵԤ����</td>
    </tr>


     	<s:if test="#request.mils<=60">

   <s:generator separator=";" val="filepath">   
       <s:iterator>   
           <tr>
    			<td align="center">
            <object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" id="MediaPlayer1" > 
			<param name="Filename" value="<s:property/>"> <!--���ļ���λ��-->
			<param name="PlayCount" value="1"><!--�����ظ�����: ��x��Ϊ���ظ����ż���; x=0������ѭ����--> 
			<param name="AutoStart" value="0"><!--���Ʋ��ŷ�ʽ: x=1������ҳ�Զ�����; x=0�������ż����š�--> 
			<param name="ClickToPlay" value="1"><!--���Ʋ��ſ���: x=1������������Ʋ��Ż���ͣ״̬; x=0�����ô˹��ܡ�-->
			<param name="DisplaySize" value="0"><!--���Ʋ��Ż���: x=0��ԭʼ��С; x=1��һ���С; x=2��2����С��--> 
			<param name="EnableFullScreen Controls" value="1"><!--�����л�ȫ��: x=1�������л�Ϊȫ��; x=0�����ô˹��ܡ�--> 
			<param name="ShowAudio Controls" value="1"><!--��������: x=1�������������; x=0����ֹ�������ڡ�-->
			<param name="EnableContext Menu" value="1"><!--���ƿ�ݲ˵�: x=1������ʹ���Ҽ��˵�; x=0�������Ҽ��˵���--> 
			<param name="ShowDisplay" value="1"><!--���ư�Ȩ��Ϣ: x=1����ʾ��Ӱ��������Ϣ;x=0������ʾ�����Ϣ-->
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
    
    ������֮ǰ�ĸ�������Ͷ��ϵͳת��������������ȫý��ϵͳ��!
     </td>
            </tr>
    </s:else>    
    
    
    
    
    
    </s:if>
    
    </table>
  


<br><br>
	      
</FIELDSET>
<br><br>
<div align="center"><input type="button" value="�رմ���" onClick="self.close()"></div>

</form>

<p>&nbsp;</p>
</body>
</html>
