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
	 
	   ExternalConnectionAsync.instance = cnx;
	   hello = new Forwarder(cnx, "hello", HelloService.getInstance());
	  // trace("main---");
	  
	    }
	
		public static function __onData(args: Array<Dynamic>) {
     
			
			
		  cnx.__onData(args);
	      
			
		}
		
		public static function callFlashSync(err, data,callBackObj:CallBackObj):Void {
         
            callBackObj.needRecall = false;
            ExternalConnectionAsync.instance.main.onData.call([err, data, callBackObj]);
			
		   
		 
			   
		}
		
}
