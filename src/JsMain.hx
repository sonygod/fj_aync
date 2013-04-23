package ;
import Forwarder;
import haxe.remoting.Context;
import js.Browser;

import FormatAsync;
using Reflect;
import haxe.Timer;

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
	  
	  
	 Timer.delay(test1, 5000);
	     
	  
	    }
		
		
		public static function test1() {
			trace("test1");
			 hello.sayHello("hi", "god js call flash", onCalljs);

        
			
		}
		
		
	
		public static function __onData(args: Array<Dynamic>) {
     
			
			
		  cnx.__onData(args);
	      
			
		}
		
		   public static function onCalljs(err, data):Void {

        trace("async come back " + data);
    }

    public static function onCalljs2(err, data):Void {

        trace("2async come back " + data);
    }

		
	
		
}
