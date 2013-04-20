package ;
import Forwarder;
import haxe.remoting.Context;
import js.Browser;

import FormatAsync;
using Reflect;

class JsMain {
     public static var cnx:ExternalConnectionAsync = null;
    static var ctx:Context = null;
   
	public static var onData: Dynamic;
    private static var hello:IHelloServer;
	 private static function __init__() : Void {
    onData = Reflect.makeVarArgs(__onData);
 
 }
	
    public static function main() {
       ctx = new haxe.remoting.Context();
      
	   ctx.addObject("main",JsMain);
       
	   cnx = ExternalConnectionAsync.flashConnect("default", "myFlashObject", ctx);
	   //register module 
	   hello = new Forwarder(cnx, "hello", HelloService.getInstance());
	   trace("main---");
	  
	    }
	
		public static function __onData(args: Array<Dynamic>) {
     
			
			
		
	        //get callBackObject
		    var callBackObj :CallBackObj = args.pop();
			//add callBack function to args
			trace("callBackObj" + callBackObj);
			args.push({cbF:callFlashSync,obj:callBackObj});
	         //get current platform class
			var callBackObjWithFun:CallBackObjWithFun = cnx.getcallBackList().get(callBackObj.id+"");

           
			var classCallback :Dynamic= callBackObjWithFun.callBack;
		
			try{
			classCallback.callMethod(classCallback.field(callBackObj.name), args);
			
			}catch (e:Dynamic) {
				trace(e);
				return ;
			}
			return ;
			
		}
		
		public static function callFlashSync(err, data,callBackObj:CallBackObj):Void {
           //don't know why much defined again, if no ,it will error 
            cnx = ExternalConnectionAsync.flashConnect("default", "myFlashObject", ctx);
            cnx.main.onData.call([err, data, callBackObj]);
			trace("async"+callBackObj);
		   
		 
			   
		}
		
}
