<%@page contentType="text/html;charset=utf-8" %> 
<%@page import = "java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>user management</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style2.css" type="text/css">
<script language="javascript">
<!--
var where = new Array(35); 

function comefrom(loca,locacity) { 
this.loca = loca; 
this.locacity = locacity; 
} 
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
with(document.UpdateForm.province) { var loca2 = options[selectedIndex].value; }
for(i = 0;i < where.length;i ++) {
if (where[i].loca == loca2) {
loca3 = (where[i].locacity).split("|");
for(j = 0;j < loca3.length;j++) { with(document.UpdateForm.city) { length = loca3.length; options[j].text = loca3[j]; options[j].value = loca3[j]; var loca4=options[selectedIndex].value;}}
break;
}}
//document.UpdateForm.newlocation.value=loca2+loca4;
}
function init() {

var strprovince=UpdateForm.province1.value; 
var strcity=UpdateForm.city1.value;
where[0]= new comefrom(strprovince+" ",strcity+" ");


with(document.UpdateForm.province) {
length = where.length;
for(k=0;k<where.length;k++) { options[k].text = where[k].loca; options[k].value = where[k].loca; }
options[selectedIndex].text = where[0].loca; options[selectedIndex].value = where[0].loca;
}
with(document.UpdateForm.city) {
loca3 = (where[0].locacity).split("|");
length = loca3.length;
for(l=0;l<length;l++) { options[l].text = loca3[l]; options[l].value = loca3[l]; }
options[selectedIndex].text = loca3[0]; options[selectedIndex].value = loca3[0];
}}
-->
</script>
</head>

