
jQuery.noConflict(); 
/**
 * 构造函数里面定义一些常用的表格树的内部变量.
 */
function GridTree() {

}

/**
 * 初始化用来分析表格的一些参数的值.
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
	//最外层普通分页栏信息对象
	pagingInfo = {}; 
	//将多个懒加载分页的信息保存在一个map中
	_lazypgInfoMap = new HashMap();
	_usnoclick=0,_usnomsover=0,_usnomsout=0;
	if(document.all){
		isIE = true;
	}else{
		isIE = false;
	}
	//用来记录懒加载分页时的div的四个顶点的位置.
	lazypagex= 0,lazypagey= 0,lazypagex2= 0,lazypagey2 = 0;
	//懒加载分页栏表格的模板字符串
	lzpagetabletemp=['<table cellspacing=0 cellpadding=0  class="lazyPageTable"><tr><td>',
			'<button class=" lazypagebarbtn firstPage" onclick="GridTree.prototype._toLazyPage(\'$\', \'first\')" id="_fstbtn_$" title="第一页"/></td>',
			'<td><button class=" lazypagebarbtn prevPage" onclick="GridTree.prototype._toLazyPage(\'$\',\'pre\')" title="前一页" id="_prebtn_$"/></td>',
			'<td><button class=" lazypagebarbtn nextPage" id="_nxtbtn_$"  onclick="GridTree.prototype._toLazyPage(\'$\',\'next\')" title="后一页"/></td>' ,
			'<td><button class=" lazypagebarbtn lastPage" onclick="GridTree.prototype._toLazyPage(\'$\',\'last\')"  id="_lstbtn_$" title="最后一页"/></td>' ,
			'<td class="splitbar"><td  class="lazyPagingMsg" >总共<span id="_lazy_page_count_$" class="lazyPagingNum">',
			'</span>条 当前显示第<span id="_lazy_page_currentpage_$"	class="lazyPagingNum"></span>页</td></table>'].join('');
	//多层次懒加载的模板字符串
	lzmorepagetemp=['<table cellspacing=0 cellpadding=0  class="lazyPageTable"><tr>',
			'<td  class="lazyPagingMsg2" >当前层次总共<span id="_lazy_page_count_$" class="lazyPagingNum">',
			'</span>条 当前显示第<span class="lazyPagingNum">1</span> - <span id="_lazy_page_currentpage_$"	class="lazyPagingNum"></span>条</td></table>'].join('');	
	_errortemp = '表格树出现错误,请仔细检查!<br><br>错误信息:<br><font color="red">$</font>';	
}


/**
 * 初始化表格
 */
GridTree.prototype.loadData = function(obj) {
	this._initData();
	tc = jQuery.extend({
			columnModel :{},//列的渲染方式,必填
			idColumn:null,//‘标示列属性’不可少
			parentColumn:null,//‘父级列属性’不可少
			tableId:null,//‘表格id属性’不可少	
			el:null,//‘渲染div的id’属性不可少		
			exchangeColor:true,//单双行交替显示颜色
			closeImg : './images/minus.gif',//父级节点的关闭图标
			openImg : './images/plus.gif',//父级节点的打开图标
			lazyLoadImg : './images/plus2.gif',//懒加载时显示的图标
			blankImg : './images/blank.gif',//空白节点
			noparentImg : './images/leaf.gif',//树叶节点的图标
			morePageImg : './images/morePage.gif',//多层次分页的图标  added on 20101212 
			pageBarId : 'pageBarTable',//默认的分页栏表格对象的id为'pageBarTable'
			pageSize : 10,//默认翻页的每页显示10行 
			pageBar : false,//是否进行分页
			lazyPage :false,//懒加载多层次进行分页处理 added on 20101212
			lazyMorePage :false,//用于懒加载继续显示下一页页数的设置 added on 20110105
			lazyPageSize :10,//默认的懒加载的每页显示10行  added on 20110102
			styleOption : '1',//可选为1,2,1是默认的ectable样式,2为ext的样式
			rowCount : false,//是否要自动显示行号
			countColumnDesc : '序列',//显示行号的话,标题名默认为'序列'
			pageAtServer : true,//是否接受后台数据
			analyzeAtServer : false,//如果是有后台代码,是否在后台进行分析.true和false情况下json串形式不同!
			checkColumnDesc : '请选择',//默认的选择列名为'请选择'
			dataUrl:null,//后台取数据的请求地址				
			showMenu:true,//是否出现右键菜单(未实现)
			contextMenu:null,//右键菜单要显示的数据,(未实现)
			disabled:false,//默认表格中的input都是可用状态.
			debug:false,//是否出现调试信息
			height:'10px',//表格树的高度,是自动适应的.
			width:'100%',//表格树的宽带
			checkOption : 'radio',//选择框的形式,radio(单选)或者mult(多选)
			hidddenProperties:null,//用于隐藏在一行中的属性,适合传递值的一种方式.
			handleCheck:null,//如果有选择按钮,可以设置选择按钮的单击事件,是一个function
			data:null,//静态传递数据,是一个数组即可
			lazy:false,//是否采用懒加载树的方式
			lazyLoadUrl:null,//如果是懒加载模式必须要输入一个字符串表示查询子节点.
			handler:null,//设置表格的行事件,是一个数组类型,例如['onclick':function(){},'onmouseover':function(){}]
			leafColumn:null,//表示是否树节点的属性
			rowCountOption:1,//如果要计算行数,选择计数的方式,有1,2,3种
			expandAll:false,//是否默认展开全部的节点
			allCheck:true,//如果是多选的表格树,默认出现全选按钮
			disableOptionColumn:null,//设置一个属性表示根据此数据列设置选择按钮是否默认可用,类型是字符串
			onSuccess:null,//设置回调函数,表格树完成时执行
			onPagingSuccess:null,//设置翻页完毕的回调函数
			onLazyLoadSuccess:null,//设置懒加载完毕执行的回调函数
			chooesdOptionColumn:null,//设置一个属性表示根据此数据列设置选择按钮是否默认选择,类型是字符串
			multiChooseMode:1//如果是多选框形式,设置选择的模式,有1,2,3,4,5种			
		  }, obj);
	elct = _$(tc.el);
	headColumns = [];
	_isValid = true;	
	_errorInfo = '';
	//如果设置了是调试模式.
	if(tc.debug){
		this._createDebugDiv();
	} 
	if (tc.lazy && tc.lazyPage && tc.lazyMorePage) {
		_errorInfo ='懒加载模式下不可以同时设置[lazyPage=true]和[lazyMorePage=true]!';
		_isValid  = false;
		return false;
	}
	if(tc.pageBar==null||tc.pageBar==false){
		//表示不分页
		tc.pageSize = -1;
	}
	
	//默认的样式为ectable样式
	if (tc.styleOption == null||(tc.styleOption+'')!='2') {
		_style = 2;
		importcss("GridTree2.css");
	}else{
		_style = tc.styleOption;
		importcss("GridTree.css");
	}	
	// 下面强制设置所有的分析都是在前台进行,这样相当于废除了这个analyzeAtServer属性!!
	// 因为设置这个之后形成的json串简单多了,便于代码编写.
	tc.analyzeAtServer = false;
	//只要设置了dataUrl属性就为后台分页模式.不要再设置pageAtServer属性了...
	if(tc.dataUrl != null){		
		_serverPagingMode = 'analyzeAtPage';
		if(tc.lazy) {
			//如果是懒加载模式,默认就使用后台数据在前台进行分析,这样的json比较简单.
			tc.analyzeAtServer = false;
			//如果是懒加载模式,强制使用第3中添加序列号的方式,简单省事.
			tc.rowCountOption = '3';
			//并且强制使用简单的选择模式.
			tc.multiChooseMode = 1;
			//如果是懒加载模式,不可以使用'展开全部'属性
			tc.expandAll = false;
			if(!tc.lazyLoadUrl){
				_errorInfo = "懒加载模式,必须配置属性[lazyLoadUrl]!";
				_isValid  = false;
				return ;
			}
			if(!tc.leafColumn){
				_errorInfo = "懒加载模式,必须配置属性[leafColumn ]!";
				_isValid  = false;
				return ;
			}
		}
		//准备一个提示信息,用来在后台分页的时候用到
		this._createMsgDiv();
	}else{
		_serverPagingMode = 'client';
	} 
}


/**
 * 根据数据在指定的div形成表格树
 */
GridTree.prototype.makeTable = function() {
	if (!elct) {  
		this._wirteError('要渲染div不存在!');
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
	/** ********** 根据json数据分析数据,得到父亲节点的集合,以及父亲节点和孩子节点的映射关系. */
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
					elct.innerHTML = "没有数据.";
				}
			}
		});		
	}
	// 如果配置了表格树为不可用状态,就把表格树中的全部文本域等全部设置为不可用.
	if (tc.disabeld) {
		this.setDisabled(true);
	}
}


/**
 * 正式的开始形成表格树内容.
 * tree:树的table的dom对象
 * data:表格树的数据内容
 */
