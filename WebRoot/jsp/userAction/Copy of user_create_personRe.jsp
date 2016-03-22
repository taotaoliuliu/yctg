<%@page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="s" uri="/struts-tags"%> 

<html>
<head>
<title>紫光新华远程投稿管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
 <%@ include file="/jsp/public/commons.jspf"%>

<script language="javascript">
<!--
var where = new Array(35); 
function comefrom(loca,locacity) { this.loca = loca; this.locacity = locacity; } 
where[0]= new comefrom("请选择省份名","请选择城市名");
where[1] = new comefrom("北京","|东城|西城|崇文|宣武|朝阳|丰台|石景山|海淀|门头沟|房山|通州|顺义|昌平|大兴|平谷|怀柔|密云|延庆|北京其他"); 
where[2] = new comefrom("上海","|黄浦|卢湾|徐汇|长宁|静安|普陀|闸北|虹口|杨浦|闵行|宝山|嘉定|浦东|金山|松江|青浦|南汇|奉贤|崇明|上海其他"); 
where[3] = new comefrom("天津","|和平|东丽|河东|西青|河西|津南|南开|北辰|河北|武清|红挢|塘沽|汉沽|大港|宁河|静海|宝坻|蓟县|天津其他"); 
where[4] = new comefrom("重庆","|万州|涪陵|渝中|大渡口|江北|沙坪坝|九龙坡|南岸|北碚|万盛|双挢|渝北|巴南|黔江|长寿|綦江|潼南|铜梁|大足|荣昌|壁山|梁平|城口|丰都|垫江|武隆|忠县|开县|云阳|奉节|巫山|巫溪|石柱|秀山|酉阳|彭水|江津|合川|永川|南川|重庆其他"); 
where[12] = new comefrom("河北","|石家庄|邯郸|邢台|保定|张家口|承德|廊坊|唐山|秦皇岛|沧州|衡水|河北其他"); 
where[25] = new comefrom("山西","|太原|大同|阳泉|长治|晋城|朔州|吕梁|忻州|晋中|临汾|运城|山西其他"); 
where[21] = new comefrom("内蒙古","|呼和浩特|包头|乌海|赤峰|呼伦贝尔盟|阿拉善盟|哲里木盟|兴安盟|乌兰察布盟|锡林郭勒盟|巴彦淖尔盟|伊克昭盟|内蒙古其他"); 
where[20] = new comefrom("辽宁","|沈阳|大连|鞍山|抚顺|本溪|丹东|锦州|营口|阜新|辽阳|盘锦|铁岭|朝阳|葫芦岛|辽宁其他"); 
where[17] = new comefrom("吉林","|长春|吉林|四平|辽源|通化|白山|松原|白城|延边|吉林其他"); 
where[14] = new comefrom("黑龙江","|哈尔滨|齐齐哈尔|牡丹江|佳木斯|大庆|绥化|鹤岗|鸡西|黑河|双鸭山|伊春|七台河|大兴安岭|黑龙江其他"); 
where[18] = new comefrom("江苏","|南京|镇江|苏州|南通|扬州|盐城|徐州|连云港|常州|无锡|宿迁|泰州|淮安|江苏其他"); 
where[31] = new comefrom("浙江","|杭州|宁波|温州|嘉兴|湖州|绍兴|金华|衢州|舟山|台州|丽水|浙江其他"); 
where[5] = new comefrom("安徽","|合肥|芜湖|蚌埠|马鞍山|淮北|铜陵|安庆|黄山|滁州|宿州|池州|淮南|巢湖|阜阳|六安|宣城|亳州|安徽其他"); 
where[6] = new comefrom("福建","|福州|厦门|莆田|三明|泉州|漳州|南平|龙岩|宁德|福建其他"); 
where[19] = new comefrom("江西","|南昌市|景德镇|九江|鹰潭|萍乡|新馀|赣州|吉安|宜春|抚州|上饶|江西其他"); 
where[24] = new comefrom("山东","|济南|青岛|淄博|枣庄|东营|烟台|潍坊|济宁|泰安|威海|日照|莱芜|临沂|德州|聊城|滨州|菏泽|山东其他"); 
where[13] = new comefrom("河南","|郑州|开封|洛阳|平顶山|安阳|鹤壁|新乡|焦作|濮阳|许昌|漯河|三门峡|南阳|商丘|信阳|周口|驻马店|济源|河南其他"); 
where[15] = new comefrom("湖北","|武汉|宜昌|荆州|襄樊|黄石|荆门|黄冈|十堰|恩施|潜江|天门|仙桃|随州|咸宁|孝感|鄂州|湖北其他");
where[16] = new comefrom("湖南","|长沙|常德|株洲|湘潭|衡阳|岳阳|邵阳|益阳|娄底|怀化|郴州|永州|湘西|张家界|湖南其他"); 
where[8] = new comefrom("广东","|广州|深圳|珠海|汕头|东莞|中山|佛山|韶关|江门|湛江|茂名|肇庆|惠州|梅州|汕尾|河源|阳江|清远|潮州|揭阳|云浮|广东其他"); 
where[9] = new comefrom("广西","|南宁|柳州|桂林|梧州|北海|防城港|钦州|贵港|玉林|南宁地区|柳州地区|贺州|百色|河池|广西其他"); 
where[11] = new comefrom("海南","|海口|三亚|海南其他"); 
where[27] = new comefrom("四川","|成都|绵阳|德阳|自贡|攀枝花|广元|内江|乐山|南充|宜宾|广安|达川|雅安|眉山|甘孜|凉山|泸州|四川其他"); 
where[10] = new comefrom("贵州","|贵阳|六盘水|遵义|安顺|铜仁|黔西南|毕节|黔东南|黔南|贵州其他"); 
where[30] = new comefrom("云南","|昆明|大理|曲靖|玉溪|昭通|楚雄|红河|文山|思茅|西双版纳|保山|德宏|丽江|怒江|迪庆|临沧|云南其他");
where[28] = new comefrom("西藏","|拉萨|日喀则|山南|林芝|昌都|阿里|那曲|西藏其他"); 
where[26] = new comefrom("陕西","|西安|宝鸡|咸阳|铜川|渭南|延安|榆林|汉中|安康|商洛|陕西其他"); 
where[7] = new comefrom("甘肃","|兰州|嘉峪关|金昌|白银|天水|酒泉|张掖|武威|定西|陇南|平凉|庆阳|临夏|甘南|甘肃其他"); 
where[22] = new comefrom("宁夏","|银川|石嘴山|吴忠|固原|宁夏其他"); 
where[23] = new comefrom("青海","|西宁|海东|海南|海北|黄南|玉树|果洛|海西|青海其他"); 
where[29] = new comefrom("新疆","|乌鲁木齐|石河子|克拉玛依|伊犁|巴音郭勒|昌吉|克孜勒苏柯尔克孜|博尔塔拉|吐鲁番|哈密|喀什|和田|阿克苏|新疆其他"); 
where[32] = new comefrom("香港","香港"); 
where[33] = new comefrom("澳门","澳门"); 
where[34] = new comefrom("台湾","|台北|高雄|台中|台南|屏东|南投|云林|新竹|彰化|苗栗|嘉义|花莲|桃园|宜兰|基隆|台东|金门|马祖|澎湖|台湾其他"); 
where[35] = new comefrom("其它","|北美洲|南美洲|亚洲|非洲|欧洲|大洋洲"); 
function select() {
with(document.AddForm.province) { var loca2 = options[selectedIndex].value; }
for(i = 0;i < where.length;i ++) {
if (where[i].loca == loca2) {
loca3 = (where[i].locacity).split("|");
for(j = 0;j < loca3.length;j++) { with(document.AddForm.city) { length = loca3.length; options[j].text = loca3[j]; options[j].value = loca3[j]; var loca4=options[selectedIndex].value;}}
break;
}}
//document.AddForm.newlocation.value=loca2+loca4;
}
function init() {
	var strprovince=AddForm.province1.value; 
	var strcity=AddForm.city1.value;
	where[0]= new comefrom(strprovince+" ",strcity+" ");


	with(document.AddForm.province) {
	length = where.length;
	for(k=0;k<where.length;k++) { options[k].text = where[k].loca; options[k].value = where[k].loca; }
	options[selectedIndex].text = where[0].loca; options[selectedIndex].value = where[0].loca;
	}
	with(document.AddForm.city) {
	loca3 = (where[0].locacity).split("|");
	length = loca3.length;
	for(l=0;l<length;l++) { options[l].text = loca3[l]; options[l].value = loca3[l]; }
	options[selectedIndex].text = loca3[0]; options[selectedIndex].value = loca3[0];
	}}
