<%@page contentType="text/html;charset=utf-8" %> 

<%@ taglib prefix="s" uri="/struts-tags" %>

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
    </script>
    <script type="text/javascript">
    
       function openWin(srcFile,winWidth,winHeight)    
    {       
    
      //  var winFeatures = "scrollbars=yes,resizable=yes,status=no,width="+winWidth+",height="+winHeight+",left="+(event.screenX)+",top="+(20);
       // var obj = "";  //將物件传到新窗中         
		 window.open(srcFile);         
        
    }	
    function sercher()
    {
    document.forms[0].submit();
    
    }
    
    
    function changePasswd()
{
 window.open("userAction_changePassword.action");
	//changePassWin();
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
            <a class="section" href="textAction_textContribute.action">工作区</a>

            <div class="divider"></div>
          <!--   <a class="active section">{$breadcrumb}</a> -->
        </div>

        <!--选择框开始-->
        <div class="text container">
            <div class="ui segment">
                <form class="ui form" method="post" action="textAction_statPerson.action">

                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui inverted left icon input">
                                <input name="textTitle" placeholder="标题检索" type="text" value="${textTitle }">
                                <i class="search icon"></i>
                            </div>
                        </div>
                        <div class="two wide field">
                            <button class="ui blue button" type="button" onclick="sercher()">提交</button>
                        </div>
                    </div>
                </form>
            </div>
            <a href="textAction_textContribute.action" class="ui blue button" style="margin-bottom: 5px;">图文投稿</a>
            <a href="textAction_textContribute2.action" class="ui blue button" style="margin-bottom: 5px;">视频投稿</a>
            <a href="textAction_textContribute3.action" class="ui blue button" style="margin-bottom: 5px;">音频投稿</a>
            
             <a href="userAction_changePassword.action" class="ui blue button" target="_new">修改密码</a>
            <a href="userAction_pageEditUI.action" class="ui blue button">修改个人信息</a>
        </div>
        
        <form action="textAction_statPerson.action">


        <table class="ui selectable inverted table" style="margin-top:4px;">
            <thead>
            <tr>
                <th>日期</th>
                <th>体裁：标题</th>
                <th>使用媒体</th>
            </tr>
            </thead>
            <c:forEach items="${recordList }" var="vo">
            
                <tr>
                    <td>${vo.contributeDate}</td>
                    
                 
                    <td>${vo.rest1}：<a href="javascript:void(0)" onclick="openWin('textAction_showText.action?textID=${vo.textID}',650,500)">${vo.textTitle}</a></td>
                    <td>${vo.status}</td>
                </tr>
          </c:forEach>
        </table>
       <div id=PageSelectorBar>
	<div class="ui large label">

		页次：${currentPage}/${pageCount }页 &nbsp;
		每页显示：${pageSize }条 &nbsp;
		总记录数：${recordCount }条
	</div>
	<div id=PageSelectorSelectorArea>
			<div class="ui large label">
	
		<a href="javascript:gotoPage(1)" title="首页" style="cursor: hand;">
		
			首页
			
		</a>
		</div>
		<s:iterator begin="beginPageIndex" end="endPageIndex" var="num">
			<s:if test="#num == currentPage"><!-- 当前页 -->
				<span class="ui black button">${num}</span>
			</s:if>
			<s:else><!-- 非当前页 -->
				<div class="ui button" style="cursor: hand;" onClick="gotoPage(${num});">${num}</div>
			</s:else>
		</s:iterator>
					<div class="ui large label">
		
		<a href="javascript:gotoPage(${pageCount})" title="尾页" style="cursor: hand;">
			尾页
		</a>
		</div>
					<div class="ui large label">
		
	转到
	</div>
    <input class="input" type="text" id="pageNum2" name="pageNum2" value="${currentPage }" style="width: 40px;height: 30px;border-radius:5px;" /> 
    
    
    			<div class="ui large label">
    
     页 
     </div>
     
                                 <button onclick="go(${pageCount }, ${currentPage })" class="ui blue button" type="button">查询</button>
     
   
		
		
	</div>	
	
	</form>
</div>
        <h4 class="ui red horizontal header divider" style="margin-top: 2em;">使用媒体说明</h4>

        <div class="ui center aligned container">
            “待取”：稿件已经进入数据库，可供编辑查看。<br>
            “某媒体：待取”：稿件被某媒体关注。<br>
            “某媒体：见***”：稿件发布至某媒体。
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

<script type="text/javascript">
	function gotoPage( pageNum ){
		 //window.location.href = "topicAction_show.action?id=${topic.id}&pageNum=" + pageNum;
		
		$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
		document.forms[0].pageNum.value = pageNum;
		
		document.forms[0].submit(); // 提交表单
	}
	
	function go(totalPageNum, defaultValue) {
  		// 获得文本框输入的内容
  		var pageNumObj = document.getElementById("pageNum2");
  		var pageNum = pageNumObj.value;
  		if(pageNum==null || pageNum=="") {
  			alert("页数不能为空");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  		var num = parseInt(pageNum);	// NaN  not a number
  		if(isNaN(num)) {
  			alert("请输入一个数字");
  			pageNumObj.value = defaultValue;
  			return ;
  		}
  		if(num<1 || num>totalPageNum) {
  			alert("对不起！没有这一页");
  			pageNumObj.value = defaultValue;
  			return;
  		}
  	$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
  		
  		document.forms[0].submit();
	}
</script>

</html>
