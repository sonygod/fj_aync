package ;
import haxe.ds.ObjectMap;
import haxe.ds.StringMap;
import haxe.Timer;

import tink.lang.Cls; 
import Format;
/**
 * ...
 * @author sonygod
 */
class FlashMain {
  public function foo(x, y) { trace("outsidecall" + x + y); }
   static var js:ExternalConnectionAsync= null;
  static  var hello;
  public static var onData: Dynamic;
 public static function main() {
    var ctx = new haxe.remoting.Context(); 
   	 ctx.addObject("FlashMain", FlashMain);
    js = ExternalConnectionAsync.jsConnect("default", ctx);
	var arr:Array<Int> = [1, 2];
	var arr2=arr.slice(0, arr.length - 1);
	 hello = new Forwarder(js);
			
     hello.sayHello("hi", "god", onCalljs);
	 
  }

  
  public static function onCalljs(err, data) {
	  
	  trace("回来了，靠"+err+data);
	
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


class Forwarder implements Cls {
    var fields:Hash<Dynamic> = new Hash<Dynamic>();
	
	public var recallFuns:ObjectMap<Caller ,Dynamic>=new ObjectMap<Caller ,Dynamic>();
    @:forward(!multiply) var target:ExternalConnectionAsync;

    @:forward function fwd2(hello:HelloService) {
    get: fields.get($name),
    set: fields.set($name, param),
             
	
    call:target.resolve("main").resolve("onData").call($argsRemoting)
	
    }

    public function new(target) {
    this.target = target;

    }
}
typedef Caller = {
	id:String,
	name:String
}

