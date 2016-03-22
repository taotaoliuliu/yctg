var xhr = null;
if(window.XMLHttpRequest){
	xhr = new XMLHttpRequest();
}else{
	xhr = new ActiveXObject("Msxml2.XMLHttp.4.0");
}
function Ajax(){
	this.post=function(url,param,func,dt){
		xhr.open("POST",url,true);
		xhr.setRequestHeader("accept","application/"+dt);
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					if(dt=="json"){
						var str = xhr.responseText;
						alert(str);
						str = eval("("+str+")");
						func(str);
					}else{
						var xml = xhr.responseXML;
						func(xml);
					}
				}
			}
		};
		xhr.send(param);
	};
	this.get=function(url,func,dt){
		xhr.open("GET",url,true);
		xhr.setRequestHeader("accept","application/"+dt);
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					if(dt=="json"){
						var str = xhr.responseText;
						str = eval("("+str+")");
						func(str);
					}else{
						var xml = xhr.responseXML;
						func(xml);
					}
				}
			}
		};
		xhr.send(null);
	};
}