GridTree.prototype._makeTable = function(tree,data)
 {
 	var o=new Date(); 	
 	this._analyseData(data);
	// 进行分页信息的处理
	this._initPageInfo();
	// 添加标题行信息
	this._addTitleHead(tree);
	
	/** ******** 上面分析完毕,下面开始具体的组装树 *************** */
	// 显示全部信息
	if (tc.pageBar != true) {
		if(tc.lazy)
			this._showLazyTable(tree, tc.allDataInfoWithPageInfo.data);
		else 
			this._showTable(tree, 0, firstLevelNodes.length);
	}
	// 分页显示
	else {
		// 如果有多页，就第一次只显示第一页
		if(!tc.lazy){
			if (tc.pageSize > firstLevelNodes.length){
				this._showTable(tree, 0, firstLevelNodes.length);
			}
			// 否则只有一页就显示全部
			else{
				this._showTable(tree, 0, tc.pageSize);
			}
		}else{
			this._showLazyTable(tree, tc.allDataInfoWithPageInfo.data);
		}
		/** ***** 添加分页栏 *************** */
		this._makePageBar(tree, tree.rows.lenght);
	}
	
	elct.innerHTML = ''; 
	elct.appendChild(tree);
	// 设置单双行颜色  modified in 20101212
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
	/** ****** 看是否设置了展开全部 ********* */
	if (tc.expandAll) 	this.expandAll();
	// 重新设置分页按钮的样式
	this._resetBasePageBtns();
	//如果设置了调试模式,可以看到消耗的时间
	var gotime = new Date()-o;
	this._wirteDebug('第一次显示前台消耗时间:'+gotime);
	if(tc.pageSize)
		jQuery('#_changePageSizeSel option[value='+tc.pageSize+']').attr('selected','selected');
	// 如果配置了表格树为不可用状态,就把表格树中的全部文本域等全部设置为不可用.
	if(tc.disabled)  this.setDisabled(1);	
	if(tc.onSuccess)	tc.onSuccess(elct);
}


/**
 * 不分页模式下显示懒加载树.
 * @param {} tableTree 表格对象
 * @param {} data 数据数组
 */
GridTree.prototype._showLazyTable = function(tableTree, data) {
	this._clearContent();	
	var datas = tc.allDataInfoWithPageInfo.data;
	var rowCount = 1;   
	for(var i=0,j=datas.length;i<j;i++){
		// 首先找到要展示的第一层节点,添加到表格（第一层节点）
		var oneObj = datas[i];
		if(typeof oneObj=='string'){
			eval("oneObj="+oneObj);			
		}		
		// 参数分别表示为:表格对象,插入的行数,插入的一行的json数据,树的深度
		var newRow = this._addOneLazyRowByData(rowCount, oneObj, 1);  
		if(jQuery('tbody',tableTree).size()>0)
			jQuery(tableTree).children('tbody').append(newRow); 
		else
			jQuery(tableTree).append(newRow);  
		rowCount = rowCount + 1;
	}
}

/**
 * 不分页模式下的显示表格树
 * @param {} tableTree 表格对象
 * @param {} startParentIndex 起始的父亲节点在一层中的位置
 * @param {} endParentIndex 终止的父亲节点在第一层中的位置
 */
GridTree.prototype._showTable = function(tableTree, startParentIndex, endParentIndex) {
	this._clearContent();		
	// 得到插入表格正文的起始位置,因为是在标题行后面插入,所以起始位置是1
	var rowCount = 1;
	/** *** 添加正文 ********* */
	var lenlen = firstLevelNodes.length;
	// 循环添加每一行的数据
	for (var ind = startParentIndex; ind < endParentIndex
			&& ind < lenlen; ind++) {
		// 首先找到要展示的第一层节点,添加到表格（第一层节点）
		var _parentId = firstLevelNodes[ind];
		var oneObj = nodeMap.get(_parentId);
		if(typeof oneObj=='string'){
			eval("oneObj="+oneObj);			
		}		
		// 参数分别表示为:表格对象,插入的行数,插入的一行的json数据,树的深度
		this._addOneRowByData(tableTree, rowCount, oneObj, 1);
		// 将行数增加1
		rowCount = rowCount + 1;
		// 参数分别表示:父亲节点,孩子所在的树的深度
		addChildByParentNode(oneObj, 2);
	}
	/**
	 * 添加一个父节点的所有孩子到表格中(这是一个内部函数,类似于内部类!)
	 */
	function addChildByParentNode(parentNode, level) {
		var _id = parentNode[tc.idColumn];
		var _parent = parentNode[tc.parentColumn];
		var _isP = GridTree.prototype.isParent(parentNode);
		var _children = parentToChildMap.get('_node'+_id);
		// 第一层节点可能是那种孤立的节点,没有孩子节点
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
				// 如果这个孩子节点同时还有孩子,就继续迭代增加
				if (GridTree.prototype.isParent(oneObj) == '1') {
					// 孩子的孩子的所在树的深度要加1!!
					addChildByParentNode(oneObj, level + 1);
				}
			}
		}
	}	
}

/**
 * 添加事件到指定的obj对象
 * @param {dom对象} obj
 * @param {事件对象} funObj{"事件名":事件处理函数对象}
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
 * 返回选择的行的id 
 * @return {}
 */
GridTree.prototype._getSelectRowId = function(){
	return _lastSelectRowId;
}

/**
 * 根据一个节点id同时选中父亲节点里面的多选框.只针对多选框被选择的时候有效
 * @param {} checkboxDom
 */
