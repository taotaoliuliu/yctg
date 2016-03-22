
jQuery.noConflict(); 
/**
 * ���캯�����涨��һЩ���õı�������ڲ�����.
 */
function GridTree() {

}

/**
 * ��ʼ��������������һЩ������ֵ.
 */
GridTree.prototype._initData = function() {
	parentToChildMap = new HashMap();
	nodeMap = new HashMap();
	firstLevelNodes = [];
	firstLevelParentIds = [];
	childToFatherMap = new HashMap();
	_idToNumMap = new HashMap();
	parents = [];
	_usHandler = [];
	_lastSelectRowId = "";
	//�������ͨ��ҳ����Ϣ����
	pagingInfo = {}; 
	//����������ط�ҳ����Ϣ������һ��map��
	_lazypgInfoMap = new HashMap();
	_usnoclick=0,_usnomsover=0,_usnomsout=0;
	if(document.all){
		isIE = true;
	}else{
		isIE = false;
	}
	//������¼�����ط�ҳʱ��div���ĸ������λ��.
	lazypagex= 0,lazypagey= 0,lazypagex2= 0,lazypagey2 = 0;
	//�����ط�ҳ������ģ���ַ���
	lzpagetabletemp=['<table cellspacing=0 cellpadding=0  class="lazyPageTable"><tr><td>',
			'<button class=" lazypagebarbtn firstPage" onclick="GridTree.prototype._toLazyPage(\'$\', \'first\')" id="_fstbtn_$" title="��һҳ"/></td>',
			'<td><button class=" lazypagebarbtn prevPage" onclick="GridTree.prototype._toLazyPage(\'$\',\'pre\')" title="ǰһҳ" id="_prebtn_$"/></td>',
			'<td><button class=" lazypagebarbtn nextPage" id="_nxtbtn_$"  onclick="GridTree.prototype._toLazyPage(\'$\',\'next\')" title="��һҳ"/></td>' ,
			'<td><button class=" lazypagebarbtn lastPage" onclick="GridTree.prototype._toLazyPage(\'$\',\'last\')"  id="_lstbtn_$" title="���һҳ"/></td>' ,
			'<td class="splitbar"><td  class="lazyPagingMsg" >�ܹ�<span id="_lazy_page_count_$" class="lazyPagingNum">',
			'</span>�� ��ǰ��ʾ��<span id="_lazy_page_currentpage_$"	class="lazyPagingNum"></span>ҳ</td></table>'].join('');
	//���������ص�ģ���ַ���
	lzmorepagetemp=['<table cellspacing=0 cellpadding=0  class="lazyPageTable"><tr>',
			'<td  class="lazyPagingMsg2" >��ǰ����ܹ�<span id="_lazy_page_count_$" class="lazyPagingNum">',
			'</span>�� ��ǰ��ʾ��<span class="lazyPagingNum">1</span> - <span id="_lazy_page_currentpage_$"	class="lazyPagingNum"></span>��</td></table>'].join('');	
	_errortemp = '��������ִ���,����ϸ���!<br><br>������Ϣ:<br><font color="red">$</font>';	
}


/**
 * ��ʼ�����
 */
GridTree.prototype.loadData = function(obj) {
	this._initData();
	tc = jQuery.extend({
			columnModel :{},//�е���Ⱦ��ʽ,����
			idColumn:null,//����ʾ�����ԡ�������
			parentColumn:null,//�����������ԡ�������
			tableId:null,//�����id���ԡ�������	
			el:null,//����Ⱦdiv��id�����Բ�����		
			exchangeColor:true,//��˫�н�����ʾ��ɫ
			closeImg : './images/minus.gif',//�����ڵ�Ĺر�ͼ��
			openImg : './images/plus.gif',//�����ڵ�Ĵ�ͼ��
			lazyLoadImg : './images/plus2.gif',//������ʱ��ʾ��ͼ��
			blankImg : './images/blank.gif',//�հ׽ڵ�
			noparentImg : './images/leaf.gif',//��Ҷ�ڵ��ͼ��
			morePageImg : './images/morePage.gif',//���η�ҳ��ͼ��  added on 20101212 
			pageBarId : 'pageBarTable',//Ĭ�ϵķ�ҳ���������idΪ'pageBarTable'
			pageSize : 10,//Ĭ�Ϸ�ҳ��ÿҳ��ʾ10�� 
			pageBar : false,//�Ƿ���з�ҳ
			lazyPage :false,//�����ض��ν��з�ҳ���� added on 20101212
			lazyMorePage :false,//���������ؼ�����ʾ��һҳҳ�������� added on 20110105
			lazyPageSize :10,//Ĭ�ϵ������ص�ÿҳ��ʾ10��  added on 20110102
			styleOption : '1',//��ѡΪ1,2,1��Ĭ�ϵ�ectable��ʽ,2Ϊext����ʽ
			rowCount : false,//�Ƿ�Ҫ�Զ���ʾ�к�
			countColumnDesc : '����',//��ʾ�кŵĻ�,������Ĭ��Ϊ'����'
			pageAtServer : true,//�Ƿ���ܺ�̨����
			analyzeAtServer : false,//������к�̨����,�Ƿ��ں�̨���з���.true��false�����json����ʽ��ͬ!
			checkColumnDesc : '��ѡ��',//Ĭ�ϵ�ѡ������Ϊ'��ѡ��'
			dataUrl:null,//��̨ȡ���ݵ������ַ				
			showMenu:true,//�Ƿ�����Ҽ��˵�(δʵ��)
			contextMenu:null,//�Ҽ��˵�Ҫ��ʾ������,(δʵ��)
			disabled:false,//Ĭ�ϱ���е�input���ǿ���״̬.
			debug:false,//�Ƿ���ֵ�����Ϣ
			height:'10px',//������ĸ߶�,���Զ���Ӧ��.
			width:'100%',//������Ŀ��
			checkOption : 'radio',//ѡ������ʽ,radio(��ѡ)����mult(��ѡ)
			hidddenProperties:null,//����������һ���е�����,�ʺϴ���ֵ��һ�ַ�ʽ.
			handleCheck:null,//�����ѡ��ť,��������ѡ��ť�ĵ����¼�,��һ��function
			data:null,//��̬��������,��һ�����鼴��
			lazy:false,//�Ƿ�������������ķ�ʽ
			lazyLoadUrl:null,//�����������ģʽ����Ҫ����һ���ַ�����ʾ��ѯ�ӽڵ�.
			handler:null,//���ñ������¼�,��һ����������,����['onclick':function(){},'onmouseover':function(){}]
			leafColumn:null,//��ʾ�Ƿ����ڵ������
			rowCountOption:1,//���Ҫ��������,ѡ������ķ�ʽ,��1,2,3��
			expandAll:false,//�Ƿ�Ĭ��չ��ȫ���Ľڵ�
			allCheck:true,//����Ƕ�ѡ�ı����,Ĭ�ϳ���ȫѡ��ť
			disableOptionColumn:null,//����һ�����Ա�ʾ���ݴ�����������ѡ��ť�Ƿ�Ĭ�Ͽ���,�������ַ���
			onSuccess:null,//���ûص�����,��������ʱִ��
			onPagingSuccess:null,//���÷�ҳ��ϵĻص�����
			onLazyLoadSuccess:null,//�������������ִ�еĻص�����
			chooesdOptionColumn:null,//����һ�����Ա�ʾ���ݴ�����������ѡ��ť�Ƿ�Ĭ��ѡ��,�������ַ���
			multiChooseMode:1//����Ƕ�ѡ����ʽ,����ѡ���ģʽ,��1,2,3,4,5��			
		  }, obj);
	elct = _$(tc.el);
	headColumns = [];
	_isValid = true;	
	_errorInfo = '';
	//����������ǵ���ģʽ.
	if(tc.debug){
		this._createDebugDiv();
	} 
	if (tc.lazy && tc.lazyPage && tc.lazyMorePage) {
		_errorInfo ='������ģʽ�²�����ͬʱ����[lazyPage=true]��[lazyMorePage=true]!';
		_isValid  = false;
		return false;
	}
	if(tc.pageBar==null||tc.pageBar==false){
		//��ʾ����ҳ
		tc.pageSize = -1;
	}
	
	//Ĭ�ϵ���ʽΪectable��ʽ
	if (tc.styleOption == null||(tc.styleOption+'')!='2') {
		_style = 2;
		importcss("GridTree2.css");
	}else{
		_style = tc.styleOption;
		importcss("GridTree.css");
	}	
	// ����ǿ���������еķ���������ǰ̨����,�����൱�ڷϳ������analyzeAtServer����!!
	// ��Ϊ�������֮���γɵ�json���򵥶���,���ڴ����д.
	tc.analyzeAtServer = false;
	//ֻҪ������dataUrl���Ծ�Ϊ��̨��ҳģʽ.��Ҫ������pageAtServer������...
	if(tc.dataUrl != null){		
		_serverPagingMode = 'analyzeAtPage';
		if(tc.lazy) {
			//�����������ģʽ,Ĭ�Ͼ�ʹ�ú�̨������ǰ̨���з���,������json�Ƚϼ�.
			tc.analyzeAtServer = false;
			//�����������ģʽ,ǿ��ʹ�õ�3��������кŵķ�ʽ,��ʡ��.
			tc.rowCountOption = '3';
			//����ǿ��ʹ�ü򵥵�ѡ��ģʽ.
			tc.multiChooseMode = 1;
			//�����������ģʽ,������ʹ��'չ��ȫ��'����
			tc.expandAll = false;
			if(!tc.lazyLoadUrl){
				_errorInfo = "������ģʽ,������������[lazyLoadUrl]!";
				_isValid  = false;
				return ;
			}
			if(!tc.leafColumn){
				_errorInfo = "������ģʽ,������������[leafColumn ]!";
				_isValid  = false;
				return ;
			}
		}
		//׼��һ����ʾ��Ϣ,�����ں�̨��ҳ��ʱ���õ�
		this._createMsgDiv();
	}else{
		_serverPagingMode = 'client';
	} 
}


/**
 * ����������ָ����div�γɱ����
 */
GridTree.prototype.makeTable = function() {
	if (!elct) {  
		this._wirteError('Ҫ��Ⱦdiv������!');
		return false;
	}
	if (!_isValid)	{ 
		this._wirteError(_errorInfo);
		return false;	
	}
	var tableTree = document.createElement("table");
	tableTree.style.height = tc.height;
	tableTree.style.width = tc.width;
	tableTree.id = '' + tc.tableId;
	tableTree.className = 'tableRegion';
	/** ********** ����json���ݷ�������,�õ����׽ڵ�ļ���,�Լ����׽ڵ�ͺ��ӽڵ��ӳ���ϵ. */
	if (tc.data != null) {
		GridTree.prototype._makeTable(tableTree, tc.data);
	} else {
		var param = {idColumn:tc.idColumn,analyze:tc.analyzeAtServer,
				parentColumn:tc.parentColumn,gtlimit:tc.pageSize,lazy:tc.lazy};			
		jQuery.ajax({
			type : "POST",
			url : tc.dataUrl,
			async : true,
			data:param,
			success : function(msg) {
				if (msg != null && msg != "") {
					try {
						if(!GridTree.prototype._verifyAjaxAns(msg)){
							_isValid = false;
							return;
						}
						GridTree.prototype._makeTable(tableTree,
								msg);
					} catch (e) {
						GridTree.prototype
								._makeTableWithNoData(tableTree);
					}
				} else {
					elct.innerHTML = "û������.";
				}
			}
		});		
	}
	// ��������˱����Ϊ������״̬,�Ͱѱ�����е�ȫ���ı����ȫ������Ϊ������.
	if (tc.disabeld) {
		this.setDisabled(true);
	}
}


/**
 * ��ʽ�Ŀ�ʼ�γɱ��������.
 * tree:����table��dom����
 * data:���������������
 */
GridTree.prototype._makeTable = function(tree,data)
 {
 	var o=new Date(); 	
 	this._analyseData(data);
	// ���з�ҳ��Ϣ�Ĵ���
	this._initPageInfo();
	// ��ӱ�������Ϣ
	this._addTitleHead(tree);
	
	/** ******** ����������,���濪ʼ�������װ�� *************** */
	// ��ʾȫ����Ϣ
	if (tc.pageBar != true) {
		if(tc.lazy)
			this._showLazyTable(tree, tc.allDataInfoWithPageInfo.data);
		else 
			this._showTable(tree, 0, firstLevelNodes.length);
	}
	// ��ҳ��ʾ
	else {
		// ����ж�ҳ���͵�һ��ֻ��ʾ��һҳ
		if(!tc.lazy){
			if (tc.pageSize > firstLevelNodes.length){
				this._showTable(tree, 0, firstLevelNodes.length);
			}
			// ����ֻ��һҳ����ʾȫ��
			else{
				this._showTable(tree, 0, tc.pageSize);
			}
		}else{
			this._showLazyTable(tree, tc.allDataInfoWithPageInfo.data);
		}
		/** ***** ��ӷ�ҳ�� *************** */
		this._makePageBar(tree, tree.rows.lenght);
	}
	
	elct.innerHTML = ''; 
	elct.appendChild(tree);
	// ���õ�˫����ɫ  modified in 20101212
	if(tc.exchangeColor)
		this._setColor(tree);
	var hasAdded = false;
	var isthere = 0;
	jQuery('#_changePageSizeSel option').each(function(i){
		if(this.value==tc.pageSize)		{
			hasAdded = true;
			return ;
		}else if(this.value<tc.pageSize){
			isthere = i;
		}
	});
	if(!hasAdded){
		if(isthere!=0)
			jQuery('#_changePageSizeSel option:eq('+isthere+')').after("<option value='"+tc.pageSize+"' selected='selected'>"+tc.pageSize+"</option>");
		else{
			jQuery('#_changePageSizeSel').prepend("<option value='"+tc.pageSize+"' selected='selected'>"+tc.pageSize+"</option>");
		}
	}
	/** ****** ���Ƿ�������չ��ȫ�� ********* */
	if (tc.expandAll) 	this.expandAll();
	// �������÷�ҳ��ť����ʽ
	this._resetBasePageBtns();
	//��������˵���ģʽ,���Կ������ĵ�ʱ��
	var gotime = new Date()-o;
	this._wirteDebug('��һ����ʾǰ̨����ʱ��:'+gotime);
	if(tc.pageSize)
		jQuery('#_changePageSizeSel option[value='+tc.pageSize+']').attr('selected','selected');
	// ��������˱����Ϊ������״̬,�Ͱѱ�����е�ȫ���ı����ȫ������Ϊ������.
	if(tc.disabled)  this.setDisabled(1);	
	if(tc.onSuccess)	tc.onSuccess(elct);
}


