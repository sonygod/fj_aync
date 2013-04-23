package ;

/**
 * ...
 * @author sonygod
 */


import haxe.remoting.Context;
import haxe.remoting.ExternalConnection;
import FormatAsync;

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

    public function sayHello(x:String, y:String, cb:JsRecall):Void {

	
		
		
		
		Test.main2(
		function(err, data) 
{ cb.cbF(null, data, cb.obj ); 
    data = null;
	cb = null;
} );
		
		
       

    }





}