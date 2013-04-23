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

    static var cnx:ExternalConnectionAsync = null;
    static var hello:IHelloServer;
    public static var onData:Dynamic;

    public static function main() {
        var ctx = new haxe.remoting.Context();
        ctx.addObject("main", FlashMain);

        cnx = ExternalConnectionAsync.jsConnect("default", ctx);
ExternalConnectionAsync.instance = cnx;
        var arr:Array<Int> = [1, 2];
        var arr2 = arr.slice(0, arr.length - 1);
        hello = new Forwarder(cnx, "hello", HelloService.getInstance());

       hello.sayHello("hi", "god", onCalljs);

     hello.sayHello("hi", "god2", onCalljs2);

    }

    public static function onCalljs(err, data):Void {

        trace("async come back " + data);
    }

    public static function onCalljs2(err, data):Void {

        trace("2async come back " + data);
    }

    public static function __onData(args:Array<Dynamic>) {


         cnx.__onData(args);


    }

    private static function __init__():Void {
        onData = Reflect.makeVarArgs(__onData);

    }

}