/**
 * ����ҳģʽ����ʾ��������.
 * @param {} tableTree ������
 * @param {} data ��������
 */
GridTree.prototype._showLazyTable = function(tableTree, data) {
	this._clearContent();	
	var datas = tc.allDataInfoWithPageInfo.data;
	var rowCount = 1;   
	for(var i=0,j=datas.length;i<j;i++){
		// �����ҵ�Ҫչʾ�ĵ�һ��ڵ�,��ӵ���񣨵�һ��ڵ㣩
		var oneObj = datas[i];
		if(typeof oneObj=='string'){
			eval("oneObj="+oneObj);			
		}		
		// �����ֱ��ʾΪ:������,���������,�����һ�е�json����,�������
		var newRow = this._addOneLazyRowByData(rowCount, oneObj, 1);  
		if(jQuery('tbody',tableTree).size()>0)
			jQuery(tableTree).children('tbody').append(newRow); 
		else
			jQuery(tableTree).append(newRow);  
		rowCount = rowCount + 1;
	}
}

/**
 * ����ҳģʽ�µ���ʾ�����
 * @param {} tableTree ������
 * @param {} startParentIndex ��ʼ�ĸ��׽ڵ���һ���е�λ��
 * @param {} endParentIndex ��ֹ�ĸ��׽ڵ��ڵ�һ���е�λ��
 */
GridTree.prototype._showTable = function(tableTree, startParentIndex, endParentIndex) {
	this._clearContent();		
	// �õ����������ĵ���ʼλ��,��Ϊ���ڱ����к������,������ʼλ����1
	var rowCount = 1;
	/** *** ������� ********* */
	var lenlen = firstLevelNodes.length;
	// ѭ�����ÿһ�е�����
	for (var ind = startParentIndex; ind < endParentIndex
			&& ind < lenlen; ind++) {
		// �����ҵ�Ҫչʾ�ĵ�һ��ڵ�,��ӵ���񣨵�һ��ڵ㣩
		var _parentId = firstLevelNodes[ind];
		var oneObj = nodeMap.get(_parentId);
		if(typeof oneObj=='string'){
			eval("oneObj="+oneObj);			
		}		
		// �����ֱ��ʾΪ:������,���������,�����һ�е�json����,�������
		this._addOneRowByData(tableTree, rowCount, oneObj, 1);
		// ����������1
		rowCount = rowCount + 1;
		// �����ֱ��ʾ:���׽ڵ�,�������ڵ��������
		addChildByParentNode(oneObj, 2);
	}
	/**
	 * ���һ�����ڵ�����к��ӵ������(����һ���ڲ�����,�������ڲ���!)
	 */
	function addChildByParentNode(parentNode, level) {
		var _id = parentNode[tc.idColumn];
		var _parent = parentNode[tc.parentColumn];
		var _isP = GridTree.prototype.isParent(parentNode);
		var _children = parentToChildMap.get('_node'+_id);
		// ��һ��ڵ���������ֹ����Ľڵ�,û�к��ӽڵ�
		if (_children != null) {
			for (var i = 0; i < _children.length; i++) {
				var oneObj ;
				oneObj = nodeMap.get(_children[i]);
				if(typeof oneObj=='string'){
					eval("oneObj="+oneObj);
				}
				GridTree.prototype._addOneRowByData(tableTree, rowCount,
						oneObj, level);
				rowCount = rowCount + 1;
				// ���������ӽڵ�ͬʱ���к���,�ͼ�����������
				if (GridTree.prototype.isParent(oneObj) == '1') {
					// ���ӵĺ��ӵ������������Ҫ��1!!
					addChildByParentNode(oneObj, level + 1);
				}
			}
		}
	}	
}

/**
 * ����¼���ָ����obj����
 * @param {dom����} obj
 * @param {�¼�����} funObj{"�¼���":�¼�����������}
 */
GridTree.prototype._addEventToObj = function(obj,funObj){
	if (isIE) {
		for (eventName in funObj) {
			var fun = funObj[eventName];
			obj.attachEvent(eventName, function() {
						fun(obj);
					});
		}
	} else {
		for (eventName in funObj) {
			var fun = funObj[eventName];
			var len  =eventName.length;
			var newfun = fun.bind(null,obj);
			obj.addEventListener(eventName.substring(2,len), newfun, false);
		}
	}
}

/**
 * ����ѡ����е�id 
 * @return {}
 */
GridTree.prototype._getSelectRowId = function(){
	return _lastSelectRowId;
}

/**
 * ����һ���ڵ�idͬʱѡ�и��׽ڵ�����Ķ�ѡ��.ֻ��Զ�ѡ��ѡ���ʱ����Ч
 * @param {} checkboxDom
 */
GridTree.prototype._chooseParentNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//�����ѡ��ǰ�Ķ�ѡ��,��ͬʱѡ�и��׵Ķ�ѡ��.
	if(checkboxDom.checked){
		while(1){
			var parentId = _$('_node'+nodeId)._node_parent;
			if(_$(parentId)!=null)
			{
				//�õ�ʵ����Ч�Ľڵ�id(ȥ��ǰ׺)
				nodeId = parentId.replace('_node','');
				var obj = _$('_chk'+nodeId).firstChild;
				if(_notBindDisabled(obj))
					obj.checked = 1;	
			}else{
				break;
			}
		}
	}
}

/**
 * ѡ���׽ڵ��Զ��Ѻ���ȫ��ѡ��.ֻ��Զ�ѡ��ѡ������
 * @param {��ѡ�����} checkboxDom
 */
GridTree.prototype._chooseChildrenNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//�����ѡ��ǰ�Ķ�ѡ��,��ͬʱѡ�и��׵Ķ�ѡ��.
	if(checkboxDom.checked){
		this._chooseAllChildrenNode('_node'+nodeId,true);
	}
}

/**
 * ȡ��ѡ���׽ڵ��Զ��Ѻ���ȫ��ȡ��ֻ��Զ�ѡ��ȡ��ѡ�е����
 * @param {��ѡ�����} checkboxDom
 */
GridTree.prototype._cancleChildrenNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//�����ѡ��ǰ�Ķ�ѡ��,��ͬʱѡ�и��׵Ķ�ѡ��.
	if(!checkboxDom.checked){
		this._chooseAllChildrenNode('_node'+nodeId,false);
	}
}

/**
 * ѡ���׽ڵ��Զ��Ѻ��ӽڵ�ȫ��ѡ�����ȫ��ȡ��
 * @param {�ڵ�id} nodeId
 * @param {ֵ} v
 */
GridTree.prototype._chooseAllChildrenNode = function(nodeId,v){
	var children = this.seeChildren(nodeId);
	if(children){
		var len = children.length;
		for(var i=0;i<len;i++){
			var nodeId = children[i].replace('_node','');
			var obj = _$('_chk'+nodeId).firstChild;
			if(_notBindDisabled(obj))
				obj.checked = v;
			if(findInArray(parents,children[i])!=-1)
			{
				this._chooseAllChildrenNode(children[i],v);
			}
		}
	}
}

/**
 * ȡ����ǰ�Ķ�ѡ��,������ֵܽڵ㶼û��ѡ��,����Ҳ��Ϊ��ѡ��״̬.ֻ��Զ�ѡ��ȡ����ʱ����Ч.
 * @param {} checkboxDom
 */
GridTree.prototype._cancelFaher = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//���ȡ����ǰ�Ķ�ѡ��,������ֵܽڵ㶼û��ѡ��,����Ҳ��Ϊ��ѡ��״̬
	if(!checkboxDom.checked){		
		while(1==1){
			var parentId = _$('_node'+nodeId)._node_parent;
			if(_$(parentId))
			{
				nodeId = parentId.replace('_node','');
				if(!this._anyChildChoosed(parentId))
				{
					var obj = _$('_chk'+nodeId).firstChild;
					if(_notBindDisabled(obj))
						obj.checked = 0;	
				}
			}else{
				break;
			}
		}
	}
}

/**
 * �ж�һ�����׽ڵ�ĺ������Ƿ�������һ����ѡ��.�оͷ���true,�����Ӷ�û��ѡ��ͷ���false.
 * @param {���׽ڵ��id} parentId
 */
GridTree.prototype._anyChildChoosed = function(parentId){
	var children = this.seeChildren(parentId);
	var len = children.length;
	for(var i=0;i<len;i++){
		var nodeId = children[i].replace('_node','');
		if(_$('_chk'+nodeId).firstChild.checked)
		{
			return true;
		}
	}
	return false;
}

/**
 * ɾ���ַ������˵Ŀո��ַ���.
 * @param {} str
 * @return {}
 */
