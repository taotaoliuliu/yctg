<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:include page="/gridTree/commonHead.jsp"></jsp:include>
<html>
	<head> 
	<script language="javascript" src="myTestGridTreeForJava.js"></script> 
	</head>

	<BODY onload='test();'>
		<div id='newtableTree'
			style='width: 100%; height: 345px; border: 1px solid #000099; overflow-x: visible; overflow-y: scroll;'>
			正在装载，请等待。。。
		</div>
		<button onclick='showHtml();' id='bt1' title='查看表格树的实际源码'>
			显示表格html
		</button> 
		<button onclick='showChoosed();' id='bt2' title='查看表格树中选中的节点id'>
			测试选择
		</button>
		<button id='bt3' title='展开表格树全部节点'>
			展开全部
		</button>
		<button id='bt4' title='只显示第一层表格树节点'>
			收缩全部
		</button>
		<button onclick='alert("可以实现，演示代码未实现。");' id='bt5'
			title='将表格树放在form表单中提交数据'>
			提交
		</button>
		<button onclick='setGridTreeDisabled(true)' id='bt6'
			title='表格树disabled'>
			禁用表格树
		</button>
		<button onclick='setGridTreeDisabled(false)' id='bt7'
			title='取消表格树disabled'>
			启用表格树
		</button>
		<br>
		<jsp:include page="/gridTree/common.jsp"></jsp:include>
		<div id='ans'>
		</div>
	</BODY>
</html>