-->
</script>
<script language="javascript" src="${pageContext.request.contextPath}/include/IdCard-Validate.js"></script>
</head>
<script language="javascript">



function AddForm_onclick() {

	var passwordObj=document.getElementById("password");
	var passwdconfirmObj=document.getElementById("passwdconfirm");


	
	if (AddForm.name_Login.value=="")
	{
		alert("用户登陆名不能为空！");
		AddForm.name_Login.focus();
		return false;
	}

	//var reg = /^\w+$/; 
	
	//if(!reg.test(AddForm.name_Login.value.match))
	//{
		    
		//alert("用户登陆名只能输入字母，数字或下划线！");
		//AddForm.name_Login.focus();
	    // return false;
	//}
	
	
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
	
	
	if (AddForm.province.value=="请选择省份名")
	{
		alert("用户所属省不能为空！");
		AddForm.province.focus();
		return false;
	}
	if (AddForm.city.value=="请选择城市名"||AddForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		AddForm.city.focus();
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

<body bgcolor="#FFFFFF" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;注册新用户&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>


<s:form name="AddForm" method="post" action="userAction_regin.action" onsubmit="return AddForm_onclick();">
<input type="hidden" name="MyAction" value="Add">
<input type="hidden" name="province1" value="${province}" />
<input type="hidden" name="city1" value="${city}" />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="2"><img src="../images/main_01.gif" width="2" height="0"></td>
	    <td background="../images/main_01.gif" align="right">&nbsp; </td>
	    <td width="5" align="right"><img src="../images/main_02.gif" width="5" height="0"></td>
	  </tr>
  </table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td bgcolor="#f0f0f0" align="center" height="250" valign="top"> 
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td>&nbsp;</td>
	        </tr>
	        <tr> 
	          <td bgcolor="#000000">
	            <table width="100%" border="0" cellspacing="1" cellpadding="0">
	              <tr>
	                <td bgcolor="#F6F6F6" align="center"> 
	                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
	                    <tr> 
	                      <td height="30">&nbsp;
	                      <font color=red><s:fielderror></s:fielderror> </font>
	                    </tr>
	                    <tr> 
	                      <td bgcolor="#000000"> 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">用户登录名：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><s:textfield name="name_Login"  cssClass="input0 {remote:'userAction_checkLoginName.action', messages:{remote:'用户名已存在，请更换！'}}"/> <font color=red>*</font>只允许字母、数字和下划线</td>
      	<td bgcolor="#F6F6F6" width="15%" align="left">基层单位</td>
        <td bgcolor="#F6F6F6" width="25%" align="left">       <s:select list="#workcompanys" name="workcompany"></s:select>
        </td>
      </tr>

      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">用户密码：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="password" name="password" id="password" value="${password }" class="input0"><font color=red>*</font>密码必须大于6位</td>
        <td bgcolor="#F6F6F6" width="15%" align="left">确认密码：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="password" name="passwdconfirm" id="passwdconfirm" value="${passwdconfirm }" class="input0"><font color=red>*</font></td>
      </tr>
      
      <tr>
       <td bgcolor="#F6F6F6" width="15%" align="left">用户真实名：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="name_real" value="${name_real }" class="input0"><font color=red>*</font></td>
         <td bgcolor="#F6F6F6" width="15%" align="left">性&nbsp;&nbsp;别：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><s:select list="{'男','女'}"  name="sex" cssStyle='width:132' cssClass="input0"
				          headerKey="" headerValue="请选择">
				     </s:select>
         <font color=red>*</font></td>
      </tr>

      <body onload="init()">
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">用户所属省：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><select name="province"  onChange="select()" style="width:132"></select><font color=red>*</font></td>
      	<td bgcolor="#F6F6F6" width="15%" align="left">用户所属市：</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><select name="city" width="61%" onChange= "select()" style="width:132"></select><font color=red>*</font></td>
      </tr>
      
       <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">详细通讯地址：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="department" value="${department }" class="input0" maxlength="40"><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">邮政编码：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="postalcode" value="${postalcode }" class="input0"><font color=red>*</font></td>
      </tr>	
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">身份证号：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><s:textfield name="idcard" cssClass="input0 {remote:'userAction_checkIdcard.action', messages:{remote:'身份证已存在，请更换！'}}"/><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">角&nbsp;&nbsp;色：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><select  name="role"  class="input0" style="width:132">
		<option value="记者" >记者</option>
		<option value="通讯员" selected="selected">通讯员</option>
		
		</select><font color=red>*</font></td>

      </tr>   
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">办公电话：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="phone" value="${phone }" class="input0"><font color=red>*</font></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">职&nbsp;&nbsp;务：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="principalship" value="${principalship }" class="input0"></td>

      </tr>   
      
       <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">家庭电话：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="homePhone" value="${homePhone }" class="input0"></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">传&nbsp;&nbsp;真：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="fax" value="${fax }" class="input0"></td>      
      </tr>     
      
      <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">电子邮件：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="email" value="${email }" class="input0">
        <td bgcolor="#F6F6F6" width="15%" align="left">手&nbsp;&nbsp;机：&nbsp;&nbsp;</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="mobilePhone" value="${mobilePhone }" class="input0">  	
      </tr> 	
	  <tr>
        <td bgcolor="#F6F6F6" width="15%" align="left">MSN账号：</td>
        <td bgcolor="#F6F6F6" width="45%" align="left"><input type="text" name="MSN" value="${MSN }" class="input0" size="40"></td>
        <td bgcolor="#F6F6F6" width="15%" align="left">QQ号码：</td>
        <td bgcolor="#F6F6F6" width="25%" align="left"><input type="text" name="QQ" value="${QQ }" class="input0"></td>      	
      </tr> 	    	  
	
		      
    </table>

	                      </td>
	                    </tr>
						<tr> 
	                      <td height="30">&nbsp;</td>
	                    </tr>
	                  </table>
	                </td>
	              </tr>
	            </table>
	          </td>
	        </tr>
	        <tr>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
	      
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="97%" align="center"><input type="submit" value="确定" src="${pageContext.request.contextPath}/jsp/images/queren.gif" width="49" height="20" border="0">		<input type="reset" value="取消">　<a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/jsp/images/cancel.gif" width="69" height="20" border="0"></a></td>
	        </tr>
	      </table>
	    </td>
	    <td background="../images/main_03.gif" width="5"><img src="/jsp/images/main_03.gif" width="5" height="1"></td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td width="4" height="4"><img src="/jsp/images/main_06.gif" width="4" height="4"></td>
	    <td background="/jsp/images/main_05.gif" height="4"><img src="/jsp/images/main_05.gif" width="1" height="4"></td>
	    <td width="5" height="4"><img src="/jsp/images/main_04.gif" width="5" height="4"></td>
	  </tr>
	</table>
	


</s:form>

<p>&nbsp;</p>
</body>
</html>

















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



















