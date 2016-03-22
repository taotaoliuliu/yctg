var myTree= new GridTree();
	
	alert(appPath+"common.do")
/**
 * 主要的测试方法
 */
function test()
{                  
	 var GridColumnType = [
                  {
					header : '标示列',
					headerIndex : 'disid',
					//建议下面的宽带使用百分比,效果较好.
					width:'10%',
					columntype : {
						inputtype : 'html',
						htmlStr : '<font color="red">$</font>',
						nameId : 'textbox'
					}
				}, {
					header : '名称',
					headerIndex : 'disname',
					width:'100px',
					columntype : {
						inputtype : 'html',
						htmlStr : '<font color="red">$</font>',
						nameId : 'textbox'
					}
				},{
					header : '连接',
					headerIndex : 'disparentId',
					columntype : {
						inputtype : 'html',
						htmlStr : '<a href="http://www.baidu.com">$</button>',
						nameId : 'textbox'
					},
					width:'100px'
				}, {
					header : '上级标示',
					headerIndex : 'disparentId',
					width:'100px'
				}];
	var content = {columnModel:GridColumnType,        
                        dataUrl:appPath+"common.do",
                        idColumn:'disid',//id所在的列,一般是主键(不一定要显示出来)
                        parentColumn:'disparentId', //父亲列id
                        handleCheck:function(){alert('点击了选择按钮!')},
                        pageSize:3,
                        debug:true,
                        disabled:false,
                        pageBar:true,
                        analyzeAtServer:true,//设置了dataUrl属性的时候，如果此属性是false表示分析树形结构在前台进行，默认是后台分析（仅支持java）,体现在json格式不用！
                        checkOption:2,//1:出现单选按钮,2:出现多选按钮,其他:不出现选择按钮
                        multiChooseMode:5,//选择模式，共有1，2，3，4，5种。
                      	tableId:'testTable',//表格树的id
                      	expandAll:true,//展开全部
                      	rowCount:true,
                      	onSuccess:function(gt){},
                        el:'newtableTree'//要进行渲染的div id
           };
	myTree.loadData(content);
	myTree.makeTable(); 
	//展开全部节点
	//_$('bt3').onclick=function(){myTree.expandAll();};
	//展开第一层节点
	//_$('bt4').onclick=function(){myTree.closeAll();};
}

/**
 * 双击事件,双击一行调用该方法.
 * @param {行对象} obj
 */
function doubleClickOnRow(obj)
{
	debugObjectInfo(obj);
}

/**
 * 用来查看一个对象的属性
 */
function debugObjectInfo(obj){
	traceObject(obj);
	
	function traceObject(obj){ 
		var str = '';
		if(obj.tagName&&obj.name&&obj.id)
		str="<table border='1' width='100%'><tr><td colspan='2' bgcolor='#ffff99'>traceObject 　　tag: &lt;"+obj.tagName+"&gt;　　 name = \""+obj.name+"\" 　　id = \""+obj.id+"\" </td></tr>"; 
		else{
			str="<table border='1' width='100%'>"; 
		}
		var key=[]; 
		for(var i in obj){ 
			key.push(i); 
		} 
		key.sort(); 
		for(var i=0;i<key.length;i++){ 
			var v= new String(obj[key[i]]).replace(/</g,"&lt;").replace(/>/g,"&gt;"); 
			if(typeof obj[key[i]]=='string'&&v!=null&&v!='')
				str+="<tr><td valign='top'>"+key[i]+"</td><td>"+v+"</td></tr>"; 
		} 
		str=str+"</table>"; 
		writeMsg(str); 
	} 
	function trace(v){ 
		var str="<table border='1' width='100%'><tr><td bgcolor='#ffff99'>"; 
		str+=String(v).replace(/</g,"&lt;").replace(/>/g,"&gt;"); 
		str+="</td></tr></table>"; 
		writeMsg(str); 
	} 
	function writeMsg(s){ 
		traceWin=window.open("","traceWindow","height=600, width=800,scrollbars=yes"); 
		traceWin.document.write(s); 
	} 
}

function showHtml()
{
	jQuery('#ans').text(jQuery('#newtableTree').html());
}

function setGridTreeDisabled(v){
	myTree.setDisabled(v);
}

function showChoosed()
{
	var ans = getAllCheckValue();
	if(ans!='')
		alert(ans);
	else
		alert('没有选择');
}

function openAll()
{
	myTree.expandAll();
}

function closeAll()
{
	myTree.closeAll();
}