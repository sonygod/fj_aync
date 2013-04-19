package ;
import haxe.ds.ObjectMap;
import haxe.ds.StringMap;
import haxe.Timer;

import FormatAsync;
/**
 * ...
 * @author sonygod
 */
class FlashMain {

   static var js:ExternalConnectionAsync= null;
  static  var hello:IHelloServer;
  public static var onData: Dynamic;
 public static function main() {
    var ctx = new haxe.remoting.Context(); 
   	 ctx.addObject("FlashMain", FlashMain);

    js = ExternalConnectionAsync.jsConnect("default", ctx);

	var arr:Array<Int> = [1, 2];
	var arr2=arr.slice(0, arr.length - 1);
	 hello = new Forwarder(js,"hello",HelloService.getInstance());
			
     hello.sayHello("hi", "god", onCalljs);
     

	 
  }

    public static function onCalljs(err,data):Void{

      trace("async come back "+data);
    }
  
  public static function __onData(args: Array<Dynamic>) {
	  
	  
	  //trace(args.toString() + "" + Timer.stamp() * 1000);
	  var recall = args.pop();
	  
	  trace(args.toString() + "" + Timer.stamp() * 1000);
	  
	 var xxx:StringMap<CallBackObjWithFun> = js.getcallBackList();
	 
	 
	 var f :CallBackObjWithFun= xxx.get(recall.id + recall.name);
	 
	 
	 trace(f.id+f.name+f.callBack);
	 Reflect.callMethod(FlashMain, f.callBack, args);
	  
	  
	  
	
	
  }
  
   private static function __init__() : Void {
    onData = Reflect.makeVarArgs(__onData);
 
 }
  
}





