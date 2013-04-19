package ;

/**
 * ...
 * @author sonygod
 */


import haxe.remoting.Context;
import haxe.remoting.ExternalConnection;
import FormatAsync;
import org.transition9.async.Step;
class HelloService implements IHelloServer{

   public var name:String="hello";
    private static var _instance:HelloService ;

    public static function getInstance():HelloService {
        if (_instance == null) {
            _instance = new HelloService ();
        }

        return _instance;
    }

    function new() {
    }

    public function sayHello(x:String, y:String, cb:Dynamic->Dynamic->CallBackObj->Void):Void {

		//trace("get sayheloo now");
		var platform:String;
		#if flash
		platform = "flash";
		 cb(null,x + y+" platform"+platform,{id:name,name:"sayHello"});
		#else
		x += ":js";
		platform = "js";
		
		
		
		Test.main(function(err, data) { cb(null, data, { id:name, name:"sayHello" } ); } );
		
		#end
       

    }





}