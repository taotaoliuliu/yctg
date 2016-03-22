var myTree= new GridTree();
	
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
					width:'10%'
				}, {
					header : '����',
					headerIndex : 'disname',
					width:'100px'
				}, {
					header : '�ϼ���ʾ',
					headerIndex : 'disparentId',
					width:'100px'
				}];
	var content = {columnModel:GridColumnType,        
                        dataUrl:appPath+"initlazy.do",
                        lazyLoadUrl:appPath+"lazyPaging.do",
                        idColumn:'disid',//id���ڵ���,һ��������(��һ��Ҫ��ʾ����)
                        parentColumn:'disparentId', //������id
                        pageSize:5,
                        pageBar:true,
                        debug:true, 
                        analyzeAtServer:true,//������dataUrl���Ե�ʱ�������������false��ʾ�������νṹ��ǰ̨���У�Ĭ���Ǻ�̨��������֧��java��,������json��ʽ���ã�
                        multiChooseMode:5,//ѡ��ģʽ������1��2��3��4��5�֡�
                      	tableId:'testTable',//�������id
                      	checkOption:2,//1:���ֵ�ѡ��ť,2:���ֶ�ѡ��ť,����:������ѡ��ť
                      	rowCount:true,
                      	onLazyLoadSuccess:function(gt){   
                      		//alert('������ִ������..');
                      	},
                      	onSuccess:function(gt){   
                      		//alert('���μ��ر����ִ������..');
                      	},
                      	onPagingSuccess:function(gt){   
                      		//alert('��ҳִ������..');
                      	},
                      	lazy:true,//ʹ��������ģʽ����ʱ��ȫ�����ر�ȫ�����ܲ���ʹ�ã�
                      	leafColumn:'isLeaf',//�����жϽڵ��ǲ�����Ҷ 
                        el:'newtableTree' //Ҫ������Ⱦ��div id 
                        //�������¼ӵ����������ط�ҳ����������
                          ,lazyPageSize:5  
						   ,lazyPage : true
						 
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

/**
 * ��ʾ��̬���
 */
function dynamicAdd(){ 
	var childNodes = '[{"disid":"5330","disparentId":"53","disname":"�������������","isLeaf":"1"},' +
			'{"disid":"5301","disparentId":"53","disname":"����","isLeaf":"1"}]';
	myTree.appendChild('53',childNodes); 
}

/**
 * �������¼��ر����
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