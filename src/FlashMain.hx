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


        var callBackObj:CallBackObj = args.pop();
		trace(callBackObj.id + "" + callBackObj.name + "" + callBackObj.sn);
        var classObject:CallBackObjWithFun = cnx.getcallBackList().get(callBackObj.id + "");
        var method:CallBackObjWithFun = cnx.getcallBackList().get(callBackObj.id + callBackObj.name + callBackObj.sn);
		trace("method" + method);
        var classCallback:Dynamic = classObject.callBack;
trace("classCallback" + classCallback);
      
        try {

          /*  trace("classCallback"+classCallback);
            trace("method"+method.callBack);
            trace("args"+args);*/
            Reflect.callMethod(classCallback, method.callBack, args);
        } catch (e:Dynamic) {
            trace(e);
            return ;
        }
        return ;


    }

    private static function __init__():Void {
        onData = Reflect.makeVarArgs(__onData);

    }

}





