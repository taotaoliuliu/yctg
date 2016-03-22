var myTree= new GridTree();
	
/**
 * 主要的测试方法
 */
function test()
{                  
	/*var content = {columnModel:[
                                {header:'地域名称',headerIndex:'mdesc'},
                                {header:'地域名称',headerIndex:'mtypeParent'},
                                {header:'测试单选',headerIndex:'minorout',width:'100px',
                                        columntype:{inputtype:'checkbox',style:'testmulti',
                                        	values:['1','2'],texts:['收入','支出']}}
                               ],
                      	dataUrl : 'http://localhost:3333/KeepMoney/tableTree.do?method=testGetListStr',
                        idColumn:'mtype',//id所在的列,一般是主键(不一定要显示出来)
                        parentColumn:'mtypeParent', //父亲列id
                        hidddenProperties:['mdesc','mtypeParent'],
                        width:'800px',
                        height:'1px',                                
                        rowCount:true,//是否自动计算行数                       
                        checkOption:2,//1:出现单选按钮,2:出现多选按钮,其他:不出现选择按钮
                        allCheck:true,//如果是多选,可以选择是否出现全部选择的按钮
                        pageBar:true,    
                        handler:[{'onclick':function(obj){alert(obj.getAttribute('mdesc'));}}],
                        styleOption:2,
                        disabeld:true,//为true就表示表格中的文本域,多选框等为不可编辑状态
                        disableOptionColumn:'rddisbled',//用来标识指定的选择框是否禁用的属性,默认没有
                        multiChooseMode:3,
                        pageAtServer:false,//表示后台分页
                        expandAll:false,//展开全部
                        tableId:'testTable',//表格树的id
                        el:'newtableTree'//要进行渲染的div id
           };*/
    var GridColumnType = [
                                {
					header : '地域名称',
					headerIndex : 'disId',
					columntype : {
						inputtype : 'html',
						htmlStr : '<button onclick="alert(\'$\');">$</button>',
						nameId : 'textbox'
					}
				}, {
					header : '地域名称',
					headerIndex : 'disName',
					columntype : {
						inputtype : 'html',
						htmlStr : '<button onclick="alert(\'$\');">$</button>',
						nameId : 'textbox'
					}
				}, {
					header : '测试下拉菜单',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'select',
						style : 'testselect',
						values : ['1', '2'],
						texts : ['男', '女'],
						nameId : 'se3xRd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'
					}
				}, {
					header : '测试多选',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'checkbox',
						style : 'testmulti',
						values : ['1', '2'],
						texts : ['男', '女'],
						nameId : 'sex2Rd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'
						,onclick:function(){alert('点击了多选按钮！');}
					}
				}, {
					header : '测试文本框',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'textbox',
						style : 'testselect',
						nameId : 'sex1Rd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'						
					}
				}, {
					header : '测试单选',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'radiobox',
						style : 'testradio',
						values : ['1', '2'],
						texts : ['男', '女'],
						nameId : 'se4xRd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'	
						,onclick:function(){alert('你选择了单击');}
					}
				}];
	var content = {columnModel:GridColumnType,        
                        hidddenProperties:['disId','disName'],
                        data:[
            				{"disId":"2200","disName":"吉林省","disParent":"",rddisbled:1,rdvisabled:0,rd:"2",radi:"1",multi:"1,2"},
                            {"disId":"2201","disName":"长春市","disParent":"2200",rddisbled:0,rdvisabled:0,rd:"2",radi:"1",multi:"1,3"},
                            {"disId":"2202","disName":"吉林市","disParent":"2200",rddisbled:0,rdvisabled:0,rd:"2",radi:"1",multi:"1"},
                            {"disId":"2203","disName":"四平市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"2",radi:"1",multi:"1"},
                            {"disId":"2204","disName":"辽源市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2205","disName":"通化市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2206","disName":"白山市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2207","disName":"松原市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2208","disName":"白城市","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2300","disName":"黑龙江省","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2301","disName":"哈尔滨市","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2302","disName":"齐齐哈尔市","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2303","disName":"鸡西市","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2304","disName":"鹤岗市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2305","disName":"双鸭山市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2306","disName":"大庆市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2307","disName":"伊春市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2308","disName":"佳木斯市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2309","disName":"七台河市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2310","disName":"牡丹江市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                             {"disId":"2311","disName":"黑河市","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2312","disName":"绥化市","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3100","disName":"上海市","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3200","disName":"江苏省","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3201","disName":"南京市","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3202","disName":"无锡市","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3203","disName":"徐州市","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3204","disName":"常州市","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3205","disName":"苏州市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3206","disName":"南通市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3207","disName":"连云港市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3208","disName":"淮安市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3209","disName":"盐城市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3210","disName":"扬州市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3211","disName":"镇江市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3212","disName":"泰州市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3213","disName":"宿迁市","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3300","disName":"浙江省","disParent":"",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3301","disName":"杭州市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3302","disName":"宁波市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3303","disName":"温州市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3304","disName":"嘉兴市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3305","disName":"湖州市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3306","disName":"绍兴市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3307","disName":"金华市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3308","disName":"衢州市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3309","disName":"舟山市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3310","disName":"台州市","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3311","disName":"丽水市","disParent":"3300",rddisbled:0,rdvisabled:1,rd:"2",radi:"1",multi:"1"}],
                        idColumn:'disId',//id所在的列,一般是主键(不一定要显示出来)
                        parentColumn:'disParent', //父亲列id
                        rowCountOption:3,
                        height:'100px',     
                        rowCount:true,//是否自动计算行数                       
                        checkOption:2,//1:出现单选按钮,2:出现多选按钮,其他:不出现选择按钮
                        allCheck:true,//如果是多选,可以选择是否出现全部选择的按钮
                        debug:true,
                        pageBar:true,    
                        styleOption:1,
                        pageSize:3,
                        //disabeld:true,//为true就表示表格中的文本域,多选框等为不可编辑状态
                        disableOptionColumn:'rddisbled',//用来标识指定的选择框是否禁用的属性,默认没有
                        chooesdOptionColumn:'rddisbled',//用来标识默认的就选择多选框的属性,在有多选的选按钮的情况时候有用.
                        multiChooseMode:3,
                        //expandAll:true,//展开全部
                      	tableId:'testTable',//表格树的id
                        el:'newtableTree'//要进行渲染的div id
           };
	myTree.loadData(content);
	myTree.makeTable();
	
	//展开全部节点
	_$('bt3').onclick=function(){myTree.expandAll();};
	//展开第一层节点
	_$('bt4').onclick=function(){myTree.closeAll();};
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