function trim(str)
{
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * �������õ����ͷ���ָ����input�ؼ���
 * @param {���͵���ϸ��������} showTypeDesc
 * @param {һ�е�����ֵ} onerow
 * @param {��������} dataColumn
 * @param {idֵ} idValue 
 */
GridTree.prototype._createContent = function(showTypeDesc,onerow,dataColumn,idValue){
	var tp = showTypeDesc.inputtype;
	var cssName = showTypeDesc.style;
	var allvalues = showTypeDesc.values;
	var texts = [];
	var value = onerow[dataColumn];
	//ɾ�����˵Ŀմ�
	value = trim(value);
	var inputName = showTypeDesc.nameId+idValue;
	var setVisible = showTypeDesc.visibledIndex; 
	var setDisabled = showTypeDesc.disabledIndex; 
	var node = document.createElement("div"); 
	//���û������showTypeDesc.visibledIndex����,����������������Զ��Ҷ�Ӧ������ֵΪ1,��˵��Ҫ��ʾ����Զ�����.
	if(setVisible==null||onerow[setVisible]+''=='1'){
		//���������showTypeDesc.disabledIndex������Զ��Ҷ�Ӧ��ֵ��1,��˵��Ҫ��������Զ����в�����״̬!
		if(onerow[setDisabled]+''=='1'){
			setDisabled = 'disabled';
		}else{
			setDisabled = '';
		}
	
		node.style.textAlign = 'center';	
		if(tp=='textbox'){
			node.innerHTML = ["<input type='text' class='",cssName,"'  value='",value,"' name='",inputName,"' ",setDisabled," userSetDisabled='",setDisabled,"'/>"].join('');
		}else if(tp=='html'){	
			texts = showTypeDesc.htmlStr;
			node.setAttribute('id',inputName); 
			node.innerHTML = texts.replace(/[$]/g,value);
		}
		else if(tp=='select'){
			texts = showTypeDesc.texts;
			var ans = [];
			for(var i=0;i<allvalues.length;i++){			
				if(allvalues[i]==value){
					ans.push(["<option value='",allvalues[i],"' selected>",texts[i],"</option>"].join(''));
				}
				else{
					ans.push(["<option value='",allvalues[i],"'>",texts[i],"</option>"].join(''));
				}
			}
			ans.push("</select>");
			node.innerHTML = ans.join('');
		}
		else if (tp == 'radiobox') {
			texts = showTypeDesc.texts;
			node.appendChild(createHidden(inputName, inputName, value));
			var f = function() {
				if (showTypeDesc.onclick)
					showTypeDesc.onclick();
				_$(inputName).value = this.value;
			};
			for (var i = 0; i < allvalues.length; i++) {
				if (value == allvalues[i]) {
					createRadio(node, setDisabled, '', 'rd_' + inputName,
							allvalues[i], f, texts[i], cssName, 'checked');
				} else {
					createRadio(node, setDisabled, '', 'rd_' + inputName,
							allvalues[i], f, texts[i], cssName, '');
				}
			}
		}
		else if(tp=='checkbox'){
			texts = showTypeDesc.texts;
			var chArry = value.split(',');
			var f = function(e) {
				if (showTypeDesc.onclick)
					showTypeDesc.onclick();
			};
			for(var i=0;i<allvalues.length;i++){	
				if (findInArray(chArry, allvalues[i]) != -1) {
					createCheckbox(node,setDisabled,'',inputName,allvalues[i],f,texts[i],cssName,'checked');
			} else {
					createCheckbox(node,setDisabled,'',inputName,allvalues[i],f,texts[i],cssName,'');
				}
			}
		}else{
			node.innerHTML = '<font color="red">���ñ�����������ͳ���.</font>';
		}
	} 
	return node;
}

/**
 * ���������ķ�ҳ��.
 */
GridTree.prototype._resetBasePageBtns = function(){
	this._resetPageBtns(pagingInfo,"_firstPageBtn","_prePageBtn","_lastPageBtn","_nextPageBtn");
	//���û�ж�ҳ,��û�б�Ҫ�����Զ���ת��ָ��ҳ�İ�ť.
	if (pagingInfo.pagesCount == 1||pagingInfo.pagesCount == 0) {
		if(pagingInfo.pagesCount==0){
			jQuery('#_toPageBtn').removeClass("nextPage").addClass("disFirstPage").attr("disabled",true);		
		}
	}
}

/**
 * �������������ط�ҳ���Ŀ���״̬.
 * @param {��ʾ�����ط�ҳ���ĸ��׽ڵ�} pid
 */
GridTree.prototype._resetLazyPageBtns = function(pid){
	var ll = _lazypgInfoMap.get(pid); 
	this._resetPageBtns(ll,"_fstbtn_"+pid,"_prebtn_"+pid,"_lstbtn_"+pid,"_nxtbtn_"+pid);
}

/**
 * ���ݵ�ǰҳ���������÷�ҳ��ť��״̬.
 * @param {��ҳ���ݶ���} pageInfo
 * @param {��һҳ��ť��id} fstBtnId
 * @param {ǰһҳ��ť��id} preBtnId
 * @param {���һҳ��ť��id} lastBtnId
 * @param {��һҳ��ť��id} nxtBtnId
 */
GridTree.prototype._resetPageBtns = function(pginfo,fstBtnId,preBtnId,lastBtnId,nxtBtnId){
	var f1t = _$(fstBtnId),pre = _$(preBtnId),lst = _$(lastBtnId),nex = _$(nxtBtnId);
	//�����ҳ��ֻ��1ҳ���������ĸ���ҳ��ť��Ϊ��������ʽ
	if (pginfo.pagesCount == 1||pginfo.pagesCount == 0) {
		jQuery(f1t).removeClass("firstPage").addClass("disFirstPage").attr("disabled",true);
		jQuery(pre).removeClass("prevPage").addClass("disPrevPage").attr("disabled",true);
		jQuery(lst).removeClass("lastPage").addClass("disLastPage").attr("disabled",true);
		jQuery(nex).removeClass("nextPage").addClass("disNextPage").attr("disabled",true);		
	} else {
		//����ǵ�һҳ��������ǰһҳ�͵�һҳ��ťΪ��������ʽ
		if (pginfo.currentPage == 1) {		
			jQuery(f1t).removeClass("firstPage").addClass("disFirstPage").attr("disabled",true);
			jQuery(pre).removeClass("prevPage").addClass("disPrevPage").attr("disabled",true);
			jQuery(lst).removeClass("disLastPage").addClass("lastPage").attr("disabled",false);
			jQuery(nex).removeClass("disNextPage").addClass("nextPage").attr("disabled",false);	
		} 
		//�����ǰҳ�������һҳ�����ú�һҳ�����һҳ��ťΪ��������ʽ
		else if (pginfo.currentPage == pginfo.pagesCount) {
			jQuery(f1t).removeClass("disFirstPage").addClass("firstPage").attr("disabled",false);
			jQuery(pre).removeClass("disPrevPage").addClass("prevPage").attr("disabled",false);
			jQuery(lst).removeClass("lastPage").addClass("disLastPage").attr("disabled",true);
			jQuery(nex).removeClass("nextPage").addClass("disNextPage").attr("disabled",true);	
		}
		//��������������ĸ���ҳ��ť�������õ���ʽ
		else{
			jQuery(f1t).removeClass("disFirstPage").addClass("firstPage").attr("disabled",false);
			jQuery(pre).removeClass("disPrevPage").addClass("prevPage").attr("disabled",false);
			jQuery(lst).removeClass("disLastPage").addClass("lastPage").attr("disabled",false);
			jQuery(nex).removeClass("disNextPage").addClass("nextPage").attr("disabled",false);	
		}
	}
}
 
/**
 * ��jsp�����ʽ�ļ�.
 * @param {��ʽ�ļ���ַ��} csspath
 */
function importcss(csspath) {
	var scripts = document.getElementsByTagName("link");
	for (var i = 0; i < scripts.length; i++) {
		if (csspath == scripts[i].getAttribute("href")) {
			return;
		}
	}
	// ��ie��.
	if (isIE) 
		document.createStyleSheet(csspath);
	// �ڻ����
	else {
		var headElement = document.getElementsByTagName("head")[0];
		var tempStyleElement = document.createElement('link');// w3c
		tempStyleElement.setAttribute("rel", "stylesheet");
		tempStyleElement.setAttribute("type", "text/css");
		tempStyleElement.setAttribute("href", csspath);
		headElement.appendChild(tempStyleElement);
	}
}

/**
 * ��û�б�������ݵ�ʱ��ֻ��ʾ�����кͷ�ҳ����Ϣ
 * @param {����table��dom����} tree
 */
GridTree.prototype._makeTableWithNoData = function(tree){
	pagingInfo.allCount = 0;
	pagingInfo.pageSize = 0;
	pagingInfo.pagesCount = 0;
	pagingInfo.currentPage = 0;
	this._addTitleHead(tree);
	elct.innerHTML = '';
	// ��ʾȫ����Ϣ
	if (tc.pageBar) {
		this._makePageBar(tree, 1);
	}
	elct.appendChild(tree);
	// �������÷�ҳ��ť����ʽ
	this._resetBasePageBtns();	
}

/**
 * ����һ����ʾ������Ϣ�Ĳ�
 */
GridTree.prototype._createDebugDiv = function()
{
	var debugDiv = document.createElement("div");
	debugDiv.setAttribute('id','_debugDiv');
	debugDiv.className='debugdiv';
	document.body.appendChild(debugDiv);
}

/**
 * ����һ��div,������ʾ�������ڼ��ص���ʾ��Ϣ
 */
GridTree.prototype._createMsgDiv = function(){
	msgDiv = document.createElement("div");
	msgDiv.setAttribute('id','_msgDiv');
	msgDiv.className='msgdiv';
	msgDiv.appendChild(document.createTextNode("�����ύ..."));
	document.body.appendChild(msgDiv);
}

/**
 * ����һ����ʾ��Ϣ��,��ʾ���ڼ���.
 * v:��ʾ���ǲ���ʾ,true����ʾ������ʾ
 */
GridTree.prototype._showMsg = function(v)
{
	var divNode = _$("_msgDiv"); 
	var table = _$('_trhead'); 
	if(!divNode){
		this._wirteError('��ʾ��ʾ��Ϣ�����,���ܲ�����!'); 
		return false;
	}
	if(v){
		divNode.innerText = '�����ύ...'; 
		divNode.style.top = table.offsetTop+10;
		divNode.style.left = table.offsetLeft+table.offsetWidth/9*8;
		divNode.style.display = 'inline';	 
	}
	else
		divNode.style.display = 'none';
	return true;
} 
 
/**
 * ��ʾ�����صķ�ҳ����div. added on 20101224
 * @param {���׽ڵ��id} pid
 * @param {�����ͼƬ����} parentImg
 * @param {�Ƿ���ʾ��true����ʾ} v
 * @param {�����صķ�ʽ����ҳ1����2} way
 */
GridTree.prototype._showLazyPagingDiv = function(pid,imgId,v,way)
{
	var lazyPageDiv = _$("_lazyPagingDiv_"+pid);  
	var offset = jQuery('#'+imgId).offset();  
	if(v){ 
		//�����������͵�ǰҳ��
		var lazypaging_info = _lazypgInfoMap.get(pid);
		// �������Ѿ����ڵ������ķ�ҳ��div
		// ���Ż�
		jQuery('[id^=_lazyPagingDiv_]').hide();
		jQuery('#_lazy_page_count_' + pid).text(lazypaging_info.allCount);
		//���÷�ҳ�����ĸ���ť�Ŀ����벻����״̬
		this._resetLazyPageBtns(pid);
		//�������÷�ҳ����λ��,=1��������
		if(way==1){
			lazyPageDiv.style.top = offset.top; 
			jQuery('#_lazy_page_currentpage_'+pid).text(lazypaging_info.currentPage);
		}else { 
			var lastcount = lazypaging_info.currentPage*lazypaging_info.pageSize;
			if(lastcount>lazypaging_info.allCount){
				lastcount = lazypaging_info.allCount;
			}
			lazyPageDiv.style.top = offset.top-jQuery('#'+imgId).height(); 
			jQuery('#_lazy_page_currentpage_'+pid).text(lastcount);
		} 
		lazyPageDiv.style.left = offset.left;
		lazypagex = offset.left;
		lazypagex2 = offset.left + jQuery(lazyPageDiv).width();
		lazypagey = offset.top;
		lazypagey2 = offset.top + jQuery(lazyPageDiv).height();
		lazyPageDiv.style.display = 'inline';
		lazyPageDiv.focus();
	}
	else
		lazyPageDiv.style.display = 'none';
}

/**
 * ���������ط�ҳ��div. added on 20101222
 * @param {����ĸ��ڵ��id} pid
 */
GridTree.prototype._createLazyPagingDiv = function(pid)
{
	if(_$("_lazyPagingDiv_"+pid)!=null){
		return true;
	} 
	var lazyPagingDiv = document.createElement("div");
    jQuery(lazyPagingDiv).attr('id', '_lazyPagingDiv_' + pid)
			.addClass("lazyPagediv") // aa
			.html(lzpagetabletemp.replace(/\$/g, pid)).mouseout(function(e) {
						e = e || window.event;
						var mousePos = mousePosition(e);   
						//������λ�ó����˵�����ķ�Χ,���Զ����ظõ����ķ�ҳ��.
						if (mousePos.x < lazypagex || mousePos.y < lazypagey || mousePos.x >= lazypagex2
								|| mousePos.y >= lazypagey2) {
							GridTree.prototype._showLazyPagingDiv(pid, 'null', false);
						}
					}); 
	document.body.appendChild(lazyPagingDiv);   
}

/**
 * ������ģʽ��������div����ʾ������.
 * @param {����id} pid
 * @return {Boolean}
 */
GridTree.prototype._createMoreLazyPagingDiv = function(pid)
{ 
	if(_$("_lazyPagingDiv_"+pid)!=null){
		return true;
	} 
	var lazyPagingDiv = document.createElement("div");
    jQuery(lazyPagingDiv).attr('id', '_lazyPagingDiv_' + pid)
			.addClass("lazyPagediv") // aa
			.html(lzmorepagetemp.replace(/\$/g, pid));
	document.body.appendChild(lazyPagingDiv);  
	//�����������͵�ǰҳ��
	var lazypaging_info = _lazypgInfoMap.get(pid);
	jQuery('#_lazy_page_count_'+pid).text(lazypaging_info.allCount);
	jQuery('#_lazy_page_currentpage_'+pid).text(lazypaging_info.currentPage*lazypaging_info.pageSize);
}

/**
 * �õ�����x,y������λ��
 * @param {����¼����} ev
 * @return {����һ������,����"{x:1,y:1}"}
 */
function mousePosition(ev) {
	if (ev.pageX || ev.pageY) {
		return {
			x : ev.pageX,
			y : ev.pageY
		};
	}
	return {
		x : ev.clientX + document.body.scrollLeft - document.body.clientLeft,
		y : ev.clientY + document.body.scrollTop - document.body.clientTop
	};
} 

/**
 * ��ʼ������ʱ����з�ҳ��Ϣ�Ĵ���.
 */
GridTree.prototype._initPageInfo = function()
{
	if (_serverPagingMode == 'client') {	
		// �ܹ��ĵ�һ��ڵ���Ŀ(�������Ϊ��Ϣ����)
		pagingInfo.allCount = firstLevelNodes.length;
		// ÿҳ����ʾ��Ϣ����
		pagingInfo.pageSize = tc.pageSize;
		// �ܹ���ҳ��
		pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
		// ��ǰҳ��(��1��ʼ����)
		pagingInfo.currentPage = 1;
	}else if (_serverPagingMode == 'analyzeAtPage') {	
		pagingInfo.allCount = tc.allDataInfoWithPageInfo.total;
		pagingInfo.pageSize = tc.pageSize;
		pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
		//��̨json����ֱ�Ӵ�����ǰҳ��
		pagingInfo.currentPage = tc.allDataInfoWithPageInfo.page;
	} 
	else {
		//�Ѿ��ϳ��˺�̨��ҳģʽ,��������Ĵ�����Զ������! 
		alert("��ô������?����bug��!");
	}
}

/**
 * ���ݺ�̨���ص��ַ���,��ʼ�������ط�ҳ�ķ�ҳ������.
 * @param {���׽ڵ�id} pid
 * @param {���׽ڵ�����} pName 
 * @param {json���ص��ַ���} msg 
 */
GridTree.prototype._initLazyPageInfo = function(pid,pName,msg)
{
	eval("tc.allDataInfoWithLazyPageInfo=" + msg); 
	var lazypgInfo = {};
	// �����صĸ��׽ڵ�id
	lazypgInfo.parentId = pid;
	lazypgInfo.parentName = pName;
	// ������
	lazypgInfo.allCount = tc.allDataInfoWithLazyPageInfo.total;
	// ÿҳ����ʾ��Ϣ����,���������ò���
	lazypgInfo.pageSize = tc.lazyPageSize;
	// �ܹ���ҳ��
	lazypgInfo.pagesCount = Math.ceil(lazypgInfo.allCount
			/ lazypgInfo.pageSize * 1.0);
	// ��ǰҳ��(��1��ʼ����)
	lazypgInfo.currentPage = tc.allDataInfoWithLazyPageInfo.page;  
	//�������ط�ҳ����Ϣ��������
	_lazypgInfoMap.put(pid,lazypgInfo); 
}

/**
 * ǰ̨������������,���ݺ�̨������json������б�������¼���ϵ�ķ���.
 * ��ؼ����㷨����.
 * @param {����ж������������} data
 */
GridTree.prototype._analyseData = function(msg)
{
	var data = [];	
	//����Ǻ�̨����ģʽ,��ֱ��ȡ�������Ϣ֮����к����Ĳ���.
	if(_serverPagingMode=='server'){
		//�Ѿ��ϳ��˺�̨��ҳģʽ,��������Ĵ�����Զ������!
		alert("��ô������?����bug��!");
	}
	else{
		if(_serverPagingMode == 'client'){
			data = msg;
		}else{
			eval("tc.allDataInfoWithPageInfo=" + msg);
			data = tc.allDataInfoWithPageInfo.data;
			if (typeof data == 'undefined') {
				data = tc.allDataInfoWithPageInfo;
			}
			pagingInfo.currentPage = tc.allDataInfoWithPageInfo.page;
			pagingInfo.allCount = tc.allDataInfoWithPageInfo.total;
		}
	}	
	
	//�������������ģʽ,��Ҫ�������ݵķ���,�����÷���,ֱ����data�����json���������Ⱦ�Ϳ�
	if(!tc.lazy){
		var len = data.length;
		for (var i = 0; i < len; i++) {
			var _id = data[i][tc.idColumn];
			var _parent = data[i][tc.parentColumn];
			// ����ڸ����������Ҳ���������ף��ͽ����׽ڵ���ӵ�parents��ȥ����ֹ�˳��ָ��׽ڵ��ظ������
			if (findInArray(parents, '_node' + _parent) == -1)
				parents.push('_node' + _parent);
			// ����Ѿ���map�д����˸ýڵ�ĸ��׽ڵ�,��ȡ���Ѿ����ڵ�����,������µ�id
			if (parentToChildMap.containsKey('_node' + _parent)) {
				var arr = parentToChildMap.get('_node' + _parent);
				arr.push('_node' + _id);
				parentToChildMap.put('_node' + _parent, arr);
			} else {
				var arr = [];
				arr.push('_node' + _id);
				parentToChildMap.put('_node' + _parent, arr);
			}
			// ��Ӻ��ӵ����׵�ӳ���ϵ
			childToFatherMap.put('_node' + _id, '_node' + _parent);
			// ��ӽڵ�id���ڵ��ӳ���ϵ
			nodeMap.put('_node' + _id, data[i]);
		}
		// ����һ������,������ŵ�һ��ڵ�ĸ����ڵ�...
		firstLevelParentIds = removeArrayFromOtherArray(parents, nodeMap.keys());
		// �õ��ڵ��еĸ��׽ڵ㼯��
		parents = removeArrayFromOtherArray(parents, firstLevelParentIds);
		// �������firstLevelParentIds�õ�Ҫ�ڵ�һ����ʾ����Щ�ڵ��id
		for (var ii = 0; ii < firstLevelParentIds.length; ii++) {
			firstLevelNodes = firstLevelNodes.concat(parentToChildMap
					.get(firstLevelParentIds[ii]));
		}		
	}	
}


/**
 * д������Ϣ
 * @param {��Ϣ} msg
 */
GridTree.prototype._wirteDebug = function(msg){
	if(tc.debug==1){
		var dbg = _$('_debugDiv');
		if(dbg.innerHTML!='')
			dbg.innerHTML +='<br>'+msg;
		else{
			dbg.innerHTML =msg;
		}
		dbg.scrollTop=dbg.scrollHeight;
	}
}

/**
 * ��ӡ������Ϣ.
 * @param {������Ϣ} msg
 */
GridTree.prototype._wirteError = function(msg){
	elct.innerHTML = _errortemp.replace(/\$/g, msg);
}

/**
 * �����̨������json�ַ������з�ҳ���ķ����ȵȡ�
 * @param {�������dom����} tree
 * @param {json����} msg
 */
GridTree.prototype._newPagingServerMakeTable = function(tree,msg)
{
	this._initData();
	this._analyseData(msg);
	// �������õ�ǰҳ		
	pagingInfo.pageSize = tc.pageSize;//0729
	pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
	//��Ȼ�Ǻ�̨��ҳģʽ,��ô��һ����ʾ�����ݿ϶���Ҫ��firstLevelNodes������ȫ����ʾ����!
	//����ڶ���������1��ԭ����'ǰ����'������ 
	if(!tc.lazy)
		this._showTable(tree,0, firstLevelNodes.length+1);
	else
		this._showLazyTable(tree,tc.allDataInfoWithPageInfo.data); 
	// �������÷�ҳ��ť����ʽ
	this._resetBasePageBtns();
	if(tc.exchangeColor)
		this._setColor(tree);
	elct.appendChild(tree);
	/** ****** ���Ƿ�������չ��ȫ�� ********* */
	if (tc.expandAll) {
		this.expandAll();
	}
	if(tc.onPagingSuccess)	tc.onPagingSuccess(elct);	
}

/**
 * ����ָ���ı�����ĵ�˫����ɫ
 * @param {���������} tableTree
 */
GridTree.prototype._setColor = function(tableTree){
	jQuery("tr:visible",tableTree).each(function(i){
		if(this.id.indexOf('_node')!=-1){
			if(i%2==0){
				jQuery(this).removeClass('TrEven').addClass('TrOdd');
			}else{
				jQuery(this).removeClass('TrOdd').addClass('TrEven');
			}
		}		
	});
}

/**
 * ��ӱ�����,����tHead���� tableTree:������
 */
GridTree.prototype._addTitleHead = function(tableTree) {
	/** *** ��ӱ�ͷ��һ�м������� */
	var cms = tc.columnModel;
	var tableHeadRow = tableTree.createTHead();
	var newRow = document.createElement("tr");
	newRow.setAttribute('id', '_trhead');
	// ���������ѡ��ť�����ڱ��������һ��ѡ��ı�����
	if (tc.checkOption == '1' || tc.checkOption == '2') {
		var checkCell = document.createElement("td");
		jQuery(checkCell).attr('id','countCell').width('5%').addClass('tablehead').width('0.1%');
		//����Ƕ�ѡģʽ,������������Ҫ��ȫѡ�İ�ť
		if(tc.checkOption=='2'&&tc.allCheck)
		{
			checkCell.innerHTML =  "<input type='checkbox' style='width:20px;border:0px;' id='_checkAll' onclick='GridTree.prototype._chooseAll()'>";
		}
		else{
			jQuery(checkCell).text(tc.checkColumnDesc);
		}
		jQuery(checkCell).appendTo(newRow);
	}
	
	// ���������Ҫ�Զ���ʾÿ�е�����,��Ҫ��������һ����ʾ����
	if (tc.rowCount) {
		jQuery("<td>").text(tc.countColumnDesc).attr('id','countCell').width('5%')
			.addClass('tablehead').addClass('countCell').appendTo(newRow);
	}
	
	var i = 0;
	var lenlen = cms.length ;
	// �����һ���������
	for (var ii=0;ii<lenlen;ii++) {
		var oneColumn = cms[ii];
		var newCell = document.createElement("td");
		if (tc.columnModel[i].width != null
				&& tc.columnModel[i].width != '*')
			newCell.style.width = tc.columnModel[i].width;
		i = i + 1;
		jQuery(newCell).addClass('tablehead').attr('id',oneColumn.headerIndex).text(oneColumn.header).appendTo(newRow);
		headColumns.push(oneColumn.headerIndex);
	}
	tableHeadRow.appendChild(newRow);
}
    
/**
 * ���ȫ��ѡ��İ�ť
 */
GridTree.prototype._chooseAll = function()
{
	if(_$('_checkAll').checked)
	{
		_checkedAll("_chks",true);
	}
	else{
		_checkedAll("_chks",false);
	}
}

/**
 * �õ���ǰҳ�ĵ�һ�е��ڵ�һ���ڵ��е�λ��
 */
GridTree.prototype._getFirstIndexInThisPage = function(){
	var _firstIndex = 0;
	//�������ҳ�Ļ�,˵����ǰҳ�ĵ�һ��λ�ÿ϶�����0��!
	if(tc.pageBar)
		_firstIndex = (pagingInfo.currentPage - 1) * pagingInfo.pageSize;
	return _firstIndex;
}

/**
 * �������������е�����
 */
GridTree.prototype._clearContent = function(){
	jQuery('#' + tc.tableId + ' tr[id]').each(function(i) {
		if (this.id != '_trpagebar' && this.id != '_trhead') {
			jQuery(this).remove();
		}
	});
}

/**
 * ��װ��ҳ��,����tFoot���� tableObj:������ index:��ҳ�����������
 */
GridTree.prototype._makePageBar = function(tableObj, index) {
	// ������ҳ���ľ�����Ϣ,��һ�����
	var pageBar = document.createElement('table');
	pageBar.setAttribute('id', tc.pageBarId); 
	var pageBarTR = pageBar.insertRow(0); 
	// ��һҳ��ť���ڵ�td
	var firstCell = pageBarTR.insertCell(pageBarTR.cells.length);
	firstCell.setAttribute('id', 'firstPageCell');  
	firstCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'first\')" class="pagebarbtn disFirstPage" title="��һҳ" id="_firstPageBtn" disabled></button>';
	// ǰһҳ��ť���ڵ�td
	var preCell = pageBarTR.insertCell(pageBarTR.cells.length);
	preCell.setAttribute('id', 'prePageCell'); 
	preCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'pre\')" class="pagebarbtn disPrevPage" title="ǰһҳ" id="_prePageBtn" disabled></button>';
	// ��һҳ��ť���ڵ�td
	var afterCell = pageBarTR.insertCell(pageBarTR.cells.length);
	afterCell.setAttribute('id', 'nextPageCell'); 
	if(pagingInfo.pagesCount==1){
		afterCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'next\')" class="pagebarbtn disNextPage" title="��һҳ" id="_nextPageBtn"></button>';
	}
	else{
		afterCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'next\')" class="pagebarbtn nextPage" title="��һҳ" id="_nextPageBtn"></button>';
	}
	// ���һҳ��ť���ڵ�td
	var lastCell = pageBarTR.insertCell(pageBarTR.cells.length);
	lastCell.setAttribute('id', 'lastPageCell'); 
	if(pagingInfo.pagesCount==1){
		lastCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'last\')" class="pagebarbtn disLastPage" title="���һҳ" id="_lastPageBtn"></button>';
	}
	else{
		lastCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'last\')" class="pagebarbtn lastPage" title="���һҳ" id="_lastPageBtn"></button>';
	}
	// ��תҳ����ť���ڵ�td
	var selectPageCell = pageBarTR.insertCell(pageBarTR.cells.length);
	selectPageCell.setAttribute('id', 'selectPageCell');
	selectPageCell.innerHTML = ['<input type="text" style="width:30px" id="_pageNum" '
			, 'onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46"'
			, 'onpaste="return !clipboardData.getData(\'text\').match(/\D/)">'
			, '<button class="pagebarbtn jumpPage" onclick="GridTree.prototype._toPage(\'any\')" title="��ת" id="_toPageBtn"></button>'].join('');
	// ѡ��ÿҳ�����������˵�
	var selectPagingCell = pageBarTR.insertCell(pageBarTR.cells.length);
	selectPagingCell.innerHTML = 'ÿҳ<select onchange="GridTree.prototype._reMakeTable(this.value);" id="_changePageSizeSel"><option value="5">5</option><option value="10" selected>10</option><option value="20">20</option><option value="40">40</option><option value="100">100</option></select>��';
	var msgCell = pageBarTR.insertCell(pageBarTR.cells.length);
	// ��ʾ�ķ�ҳ(��ǰҳ,��ҳ��)
	msgCell.style.textAlign = 'right';
	msgCell.setAttribute('id', 'msgCell');
	msgCell.innerHTML = ["��ǰ��" , pagingInfo.currentPage , "ҳ/�ܹ�"
			, pagingInfo.pagesCount , "ҳ"].join('');
			
	//�����ext����ʽ.
	if(_style==1)
	{
		pageBar.style.width = '100%';
		pageBar.className = 'pagebartable';
		pageBar.style.height = '20px';
		firstCell.className = 'pagebartd';
		firstCell.style.width = '1%';
		preCell.className = 'pagebartd';
		preCell.style.width = '1%';
		afterCell.className = 'pagebartd';
		afterCell.style.width = '1%';
		lastCell.className = 'pagebartd';
		lastCell.style.width = '1%';
		selectPageCell.className = 'pagebartd';
		selectPageCell.style.width = '1%';
		selectPagingCell.className = 'pagebartd';
		selectPagingCell.style.width = '1%';
		selectPagingCell.style.width = '1%';
		msgCell.className = 'pagebartd';
		msgCell.style.width = '1%';	
	}
	//���������ectable����ʽ
	else{
		pageBar.style.width = '100%';
		pageBar.className = 'pageBar';
		firstCell.className = 'pageNavigationTool';
		firstCell.nowrap = 'nowrap';
		firstCell.border = '0px';
		preCell.className = 'pageNavigationTool';
		preCell.nowrap = 'nowrap';
		preCell.border = '0px';
		afterCell.className = 'pageNavigationTool';
		afterCell.nowrap = 'nowrap';
		afterCell.border = '0px';
		lastCell.className = 'pageNavigationTool';
		lastCell.nowrap = 'true';
		lastCell.border = '0px';
		selectPageCell.className = 'pageJumpTool';
		selectPageCell.nowrap = 'nowrap';
		selectPagingCell.className = 'pageSizeTool';
		selectPagingCell.nowrap = 'nowrap';
		msgCell.className = 'statusTool';
		msgCell.nowrap = 'nowrap';
	}
	var tfoot = tableObj.createTFoot();
	var newTr = tfoot.insertRow(0);
	var newCell = newTr.insertCell(0);
	var colspan = headColumns.length;
	if (tc.rowCount)
		colspan = colspan + 1;
	if (tc.checkOption == '1' || tc.checkOption == '2')
		colspan = colspan + 1;
	newCell.colSpan = colspan;
	newCell.appendChild(pageBar);
}

/**
 * �����µķ�ҳ�������»������
 * @param {��ҳ��Ŀ} pageSize
 */
GridTree.prototype._reMakeTable = function(pageSize)
{
	if(pagingInfo.pagesCount!=0){
		//�����ʹ�õĿͻ��˷�ҳ,�ܼ򵥾�ʵ����.
		if (_serverPagingMode == 'client') {
			// ÿҳ������
			pagingInfo.pageSize = pageSize;
			// �ܹ���ҳ��
			pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount / pagingInfo.pageSize
					* 1.0);
			// ��ǰҳ��(��1��ʼ����)
			pagingInfo.currentPage = 1;
			_$('msgCell').innerHTML = "��ǰ��" + pagingInfo.currentPage + "ҳ/�ܹ�"
					+ pagingInfo.pagesCount + "ҳ";
			this._toPage(1);
			_$(tc.tableId).focus();
		}
		//�����Ҫ�ߺ�̨.
		else{
			pagingInfo.pageSize = pageSize;//�޸�:2010-0729
			tc.pageSize = pageSize;
			this._toPage("repaging");
			_$(tc.tableId).focus();
		}
	}
}

