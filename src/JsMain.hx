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
	  
	  
	 Timer.delay(test1, 3000);
	     
	  
	    }
		
		
		public static function test1() {
		
			 hello.sayHello("hi", "god js call flash"+Math.random()*1000, onCalljs);

        
			//GlobalTimer.setInterval(timeCall, 100, []);
			untyped __js__('setInterval')(timeCall, 100);
		}
		
		public static function timeCall():Void {
		 hello.sayHello("hi", "god2"+Math.random()*1000, onCalljs2);
	}
	
		public static function __onData(args: Array<Dynamic>) {
     
			
			
		  cnx.__onData(args);
	      
			
		}
		
		   public static function onCalljs(err, data):Void {

        //trace("async come back " + data);
    }

    public static function onCalljs2(err, data):Void {

       // trace("2async come back " + data);
    }

		
	
		
}
