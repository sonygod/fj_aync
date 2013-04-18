package rpc;
import rpc.RpcType;
class Session {

	private static var _instance:Session;
	
    public static function getInstance():Session
    {
        if (_instance == null)
        {
            _instance = new Session();
        }

        return _instance;
    }
     function new() {
    }

    public  function connect():Void{
        
    }

    public function get_connected():Bool{

		return false;
    }

    public function send(request:Request):Void{

    }
    //链接上
    private function onConnect():Void{

    }

    private function onEventResult():Void{

    }

    private function onMethodResult():Void{

    }



   private function onData():Void{

   }

    private function onSystemError():Void{

    }
	
	private function resetAll():Void {
		
	}


}