/**
 * ����json������ӵ�����������,��������ӵĵ�һ��ڵ�
 * @param {�������е�λ��} index
 * @param {json����} rowData
 * @param {�������(��һ����1)} level
 * @param {��ʾ��ǰ������ͬ���е�λ��} nth
 */
GridTree.prototype._addOneLazyRowByData = function(index, rowData, level,nth) {
	var newRow = document.createElement('tr');
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	_parent = _parent == "" ? '-1' : _parent;// ��ֹ���ָ��׽ڵ�Ϊ�յ����
	var _isP = this.isParent(rowData);
	var pnode = GridTree.prototype.getRowObjById(_parent);
	_parent = '_node'+_parent;
	var parentRowNum = '';
	var parentPath = '';
	if(pnode){
		parentRowNum = pnode.getAttribute('rownum')+'.';
		parentPath = pnode.getAttribute('_node_path')+',';
	} 
	if(!nth) nth = index;
	jQuery(newRow).attr({rownum:parentRowNum+nth,id:'_node'+_id,_node_parent: _parent,
				_node_path: parentPath+_parent,_node_isparent: _isP,_node_level: level});
	// ����Ǹ��׽ڵ�,������һ���Ƿ�򿪵ı�־
	if (_isP == '1') newRow.setAttribute('_open', 'false'); 
	this._userSetPros(rowData,newRow); 
	this._addCheckOptionCell(rowData,newRow); 
	this._addCountCell(rowData,newRow,index,level); 
	this._addOneLazyRowContent(rowData,newRow,_id,_isP,level); 
	this._addOneRowListerners(newRow); 
	return newRow;
}

