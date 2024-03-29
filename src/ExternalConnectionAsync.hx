/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
package ;



import FormatAsync;
import haxe.remoting.Connection;
import haxe.remoting.Context;
import IECAsync;
using Reflect;



/**
	Synchronous communications between Flash and Javascript.
**/
@:expose
class ExternalConnectionAsync implements Connection implements Dynamic<Connection> {

	var __data : { name : String, ctx : Context, #if js flash : String #end };
	var __path : Array<String>;
	public static var  sn:Int = 0;
	public static var instance:ExternalConnectionAsync;

	function new( data, path ) {
		__data = data;
		__path = path;
	}

	public function resolve(field) : Connection {
		var e = new ExternalConnectionAsync(__data,__path.copy());
		e.__path.push(field);
		return e;
	}

	public function close() {
		connections.remove(__data.name);
	}

	#if flash9
	static function escapeString( s : String ) {
		return s.split("\\").join("\\\\");
	}
	#elseif flash
	static function escapeString( s : String ) {
		return s.split("\\").join("\\\\").split("&").join("&amp;");
	}
	#else
	static inline function escapeString(s) {
		return s;
	}
	#end

	
	public function call( params : Array<Dynamic> ) : Dynamic {
		
		
		if (sn > 10000) {
			sn = 1;
		}
		sn += 1;
		
		//if last params is function .
		if(Reflect.isFunction(params[params.length - 1])){
		 var callBackF = params.pop();
	  
		 var p:CallBackObj = params[params.length - 1];
		 p.sn = sn + "";
		 if(!p.needRecall)
		 callBackList.set(p.id + p.name + sn, { id:p.id, name:p.name, callBack:callBackF, sn:sn + "" } );
		 else
		 callBackList.set(p.id + p.name + sn+p.needRecall, { id:p.id, name:p.name, callBack:callBackF, sn:sn + "" } );
		 p.needRecall = true;
		 callBackF = null;
		}
		 
		
	
		var s = new haxe.Serializer();
		s.serialize(params);
		var params = escapeString(s.toString());
		var data = null;
		#if flash
			data = flash.external.ExternalInterface.call("ExternalConnectionAsync.doCall",__data.name,__path.join("."),params);
		#elseif js
			var fobj : Dynamic = untyped window.document[__data.flash];
			if( fobj == null ) fobj = untyped window.document.getElementById(__data.flash);
			if( fobj == null ) throw "Could not find flash object '"+__data.flash+"'";
			try	data = fobj.externalRemotingCall(__data.name,__path.join("."),params) catch( e : Dynamic ) {};
		#end
		if( data == null ) {
			#if js
			var domain, pageDomain;
			try {
				// check that swf in on the same domain
				domain = fobj.src.split("/")[2];
				pageDomain = js.Browser.window.location.host;
			} catch( e : Dynamic ) {
				domain = null;
				pageDomain = null;
			}
			if( domain != pageDomain )
				throw "ExternalConnectionAsync call failure : SWF need allowDomain('"+pageDomain+"')";
			#end
			throw "Call failure : ExternalConnection is not " + #if flash "compiled in JS" #else "initialized in Flash" #end;
		}
		
		return new haxe.Unserializer(data).unserialize();
	}
	
	

	static var connections = new haxe.ds.StringMap<ExternalConnectionAsync>();
	 static var  callBackList = new haxe.ds.StringMap<CallBackObjWithFun>();
	
	 public function getcallBackList():haxe.ds.StringMap<CallBackObjWithFun> {
		return callBackList; 
	 }

	@:keep
	static function doCall( name : String, path : String, params : String ) : String {
		try {
			var cnx = connections.get(name);
			if( cnx == null ) throw "Unknown connection : "+name;
			if( cnx.__data.ctx == null ) throw "No context shared for the connection "+name;
			var params = new haxe.Unserializer(params).unserialize();
			var ret = cnx.__data.ctx.call(path.split("."),params);
			var s = new haxe.Serializer();
			s.serialize(ret);
			#if flash
			return escapeString(s.toString());
			#else
			return s.toString()+"#";
			#end
		} catch( e : Dynamic ) {
			var s = new haxe.Serializer();
			s.serializeException(e);
			return s.toString();
		}
		#if as3
		return "";
		#end
	}

	#if flash

	public static function jsConnect( name : String, ?ctx : Context ) {
		if( !flash.external.ExternalInterface.available )
			throw "External Interface not available";
		#if flash9
		try flash.external.ExternalInterface.addCallback("externalRemotingCall",doCall) catch( e : Dynamic ) {};
		#else
		flash.external.ExternalInterface.addCallback("externalRemotingCall",null,doCall);
		#end
		var cnx = new ExternalConnectionAsync({ name : name, ctx : ctx },[]);
		connections.set(name,cnx);
		return cnx;
	}

	#elseif js

	public static function flashConnect( name : String, flashObjectID : String, ?ctx : Context ) {
		var cnx = new ExternalConnectionAsync({ ctx : ctx, name : name, flash : flashObjectID },[]);
		connections.set(name,cnx);
		return cnx;
	}

	#end
     
	
	  public  function __onData(args:Array<Dynamic>) {


		 
           //get callBackObject
		    var callBackObj :CallBackObj =args.pop();
			//add callBack function to args
		     
			
			if (callBackObj.needRecall==true) {
				
				 args.push({cbF:callFlashSync,obj:callBackObj});
			}else {
				
			}
			
	         //get current platform class
			var classObject:CallBackObjWithFun = getcallBackList().get(callBackObj.id+"");
            var method:CallBackObjWithFun ;//= 
			
			if (callBackObj.needRecall) {
				method=getcallBackList().get(callBackObj.id + callBackObj.name + callBackObj.sn+callBackObj.needRecall);
			}else {
				method = getcallBackList().get(callBackObj.id + callBackObj.name + callBackObj.sn);
			}
			
			var classCallback :Dynamic = classObject.callBack;
			var theCallMethod:Dynamic;
			if (method != null) {
				
				theCallMethod = method.callBack;
			}else {
				theCallMethod = classCallback.field(callBackObj.name);
				
				
			}
         
			
		   
			try {
				
			//classCallback.callMethod(theCallMethod, args);
			Reflect.callMethod(classCallback, theCallMethod, args);
			
			
			
			}catch (e:Dynamic) {
				trace(e);
				
				
			}
			if (callBackObj.needRecall){
			getcallBackList().remove(callBackObj.id + callBackObj.name + callBackObj.sn+callBackObj.needRecall);
			}else {
				getcallBackList().remove(callBackObj.id + callBackObj.name + callBackObj.sn);
			}
			classCallback = null;
			method = null;
			classObject = null;
			theCallMethod = null;
			
			return ;


    }
	
	//derect call 
	public  static function callFlashSync(err, data,callBackObj:CallBackObj):Void {
         
            callBackObj.needRecall = false;
            ExternalConnectionAsync.instance.main.onData.call([err, data, callBackObj]);
		
		   
		 
		  
		
		callBackObj = null;  
		}
	
	
}