GridTree.prototype._chooseParentNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//如果是选择当前的多选框,就同时选中父亲的多选框.
	if(checkboxDom.checked){
		while(1){
			var parentId = _$('_node'+nodeId)._node_parent;
			if(_$(parentId)!=null)
			{
				//得到实际有效的节点id(去掉前缀)
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
 * 选择父亲节点自动把孩子全部选择.只针对多选框被选择的情况
 * @param {多选框对象} checkboxDom
 */
GridTree.prototype._chooseChildrenNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//如果是选择当前的多选框,就同时选中父亲的多选框.
	if(checkboxDom.checked){
		this._chooseAllChildrenNode('_node'+nodeId,true);
	}
}

/**
 * 取消选择父亲节点自动把孩子全部取消只针对多选框被取消选中的情况
 * @param {多选框对象} checkboxDom
 */
GridTree.prototype._cancleChildrenNode = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//如果是选择当前的多选框,就同时选中父亲的多选框.
	if(!checkboxDom.checked){
		this._chooseAllChildrenNode('_node'+nodeId,false);
	}
}

/**
 * 选择父亲节点自动把孩子节点全部选择或者全部取消
 * @param {节点id} nodeId
 * @param {值} v
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
 * 取消当前的多选框,如果其兄弟节点都没有选择,则父亲也变为不选择状态.只针对多选框被取消的时候有效.
 * @param {} checkboxDom
 */
GridTree.prototype._cancelFaher = function(checkboxDom){
	var nodeId = checkboxDom.value;
	//如果取消当前的多选框,如果其兄弟节点都没有选择,则父亲也变为不选择状态
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
 * 判断一个父亲节点的孩子中是否有任意一个被选择.有就返回true,否则孩子都没有选择就返回false.
 * @param {父亲节点的id} parentId
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
 * 删除字符串两端的空格字符串.
 * @param {} str
 * @return {}
 */
function trim(str)
{
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * 根据设置的类型返回指定的input控件。
 * @param {类型的详细描述对象} showTypeDesc
 * @param {一行的数据值} onerow
 * @param {数据列名} dataColumn
 * @param {id值} idValue 
 */
GridTree.prototype._createContent = function(showTypeDesc,onerow,dataColumn,idValue){
	var tp = showTypeDesc.inputtype;
	var cssName = showTypeDesc.style;
	var allvalues = showTypeDesc.values;
	var texts = [];
	var value = onerow[dataColumn];
	//删除两端的空串
	value = trim(value);
	var inputName = showTypeDesc.nameId+idValue;
	var setVisible = showTypeDesc.visibledIndex; 
	var setDisabled = showTypeDesc.disabledIndex; 
	var node = document.createElement("div"); 
	//如果没有配置showTypeDesc.visibledIndex属性,或者配置了这个属性而且对应的数据值为1,就说明要显示这个自定义列.
	if(setVisible==null||onerow[setVisible]+''=='1'){
		//如果配置了showTypeDesc.disabledIndex这个属性而且对应的值是1,就说明要设置这个自定义列不可用状态!
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
			node.innerHTML = '<font color="red">配置表格树的列类型出错.</font>';
		}
	} 
	return node;
}

/**
 * 设置最外层的分页栏.
 */
GridTree.prototype._resetBasePageBtns = function(){
	this._resetPageBtns(pagingInfo,"_firstPageBtn","_prePageBtn","_lastPageBtn","_nextPageBtn");
	//如果没有多页,就没有必要出现自动跳转到指定页的按钮.
	if (pagingInfo.pagesCount == 1||pagingInfo.pagesCount == 0) {
		if(pagingInfo.pagesCount==0){
			jQuery('#_toPageBtn').removeClass("nextPage").addClass("disFirstPage").attr("disabled",true);		
		}
	}
}

/**
 * 重新设置懒加载分页栏的可用状态.
 * @param {标示懒加载分页栏的父亲节点} pid
 */
GridTree.prototype._resetLazyPageBtns = function(pid){
	var ll = _lazypgInfoMap.get(pid); 
	this._resetPageBtns(ll,"_fstbtn_"+pid,"_prebtn_"+pid,"_lstbtn_"+pid,"_nxtbtn_"+pid);
}

/**
 * 根据当前页码重新设置分页按钮的状态.
 * @param {分页依据对象} pageInfo
 * @param {第一页按钮的id} fstBtnId
 * @param {前一页按钮的id} preBtnId
 * @param {最后一页按钮的id} lastBtnId
 * @param {下一页按钮的id} nxtBtnId
 */
GridTree.prototype._resetPageBtns = function(pginfo,fstBtnId,preBtnId,lastBtnId,nxtBtnId){
	var f1t = _$(fstBtnId),pre = _$(preBtnId),lst = _$(lastBtnId),nex = _$(nxtBtnId);
	//如果总页数只有1页，就设置四个分页按钮都为不可用样式
	if (pginfo.pagesCount == 1||pginfo.pagesCount == 0) {
		jQuery(f1t).removeClass("firstPage").addClass("disFirstPage").attr("disabled",true);
		jQuery(pre).removeClass("prevPage").addClass("disPrevPage").attr("disabled",true);
		jQuery(lst).removeClass("lastPage").addClass("disLastPage").attr("disabled",true);
		jQuery(nex).removeClass("nextPage").addClass("disNextPage").attr("disabled",true);		
	} else {
		//如果是第一页，就设置前一页和第一页按钮为不可用样式
		if (pginfo.currentPage == 1) {		
			jQuery(f1t).removeClass("firstPage").addClass("disFirstPage").attr("disabled",true);
			jQuery(pre).removeClass("prevPage").addClass("disPrevPage").attr("disabled",true);
			jQuery(lst).removeClass("disLastPage").addClass("lastPage").attr("disabled",false);
			jQuery(nex).removeClass("disNextPage").addClass("nextPage").attr("disabled",false);	
		} 
		//如果当前页就是最后一页，设置后一页和最后一页按钮为不可用样式
		else if (pginfo.currentPage == pginfo.pagesCount) {
			jQuery(f1t).removeClass("disFirstPage").addClass("firstPage").attr("disabled",false);
			jQuery(pre).removeClass("disPrevPage").addClass("prevPage").attr("disabled",false);
			jQuery(lst).removeClass("lastPage").addClass("disLastPage").attr("disabled",true);
			jQuery(nex).removeClass("nextPage").addClass("disNextPage").attr("disabled",true);	
		}
		//其他情况就设置四个分页按钮都可以用的样式
		else{
			jQuery(f1t).removeClass("disFirstPage").addClass("firstPage").attr("disabled",false);
			jQuery(pre).removeClass("disPrevPage").addClass("prevPage").attr("disabled",false);
			jQuery(lst).removeClass("disLastPage").addClass("lastPage").attr("disabled",false);
			jQuery(nex).removeClass("disNextPage").addClass("nextPage").attr("disabled",false);	
		}
	}
}
 
/**
 * 对jsp添加样式文件.
 * @param {样式文件地址名} csspath
 */
function importcss(csspath) {
	var scripts = document.getElementsByTagName("link");
	for (var i = 0; i < scripts.length; i++) {
		if (csspath == scripts[i].getAttribute("href")) {
			return;
		}
	}
	// 在ie中.
	if (isIE) 
		document.createStyleSheet(csspath);
	// 在火狐中
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
 * 在没有表格树内容的时候只显示标题行和分页栏信息
 * @param {树的table的dom对象} tree
 */
GridTree.prototype._makeTableWithNoData = function(tree){
	pagingInfo.allCount = 0;
	pagingInfo.pageSize = 0;
	pagingInfo.pagesCount = 0;
	pagingInfo.currentPage = 0;
	this._addTitleHead(tree);
	elct.innerHTML = '';
	// 显示全部信息
	if (tc.pageBar) {
		this._makePageBar(tree, 1);
	}
	elct.appendChild(tree);
	// 重新设置分页按钮的样式
	this._resetBasePageBtns();	
}

/**
 * 创建一个显示调试信息的层
 */
GridTree.prototype._createDebugDiv = function()
{
	var debugDiv = document.createElement("div");
	debugDiv.setAttribute('id','_debugDiv');
	debugDiv.className='debugdiv';
	document.body.appendChild(debugDiv);
}

/**
 * 创建一个div,里面显示的是正在加载的提示信息
 */
GridTree.prototype._createMsgDiv = function(){
	msgDiv = document.createElement("div");
	msgDiv.setAttribute('id','_msgDiv');
	msgDiv.className='msgdiv';
	msgDiv.appendChild(document.createTextNode("正在提交..."));
	document.body.appendChild(msgDiv);
}

/**
 * 出现一个提示信息框,表示正在加载.
 * v:显示还是不显示,true则显示否则不显示
 */
GridTree.prototype._showMsg = function(v)
{
	var divNode = _$("_msgDiv"); 
	var table = _$('_trhead'); 
	if(!divNode){
		this._wirteError('显示提示信息框出错,可能不存在!'); 
		return false;
	}
	if(v){
		divNode.innerText = '正在提交...'; 
		divNode.style.top = table.offsetTop+10;
		divNode.style.left = table.offsetLeft+table.offsetWidth/9*8;
		divNode.style.display = 'inline';	 
	}
	else
		divNode.style.display = 'none';
	return true;
} 
 
/**
 * 显示懒加载的分页栏的div. added on 20101224
 * @param {父亲节点的id} pid
 * @param {点击的图片对象} parentImg
 * @param {是否显示，true则显示} v
 * @param {懒加载的方式，分页1更多2} way
 */
GridTree.prototype._showLazyPagingDiv = function(pid,imgId,v,way)
{
	var lazyPageDiv = _$("_lazyPagingDiv_"+pid);  
	var offset = jQuery('#'+imgId).offset();  
	if(v){ 
		//设置总行数和当前页数
		var lazypaging_info = _lazypgInfoMap.get(pid);
		// 先隐藏已经存在的其他的分页栏div
		// 待优化
		jQuery('[id^=_lazyPagingDiv_]').hide();
		jQuery('#_lazy_page_count_' + pid).text(lazypaging_info.allCount);
		//设置分页栏的四个按钮的可用与不可用状态
		this._resetLazyPageBtns(pid);
		//下面设置分页栏的位置,=1是懒加载
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
 * 创建懒加载分页的div. added on 20101222
 * @param {点击的父节点的id} pid
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
						//如果鼠标位置超出了弹出框的范围,就自动隐藏该弹出的分页框.
						if (mousePos.x < lazypagex || mousePos.y < lazypagey || mousePos.x >= lazypagex2
								|| mousePos.y >= lazypagey2) {
							GridTree.prototype._showLazyPagingDiv(pid, 'null', false);
						}
					}); 
	document.body.appendChild(lazyPagingDiv);   
}

/**
 * 懒加载模式下面更多的div的显示层的设计.
 * @param {父亲id} pid
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
	//设置总行数和当前页数
	var lazypaging_info = _lazypgInfoMap.get(pid);
	jQuery('#_lazy_page_count_'+pid).text(lazypaging_info.allCount);
	jQuery('#_lazy_page_currentpage_'+pid).text(lazypaging_info.currentPage*lazypaging_info.pageSize);
}

/**
 * 得到鼠标的x,y轴坐标位置
 * @param {鼠标事件句柄} ev
 * @return {返回一个对象,例如"{x:1,y:1}"}
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
 * 初始化表格的时候进行分页信息的处理.
 */
GridTree.prototype._initPageInfo = function()
{
	if (_serverPagingMode == 'client') {	
		// 总共的第一层节点数目(可以理解为信息总数)
		pagingInfo.allCount = firstLevelNodes.length;
		// 每页的显示信息条数
		pagingInfo.pageSize = tc.pageSize;
		// 总共的页数
		pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
		// 当前页数(从1开始计数)
		pagingInfo.currentPage = 1;
	}else if (_serverPagingMode == 'analyzeAtPage') {	
		pagingInfo.allCount = tc.allDataInfoWithPageInfo.total;
		pagingInfo.pageSize = tc.pageSize;
		pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
		//后台json传串直接传来当前页数
		pagingInfo.currentPage = tc.allDataInfoWithPageInfo.page;
	} 
	else {
		//已经废除了后台分页模式,所以下面的代码永远不会走! 
		alert("怎么进来了?出现bug了!");
	}
}

/**
 * 根据后台返回的字符串,初始化懒加载分页的分页栏对象.
 * @param {父亲节点id} pid
 * @param {父亲节点名字} pName 
 * @param {json返回的字符串} msg 
 */
GridTree.prototype._initLazyPageInfo = function(pid,pName,msg)
{
	eval("tc.allDataInfoWithLazyPageInfo=" + msg); 
	var lazypgInfo = {};
	// 懒加载的父亲节点id
	lazypgInfo.parentId = pid;
	lazypgInfo.parentName = pName;
	// 总行数
	lazypgInfo.allCount = tc.allDataInfoWithLazyPageInfo.total;
	// 每页的显示信息条数,来自于配置参数
	lazypgInfo.pageSize = tc.lazyPageSize;
	// 总共的页数
	lazypgInfo.pagesCount = Math.ceil(lazypgInfo.allCount
			/ lazypgInfo.pageSize * 1.0);
	// 当前页数(从1开始计数)
	lazypgInfo.currentPage = tc.allDataInfoWithLazyPageInfo.page;  
	//将懒加载分页栏信息保存起来
	_lazypgInfoMap.put(pid,lazypgInfo); 
}

/**
 * 前台分析表格的数据,根据后台传来的json数组进行表格树上下级关系的分析.
 * 最关键的算法函数.
 * @param {表格行对象的数据数组} data
 */
GridTree.prototype._analyseData = function(msg)
{
	var data = [];	
	//如果是后台分析模式,就直接取完参数信息之后进行后续的操作.
	if(_serverPagingMode=='server'){
		//已经废除了后台分页模式,所以下面的代码永远不会走!
		alert("怎么进来了?出现bug了!");
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
	
	//如果不是懒加载模式,就要进行数据的分析,否则不用分析,直接用data数组的json对象进行渲染就可
	if(!tc.lazy){
		var len = data.length;
		for (var i = 0; i < len; i++) {
			var _id = data[i][tc.idColumn];
			var _parent = data[i][tc.parentColumn];
			// 如果在父亲数组中找不到这个父亲，就将父亲节点添加到parents中去。防止了出现父亲节点重复的情况
			if (findInArray(parents, '_node' + _parent) == -1)
				parents.push('_node' + _parent);
			// 如果已经在map中存在了该节点的父亲节点,先取出已经存在的内容,再添加新的id
			if (parentToChildMap.containsKey('_node' + _parent)) {
				var arr = parentToChildMap.get('_node' + _parent);
				arr.push('_node' + _id);
				parentToChildMap.put('_node' + _parent, arr);
			} else {
				var arr = [];
				arr.push('_node' + _id);
				parentToChildMap.put('_node' + _parent, arr);
			}
			// 添加孩子到父亲的映射关系
			childToFatherMap.put('_node' + _id, '_node' + _parent);
			// 添加节点id到节点的映射关系
			nodeMap.put('_node' + _id, data[i]);
		}
		// 定义一个数组,用来存放第一层节点的父级节点...
		firstLevelParentIds = removeArrayFromOtherArray(parents, nodeMap.keys());
		// 得到节点中的父亲节点集合
		parents = removeArrayFromOtherArray(parents, firstLevelParentIds);
		// 下面根据firstLevelParentIds得到要在第一层显示的那些节点的id
		for (var ii = 0; ii < firstLevelParentIds.length; ii++) {
			firstLevelNodes = firstLevelNodes.concat(parentToChildMap
					.get(firstLevelParentIds[ii]));
		}		
	}	
}


/**
 * 写调试信息
 * @param {信息} msg
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
 * 打印错误信息.
 * @param {错误信息} msg
 */
GridTree.prototype._wirteError = function(msg){
	elct.innerHTML = _errortemp.replace(/\$/g, msg);
}

/**
 * 处理后台传来的json字符串进行分页栏的分析等等。
 * @param {表格树的dom对象} tree
 * @param {json数据} msg
 */
GridTree.prototype._newPagingServerMakeTable = function(tree,msg)
{
	this._initData();
	this._analyseData(msg);
	// 重新设置当前页		
	pagingInfo.pageSize = tc.pageSize;//0729
	pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount
				/ pagingInfo.pageSize * 1.0);
	//既然是后台分页模式,那么在一次显示的数据肯定是要把firstLevelNodes的数据全部显示出来!
	//下面第二个参数加1的原因是'前开后开'的区间 
	if(!tc.lazy)
		this._showTable(tree,0, firstLevelNodes.length+1);
	else
		this._showLazyTable(tree,tc.allDataInfoWithPageInfo.data); 
	// 重新设置分页按钮的样式
	this._resetBasePageBtns();
	if(tc.exchangeColor)
		this._setColor(tree);
	elct.appendChild(tree);
	/** ****** 看是否设置了展开全部 ********* */
	if (tc.expandAll) {
		this.expandAll();
	}
	if(tc.onPagingSuccess)	tc.onPagingSuccess(elct);	
}

/**
 * 设置指定的表格树的单双行颜色
 * @param {表格树对象} tableTree
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
 * 添加标题行,放在tHead里面 tableTree:表格对象
 */
GridTree.prototype._addTitleHead = function(tableTree) {
	/** *** 添加表头第一行即标题行 */
	var cms = tc.columnModel;
	var tableHeadRow = tableTree.createTHead();
	var newRow = document.createElement("tr");
	newRow.setAttribute('id', '_trhead');
	// 如果设置了选择按钮，就在标题行添加一个选择的标题列
	if (tc.checkOption == '1' || tc.checkOption == '2') {
		var checkCell = document.createElement("td");
		jQuery(checkCell).attr('id','countCell').width('5%').addClass('tablehead').width('0.1%');
		//如果是多选模式,而且是设置了要有全选的按钮
		if(tc.checkOption=='2'&&tc.allCheck)
		{
			checkCell.innerHTML =  "<input type='checkbox' style='width:20px;border:0px;' id='_checkAll' onclick='GridTree.prototype._chooseAll()'>";
		}
		else{
			jQuery(checkCell).text(tc.checkColumnDesc);
		}
		jQuery(checkCell).appendTo(newRow);
	}
	
	// 如果设置了要自动显示每行的行数,就要添加先添加一列显示行数
	if (tc.rowCount) {
		jQuery("<td>").text(tc.countColumnDesc).attr('id','countCell').width('5%')
			.addClass('tablehead').addClass('countCell').appendTo(newRow);
	}
	
	var i = 0;
	var lenlen = cms.length ;
	// 添加这一行里面的列
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
 * 点击全部选择的按钮
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
 * 得到当前页的第一行的在第一级节点中的位置
 */
GridTree.prototype._getFirstIndexInThisPage = function(){
	var _firstIndex = 0;
	//如果不分页的话,说明当前页的第一个位置肯定就是0了!
	if(tc.pageBar)
		_firstIndex = (pagingInfo.currentPage - 1) * pagingInfo.pageSize;
	return _firstIndex;
}

/**
 * 清除表格树中已有的内容
 */
GridTree.prototype._clearContent = function(){
	jQuery('#' + tc.tableId + ' tr[id]').each(function(i) {
		if (this.id != '_trpagebar' && this.id != '_trhead') {
			jQuery(this).remove();
		}
	});
}

/**
 * 组装翻页栏,放在tFoot里面 tableObj:表格对象 index:翻页栏插入的行数
 */
GridTree.prototype._makePageBar = function(tableObj, index) {
	// 创建分页栏的具体信息,是一个表格
	var pageBar = document.createElement('table');
	pageBar.setAttribute('id', tc.pageBarId); 
	var pageBarTR = pageBar.insertRow(0); 
	// 第一页按钮所在的td
	var firstCell = pageBarTR.insertCell(pageBarTR.cells.length);
	firstCell.setAttribute('id', 'firstPageCell');  
	firstCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'first\')" class="pagebarbtn disFirstPage" title="第一页" id="_firstPageBtn" disabled></button>';
	// 前一页按钮所在的td
	var preCell = pageBarTR.insertCell(pageBarTR.cells.length);
	preCell.setAttribute('id', 'prePageCell'); 
	preCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'pre\')" class="pagebarbtn disPrevPage" title="前一页" id="_prePageBtn" disabled></button>';
	// 后一页按钮所在的td
	var afterCell = pageBarTR.insertCell(pageBarTR.cells.length);
	afterCell.setAttribute('id', 'nextPageCell'); 
	if(pagingInfo.pagesCount==1){
		afterCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'next\')" class="pagebarbtn disNextPage" title="后一页" id="_nextPageBtn"></button>';
	}
	else{
		afterCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'next\')" class="pagebarbtn nextPage" title="后一页" id="_nextPageBtn"></button>';
	}
	// 最后一页按钮所在的td
	var lastCell = pageBarTR.insertCell(pageBarTR.cells.length);
	lastCell.setAttribute('id', 'lastPageCell'); 
	if(pagingInfo.pagesCount==1){
		lastCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'last\')" class="pagebarbtn disLastPage" title="最后一页" id="_lastPageBtn"></button>';
	}
	else{
		lastCell.innerHTML = '<button onclick="GridTree.prototype._toPage(\'last\')" class="pagebarbtn lastPage" title="最后一页" id="_lastPageBtn"></button>';
	}
	// 跳转页数按钮所在的td
	var selectPageCell = pageBarTR.insertCell(pageBarTR.cells.length);
	selectPageCell.setAttribute('id', 'selectPageCell');
	selectPageCell.innerHTML = ['<input type="text" style="width:30px" id="_pageNum" '
			, 'onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46"'
			, 'onpaste="return !clipboardData.getData(\'text\').match(/\D/)">'
			, '<button class="pagebarbtn jumpPage" onclick="GridTree.prototype._toPage(\'any\')" title="跳转" id="_toPageBtn"></button>'].join('');
	// 选择每页行数的下拉菜单
	var selectPagingCell = pageBarTR.insertCell(pageBarTR.cells.length);
	selectPagingCell.innerHTML = '每页<select onchange="GridTree.prototype._reMakeTable(this.value);" id="_changePageSizeSel"><option value="5">5</option><option value="10" selected>10</option><option value="20">20</option><option value="40">40</option><option value="100">100</option></select>条';
	var msgCell = pageBarTR.insertCell(pageBarTR.cells.length);
	// 显示的分页(当前页,总页数)
	msgCell.style.textAlign = 'right';
	msgCell.setAttribute('id', 'msgCell');
	msgCell.innerHTML = ["当前第" , pagingInfo.currentPage , "页/总共"
			, pagingInfo.pagesCount , "页"].join('');
			
	//如果是ext的样式.
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
	//否则就是用ectable的样式
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
 * 根据新的分页行数重新画表格树
 * @param {分页数目} pageSize
 */
GridTree.prototype._reMakeTable = function(pageSize)
{
	if(pagingInfo.pagesCount!=0){
		//如果是使用的客户端分页,很简单就实现了.
		if (_serverPagingMode == 'client') {
			// 每页的行数
			pagingInfo.pageSize = pageSize;
			// 总共的页数
			pagingInfo.pagesCount = Math.ceil(pagingInfo.allCount / pagingInfo.pageSize
					* 1.0);
			// 当前页数(从1开始计数)
			pagingInfo.currentPage = 1;
			_$('msgCell').innerHTML = "当前第" + pagingInfo.currentPage + "页/总共"
					+ pagingInfo.pagesCount + "页";
			this._toPage(1);
			_$(tc.tableId).focus();
		}
		//否则就要走后台.
		else{
			pagingInfo.pageSize = pageSize;//修改:2010-0729
			tc.pageSize = pageSize;
			this._toPage("repaging");
			_$(tc.tableId).focus();
		}
	}
}

/**
 * 根据json数据添加到懒加载树中,这里是添加的第一层节点
 * @param {插入这行的位置} index
 * @param {json数据} rowData
 * @param {树的深度(第一层是1)} level
 * @param {表示当前数据在同级中的位置} nth
 */
GridTree.prototype._addOneLazyRowByData = function(index, rowData, level,nth) {
	var newRow = document.createElement('tr');
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	_parent = _parent == "" ? '-1' : _parent;// 防止出现父亲节点为空的情况
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
	// 如果是父亲节点,就设置一个是否打开的标志
	if (_isP == '1') newRow.setAttribute('_open', 'false'); 
	this._userSetPros(rowData,newRow); 
	this._addCheckOptionCell(rowData,newRow); 
	this._addCountCell(rowData,newRow,index,level); 
	this._addOneLazyRowContent(rowData,newRow,_id,_isP,level); 
	this._addOneRowListerners(newRow); 
	return newRow;
}

/**
 * 根据一个符合要求的json数据添加一行 
 * tableObj:表格对象 
 * index:插入这行的位置 
 * rowData:json数据
 * level:树的深度(第一层是1)
 */
GridTree.prototype._addOneRowByData = function(tableObj, index, rowData, level) {
	// 在已经有的行数之后，添加新的一行
	var newRow = tableObj.insertRow(index);
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	var _isP = this.isParent(rowData);
	
	// 设置该行的id
	newRow.setAttribute('id', '_node'+_id);
	// 设置该行的父亲行id
	_parent = _parent == "" ? '-1' : _parent;// 防止出现父亲节点为空的情况
	_parent = '_node'+_parent;
	newRow.setAttribute('_node_parent', _parent);
	// 如果是第一层的节点，其路径就设置为'-1'，表示是第一层的节点
	if (level == 1) newRow.setAttribute('_node_path', '-1');
	// 否则其路径就设置为从第一层父亲一直往下到当前节点的路径方式
	else {
		newRow.setAttribute('_node_path', this.getNodePath('_node'+_id).join(','));
	}
	newRow.setAttribute('_node_isparent', _isP);
	newRow.setAttribute('_node_level', level);
	
	// 如果是父亲节点,就设置一个是否打开的标志
	if (_isP == '1')
		newRow.setAttribute('_open', 'false');
	//添加隐藏的属性到行对象中
	this._userSetPros(rowData,newRow);
	//为每一行添加选择的列。
	this._addCheckOptionCell(rowData,newRow);	
	//添加自增列
	this._addCountCell(rowData,newRow,index,level);	
	//添加行的具体内容。
	this._addOneRowContent(rowData,newRow,_id,_isP,level);	
	//对每一行添加行的事件处理。
	this._addOneRowListerners(newRow);
}

/**
 * 添加懒加载模式下的一行数据的主要内容.
 * @param {行数据源} rowData
 * @param {行对象} newRow
 * @param {id值} _id
 * @param {是否父亲节点} _isP
 * @param {级别} level
 */
GridTree.prototype._addOneLazyRowContent = function(rowData,newRow,_id,_isP,level){
	// 下面设置一行里面的各个列,显示的顺序是根据在columns里面的先后顺序展示的.
	var i = 0; 
	for (; i < headColumns.length; i++) {
		var newSmallCell = document.createElement("td");
		newSmallCell.setAttribute('_td_pro', headColumns[i]);
		var _t = rowData[headColumns[i]]; 
		// 在第一列进行图标的设置
		if (i == 0) {			
			if (_t != '') {				
				var ct = level - 1;
				var ans = [];
				for(var ii=0;ii<ct;ii++){
					ans.push(['<IMG ','src="',tc.blankImg,'"/>'].join(''));
				}
				// 如果是父亲节点
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
				//如果第一列设置了特殊显示的情况。
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id).firstChild);
				}else{
					newSmallCell.innerHTML += _t;
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
		// 其他列就直接设置内容即可
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
 * 添加行的具体内容
 * @param {行数据源} rowData
 * @param {行对象} newRow
 * @param {id值} _id
 * @param {是否父亲节点} _isP
 * @param {级别} level
 */
GridTree.prototype._addOneRowContent = function(rowData,newRow,_id,_isP,level){
	// 下面设置一行里面的各个列,显示的顺序是根据在columns里面的先后顺序展示的.
	var i = 0;
	for (; i < headColumns.length; i++) {
		var newSmallCell = newRow.insertCell(newRow.cells.length);
		newSmallCell.setAttribute('_td_pro', headColumns[i]); 
		var _t = rowData[headColumns[i]];
		// 在第一列进行图标的设置
		if (i == 0) {			
			if (_t != '') {				
				// 根据树的深度设置缩进的大小
				var ct = level - 1;
				var ans = [];
				for(var ii=0;ii<ct;ii++){
					ans.push(['<IMG ','src="',tc.blankImg,'"/>'].join(''));
				}
				// 如果是父亲节点
				if (_isP == '1') {
					ans.push(["<IMG id='img_"
							, _id, "' style='CURSOR: hand' ",
							"onclick='javascript:GridTree.prototype.openChildrenTable(this.id,this,event);' src='",
							tc.openImg , "'/>" ].join(''));
					// 虽然是父亲节点,但是不在第一层节点中,所以不应该显示出来
					if (findInArray(firstLevelNodes, '_node'+_id) == -1) {
						newRow.style.display = 'none';
					}
				} else {
					// 如果不是第一层节点要显示出来的树叶,就设置为看不见(因为在第一层节点要显示出来的孤立节点必须可见)
					if (findInArray(firstLevelNodes, '_node'+_id) == -1) {
						ans.push(["<IMG id='img_" , _id
								, "' src='" , tc.noparentImg , "'/>"].join(''));
						newRow.style.display = 'none';
					}
					// 对于孤立节点(在第一级的没有父亲也没有孩子的节点)就特殊显示.主要是图标文件显示特殊,并且没有设置为不可见.
					else {
						ans.push(["<IMG id='img_" , _id
								, "' src='" , tc.noparentImg , "'/>" ].join(''));
					}
				}	
				newSmallCell.innerHTML = ans.join('');
				var showTypeDesc = tc.columnModel[i].columntype;
				//如果第一列设置了特殊显示的情况。
				if(showTypeDesc!=null){
						newSmallCell.appendChild(GridTree.prototype._createContent(showTypeDesc,rowData,headColumns[i],_id).firstChild);
				}else{
					newSmallCell.innerHTML += _t;
				}
			} else
				newSmallCell.innerHTML = '&nbsp;';
		}
		// 其他列就直接设置内容即可
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
 * 根据跳转的操作类型得到实际的当前页数.
 * @param {分页栏} pginfo
 * @param {直接输入跳转页码的文本框id} pageNumId
 * @param {操作类型} operCode
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
					alert("输入页码有误或者为空，请重新输入！");
					pnum.focus();
					return;
				}
				pginfo.currentPage = n;
			}else{
				alert('出现bug,跳转页面没有正确处理.');
			}
			break;
	}
}

/**
 * 懒加载的到指定页.
 * @param {懒加载的父亲节点id} pid
 * @param {操作类型} operCode
 */
GridTree.prototype._toLazyPage = function(pid,operCode) {
	var pnum = _$('_pageNum'), mdiv = _$('_msgDiv'), mcel = _$('msgCell'), tb = _$(tc.tableId);
	var lazypaing_info = _lazypgInfoMap.get(pid);
	//如果_morepage说明是懒加载显示更多的时候进入的该方法.
	if(operCode=='_morepage')
		lazypaing_info.currentPage += 1; 
	// 计算得到应显示的当前页数.
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
		// 分页的时候传递到后台只有起始位置和每页大小两个参数.
		data : param,
		async : 1,
		success : function(msg) {  
			var parentNode = _$('_node'+pid); 
			var img = _$('img_'+pid); 
			var o = new Date();
			if(operCode!='_morepage'){
				//删除已经存在的子节点
				GridTree.prototype._removeChildrenTable(pid);
				GridTree.prototype._initLazyPageInfo(pid,'父亲节点id',msg); 
				GridTree.prototype.dynamicAdd(pid,parentNode,img,msg);
			}
			//operCode = _morepage，说明是懒加载的显示更多
			else{ 
				// 得到当前显示出来的前一个兄弟节点的位置索引属性,用于生成后面的子节点的索引
			 	var numstrs = jQuery('[_node_parent=_node' + pid + ']:last').attr('rownum').split('.');
				var lastnum = numstrs[numstrs.length - 1];
				GridTree.prototype
						._initLazyPageInfo(pid, '父亲节点id', msg);
				GridTree.prototype.dynamicAdd(pid, parentNode, img,
						msg, lastnum);
			}
			var gotime = new Date() - o;
			GridTree.prototype._wirteDebug('翻页显示前台消耗时间:' + gotime);
			GridTree.prototype._showMsg(0);
		}
	});	 
} 

/**
 * 移除一个父亲节点下面的全部嵌套子节点.
 * @param {父亲节点id} pid
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
 * 到指定的页
 * @param {页数} num(在后台分页模式的时候,这个参数表示当前页码,如果是前台分页模式,传递的是新的页数)
 * @param {到新页码的操作方式} operCode(在后台分页模式的时候这个参数有用)
 */
GridTree.prototype._toPage = function(operCode) { 
	var pnum = _$('_pageNum'),mdiv = _$('_msgDiv'),mcel = _$('msgCell'),tb = _$(tc.tableId);
	//计算得到应显示的当前页数.
	this._getCurrentPage(pagingInfo,'_pageNum',operCode);
	var num = pagingInfo.currentPage;	 
	//如果是前台分页
	if(_serverPagingMode == 'client'){		
		pagingInfo.currentPage = num;
		var end = pagingInfo.currentPage * pagingInfo.pageSize > pagingInfo.allCount
				? pagingInfo.allCount
				: pagingInfo.currentPage * pagingInfo.pageSize;
		GridTree.prototype._showTable(document
						.getElementById(tc.tableId),
				(pagingInfo.currentPage - 1) * pagingInfo.pageSize, end);
		mcel.innerHTML = ["当前第",pagingInfo.currentPage , "页/总共" , pagingInfo.pagesCount , "页"].join('');
		/** ****** 看是否设置了展开全部 ********* */
		if (tc.expandAll) {
			GridTree.prototype.expandAll();
		}
		pnum.value = '';
		// 重新设置图片按钮的样式
		this._resetBasePageBtns();
		// 重新设置单双行颜色
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
			//分页的时候传递到后台只有起始位置和每页大小两个参数.
			data: param,
			async : 1,
			success : function(msg) {
				var o=new Date();
				mdiv.innerText = '正在画表格树...';
				GridTree.prototype._newPagingServerMakeTable(tb,msg); 
				GridTree.prototype._showMsg(0);
				mcel.innerHTML = ["当前第",pagingInfo.currentPage , "页/总共", pagingInfo.pagesCount , "页"].join('');
				var gotime = new Date()-o;
				GridTree.prototype._wirteDebug('翻页显示前台消耗时间:'+gotime);		
				}				
		});	
	}
}

