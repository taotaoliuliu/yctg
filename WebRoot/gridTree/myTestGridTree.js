var myTree= new GridTree();
	
/**
 * ��Ҫ�Ĳ��Է���
 */
function test()
{                  
	/*var content = {columnModel:[
                                {header:'��������',headerIndex:'mdesc'},
                                {header:'��������',headerIndex:'mtypeParent'},
                                {header:'���Ե�ѡ',headerIndex:'minorout',width:'100px',
                                        columntype:{inputtype:'checkbox',style:'testmulti',
                                        	values:['1','2'],texts:['����','֧��']}}
                               ],
                      	dataUrl : 'http://localhost:3333/KeepMoney/tableTree.do?method=testGetListStr',
                        idColumn:'mtype',//id���ڵ���,һ��������(��һ��Ҫ��ʾ����)
                        parentColumn:'mtypeParent', //������id
                        hidddenProperties:['mdesc','mtypeParent'],
                        width:'800px',
                        height:'1px',                                
                        rowCount:true,//�Ƿ��Զ���������                       
                        checkOption:2,//1:���ֵ�ѡ��ť,2:���ֶ�ѡ��ť,����:������ѡ��ť
                        allCheck:true,//����Ƕ�ѡ,����ѡ���Ƿ����ȫ��ѡ��İ�ť
                        pageBar:true,    
                        handler:[{'onclick':function(obj){alert(obj.getAttribute('mdesc'));}}],
                        styleOption:2,
                        disabeld:true,//Ϊtrue�ͱ�ʾ����е��ı���,��ѡ���Ϊ���ɱ༭״̬
                        disableOptionColumn:'rddisbled',//������ʶָ����ѡ����Ƿ���õ�����,Ĭ��û��
                        multiChooseMode:3,
                        pageAtServer:false,//��ʾ��̨��ҳ
                        expandAll:false,//չ��ȫ��
                        tableId:'testTable',//�������id
                        el:'newtableTree'//Ҫ������Ⱦ��div id
           };*/
    var GridColumnType = [
                                {
					header : '��������',
					headerIndex : 'disId',
					columntype : {
						inputtype : 'html',
						htmlStr : '<button onclick="alert(\'$\');">$</button>',
						nameId : 'textbox'
					}
				}, {
					header : '��������',
					headerIndex : 'disName',
					columntype : {
						inputtype : 'html',
						htmlStr : '<button onclick="alert(\'$\');">$</button>',
						nameId : 'textbox'
					}
				}, {
					header : '���������˵�',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'select',
						style : 'testselect',
						values : ['1', '2'],
						texts : ['��', 'Ů'],
						nameId : 'se3xRd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'
					}
				}, {
					header : '���Զ�ѡ',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'checkbox',
						style : 'testmulti',
						values : ['1', '2'],
						texts : ['��', 'Ů'],
						nameId : 'sex2Rd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'
						,onclick:function(){alert('����˶�ѡ��ť��');}
					}
				}, {
					header : '�����ı���',
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
					header : '���Ե�ѡ',
					headerIndex : 'rd',
					width : '60px',
					columntype : {
						inputtype : 'radiobox',
						style : 'testradio',
						values : ['1', '2'],
						texts : ['��', 'Ů'],
						nameId : 'se4xRd',
						disabledIndex : 'rddisbled',
						visibledIndex : 'rdvisabled'	
						,onclick:function(){alert('��ѡ���˵���');}
					}
				}];
	var content = {columnModel:GridColumnType,        
                        hidddenProperties:['disId','disName'],
                        data:[
            				{"disId":"2200","disName":"����ʡ","disParent":"",rddisbled:1,rdvisabled:0,rd:"2",radi:"1",multi:"1,2"},
                            {"disId":"2201","disName":"������","disParent":"2200",rddisbled:0,rdvisabled:0,rd:"2",radi:"1",multi:"1,3"},
                            {"disId":"2202","disName":"������","disParent":"2200",rddisbled:0,rdvisabled:0,rd:"2",radi:"1",multi:"1"},
                            {"disId":"2203","disName":"��ƽ��","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"2",radi:"1",multi:"1"},
                            {"disId":"2204","disName":"��Դ��","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2205","disName":"ͨ����","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2206","disName":"��ɽ��","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2207","disName":"��ԭ��","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2208","disName":"�׳���","disParent":"2200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2300","disName":"������ʡ","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2301","disName":"��������","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2302","disName":"���������","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2303","disName":"������","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2304","disName":"�׸���","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2305","disName":"˫Ѽɽ��","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2306","disName":"������","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2307","disName":"������","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2308","disName":"��ľ˹��","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2309","disName":"��̨����","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2310","disName":"ĵ������","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                             {"disId":"2311","disName":"�ں���","disParent":"2300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"2312","disName":"�绯��","disParent":"2300",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3100","disName":"�Ϻ���","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3200","disName":"����ʡ","disParent":"",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3201","disName":"�Ͼ���","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3202","disName":"������","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3203","disName":"������","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3204","disName":"������","disParent":"3200",rddisbled:0,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3205","disName":"������","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3206","disName":"��ͨ��","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3207","disName":"���Ƹ���","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3208","disName":"������","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3209","disName":"�γ���","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3210","disName":"������","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3211","disName":"����","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3212","disName":"̩����","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3213","disName":"��Ǩ��","disParent":"3200",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3300","disName":"�㽭ʡ","disParent":"",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3301","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3302","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3303","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3304","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3305","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3306","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3307","disName":"����","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3308","disName":"������","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3309","disName":"��ɽ��","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3310","disName":"̨����","disParent":"3300",rddisbled:1,rdvisabled:1,rd:"1",radi:"2",multi:"1"},
                            {"disId":"3311","disName":"��ˮ��","disParent":"3300",rddisbled:0,rdvisabled:1,rd:"2",radi:"1",multi:"1"}],
                        idColumn:'disId',//id���ڵ���,һ��������(��һ��Ҫ��ʾ����)
                        parentColumn:'disParent', //������id
                        rowCountOption:3,
                        height:'100px',     
                        rowCount:true,//�Ƿ��Զ���������                       
                        checkOption:2,//1:���ֵ�ѡ��ť,2:���ֶ�ѡ��ť,����:������ѡ��ť
                        allCheck:true,//����Ƕ�ѡ,����ѡ���Ƿ����ȫ��ѡ��İ�ť
                        debug:true,
                        pageBar:true,    
                        styleOption:1,
                        pageSize:3,
                        //disabeld:true,//Ϊtrue�ͱ�ʾ����е��ı���,��ѡ���Ϊ���ɱ༭״̬
                        disableOptionColumn:'rddisbled',//������ʶָ����ѡ����Ƿ���õ�����,Ĭ��û��
                        chooesdOptionColumn:'rddisbled',//������ʶĬ�ϵľ�ѡ���ѡ�������,���ж�ѡ��ѡ��ť�����ʱ������.
                        multiChooseMode:3,
                        //expandAll:true,//չ��ȫ��
                      	tableId:'testTable',//�������id
                        el:'newtableTree'//Ҫ������Ⱦ��div id
           };
	myTree.loadData(content);
	myTree.makeTable();
	
	//չ��ȫ���ڵ�
	_$('bt3').onclick=function(){myTree.expandAll();};
	//չ����һ��ڵ�
	_$('bt4').onclick=function(){myTree.closeAll();};
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