<script language="javascript" src="${pageContext.request.contextPath}/include/IdCard-Validate.js"></script>
<script language="javascript">
function UpdateForm_onclick() {

	if (UpdateForm.name_Login.value=="")
	{
		alert("用户真实姓名不能为空！");
		UpdateForm.name_Login.focus();
		return false;
	}
	
	if (UpdateForm.sex.value=="")
	{
		alert("用户性别不能为空！");
		UpdateForm.sex.focus();
		return false;
	}	
	
	if (UpdateForm.city.value=="")
	{
		alert("用户所属城市不能为空！");
		UpdateForm.city.focus();
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

	if(!IdCardValidate(UpdateForm.idcard.value))
	{
		alert("请检查用户身份证号！");
		UpdateForm.idcard.focus();
		return false;
	}
	
	if (UpdateForm.role.value=="")
	{
		alert("用户角色不能为空！");
		UpdateForm.role.focus();
		return false;
	}	

	return true;
}
</script>
<body bgcolor="#FFFFFF" text="#000000">
<Table border=0 width=100% cellpadding="0" cellspacing="0">
        <tr> 
          
    <td width="99%" class="text">
    
    <b>::&nbsp;&nbsp;用户管理--查看（${name_real }）用户信息&nbsp;&nbsp;::</b><br>
            <hr width="100%" size="1" noshade>
          </td>
        </tr>
</Table>

<s:form name="UpdateForm" method="post" action="userAction_edit.action" onsubmit="return UpdateForm_onclick();">

<input type="hidden" name="MyAction" value="Update" />
<input type="hidden" name="username" value="" />
<input type="hidden" name="province1" value="${province}" />
<input type="hidden" name="city1" value="${city}" />
<s:hidden name="userID"></s:hidden>
<s:hidden name="name_Login"></s:hidden>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" height="250" valign="top"> 
	      	    <FIELDSET style="WIDTH: 90%; HEIGHT: 200px" align=center bgcolor="#FFFFFF">
      <LEGEND align=left><B>${name_real }(${name_Login })：用户信息</B> </LEGEND>
      
      
	            <table width="100%" border="0" cellspacing="1" cellpadding="0">
	              <tr>
	                <td align="center"> 
	                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
	                    <tr> 
	                    
	                    </tr>
	                    <tr> 
	                      <td > 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">     
     
      <tr>
       <td width="15%" align="left" height="30">用户真实名：</td>
        <td width="45%" align="left"> <s:textfield  name="name_real"  id="cnname"  cssClass="input0" readonly="true" />  
        <font color=red>*</font></td>
         <td width="15%" align="left">性&nbsp;&nbsp;别：&nbsp;&nbsp;</td>
        <td width="25%" align="left">
         <s:select list="{'男','女'}"  name="sex" cssStyle='width:132' cssClass="input0"
				          headerKey="" headerValue="请选择" disabled="true">
				     </s:select>
         <font color=red>*</font></td>
      </tr>

     <body onload="init()">
      <tr>
        <td width="15%" align="left" height="30">用户所属省：</td>
        <td width="45%" align="left"><select name="province"  onChange="select()" style="width:132" disabled="disabled">
        								</select>
						<font color=red>*</font></td>
      	<td width="15%" align="left">用户所属市：</td>
        <td width="25%" align="left"><select name="city" width="61%" onChange= "select()" style="width:132" disabled="disabled" ></select> <font color=red>*</font></td>
      </tr>
      
       <tr>
        <td width="15%" align="left" height="30">详细通讯地址：</td>
        <td width="45%" align="left"><s:textfield  name="department" cssClass="input0" readonly="true" />   <font color=red>*</font></td>
        <td width="15%" align="left">邮政编码：&nbsp;&nbsp;</td>
        <td width="25%" align="left"><s:textfield  name="postalcode" cssClass="input0" readonly="true"/>   <font color=red>*</font></td>
      </tr>	
      
      <tr>
        <td width="15%" align="left" height="30">身份证号：</td>
        <td width="45%" align="left"><s:textfield name="idcard" cssClass="input0" readonly="true"></s:textfield> <font color=red>*</font></td>
        <td width="15%" align="left">角&nbsp;&nbsp;色：&nbsp;&nbsp;</td>
        <td width="25%" align="left">
		
		<s:select cssClass="input0" cssStyle="width:132" name="role"  list="{'记者','通讯员','统计员','管理员'}" 
						headerKey="" headerValue="" disabled="true">
						</s:select>
		<font color=red>*</font></td>
      </tr>   
      
      <tr>
        <td width="15%" align="left" height="30">办公电话：</td>
        <td width="45%" align="left"><s:textfield name="phone" cssStyle="input0" readonly=""></s:textfield></td>
        <td width="15%" align="left">职&nbsp;&nbsp;务：&nbsp;&nbsp;</td>
        <td width="25%" align="left"><s:textfield name="principalship" cssStyle="input0" readonly=""></s:textfield></td>
      </tr>   
      
       <tr>
        <td width="15%" align="left" height="30">家庭电话：</td>
        <td width="45%" align="left"><s:textfield name="homePhone" cssStyle="input0" readonly=""/></td>
        <td width="15%" align="left">传&nbsp;&nbsp;真：&nbsp;&nbsp;</td>
        <td width="25%" align="left"><s:textfield name="fax" cssStyle="input0" readonly=""/></td>      
      </tr>     
      
      <tr>
        <td width="15%" align="left" height="30">电子邮件：</td>
        <td width="45%" align="left"><s:textfield name="email" cssStyle="input0" size="40" readonly=""/></td>
        <td width="15%" align="left">手&nbsp;&nbsp;机：&nbsp;&nbsp;</td>
        <td width="25%" align="left"><s:textfield name="mobilePhone" cssStyle="input0" readonly=""/></td>     	
      </tr> 	  
      
      <tr>
        <td width="15%" align="left">&nbsp;&nbsp;</td>
        <td width="45%" align="left"><input type="hidden" name="space" value="" class="input0"></td>
        <td width="15%" align="left">&nbsp;&nbsp;</td>
        <td width="25%" align="left"><input type="hidden" name="space1" value="" class="input0"></td>     	
      </tr> 
      <tr>
        <td align="left" height="30">用户密码：</td>
        <td>
          <s:password name="password" cssStyle="input0" readonly=""/> 如不填，则不更改用户密码        </td>
        <td align="left">基层单位：</td>
        <td > <s:select list="#workcompanys" name="workcompany" disabled="true"></s:select>
      
        </td>       
      </tr>   
	  
       <tr>
       
        <td width="15%" align="left" height="30">MSN账号：</td>
        <td width="45%" align="left"> <s:textfield name="MSN" cssStyle="input0" size="40" readonly=""/></td>
        <td width="15%" align="left">QQ号码：</td>
        <td width="25%" align="left"> <s:textfield name="QQ" cssStyle="input0" readonly=""/></td>     	
      </tr>    		          
    </table>

	                      </td>
	                    </tr>
		                  </table>
	                </td>
	              </tr>
	            </table>
<br><br>
	      
</FIELDSET>
	    </td>

	  </tr>
	</table>

	<br><br>
	      <table width="90%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	        </tr>
	      </table>

</s:form>

<p>&nbsp;</p>
</body>
</html>