/**
 * ����һ������Ҫ���json�������һ�� 
 * tableObj:������ 
 * index:�������е�λ�� 
 * rowData:json����
 * level:�������(��һ����1)
 */
GridTree.prototype._addOneRowByData = function(tableObj, index, rowData, level) {
	// ���Ѿ��е�����֮������µ�һ��
	var newRow = tableObj.insertRow(index);
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	var _isP = this.isParent(rowData);
	
	// ���ø��е�id
	newRow.setAttribute('id', '_node'+_id);
	// ���ø��еĸ�����id
	_parent = _parent == "" ? '-1' : _parent;// ��ֹ���ָ��׽ڵ�Ϊ�յ����
	_parent = '_node'+_parent;
	newRow.setAttribute('_node_parent', _parent);
	// ����ǵ�һ��Ľڵ㣬��·��������Ϊ'-1'����ʾ�ǵ�һ��Ľڵ�
	if (level == 1) newRow.setAttribute('_node_path', '-1');
	// ������·��������Ϊ�ӵ�һ�㸸��һֱ���µ���ǰ�ڵ��·����ʽ
	else {
		newRow.setAttribute('_node_path', this.getNodePath('_node'+_id).join(','));
	}
	newRow.setAttribute('_node_isparent', _isP);
	newRow.setAttribute('_node_level', level);
	
	// ����Ǹ��׽ڵ�,������һ���Ƿ�򿪵ı�־
	if (_isP == '1')
		newRow.setAttribute('_open', 'false');
	//������ص����Ե��ж�����
	this._userSetPros(rowData,newRow);
	//Ϊÿһ�����ѡ����С�
	this._addCheckOptionCell(rowData,newRow);	
	//���������
	this._addCountCell(rowData,newRow,index,level);	
	//����еľ������ݡ�
	this._addOneRowContent(rowData,newRow,_id,_isP,level);	
	//��ÿһ������е��¼�����
	this._addOneRowListerners(newRow);
}

/**
 * ���������ģʽ�µ�һ�����ݵ���Ҫ����.
 * @param {������Դ} rowData
 * @param {�ж���} newRow
 * @param {idֵ} _id
 * @param {�Ƿ��׽ڵ�} _isP
 * @param {����} level
 */
GridTree.prototype._addOneLazyRowContent = function(rowData,newRow,_id,_isP,level){
	// ��������һ������ĸ�����,��ʾ��˳���Ǹ�����columns������Ⱥ�˳��չʾ��.
	var i = 0; 
	for (; i < headColumns.length; i++) {
		var newSmallCell = document.createElement("td");
		newSmallCell.setAttribute('_td_pro', headColumns[i]);
		var _t = rowData[headColumns[i]]; 
		// �ڵ�һ�н���ͼ�������
		if (i == 0) {			
			if (_t != '') {				
				var ct = level - 1;
				var ans = [];
				for(var ii=0;ii<ct;ii++){
					ans.push(['<IMG ','src="',tc.blankImg,'"/>'].join(''));
				}
				// ����Ǹ��׽ڵ�
				if (_isP == '1') {
					ans.push(["<IMG id='img_"
							, _id, "' style='CURSOR: hand' ",
							"onclick='javascript:GridTree.prototype.openChildrenTable(this.id,this,event);' src='",
							tc.openImg , "'/>" ].join(''));
				} else {
						ans.push(["<IMG id='img_" , _id, "' src='" , tc.noparentImg , "'/>"].join(''));					
				}	
				newSmallCell.innerHTML = ans.join('');
				var showTypeDesc = tc.columnModel[i].columntype;
				//�����һ��������������ʾ�������
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id).firstChild);
				}else{
					newSmallCell.innerHTML += _t;
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
		// �����о�ֱ���������ݼ���
		else {			
			if (_t != '') {
				var showTypeDesc = tc.columnModel[i].columntype; 
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id));
				}else{
					newSmallCell.innerHTML = rowData[headColumns[i]];
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
		
		newRow.appendChild(newSmallCell);
	}
}

/**
 * ����еľ�������
 * @param {������Դ} rowData
 * @param {�ж���} newRow
 * @param {idֵ} _id
 * @param {�Ƿ��׽ڵ�} _isP
 * @param {����} level
 */
GridTree.prototype._addOneRowContent = function(rowData,newRow,_id,_isP,level){
	// ��������һ������ĸ�����,��ʾ��˳���Ǹ�����columns������Ⱥ�˳��չʾ��.
	var i = 0;
	for (; i < headColumns.length; i++) {
		var newSmallCell = newRow.insertCell(newRow.cells.length);
		newSmallCell.setAttribute('_td_pro', headColumns[i]); 
		var _t = rowData[headColumns[i]];
		// �ڵ�һ�н���ͼ�������
		if (i == 0) {			
			if (_t != '') {				
				// ��������������������Ĵ�С
				var ct = level - 1;
				var ans = [];
				for(var ii=0;ii<ct;ii++){
					ans.push(['<IMG ','src="',tc.blankImg,'"/>'].join(''));
				}
				// ����Ǹ��׽ڵ�
				if (_isP == '1') {
					ans.push(["<IMG id='img_"
							, _id, "' style='CURSOR: hand' ",
							"onclick='javascript:GridTree.prototype.openChildrenTable(this.id,this,event);' src='",
							tc.openImg , "'/>" ].join(''));
					// ��Ȼ�Ǹ��׽ڵ�,���ǲ��ڵ�һ��ڵ���,���Բ�Ӧ����ʾ����
					if (findInArray(firstLevelNodes, '_node'+_id) == -1) {
						newRow.style.display = 'none';
					}
				} else {
					// ������ǵ�һ��ڵ�Ҫ��ʾ��������Ҷ,������Ϊ������(��Ϊ�ڵ�һ��ڵ�Ҫ��ʾ�����Ĺ����ڵ����ɼ�)
					if (findInArray(firstLevelNodes, '_node'+_id) == -1) {
						ans.push(["<IMG id='img_" , _id
								, "' src='" , tc.noparentImg , "'/>"].join(''));
						newRow.style.display = 'none';
					}
					// ���ڹ����ڵ�(�ڵ�һ����û�и���Ҳû�к��ӵĽڵ�)��������ʾ.��Ҫ��ͼ���ļ���ʾ����,����û������Ϊ���ɼ�.
					else {
						ans.push(["<IMG id='img_" , _id
								, "' src='" , tc.noparentImg , "'/>" ].join(''));
					}
				}	
				newSmallCell.innerHTML = ans.join('');
				var showTypeDesc = tc.columnModel[i].columntype;
				//�����һ��������������ʾ�������
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id).firstChild);
				}else{
					newSmallCell.innerHTML += _t;
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
		// �����о�ֱ���������ݼ���
		else {			
			if (_t != '') {
				var showTypeDesc = tc.columnModel[i].columntype;
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id));
				}else{
					newSmallCell.innerHTML = rowData[headColumns[i]];
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
	}
}

/**
 * ������ת�Ĳ������͵õ�ʵ�ʵĵ�ǰҳ��.
 * @param {��ҳ��} pginfo
 * @param {ֱ��������תҳ����ı���id} pageNumId
 * @param {��������} operCode
 */
GridTree.prototype._getCurrentPage = function(pginfo,pageNumId,operCode){  
	switch(operCode){
		case 'first' :
			pginfo.currentPage = 1;
			break;
		case 'pre':
			pginfo.currentPage = (pginfo.currentPage - 1) < 1
			? 1
			: (pginfo.currentPage - 1);
			break;
		case 'next':
			pginfo.currentPage = (pginfo.currentPage + 1) > pginfo.pagesCount
			? pginfo.pagesCount
			: (pginfo.currentPage + 1);
			break;
		case 'last':
			pginfo.currentPage = pginfo.pagesCount;
			break;
		case 'repaging':
			pginfo.currentPage = '1';
			break;
		default:
			var pnum = _$(pageNumId); 
			if(pnum){
				var n = pnum.value;
				if (n == '' || n > pginfo.pagesCount) {
					alert("����ҳ���������Ϊ�գ����������룡");
					pnum.focus();
					return;
				}
				pginfo.currentPage = n;
			}else{
				alert('����bug,��תҳ��û����ȷ����.');
			}
			break;
	}
}

/**
 * �����صĵ�ָ��ҳ.
 * @param {�����صĸ��׽ڵ�id} pid
 * @param {��������} operCode
 */
GridTree.prototype._toLazyPage = function(pid,operCode) {
	var pnum = _$('_pageNum'), mdiv = _$('_msgDiv'), mcel = _$('msgCell'), tb = _$(tc.tableId);
	var lazypaing_info = _lazypgInfoMap.get(pid);
	//���_morepage˵������������ʾ�����ʱ�����ĸ÷���.
	if(operCode=='_morepage')
		lazypaing_info.currentPage += 1; 
	// ����õ�Ӧ��ʾ�ĵ�ǰҳ��.
	else
		this._getCurrentPage(lazypaing_info, '', operCode); 
	var param = {
		analyze : tc.analyzeAtServer,
		gtlimit : lazypaing_info.pageSize,
		gtpage : lazypaing_info.currentPage,
		pId : pid
	};  
	this._showLazyPagingDiv(pid, 'null', false);
	this._showMsg(1);
	jQuery.ajax({
		type : "POST",
		url : tc.lazyLoadUrl,
		// ��ҳ��ʱ�򴫵ݵ���ֻ̨����ʼλ�ú�ÿҳ��С��������.
		data : param,
		async : 1,
		success : function(msg) {  
			var parentNode = _$('_node'+pid); 
			var img = _$('img_'+pid); 
			var o = new Date();
			if(operCode!='_morepage'){
				//ɾ���Ѿ����ڵ��ӽڵ�
				GridTree.prototype._removeChildrenTable(pid);
				GridTree.prototype._initLazyPageInfo(pid,'���׽ڵ�id',msg); 
				GridTree.prototype.dynamicAdd(pid,parentNode,img,msg);
			}
			//operCode = _morepage��˵���������ص���ʾ����
			else{ 
				// �õ���ǰ��ʾ������ǰһ���ֵܽڵ��λ����������,�������ɺ�����ӽڵ������
			 	var numstrs = jQuery('[_node_parent=_node' + pid + ']:last').attr('rownum').split('.');
				var lastnum = numstrs[numstrs.length - 1];
				GridTree.prototype
						._initLazyPageInfo(pid, '���׽ڵ�id', msg);
				GridTree.prototype.dynamicAdd(pid, parentNode, img,
						msg, lastnum);
			}
			var gotime = new Date() - o;
			GridTree.prototype._wirteDebug('��ҳ��ʾǰ̨����ʱ��:' + gotime);
			GridTree.prototype._showMsg(0);
		}
	});	 
} 

