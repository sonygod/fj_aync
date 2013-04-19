package ;
import js.Browser;

import Format;

class JsMain {
     public static var cnx = null;
    static var ctx = null;
   
	public static var onData: Dynamic;
	 private static function __init__() : Void {
    onData = Reflect.makeVarArgs(__onData);
 
 }
	
    public static function main() {
       ctx = new haxe.remoting.Context();
      
	   ctx.addObject("main",JsMain);
	    cnx = ExternalConnectionAsync.flashConnect("default", "myFlashObject", ctx);
	  
	   
	   
	   
	    }
		//http://www.verydemo.com/demo_c98_i5393.html
		
		public static function __onData(args: Array<Dynamic>) {
			
			
	   
			Browser.window.alert("length=" + args[2].id);
		
			
			Test.bubblesort([1, 2, 9, 7, 6, 0.3], function (err, data) { 
				
				 cnx = ExternalConnectionAsync.flashConnect("default", "myFlashObject", ctx);
				cnx.FlashMain.onData.call([err,data,args[2]]); 
				
				} );
			
		}
		
}
