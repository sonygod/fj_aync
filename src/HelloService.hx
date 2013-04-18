package ;

/**
 * ...
 * @author sonygod
 */


import haxe.remoting.Context;
import haxe.remoting.ExternalConnection;
class HelloService {
    private static var _instance:HelloService ;

    public static function getInstance():HelloService {
        if (_instance == null) {
            _instance = new HelloService ();
        }

        return _instance;
    }

    function new() {
    }

    public function sayHello(x:String, y:String, cb:Dynamic):Void {

        cb(null,x + y);

    }

   /* private var ctx: Context;
    private var cnx: ExternalConnection;
    private var caller:Forwarder;
   public function init():Void{

       ctx = new haxe.remoting.Context();
       ctx.addObject("main", HelloService.getInstance());
       
	   #if js
       cnx = ExternalConnection.flashConnect("default", "myFlashObject", ctx);
	   #elseif flash
	   cnx = haxe.remoting.ExternalConnection.jsConnect("default", ctx);
	   #end
       caller = new Forwarder(cnx);
   }*/




}