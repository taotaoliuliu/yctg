<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:include page="/gridTree/commonHead.jsp"></jsp:include> 
<html>
	<head>
		<script language="javascript" src="myTestGridTree.js"></script>  
	</head>

	<BODY onload='test();'>
		<div id='newtableTree'
			style='width: 100%; height: 345px; border: 1px solid #000099; overflow-x: visible; overflow-y: scroll;'>
			����װ�أ���ȴ�������
		</div>
		<button onclick='showHtml();' id='bt1' title='�鿴��������ʵ��Դ��'>
			��ʾ����html
		</button>
		<button onclick='showChoosed();' id='bt2' title='�鿴��������ѡ�еĽڵ�id'>
			����ѡ��
		</button>
		<button id='bt3' title='չ��������ȫ���ڵ�'>
			չ��ȫ��
		</button>
		<button id='bt4' title='ֻ��ʾ��һ��������ڵ�'>
			����ȫ��
		</button>
		<button onclick='alert("����ʵ�֣���ʾ����δʵ�֡�");' id='bt5'
			title='������������form�������ύ����'>
			�ύ
		</button>
		<button onclick='setGridTreeDisabled(true)' id='bt6'
			title='������disabled'>
			���ñ�����
		</button>
		<button onclick='setGridTreeDisabled(false)' id='bt7'
			title='ȡ��������disabled'>
			���ñ�����
		</button>
		<br>
		<jsp:include page="/gridTree/common.jsp"></jsp:include>
		<div id='ans'>
		</div>
	</BODY>
</html>