var myTree= new GridTree();
	
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
					width:'10%'
				}, {
					header : '名称',
					headerIndex : 'disname',
					width:'100px'
				}, {
					header : '上级标示',
					headerIndex : 'disparentId',
					width:'100px'
				}];
	var content = {columnModel:GridColumnType,        
                        dataUrl:appPath+"initlazy.do",
                        lazyLoadUrl:appPath+"lazyPaging.do",
                        idColumn:'disid',//id所在的列,一般是主键(不一定要显示出来)
                        parentColumn:'disparentId', //父亲列id
                        pageSize:5,
                        pageBar:true,
                        debug:true, 
                        analyzeAtServer:true,//设置了dataUrl属性的时候，如果此属性是false表示分析树形结构在前台进行，默认是后台分析（仅支持java）,体现在json格式不用！
                        multiChooseMode:5,//选择模式，共有1，2，3，4，5种。
                      	tableId:'testTable',//表格树的id
                      	checkOption:2,//1:出现单选按钮,2:出现多选按钮,其他:不出现选择按钮
                      	rowCount:true,
                      	onLazyLoadSuccess:function(gt){   
                      		//alert('懒加载执行完了..');
                      	},
                      	onSuccess:function(gt){   
                      		//alert('初次加载表格树执行完了..');
                      	},
                      	onPagingSuccess:function(gt){   
                      		//alert('翻页执行完了..');
                      	},
                      	lazy:true,//使用懒加载模式（此时打开全部，关闭全部功能不可使用）
                      	leafColumn:'isLeaf',//用于判断节点是不是树叶 
                        el:'newtableTree' //要进行渲染的div id 
                        //下面是新加的用于懒加载分页的两个属性
                          ,lazyPageSize:5  
						   ,lazyPage : true
						 
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

/**
 * 演示动态添加
 */
function dynamicAdd(){ 
	var childNodes = '[{"disid":"5330","disparentId":"53","disname":"大理白族自治州","isLeaf":"1"},' +
			'{"disid":"5301","disparentId":"53","disname":"云南","isLeaf":"1"}]';
	myTree.appendChild('53',childNodes); 
}

/**
 * 测试重新加载表格树
 */
function reloadgridtree()
{
	myTree.reload();
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