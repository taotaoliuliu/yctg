var myTree= new GridTree();
	
	alert(appPath+"common.do")
/**
 * ��Ҫ�Ĳ��Է���
 */
function test()
{                  
	 var GridColumnType = [
                  {
					header : '��ʾ��',
					headerIndex : 'disid',
					//��������Ŀ��ʹ�ðٷֱ�,Ч���Ϻ�.
					width:'10%',
					columntype : {
						inputtype : 'html',
						htmlStr : '<font color="red">$</font>',
						nameId : 'textbox'
					}
				}, {
					header : '����',
					headerIndex : 'disname',
					width:'100px',
					columntype : {
						inputtype : 'html',
						htmlStr : '<font color="red">$</font>',
						nameId : 'textbox'
					}
				},{
					header : '����',
					headerIndex : 'disparentId',
					columntype : {
						inputtype : 'html',
						htmlStr : '<a href="http://www.baidu.com">$</button>',
						nameId : 'textbox'
					},
					width:'100px'
				}, {
					header : '�ϼ���ʾ',
					headerIndex : 'disparentId',
					width:'100px'
				}];
	var content = {columnModel:GridColumnType,        
                        dataUrl:appPath+"common.do",
                        idColumn:'disid',//id���ڵ���,һ��������(��һ��Ҫ��ʾ����)
                        parentColumn:'disparentId', //������id
                        handleCheck:function(){alert('�����ѡ��ť!')},
                        pageSize:3,
                        debug:true,
                        disabled:false,
                        pageBar:true,
                        analyzeAtServer:true,//������dataUrl���Ե�ʱ�������������false��ʾ�������νṹ��ǰ̨���У�Ĭ���Ǻ�̨��������֧��java��,������json��ʽ���ã�
                        checkOption:2,//1:���ֵ�ѡ��ť,2:���ֶ�ѡ��ť,����:������ѡ��ť
                        multiChooseMode:5,//ѡ��ģʽ������1��2��3��4��5�֡�
                      	tableId:'testTable',//�������id
                      	expandAll:true,//չ��ȫ��
                      	rowCount:true,
                      	onSuccess:function(gt){},
                        el:'newtableTree'//Ҫ������Ⱦ��div id
           };
	myTree.loadData(content);
	myTree.makeTable(); 
	//չ��ȫ���ڵ�
	//_$('bt3').onclick=function(){myTree.expandAll();};
	//չ����һ��ڵ�
	//_$('bt4').onclick=function(){myTree.closeAll();};
}

/**
 * ˫���¼�,˫��һ�е��ø÷���.
 * @param {�ж���} obj
 */
function doubleClickOnRow(obj)
{
	debugObjectInfo(obj);
}

/**
 * �����鿴һ�����������
 */
function debugObjectInfo(obj){
	traceObject(obj);
	
	function traceObject(obj){ 
		var str = '';
		if(obj.tagName&&obj.name&&obj.id)
		str="<table border='1' width='100%'><tr><td colspan='2' bgcolor='#ffff99'>traceObject ����tag: &lt;"+obj.tagName+"&gt;���� name = \""+obj.name+"\" ����id = \""+obj.id+"\" </td></tr>"; 
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
		alert('û��ѡ��');
}

function openAll()
{
	myTree.expandAll();
}

function closeAll()
{
	myTree.closeAll();
}