/**
 * �Ƴ�һ�����׽ڵ������ȫ��Ƕ���ӽڵ�.
 * @param {���׽ڵ�id} pid
 */
GridTree.prototype._removeChildrenTable = function(pid){ 
	jQuery('tr[_node_parent=_node'+pid+']').each(function(i){
		if(this.getAttribute('_node_isparent')=='1')
		{ 
			GridTree.prototype._removeChildrenTable(this.id.replace('_node',''));
		} 
	}).remove();
}

/**
 * ��ָ����ҳ
 * @param {ҳ��} num(�ں�̨��ҳģʽ��ʱ��,���������ʾ��ǰҳ��,�����ǰ̨��ҳģʽ,���ݵ����µ�ҳ��)
 * @param {����ҳ��Ĳ�����ʽ} operCode(�ں�̨��ҳģʽ��ʱ�������������)
 */
GridTree.prototype._toPage = function(operCode) { 
	var pnum = _$('_pageNum'),mdiv = _$('_msgDiv'),mcel = _$('msgCell'),tb = _$(tc.tableId);
	//����õ�Ӧ��ʾ�ĵ�ǰҳ��.
	this._getCurrentPage(pagingInfo,'_pageNum',operCode);
	var num = pagingInfo.currentPage;	 
	//�����ǰ̨��ҳ
	if(_serverPagingMode == 'client'){		
		pagingInfo.currentPage = num;
		var end = pagingInfo.currentPage * pagingInfo.pageSize > pagingInfo.allCount
				? pagingInfo.allCount
				: pagingInfo.currentPage * pagingInfo.pageSize;
		GridTree.prototype._showTable(document
						.getElementById(tc.tableId),
				(pagingInfo.currentPage - 1) * pagingInfo.pageSize, end);
		mcel.innerHTML = ["��ǰ��",pagingInfo.currentPage , "ҳ/�ܹ�" , pagingInfo.pagesCount , "ҳ"].join('');
		/** ****** ���Ƿ�������չ��ȫ�� ********* */
		if (tc.expandAll) {
			GridTree.prototype.expandAll();
		}
		pnum.value = '';
		// ��������ͼƬ��ť����ʽ
		this._resetBasePageBtns();
		// �������õ�˫����ɫ
		if(tc.exchangeColor)
			this._setColor(tb);
	}else{ 
		var param = {idColumn:tc.idColumn,
					analyze:tc.analyzeAtServer,
					parentColumn:tc.parentColumn,
					gtlimit:pagingInfo.pageSize,
					gtpage:pagingInfo.currentPage};	
		GridTree.prototype._showMsg(1);	 
		jQuery.ajax({
			type : "POST",
			url : tc.dataUrl,
			//��ҳ��ʱ�򴫵ݵ���ֻ̨����ʼλ�ú�ÿҳ��С��������.
			data: param,
			async : 1,
			success : function(msg) {
				var o=new Date();
				mdiv.innerText = '���ڻ������...';
				GridTree.prototype._newPagingServerMakeTable(tb,msg); 
				GridTree.prototype._showMsg(0);
				mcel.innerHTML = ["��ǰ��",pagingInfo.currentPage , "ҳ/�ܹ�", pagingInfo.pagesCount , "ҳ"].join('');
				var gotime = new Date()-o;
				GridTree.prototype._wirteDebug('��ҳ��ʾǰ̨����ʱ��:'+gotime);		
				}				
		});	
	}
}

/**
 * ����е��Զ�������
 * @param {������Դ} rowData
 * @param {�ж���} newRow
 */
GridTree.prototype._userSetPros = function(rowData,newRow){
	//���ø�����������Զ������������
	if(tc.hidddenProperties){
		for(var i=0;i<tc.hidddenProperties.length;i++){
			var proName = tc.hidddenProperties[i];
			newRow.setAttribute(proName, rowData[proName]);
		}
	}
}
/**
 * ����Զ��������չʾ�С�
 * @param {������Դ} rowData
 * @param {�ж���} newRow
 * @param {�����е�λ������} index
 */
GridTree.prototype._addCountCell = function(rowData,newRow,index,level){
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	_parent = _parent == "" ? '-1' : _parent;// ��ֹ���ָ��׽ڵ�Ϊ�յ����
	_parent = '_node'+_parent;	
	// ���������Ҫ�Զ���ʾÿ�е�����,��Ҫ��������һ����ʾ����
	if (tc.rowCount) {
		var countCell = document.createElement("td");
		countCell.className = 'countCell';
		var indexNum = 0;
		//ȫ��������ͳһ��������������
		if(tc.rowCountOption+''=='3'){
			if(!tc.lazy)
				indexNum = index;
			else
				indexNum = newRow.getAttribute('rownum');
		}
		else if(tc.rowCountOption+''=='2'){
			//������еĸ��׽ڵ��ڸ��׽ڵ㼯���У�˵�����п϶������ǵڶ����Ľڵ�����ǵ�һ��ġ�
			if (findInArray(parents, _parent) != -1) {
				var brothers = this.seeChildren(_parent);
				// �õ������ڵ������ֵ
				var parentIndex = _idToNumMap.get(_parent);
				indexNum = parentIndex + '.' + (1+findInArray(brothers, '_node' + _id));
				// �������ڵ�����ֵ+���+��ǰ���������ֵ
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			} else {		
				indexNum = 1+findInArray(firstLevelNodes, '_node' + _id);	
				// _node_num��¼���������ڼ����е�����ֵ
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			}
		}
		else{
			//������еĸ��׽ڵ��ڸ��׽ڵ㼯���У�˵�����п϶������ǵڶ����Ľڵ�����ǵ�һ��ġ�
			if (findInArray(parents, _parent) != -1) {
				var brothers = this.seeChildren(_parent);
				// �õ������ڵ������ֵ
				var parentIndex = _idToNumMap.get(_parent);
				indexNum = parentIndex + '.' + (1+findInArray(brothers, '_node' + _id));
				// �������ڵ�����ֵ+���+��ǰ���������ֵ
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			} else {
				indexNum = 1+findInArray(firstLevelNodes, '_node' + _id);	
				//����ǿͻ��˷�ҳ,��Ҫ�ټ�ȥ��ҳ��һ�е�����ֵ.
				if (_serverPagingMode == 'client') {
					indexNum = indexNum-this._getFirstIndexInThisPage();
				}
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			}
		}
		jQuery(countCell).text(indexNum).appendTo(newRow);
	}
}

/**
 * ��ÿһ�����ѡ����С������û�����þͲ�������
 * @param {������Դ} rowData
 * @param {�ж���} newRow
 */
GridTree.prototype._addCheckOptionCell = function(rowData,newRow){
	var _id = rowData[tc.idColumn];
	//���Ƿ�������Ҫ����ǰ�˵�ѡ��ť�Ƿ��������.
	var setOptionDisabled = '';
	if(tc.disableOptionColumn){
		if(rowData[tc.disableOptionColumn]+''=='1'){
				setOptionDisabled = 'disabled';
		}
	}
	
	//�����Ƿ�������Ĭ��Ҫ���ж�ѡ���ѡ�е���������.
	var setChoosedColumn = tc.chooesdOptionColumn;
	var defalutChoose = 0;
	//ֻ���Ƕ�ѡ���ģʽ����ŵõ�Ĭ��ѡ���ֵ����.����ѡҲ���ԣ���
	if(tc.checkOption == 2&& setChoosedColumn!=null){
		defalutChoose = rowData[setChoosedColumn];
		if(defalutChoose+''=='1'){
			defalutChoose = 'checked';
		}else{
			defalutChoose = '';
		}
	}
	
	// ���������ѡ���оͼ�һ����������ѡ��ť,1Ϊ��ѡ��2Ϊ��ѡ
	if (tc.checkOption == '1') {
		var checkCell = document.createElement("td");
		checkCell.className = 'checkCell';
		checkCell.setAttribute('id','_chk'+_id);
		createRadio(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,tc.handleCheck,'','','');
		jQuery(checkCell).appendTo(newRow);
	} else if (tc.checkOption == 2) {
		var checkCell = document.createElement("td");
		checkCell.className = 'checkCell';
		checkCell.setAttribute('id','_chk'+_id);
		//ѡ��ģʽΪ3,A����ѡ���ײ��Զ�ѡ��,B���Ӷ�û��ѡ�������Զ���ѡ��,C����ѡ����ȫ��ѡ��;D����ȡ��,����ȫ����ѡ��.
		if(tc.multiChooseMode==5){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseChildrenNode(this);
						GridTree.prototype._cancleChildrenNode(this);
						GridTree.prototype._chooseParentNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);			
		}else if(tc.multiChooseMode==4){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseChildrenNode(this);
						GridTree.prototype._cancleChildrenNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);
		}
		//ѡ��ģʽΪ3,A����ѡ���ײ��Զ�ѡ��,B���Ӷ�û��ѡ�������Զ���ѡ��,C����ѡ����ȫ��ѡ��.
		else if(tc.multiChooseMode==3){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseChildrenNode(this);
						GridTree.prototype._chooseParentNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);
		}
		//ѡ��ģʽΪ2,A����ѡ�����Զ�ѡ��,B���Ӷ�û��ѡ�����Զ���ѡ��,C����ѡ��ͺ����Ƿ�ѡ���޹�.
		else if(tc.multiChooseMode==2){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseParentNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);
		}
		//ѡ��ģʽΪ1.
		else{
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,tc.handleCheck,'','',defalutChoose);
		}
		
		jQuery(checkCell).appendTo(newRow);
	}	
}

/**
 * �Ա������ÿһ������¼�����
 * @param {�ж���} newRow
 */
GridTree.prototype._addOneRowListerners = function(newRow){
	// ����Ϊÿ������Զ�����д����¼�.����������Զ����¼��ķ���,�ͽ�������Ĵ���.
	if (tc.handler) {
		var lenlen = tc.handler.length;
		for (var i = lenlen - 1; i >= 0; i--) {
			GridTree.prototype._addEventToObj(newRow, tc.handler[i]);			
		}
		//�ڵ�һ�ν����¼���ӵ�ʱ��,���û�������¼�ע�ᵽһ���¼��ļ�����.
		//Ȼ�����������Ͽ���û�ж���onclick,onmouse,onmouseover����,���û�ж���Ͳ���Ĭ�ϵ�ʵ��.
		if(!_usHandler.length){
			for (var i = lenlen - 1; i >= 0; i--) {
				for(eventName in tc.handler[i])
					_usHandler.push(eventName);
			}	
			if(findInArray(_usHandler, 'onclick')==-1){
				_usnoclick =1;
			}
			if(findInArray(_usHandler, 'onmouseout')==-1){
				_usnomsout =1;
			}
			if(findInArray(_usHandler, 'onmouseover')==-1){
				_usnomsover =1;
			}
		}
		//���û�û�ж�����ЩĬ�ϵķ���,�Ͳ���Ĭ��ʵ��.
		if (_usnoclick) {
			newRow.onclick = function() {
				if (_$(_lastSelectRowId)) {
					jQuery(_$(_lastSelectRowId)).removeClass("selectlight");
				}
				jQuery(newRow).addClass("selectlight");
				_lastSelectRowId = newRow.id;
			};
		}
		if (_usnomsover) {
			newRow.onmouseout = function() {
				jQuery(newRow).removeClass('highlight')
			};	
		}
		if (_usnomsout) {
			newRow.onmouseover = function() {
				jQuery(newRow).addClass('highlight')
			};
		}
	} else {	
		// ��ӽڵ��������Ƴ�����ʽ
		newRow.onmouseover = function() {
			jQuery(newRow).addClass('highlight')
		};

		newRow.onmouseout = function(s) {
			jQuery(newRow).removeClass('highlight')
		};

		newRow.onclick = function() {
			if (_$(_lastSelectRowId)) {
				jQuery(_$(_lastSelectRowId)).removeClass("selectlight");
			}
			jQuery(newRow).addClass("selectlight");
			_lastSelectRowId = newRow.id;
		};
	}
}

/**
 * У��ajax�����ַ�������û����Ҫ��idColumn,parentColumn����.
 * @param {ajax���ص��ַ���} msg
 * @return true��ʾ���ص�ajax������������ȷ,���򷵻�false
 */
GridTree.prototype._verifyAjaxAns = function(msg){
	eval(" tempData=" + msg);
	var data = tempData.data;
	// ��֤����ı�ʾ�е�ֵ�Ƿ��ڡ�data�������д���
	var columnName = tc['idColumn'];
	if (typeof data[0][columnName] == 'undefined') {
		alert("���õ�����[idColumn]ֵ����,����!");
		return false;
	}
	// ��֤����ĸ����е�ֵ�Ƿ��ڡ������ԡ��д���
	var columnName = tc['parentColumn'];
	if (typeof data[0][columnName] == 'undefined') {
		alert("���õ�����[parentColumn]ֵ����,����!");
		return false;
	}
	return true;
}
/**
 * ��ָ���ڵ�ĺ���
 * nodeid:�ڵ�
 * return:���ӽڵ�id��ɵ�����.����ǰ׺'_node'
 */
GridTree.prototype.seeChildren = function(nodeid)
{
	var ansArr = parentToChildMap.get(nodeid);
	return ansArr;
}