/**
 * 添加行的自定义属性
 * @param {行数据源} rowData
 * @param {行对象} newRow
 */
GridTree.prototype._userSetPros = function(rowData,newRow){
	//设置该行里面添加自定义的隐藏属性
	if(tc.hidddenProperties){
		for(var i=0;i<tc.hidddenProperties.length;i++){
			var proName = tc.hidddenProperties[i];
			newRow.setAttribute(proName, rowData[proName]);
		}
	}
}
/**
 * 添加自定义的自增展示列。
 * @param {行数据源} rowData
 * @param {行对象} newRow
 * @param {插入行的位置索引} index
 */
GridTree.prototype._addCountCell = function(rowData,newRow,index,level){
	var _id = rowData[tc.idColumn];
	var _parent = rowData[tc.parentColumn];
	_parent = _parent == "" ? '-1' : _parent;// 防止出现父亲节点为空的情况
	_parent = '_node'+_parent;	
	// 如果设置了要自动显示每行的行数,就要添加先添加一列显示行数
	if (tc.rowCount) {
		var countCell = document.createElement("td");
		countCell.className = 'countCell';
		var indexNum = 0;
		//全部的行数统一计数，连续计数
		if(tc.rowCountOption+''=='3'){
			if(!tc.lazy)
				indexNum = index;
			else
				indexNum = newRow.getAttribute('rownum');
		}
		else if(tc.rowCountOption+''=='2'){
			//如果该行的父亲节点在父亲节点集合中，说明该行肯定至少是第二级的节点而不是第一层的。
			if (findInArray(parents, _parent) != -1) {
				var brothers = this.seeChildren(_parent);
				// 得到父级节点的序列值
				var parentIndex = _idToNumMap.get(_parent);
				indexNum = parentIndex + '.' + (1+findInArray(brothers, '_node' + _id));
				// 将父级节点序列值+点号+当前级别的序列值
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			} else {		
				indexNum = 1+findInArray(firstLevelNodes, '_node' + _id);	
				// _node_num记录该行在所在级别中的序列值
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			}
		}
		else{
			//如果该行的父亲节点在父亲节点集合中，说明该行肯定至少是第二级的节点而不是第一层的。
			if (findInArray(parents, _parent) != -1) {
				var brothers = this.seeChildren(_parent);
				// 得到父级节点的序列值
				var parentIndex = _idToNumMap.get(_parent);
				indexNum = parentIndex + '.' + (1+findInArray(brothers, '_node' + _id));
				// 将父级节点序列值+点号+当前级别的序列值
				newRow.setAttribute('_node_num', indexNum);
				_idToNumMap.put('_node' + _id, indexNum);
			} else {
				indexNum = 1+findInArray(firstLevelNodes, '_node' + _id);	
				//如果是客户端分页,就要再减去本页第一行的序列值.
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
 * 对每一行添加选择的列。（如果没有设置就不做处理）
 * @param {行数据源} rowData
 * @param {行对象} newRow
 */
GridTree.prototype._addCheckOptionCell = function(rowData,newRow){
	var _id = rowData[tc.idColumn];
	//看是否设置了要求检测前端的选择按钮是否禁用属性.
	var setOptionDisabled = '';
	if(tc.disableOptionColumn){
		if(rowData[tc.disableOptionColumn]+''=='1'){
				setOptionDisabled = 'disabled';
		}
	}
	
	//看看是否设置了默认要进行多选框的选中的列名属性.
	var setChoosedColumn = tc.chooesdOptionColumn;
	var defalutChoose = 0;
	//只在是多选框的模式下面才得到默认选择的值属性.（单选也可以！）
	if(tc.checkOption == 2&& setChoosedColumn!=null){
		defalutChoose = rowData[setChoosedColumn];
		if(defalutChoose+''=='1'){
			defalutChoose = 'checked';
		}else{
			defalutChoose = '';
		}
	}
	
	// 如果设置了选择列就加一列用来放置选择按钮,1为单选，2为多选
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
		//选择模式为3,A孩子选择父亲不自动选择,B孩子都没有选择则父亲自动不选择,C父亲选择孩子全部选择;D父亲取消,孩子全部不选择.
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
		//选择模式为3,A孩子选择父亲不自动选择,B孩子都没有选择则父亲自动不选择,C父亲选择孩子全部选择.
		else if(tc.multiChooseMode==3){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseChildrenNode(this);
						GridTree.prototype._chooseParentNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);
		}
		//选择模式为2,A孩子选择父亲自动选择,B孩子都没有选择父亲自动不选择,C父亲选择和孩子是否选择无关.
		else if(tc.multiChooseMode==2){
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,function(){
						GridTree.prototype._chooseParentNode(this);
						GridTree.prototype._cancelFaher(this);
						if(tc.handleCheck)
							tc.handleCheck();
					},'','',defalutChoose);
		}
		//选择模式为1.
		else{
			createCheckbox(checkCell,setOptionDisabled,'width:20px;border:0px;','_chks',_id,tc.handleCheck,'','',defalutChoose);
		}
		
		jQuery(checkCell).appendTo(newRow);
	}	
}

/**
 * 对表格树的每一行添加事件处理。
 * @param {行对象} newRow
 */
GridTree.prototype._addOneRowListerners = function(newRow){
	// 下面为每行添加自定义的行处理事件.如果定义了自定义事件的方法,就进行下面的处理.
	if (tc.handler) {
		var lenlen = tc.handler.length;
		for (var i = lenlen - 1; i >= 0; i--) {
			GridTree.prototype._addEventToObj(newRow, tc.handler[i]);			
		}
		//在第一次进行事件添加的时候,将用户定义的事件注册到一个事件的集合中.
		//然后根据这个集合看有没有定义onclick,onmouse,onmouseover方法,如果没有定义就采用默认的实现.
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
		//看用户没有定义哪些默认的方法,就采用默认实现.
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
		// 添加节点的移入和移除的样式
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
 * 校验ajax返回字符串中有没有需要的idColumn,parentColumn属性.
 * @param {ajax返回的字符串} msg
 * @return true表示返回的ajax数组中属性正确,否则返回false
 */
GridTree.prototype._verifyAjaxAns = function(msg){
	eval(" tempData=" + msg);
	var data = tempData.data;
	// 验证输入的标示列的值是否在‘data’数组中存在
	var columnName = tc['idColumn'];
	if (typeof data[0][columnName] == 'undefined') {
		alert("配置的属性[idColumn]值有误,请检查!");
		return false;
	}
	// 验证输入的父级列的值是否在‘列属性’中存在
	var columnName = tc['parentColumn'];
	if (typeof data[0][columnName] == 'undefined') {
		alert("配置的属性[parentColumn]值有误,请检查!");
		return false;
	}
	return true;
}
/**
 * 看指定节点的孩子
 * nodeid:节点
 * return:孩子节点id组成的数组.含有前缀'_node'
 */
GridTree.prototype.seeChildren = function(nodeid)
{
	var ansArr = parentToChildMap.get(nodeid);
	return ansArr;
}

/**
 * 判断一个节点是不是父亲节点（是父亲节点就返回'1',否则返回‘0’） 
 * rowobj：要判断的节点对象
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
 * 全部展开
 */
GridTree.prototype.expandAll = function() {	
	// 找打全部的没有展开的一级节点,全部点击打开
	if(!tc.lazy){
		if (document.all) {
			jQuery('#' + tc.tableId + ' tr[_open=false]').each(
					function(i) {
						var nodeId = this.id.replace('_node', '');
						// 下面要加这个判断条件!如果去掉的话,发现在设置了默认打开全部的时候,不会自动展开第三级的树...原因自己仔细想一想！！
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
		alert('懒加载模式下全部展开不可用.');
	}
}

/**
 * 关闭全部的表格树节点
 */
GridTree.prototype.closeAll = function() {
	// 找打全部的没有展开的一级节点,全部点击打开
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
		alert('懒加载模式下全部关闭不可用.');
	}
}

/**
 * 设置表格树的编辑状态.
 * @param {状态} val(true则全部禁用或者false全部启用)
 */
GridTree.prototype.setDisabled = function(val){
	var tabregion = jQuery('.tableRegion');
	//如果是true就全部禁用.
	if(val){
		jQuery('input',tabregion).attr('disabled','true');
		jQuery('button',tabregion).attr('disabled','true');
		jQuery('select',tabregion).attr('disabled','true');
	}
	//否则全部启用.除非那些设置了不可用属性的.
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
			//发现在火狐中的属性名周末成了小写了!!厉害。。。
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
 * 得到指定的节点的父级节点里面的_node_num属性数组
 * @param {节点id} nid
 * return 返回父亲节点的_node_num的属性集合
 */
GridTree.prototype.getSelectedRow = function() {
	return _$(_lastSelectRowId);
}

/**
 * 根据节点id得到行对象
 * @param {节点id,不含有前缀} nid
 */
GridTree.prototype.getRowObjById = function(nid){
	return _$('_node'+nid);
}

/**
 * 得到指定节点的父亲的路径。 nid：节点id 返回其父亲，祖父一直到顶层节点的id组成的一个数组
 */
GridTree.prototype.getNodePath = function(nid) {
	// 所有的父亲id组成的集合
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
 * 在指定的父亲节点id下面添加子节点.   added on 20101211  
 * @param {父亲节点id} parentId
 * @param {孩子节点的json串数组} jsonStr
 */
GridTree.prototype.appendChild = function(parentId,jsonStr)
{
	 if(!tc.lazy){
	 	this._wirteError('只在懒加载模式下面可动态添加子节点！');
	 	return false;
	 }
	 else{
 		var parentNode = _$('_node'+parentId); 
 		var img = _$('img_'+parentId);
 		GridTree.prototype.dynamicAdd(parentId,parentNode,img,jsonStr);
	 }
}

/**
 * 表格树刷新方法.
 * @return {Boolean}
 */
GridTree.prototype.reload = function()
{
	if (!tc.dataUrl) {
		this._wirteError('只在后台表格树下面才可使用reload方法！');
		return false;
	}  
	//出现提示框.
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
	this._wirteDebug('开始重新加载数据！！'); 
	jQuery.ajax({
				type : "POST",
				url : tc.dataUrl,
				async : true,
				data : param,
				success : function(msg) {
					var tb = _$(tc.tableId);
					var o = new Date();
					mdiv.innerText = '正在重新加载表格树...';
					GridTree.prototype._newPagingServerMakeTable(tb, msg);
					GridTree.prototype._showMsg(0);
					mcel.innerHTML = ["当前第", pagingInfo.currentPage, "页/总共",
							pagingInfo.pagesCount, "页"].join('');
					var gotime = new Date() - o;
					GridTree.prototype._wirteDebug('重新加载显示前台消耗时间:' + gotime);
				}
			});		
}

/**
 * 动态添加行.   added on 20101211  
 * @param {父亲节点id} parentId
 * @param {父亲节点} parentNode
 * @param {点击行的图标节点} imgNode
 * @param {孩子节点json数组} childNodeStrs
 * @param {在懒加载的更多模式下，传入前一个兄弟的序列号用于生成序列} prebotherindex
 */
GridTree.prototype.dynamicAdd = function(parentId,parentNode,imgNode,childNodeStrs,prebotherindex){  
		if(!imgNode){
			this._wirteError('动态添加表格行出现错误！');
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
        //如果不进行懒加载的分页处理或者不是分步骤取数据,就说明返回的json串直接就是要进行处理的数据
        if(!(tc.lazyPage||tc.lazyMorePage)){
        	eval('tc.repaintDataInfoDatas = '+childNodeStrs); 
        	datas = tc.repaintDataInfoDatas;
        }
        //否则从tc.allDataInfoWithLazyPageInfo这个对象里面取出data元素,在上一步骤已经得到了这个对象.
        else{   
        	//如果是懒加载分页之后的方法执行,肯定有tc.allDataInfoWithLazyPageInfo这个属性,因为前面已经分析处理过
        	if(tc.allDataInfoWithLazyPageInfo){
        		if(tc.allDataInfoWithLazyPageInfo.data)
        			datas = tc.allDataInfoWithLazyPageInfo.data;
        		else{
        			datas = tc.allDataInfoWithLazyPageInfo;
        		}
        	}
        	//如果是直接使用的动态添加json数组到子节点中,就使用下面的方法.
        	else{
        		//进行一个标示表明是使用的用户自定义字符串进行动态添加的!
        		tc._dynamicAddByUse = 1; 
        		eval('tc.repaintDataInfoDatas = '+childNodeStrs); 
        		datas = tc.repaintDataInfoDatas;
        		
        	}
        }         
        //modified on 20101212
        var temp  = document.createDocumentFragment(); 
        for(var i=0;i<=datas.length-1;i++){ 
                //这里第五个参数:设置一个_nth标志当前是第几个数据     
    			if(!prebotherindex){
    				prebotherindex=0;
    			} 
    			var newRow= GridTree.prototype._addOneLazyRowByData(startIndex,datas[i],level,i+1+prebotherindex*1);  
                //如果是懒加载分页模式，而且是最后一行并且不是用户自定义字符串进行动态添加，就要准备添加一个特殊的图标,而且一个特殊的属性用于分页！
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
						// 禁止事件冒泡.
						isIE ? stopBubble() : stopBubble(e);
					});
				}
				//否则如果是懒加载的更多的显示，就进行下面的特殊处理，图标的处理方式不一样，找到最后一个添加的行对象进行处理
				else if (tc.lazyMorePage && (i == datas.length - 1)&&!tc._dynamicAddByUse) {
					//先移除可能已经存在的（_lazy_paging_pId=parentId）行对象中的_lazy_paging_pId属性，因为马上要添加新的这里的一行
					jQuery('tr[_lazy_paging_pId='+parentId+']:last img:eq(' + (level - 2) + ')').attr('src', tc.blankImg);  
					jQuery('tr[_lazy_paging_pId='+parentId+']').removeAttr('_lazy_paging_pId');  
					jQuery('#_lazypagingimg_'+parentId).removeAttr('id').unbind('mouseover').unbind('click').unbind('mouseout');
					//下面开始设置最后一行的特殊图标显示和事件绑定.
					newRow.setAttribute('_lazy_paging_pId', parentId);  
					var lazypaging_info = _lazypgInfoMap.get(parentId);
					if (lazypaging_info.currentPage * lazypaging_info.pageSize < lazypaging_info.allCount) 
					jQuery('td[_td_pro]:eq(0) img:eq(' + (level - 2) + ')', newRow)
					.attr({'src': tc.morePageImg,'title':'点击查看更多'}).css('cursor','pointer').mouseover(function() {
						jQuery(this).attr({ 
									'id' : '_lazypagingimg_' + parentId
								});  
						GridTree.prototype._createMoreLazyPagingDiv(parentId); 
						GridTree.prototype._showLazyPagingDiv(parentId,
								this.id, true,2);  
						// 禁止事件冒泡.
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
        //如果是懒加载分页模式，或者是懒加载的更多显示模式下的动态添加方式
        if(tc.lazyPage||(tc.lazyMorePage&&tc._dynamicAddByUse)){
        	jQuery(parentNode).after(temp).attr('_expaned','true'); 
        } //否则说明是懒加载的更多显示模式下的非动态添加方式
        else{   
        	//如果已经有子节点了，说明是懒加载的更多模式下面的添加后续节点
        	if(jQuery('tr[_node_parent=_node'+parentId+']').size()>0){
        		jQuery('tr[_node_parent=_node'+parentId+']:last').after(temp);
        	}
        	//否则就说明是第一次添加子节点
        	else
        		jQuery(parentNode).after(temp).attr('_expaned','true');
        }
        imgNode.src = tc.closeImg;        
        if(tc.exchangeColor)
				this._setColor(_$(tc.tableId));
				
		//使用完数据之后,将两个变量的内容清空,防止被其他地方使用.
		tc.repaintDataInfoDatas = null;
		tc.allDataInfoWithLazyPageInfo = null;
		tc._dynamicAddByUse =null;

}
 
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
 * 点击一个图标,打开其子节点
 */
GridTree.prototype.openChildrenTable = function(imgid,node,e)
{ 
	var _id = imgid.replace('img_','').replace('_node',''); 
	var img = _$('img_'+_id); 
	if(!tc.lazy){
		img.onclick = function(ee){
			GridTree.prototype.closeChildrenTable(imgid,node,ee)
		};
		//如果不是懒加载就继续打开子节点中的文件夹
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
	//如果是懒加载模式,就要传递当前节点的id到后台查询子节点的集合,再重新组装进树中
	else{  
		//防止出现点击多次重复提交后台的发生.
		if(img.src.indexOf(tc.lazyLoadImg) == -1){
			img.src = tc.lazyLoadImg;	
		}else{
			return false; 
		}
		var param = {pId:_id};		
		var parentNode = _$('_node'+_id);  
		//如果当前父节点没有被打开过,就要到后台查询子节点
		//要在这里添加懒加载分页的代码  modified on 20101212  notready
		if (parentNode.getAttribute('_open') != 'true'
				&& parentNode.getAttribute('_expaned') != 'true') { 
			//如果要进行懒加载分页，就准备设置懒加载分页的起始行和终止行.
			if(tc.lazyPage||tc.lazyMorePage){ 
				//如果要进行懒加载的分页,就多传递一个参数表示要进行分页处理
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
							//进行懒加载分页的处理
							if(tc.lazyPage||tc.lazyMorePage){
								GridTree.prototype._initLazyPageInfo(_id,'父亲节点id',msg);  
								GridTree.prototype.dynamicAdd(_id,parentNode,img,msg); 
							}
							//普通的懒加载显示处理方式
							else{ 
								GridTree.prototype.dynamicAdd(_id,parentNode,img,msg);
							} 
							var gotime = new Date()-o;
							GridTree.prototype._wirteDebug('懒加载显示前台消耗时间:'+gotime);	
							if(tc.onLazyLoadSuccess)	
								tc.onLazyLoadSuccess(elct); 
						} catch (ee) {
							GridTree.prototype
									._makeTableWithNoData(tableTree);
						}
					} else {
						elct.innerHTML = "没有数据.";
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
 * 点击一个图标,关闭其子节点
 * @param {图标id} imgid
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
	//找到父亲节点是当前节点的对象,设置为不可见.并对这些节点如果还有子节点也递归进行调用.
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
 * 选择树节点.
 * @param {节点id,不含有前缀} nodeId
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
 * 实现数组对象。
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
 * 定义bind方法为function自动的再多绑定自定义的参数，返回新的函数。用于在事件的绑定方法中传递参数很有作用
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
 * 将json的map对象转换为程序中的hashMap对象
 * @param {json的map对象} jsonMap
 */
function jsonMapToJsHashMap(jsonMap){
	var mapObj = new HashMap();
	for(var obj in jsonMap){
		mapObj.put(obj,jsonMap[obj]);
	}
	return mapObj;
}


/**
 * 从一个数组中减去另外一个数组 arr1:数组1 arr2:数组2 返回:arr1 - arr2的新数组
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
 * 在一个数组中找指定的元素 
 * arr:数组对象 
 * obj:要查找的对象
 * 返回值:如果找到就返回数组中的位置(从0开始),否则就返回-1
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
 * 控制多个多选按钮的选择状态
 * checkName:多选按钮的name
 * v:设置的值
 */
function _checkedAll(checkName,v)
{
	var objs = document.getElementsByName(checkName);	
	var len = objs.length;
	if(isIE){
		for(var i=0;i<len;i++)
		{
			//排除那些有定义了是否后台选择的节点.
			if(objs[i].userSetDisabled==null||objs[i].userSetDisabled!='disabled')
				objs[i].checked = v;
			
		}
	} else {
		for (var i = 0; i < len; i++) {
			// 排除那些有定义了是否后台选择的节点.
			if (objs[i].getAttribute('userSetDisabled') == null
					|| objs[i].getAttribute('userSetDisabled') != 'disabled')
				objs[i].checked = v;

		}
	}
}

/**
 * 判断一个元素是否被自动绑定了为不可用.
 * 如果没有userSetDisabled属性或者这个属性为disabled.就返回true,
 * 否则返回false.
 * @param {元素对象} o
 */
function _notBindDisabled(o){
	return jQuery(o).attr('userSetDisabled')!='disabled';
}

/**
 * 设置指定元素不可用或者可用
 * obj:元素
 * val:不可用(1)或者可用(0)
 */
function disableDom(obj,val)
{
	if(obj)
		obj.disabled = val;
}

/**
 * 设置指定name的元素是否可用
 * @param {name属性} domName
 * @param {不可用(1)或者可用(0)} val
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
 * 阻止js事件的冒泡
 */
function stopBubble(e){ 
	 //一般用在鼠标或键盘事件上 
     if(!isIE){ 
     	e.preventDefault();
     	e.stopPropagation();
     }else{ 
         //IE取消冒泡事件 
         window.event.cancelBubble = true; 
     } 
 }
 
/**
 * 得到选择的id行的id
 */
function getAllCheckValue(){
	var ans = '';
	jQuery('[name=_chks]:checked').each(function(){
			ans += this.value+',';
	});
	return ans.substring(0,ans.length-1); 
}

/**
 * 动态创建一个radio的方法
 * @param {附属的上级dom元素} el
 * @param {是否可用} dis
 * @param {样式文本} sty
 * @param {名字属性} name
 * @param {值属性} val
 * @param {单击事件} click
 * @param {innerText值} innertext
 * @param {样式名} cssname
 * @param {是否默认选择} chk
 */
function createRadio(el,dis,sty,name,v,click,t,cssname,chk){
	jQuery(el).append(jQuery("<input type='radio' name='"+name+"'>")
	.attr({'style':sty,'userSetDisabled':dis,'value':v,'disabled':dis,'checked':chk})
	.addClass(cssname).click(click)).append(t);	
}

/**
 * 动态创建一个多选按钮
 * @param {附属的上级dom元素} el
 * @param {是否可用} dis
 * @param {样式文本} sty
 * @param {名字属性} name
 * @param {值属性} val
 * @param {单击事件} click
 * @param {innerText值} innertext
 * @param {样式名} cssname
 * @param {是否默认选择} chk
 */
function createCheckbox(el,dis,sty,name,val,click,innertext,cssname,chk){
	jQuery(el).append(jQuery("<input type='checkbox' name='"+name+"'>")
	.attr({'style':sty,'userSetDisabled':dis,'value':val,'disabled':dis,'checked':chk})
	.addClass(cssname).click(click)).append(innertext);	
}

/**
 * 动态创建hidden。
 * @param {id值} id
 * @param {名字值} name
 * @param {val属性} val
 * @return {}
 */
function createHidden(id,name,val){
	return jQuery('<input type="hidden" name="'+name+'">').attr({'id':id,"value":val})[0];
}
/**
 * 创建一个Img元素
 * @param {图片来源} imgsrc
 */
function createImg(imgsrc)
{
	var node = document.createElement('img');
	node.setAttribute('src',imgsrc);
	return node;
}

/**
 * 得到指定的元素id对应的节点.
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