/**
 * �ж�һ���ڵ��ǲ��Ǹ��׽ڵ㣨�Ǹ��׽ڵ�ͷ���'1',���򷵻ء�0���� 
 * rowobj��Ҫ�жϵĽڵ����
 */
GridTree.prototype.isParent = function(rowobj) {
	if(!tc.lazy){
		var nid = '_node'+rowobj[tc.idColumn];
		if (findInArray(parents, nid) != -1) {
			return '1';
		} else
			return '0';
	}else{
		return rowobj[tc.leafColumn];
	}
}

/**
 * ȫ��չ��
 */
GridTree.prototype.expandAll = function() {	
	// �Ҵ�ȫ����û��չ����һ���ڵ�,ȫ�������
	if(!tc.lazy){
		if (document.all) {
			jQuery('#' + tc.tableId + ' tr[_open=false]').each(
					function(i) {
						var nodeId = this.id.replace('_node', '');
						// ����Ҫ������ж�����!���ȥ���Ļ�,������������Ĭ�ϴ�ȫ����ʱ��,�����Զ�չ������������...ԭ���Լ���ϸ��һ�룡��
						if (this._open == 'false')
							jQuery('#img_' + nodeId)[0].fireEvent('onclick');
					});
		} else {
			jQuery('#' + tc.tableId + ' tr[_open=false]').each(
					function(i) {
						var nodeId = this.id.replace('_node', '');
						var evt = document.createEvent("MouseEvents");
						evt.initEvent("click", true, true);
						_$('img_' + nodeId)
								.dispatchEvent(evt);
					});
		}
	}else{
		alert('������ģʽ��ȫ��չ��������.');
	}
}

/**
 * �ر�ȫ���ı�����ڵ�
 */
GridTree.prototype.closeAll = function() {
	// �Ҵ�ȫ����û��չ����һ���ڵ�,ȫ�������
	if(!tc.lazy){
		if (document.all) {
			jQuery('#' + tc.tableId + ' tr[_open=true]').each(
					function(i) {
						var nodeId = this.id.replace('_node', '');
						if (this._open == 'true')
							jQuery('#img_' + nodeId)[0].fireEvent('onclick');
					});
		} else {
			jQuery('#' + tc.tableId + ' tr[_open=true]').each(
					function(i) {
						var nodeId = this.id.replace('_node', '');
						var evt = document.createEvent("MouseEvents");
						evt.initEvent("click", true, true);
						_$('img_' + nodeId)
								.dispatchEvent(evt);
					});
		}
	}else{
		alert('������ģʽ��ȫ���رղ�����.');
	}
}

/**
 * ���ñ�����ı༭״̬.
 * @param {״̬} val(true��ȫ�����û���falseȫ������)
 */
GridTree.prototype.setDisabled = function(val){
	var tabregion = jQuery('.tableRegion');
	//�����true��ȫ������.
	if(val){
		jQuery('input',tabregion).attr('disabled','true');
		jQuery('button',tabregion).attr('disabled','true');
		jQuery('select',tabregion).attr('disabled','true');
	}
	//����ȫ������.������Щ�����˲��������Ե�.
	else{
		if (isIE) {
			jQuery('input',tabregion).each(function(i) {
				if (this.userSetDisabled != 'disabled'){
					jQuery(this).removeAttr('disabled');
				}
			});
			jQuery('button',tabregion).each(function(i) {
				if (this.userSetDisabled != 'disabled') {
					jQuery(this).removeAttr('disabled');
				}
			});
			jQuery('select',tabregion).each(function(i) {
				if (this.userSetDisabled != 'disabled') {
					jQuery(this).removeAttr('disabled');
				}
			});
		} else {
			//�����ڻ���е���������ĩ����Сд��!!����������
			jQuery('input',tabregion).each(function(i) {
				if (this.usersetdisabled != 'disabled') {
					jQuery(this).attr('disabled', false);
				}
			});
			jQuery('button',tabregion).each(function(i) {
				if (this.usersetdisabled != 'disabled') {
					jQuery(this).attr('disabled', false);
				}
			});
			jQuery('select',tabregion).each(function(i) {
				if (this.usersetdisabled != 'disabled') {
					jQuery(this).attr('disabled', false);
				}
			});
			jQuery('input[usersetdisabled=disabled]',tabregion).each(function(i){
				this.disabled = true;
			});
			jQuery('button[usersetdisabled=disabled]',tabregion).each(function(i){
				this.disabled = true;
			});
			jQuery('select[usersetdisabled=disabled]',tabregion).each(function(i){
				this.disabled = true;
			});
		}
	}
}


/**
 * �õ�ָ���Ľڵ�ĸ����ڵ������_node_num��������
 * @param {�ڵ�id} nid
 * return ���ظ��׽ڵ��_node_num�����Լ���
 */
GridTree.prototype.getSelectedRow = function() {
	return _$(_lastSelectRowId);
}

/**
 * ���ݽڵ�id�õ��ж���
 * @param {�ڵ�id,������ǰ׺} nid
 */
GridTree.prototype.getRowObjById = function(nid){
	return _$('_node'+nid);
}

/**
 * �õ�ָ���ڵ�ĸ��׵�·���� nid���ڵ�id �����丸�ף��游һֱ������ڵ��id��ɵ�һ������
 */
GridTree.prototype.getNodePath = function(nid) {
	// ���еĸ���id��ɵļ���
	var allParents = [];
	if(!tc.lazy){
		while (1) {
			var pId;
			pId = childToFatherMap.get(nid);	
			if(pId!=null){
				allParents.push(pId.replace('_node',''));
				if (findInArray(parents, pId) != -1) {
					nid = pId;
				} else {
					break;
				}
			}else{
				break;
			}
		}
		return allParents.reverse();
	}	
}

/**
 * ��ָ���ĸ��׽ڵ�id��������ӽڵ�.   added on 20101211  
 * @param {���׽ڵ�id} parentId
 * @param {���ӽڵ��json������} jsonStr
 */
GridTree.prototype.appendChild = function(parentId,jsonStr)
{
	 if(!tc.lazy){
	 	this._wirteError('ֻ��������ģʽ����ɶ�̬����ӽڵ㣡');
	 	return false;
	 }
	 else{
 		var parentNode = _$('_node'+parentId); 
 		var img = _$('img_'+parentId);
 		GridTree.prototype.dynamicAdd(parentId,parentNode,img,jsonStr);
	 }
}

/**
 * �����ˢ�·���.
 * @return {Boolean}
 */
GridTree.prototype.reload = function()
{
	if (!tc.dataUrl) {
		this._wirteError('ֻ�ں�̨���������ſ�ʹ��reload������');
		return false;
	}  
	//������ʾ��.
	var flag = this._showMsg(1); 
	if(!flag){
		return false;
	} 
	var mdiv = _$('_msgDiv');
	var mcel = _$('msgCell');
	var param = {
		idColumn : tc.idColumn,
		analyze : tc.analyzeAtServer,
		parentColumn : tc.parentColumn,
		gtlimit : tc.pageSize,
		lazy : tc.lazy
	}; 
	this._wirteDebug('��ʼ���¼������ݣ���'); 
	jQuery.ajax({
				type : "POST",
				url : tc.dataUrl,
				async : true,
				data : param,
				success : function(msg) {
					var tb = _$(tc.tableId);
					var o = new Date();
					mdiv.innerText = '�������¼��ر����...';
					GridTree.prototype._newPagingServerMakeTable(tb, msg);
					GridTree.prototype._showMsg(0);
					mcel.innerHTML = ["��ǰ��", pagingInfo.currentPage, "ҳ/�ܹ�",
							pagingInfo.pagesCount, "ҳ"].join('');
					var gotime = new Date() - o;
					GridTree.prototype._wirteDebug('���¼�����ʾǰ̨����ʱ��:' + gotime);
				}
			});		
}

/**
 * ��̬�����.   added on 20101211  
 * @param {���׽ڵ�id} parentId
 * @param {���׽ڵ�} parentNode
 * @param {����е�ͼ��ڵ�} imgNode
 * @param {���ӽڵ�json����} childNodeStrs
 * @param {�������صĸ���ģʽ�£�����ǰһ���ֵܵ����к�������������} prebotherindex
 */
GridTree.prototype.dynamicAdd = function(parentId,parentNode,imgNode,childNodeStrs,prebotherindex){  
		if(!imgNode){
			this._wirteError('��̬��ӱ���г��ִ���');
			return false;
		} 
		imgNode.onclick = function(ee){
			GridTree.prototype.closeChildrenTable('img_'+parentId,imgNode,ee)
		}; 
        var level = parseInt(parentNode.getAttribute('_node_level'))+1;
        var tableTree = _$(tc.tableId);
        var rownumstr = parentNode.getAttribute('rownum').split('.');
        var startIndex = 1 ; 
        for(var i=0,j=rownumstr.length;i<j;i++){
                startIndex+=parseInt(rownumstr[i]);
        }
        var datas = []; 
        //��������������صķ�ҳ������߲��Ƿֲ���ȡ����,��˵�����ص�json��ֱ�Ӿ���Ҫ���д��������
        if(!(tc.lazyPage||tc.lazyMorePage)){
        	eval('tc.repaintDataInfoDatas = '+childNodeStrs); 
        	datas = tc.repaintDataInfoDatas;
        }
        //�����tc.allDataInfoWithLazyPageInfo�����������ȡ��dataԪ��,����һ�����Ѿ��õ����������.
        else{   
        	//����������ط�ҳ֮��ķ���ִ��,�϶���tc.allDataInfoWithLazyPageInfo�������,��Ϊǰ���Ѿ����������
        	if(tc.allDataInfoWithLazyPageInfo){
        		if(tc.allDataInfoWithLazyPageInfo.data)
        			datas = tc.allDataInfoWithLazyPageInfo.data;
        		else{
        			datas = tc.allDataInfoWithLazyPageInfo;
        		}
        	}
        	//�����ֱ��ʹ�õĶ�̬���json���鵽�ӽڵ���,��ʹ������ķ���.
        	else{
        		//����һ����ʾ������ʹ�õ��û��Զ����ַ������ж�̬��ӵ�!
        		tc._dynamicAddByUse = 1; 
        		eval('tc.repaintDataInfoDatas = '+childNodeStrs); 
        		datas = tc.repaintDataInfoDatas;
        		
        	}
        }         
        //modified on 20101212
        var temp  = document.createDocumentFragment(); 
        for(var i=0;i<=datas.length-1;i++){ 
                //������������:����һ��_nth��־��ǰ�ǵڼ�������     
    			if(!prebotherindex){
    				prebotherindex=0;
    			} 
    			var newRow= GridTree.prototype._addOneLazyRowByData(startIndex,datas[i],level,i+1+prebotherindex*1);  
                //����������ط�ҳģʽ�����������һ�в��Ҳ����û��Զ����ַ������ж�̬��ӣ���Ҫ׼�����һ�������ͼ��,����һ��������������ڷ�ҳ��
                if (tc.lazyPage && (i == datas.length - 1)&&!tc._dynamicAddByUse) {
					newRow.setAttribute('_lazy_paging_pId', parentId);
					jQuery('td[_td_pro]:eq(0) img:eq(' + (level - 2) + ')', newRow)
					.attr('src', tc.morePageImg).mouseover(function() {
						jQuery(this).attr({ 
									'id' : '_lazypagingimg_' + parentId
								});
						GridTree.prototype._createLazyPagingDiv(parentId); 
						GridTree.prototype._showLazyPagingDiv(parentId,
								this.id, true,1);  
						// ��ֹ�¼�ð��.
						isIE ? stopBubble() : stopBubble(e);
					});
				}
				//��������������صĸ������ʾ���ͽ�����������⴦��ͼ��Ĵ���ʽ��һ�����ҵ����һ����ӵ��ж�����д���
				else if (tc.lazyMorePage && (i == datas.length - 1)&&!tc._dynamicAddByUse) {
					//���Ƴ������Ѿ����ڵģ�_lazy_paging_pId=parentId���ж����е�_lazy_paging_pId���ԣ���Ϊ����Ҫ����µ������һ��
					jQuery('tr[_lazy_paging_pId='+parentId+']:last img:eq(' + (level - 2) + ')').attr('src', tc.blankImg);  
					jQuery('tr[_lazy_paging_pId='+parentId+']').removeAttr('_lazy_paging_pId');  
					jQuery('#_lazypagingimg_'+parentId).removeAttr('id').unbind('mouseover').unbind('click').unbind('mouseout');
					//���濪ʼ�������һ�е�����ͼ����ʾ���¼���.
					newRow.setAttribute('_lazy_paging_pId', parentId);  
					var lazypaging_info = _lazypgInfoMap.get(parentId);
					if (lazypaging_info.currentPage * lazypaging_info.pageSize < lazypaging_info.allCount) 
					jQuery('td[_td_pro]:eq(0) img:eq(' + (level - 2) + ')', newRow)
					.attr({'src': tc.morePageImg,'title':'����鿴����'}).css('cursor','pointer').mouseover(function() {
						jQuery(this).attr({ 
									'id' : '_lazypagingimg_' + parentId
								});  
						GridTree.prototype._createMoreLazyPagingDiv(parentId); 
						GridTree.prototype._showLazyPagingDiv(parentId,
								this.id, true,2);  
						// ��ֹ�¼�ð��.
						isIE ? stopBubble() : stopBubble(e);
					}).mouseout(function(){
						jQuery('[id^=_lazyPagingDiv_]').hide();
					}).click(function(){
						GridTree.prototype._toLazyPage(parentId,'_morepage');
						jQuery('[id^=_lazyPagingDiv_]').hide();
					});
				}
                temp.appendChild(newRow);
                startIndex++;
        }  
        //����������ط�ҳģʽ�������������صĸ�����ʾģʽ�µĶ�̬��ӷ�ʽ
        if(tc.lazyPage||(tc.lazyMorePage&&tc._dynamicAddByUse)){
        	jQuery(parentNode).after(temp).attr('_expaned','true'); 
        } //����˵���������صĸ�����ʾģʽ�µķǶ�̬��ӷ�ʽ
        else{   
        	//����Ѿ����ӽڵ��ˣ�˵���������صĸ���ģʽ�������Ӻ����ڵ�
        	if(jQuery('tr[_node_parent=_node'+parentId+']').size()>0){
        		jQuery('tr[_node_parent=_node'+parentId+']:last').after(temp);
        	}
        	//�����˵���ǵ�һ������ӽڵ�
        	else
        		jQuery(parentNode).after(temp).attr('_expaned','true');
        }
        imgNode.src = tc.closeImg;        
        if(tc.exchangeColor)
				this._setColor(_$(tc.tableId));
				
		//ʹ��������֮��,�������������������,��ֹ�������ط�ʹ��.
		tc.repaintDataInfoDatas = null;
		tc.allDataInfoWithLazyPageInfo = null;
		tc._dynamicAddByUse =null;

}
 
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
 * ���һ��ͼ��,�����ӽڵ�
 */
GridTree.prototype.openChildrenTable = function(imgid,node,e)
{ 
	var _id = imgid.replace('img_','').replace('_node',''); 
	var img = _$('img_'+_id); 
	if(!tc.lazy){
		img.onclick = function(ee){
			GridTree.prototype.closeChildrenTable(imgid,node,ee)
		};
		//������������ؾͼ������ӽڵ��е��ļ���
		jQuery('tr[_node_parent=_node'+_id+']').each(function(i){
			if(this.getAttribute('_node_isparent')=='1')
			{
				GridTree.prototype.openChildrenTable(this.id,this,e);
			}
			jQuery(this).show();			
		});
		_$('_node'+_id)._open = 'true';
		jQuery('tr[_node_parent=_node'+_id+']').show();
		img.src = tc.closeImg;	
		if(tc.exchangeColor)
			this._setColor(_$(tc.tableId));
		isIE?stopBubble():stopBubble(e); 
	}
	//�����������ģʽ,��Ҫ���ݵ�ǰ�ڵ��id����̨��ѯ�ӽڵ�ļ���,��������װ������
	else{  
		//��ֹ���ֵ������ظ��ύ��̨�ķ���.
		if(img.src.indexOf(tc.lazyLoadImg) == -1){
			img.src = tc.lazyLoadImg;	
		}else{
			return false; 
		}
		var param = {pId:_id};		
		var parentNode = _$('_node'+_id);  
		//�����ǰ���ڵ�û�б��򿪹�,��Ҫ����̨��ѯ�ӽڵ�
		//Ҫ��������������ط�ҳ�Ĵ���  modified on 20101212  notready
		if (parentNode.getAttribute('_open') != 'true'
				&& parentNode.getAttribute('_expaned') != 'true') { 
			//���Ҫ���������ط�ҳ����׼�����������ط�ҳ����ʼ�к���ֹ��.
			if(tc.lazyPage||tc.lazyMorePage){ 
				//���Ҫ���������صķ�ҳ,�Ͷഫ��һ��������ʾҪ���з�ҳ����
				param = {pId:_id,page:true,gtlimit:tc.lazyPageSize,analyze:tc.analyzeAtServer};	
			}   
			jQuery.ajax({
				type : "POST",
				url : tc.lazyLoadUrl,
				async : true,
				data:param,
				success : function(msg) {
					if (msg != null && msg != "") { 
						try {
							var o=new Date();
							//���������ط�ҳ�Ĵ���
							if(tc.lazyPage||tc.lazyMorePage){
								GridTree.prototype._initLazyPageInfo(_id,'���׽ڵ�id',msg);  
								GridTree.prototype.dynamicAdd(_id,parentNode,img,msg); 
							}
							//��ͨ����������ʾ����ʽ
							else{ 
								GridTree.prototype.dynamicAdd(_id,parentNode,img,msg);
							} 
							var gotime = new Date()-o;
							GridTree.prototype._wirteDebug('��������ʾǰ̨����ʱ��:'+gotime);	
							if(tc.onLazyLoadSuccess)	
								tc.onLazyLoadSuccess(elct); 
						} catch (ee) {
							GridTree.prototype
									._makeTableWithNoData(tableTree);
						}
					} else {
						elct.innerHTML = "û������.";
					}
				}
			});		
		}else{
			jQuery('tr[_node_parent=_node'+_id+']').show();
			if(tc.exchangeColor)
				this._setColor(_$(tc.tableId));
			img.onclick = function(ee){
				GridTree.prototype.closeChildrenTable('img_'+_id,img,ee)
			};
			img.src = tc.closeImg;	
			isIE?stopBubble():stopBubble(e); 
		}
	}	
}

/**
 * ���һ��ͼ��,�ر����ӽڵ�
 * @param {ͼ��id} imgid
 * @param {} node
 */
GridTree.prototype.closeChildrenTable = function(imgid,node,e)
{
	var _id = imgid.replace('img_','').replace('_node','');
	var img = _$('img_'+_id);
	img.src = tc.openImg;
	img.onclick = function(ee){
			GridTree.prototype.openChildrenTable(imgid,node,ee)
	};
	_$('_node'+_id)._open = 'false'; 
	//�ҵ����׽ڵ��ǵ�ǰ�ڵ�Ķ���,����Ϊ���ɼ�.������Щ�ڵ���������ӽڵ�Ҳ�ݹ���е���.
	jQuery('tr[_node_parent=_node'+_id+']').each(function(i){
		if(this.getAttribute('_node_isparent')=='1')
		{
			GridTree.prototype.closeChildrenTable(this.id,this,e);
		}
		this.style.display = 'none';
	});
	if(tc.exchangeColor)
		this._setColor(_$(tc.tableId));
	isIE?stopBubble():stopBubble(e); 
}

/**
 * ѡ�����ڵ�.
 * @param {�ڵ�id,������ǰ׺} nodeId
 */
GridTree.prototype.select = function(nodeId)
{
	var obj = jQuery('input[name=_chks][value='+nodeId+']')[0];
	if(isIE){
		if(_notBindDisabled(obj))
		{
			jQuery(obj).attr('checked','true');	
		}		 
	}else{
		if (obj.getAttribute('userSetDisabled') == null
				|| obj.getAttribute('userSetDisabled') != 'disabled') {
			jQuery(obj).attr('checked', 'true');
		}		 
	}
	isIE?stopBubble():stopBubble(window.Event); 
}

/**
 * ʵ���������
 * @param {} ary
 * @return {}
 */
function toArray(ary) {
	var result = new Array(ary.length);
	for (var i = 0; i < ary.length; i++) {
		result[i] = ary[i]
	}
	return result;
}

/**
 * ����bind����Ϊfunction�Զ����ٶ���Զ���Ĳ����������µĺ������������¼��İ󶨷����д��ݲ�����������
 * @return {}
 */
Function.prototype.bind = function() {
	var args = toArray(arguments);
	var owner = args.shift();
	var _this = this;
	return function(owner) {
		return _this.apply(owner, args.concat(toArray(arguments)));
	}
}

/**
 * ��json��map����ת��Ϊ�����е�hashMap����
 * @param {json��map����} jsonMap
 */
function jsonMapToJsHashMap(jsonMap){
	var mapObj = new HashMap();
	for(var obj in jsonMap){
		mapObj.put(obj,jsonMap[obj]);
	}
	return mapObj;
}


/**
 * ��һ�������м�ȥ����һ������ arr1:����1 arr2:����2 ����:arr1 - arr2��������
 */
function removeArrayFromOtherArray(arr1, arr2) {
	var tempArr = [];
	var bingo = [];
	var len1 = arr2.length;
	for (var ii = 0; ii < len1; ii++) {
		bingo.push(findInArray(arr1, arr2[ii]));
	}
	var len2 = arr1.length;
	for (var ii = 0; ii < len2; ii++) {
		if (findInArray(bingo, ii) == -1) {
			tempArr.push(arr1[ii]);
		}
	}
	return tempArr;
}

/**
 * ��һ����������ָ����Ԫ�� 
 * arr:������� 
 * obj:Ҫ���ҵĶ���
 * ����ֵ:����ҵ��ͷ��������е�λ��(��0��ʼ),����ͷ���-1
 */
function findInArray(arr, obj) {
	var ans = -1;
	var len = arr.length;
	for (var i = 0; i < len; i++) {		
		if(arr[i]==obj){
			ans = i;
			return ans;
		}
	}
	return -1;
}


/**
 * ���ƶ����ѡ��ť��ѡ��״̬
 * checkName:��ѡ��ť��name
 * v:���õ�ֵ
 */
function _checkedAll(checkName,v)
{
	var objs = document.getElementsByName(checkName);	
	var len = objs.length;
	if(isIE){
		for(var i=0;i<len;i++)
		{
			//�ų���Щ�ж������Ƿ��̨ѡ��Ľڵ�.
			if(objs[i].userSetDisabled==null||objs[i].userSetDisabled!='disabled')
				objs[i].checked = v;
			
		}
	} else {
		for (var i = 0; i < len; i++) {
			// �ų���Щ�ж������Ƿ��̨ѡ��Ľڵ�.
			if (objs[i].getAttribute('userSetDisabled') == null
					|| objs[i].getAttribute('userSetDisabled') != 'disabled')
				objs[i].checked = v;

		}
	}
}

/**
 * �ж�һ��Ԫ���Ƿ��Զ�����Ϊ������.
 * ���û��userSetDisabled���Ի����������Ϊdisabled.�ͷ���true,
 * ���򷵻�false.
 * @param {Ԫ�ض���} o
 */
function _notBindDisabled(o){
	return jQuery(o).attr('userSetDisabled')!='disabled';
}

/**
 * ����ָ��Ԫ�ز����û��߿���
 * obj:Ԫ��
 * val:������(1)���߿���(0)
 */
function disableDom(obj,val)
{
	if(obj)
		obj.disabled = val;
}

/**
 * ����ָ��name��Ԫ���Ƿ����
 * @param {name����} domName
 * @param {������(1)���߿���(0)} val
 */
function disableDomByName(domName,val)
{
	jQuery('[name='+domName+']').each(function(){
		if(jQuery(this).attr('userSetDisabled')!='disabled'){
			jQuery(this).attr('disabled',val);
		}
	});	
}


/**
 * ��ֹjs�¼���ð��
 */
function stopBubble(e){ 
	 //һ��������������¼��� 
     if(!isIE){ 
     	e.preventDefault();
     	e.stopPropagation();
     }else{ 
         //IEȡ��ð���¼� 
         window.event.cancelBubble = true; 
     } 
 }
 
/**
 * �õ�ѡ���id�е�id
 */
function getAllCheckValue(){
	var ans = '';
	jQuery('[name=_chks]:checked').each(function(){
			ans += this.value+',';
	});
	return ans.substring(0,ans.length-1); 
}

/**
 * ��̬����һ��radio�ķ���
 * @param {�������ϼ�domԪ��} el
 * @param {�Ƿ����} dis
 * @param {��ʽ�ı�} sty
 * @param {��������} name
 * @param {ֵ����} val
 * @param {�����¼�} click
 * @param {innerTextֵ} innertext
 * @param {��ʽ��} cssname
 * @param {�Ƿ�Ĭ��ѡ��} chk
 */
function createRadio(el,dis,sty,name,v,click,t,cssname,chk){
	jQuery(el).append(jQuery("<input type='radio' name='"+name+"'>")
	.attr({'style':sty,'userSetDisabled':dis,'value':v,'disabled':dis,'checked':chk})
	.addClass(cssname).click(click)).append(t);	
}

/**
 * ��̬����һ����ѡ��ť
 * @param {�������ϼ�domԪ��} el
 * @param {�Ƿ����} dis
 * @param {��ʽ�ı�} sty
 * @param {��������} name
 * @param {ֵ����} val
 * @param {�����¼�} click
 * @param {innerTextֵ} innertext
 * @param {��ʽ��} cssname
 * @param {�Ƿ�Ĭ��ѡ��} chk
 */
function createCheckbox(el,dis,sty,name,val,click,innertext,cssname,chk){
	jQuery(el).append(jQuery("<input type='checkbox' name='"+name+"'>")
	.attr({'style':sty,'userSetDisabled':dis,'value':val,'disabled':dis,'checked':chk})
	.addClass(cssname).click(click)).append(innertext);	
}

/**
 * ��̬����hidden��
 * @param {idֵ} id
 * @param {����ֵ} name
 * @param {val����} val
 * @return {}
 */
function createHidden(id,name,val){
	return jQuery('<input type="hidden" name="'+name+'">').attr({'id':id,"value":val})[0];
}
/**
 * ����һ��ImgԪ��
 * @param {ͼƬ��Դ} imgsrc
 */
function createImg(imgsrc)
{
	var node = document.createElement('img');
	node.setAttribute('src',imgsrc);
	return node;
}

/**
 * �õ�ָ����Ԫ��id��Ӧ�Ľڵ�.
 * @param {} id
 */
function _$(id){
	return document.getElementById(id);
}

Function.prototype.attachAfter = function(closure,functionOwner) {
	var _this = this;
	return function() {
		this.apply(functionOwner,arguments);
		closure();
	}
}
function attachEvent (obj , eventName,handler) {
	obj[eventName]=(obj[eventName]||function(){}).attachAfter(handler,obj);
}